package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.ConexionPostgreSQL;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.state.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jhonatan
 */
public class ProjectRepository {
    
    private static final String BASE_QUERY = """
        SELECT p.*, c.name as company_name, c.nit as company_nit,
               c.sector as company_sector, c.contact as company_contact,
               CASE p.state 
                   WHEN 'ACCEPTED' THEN 'Accepted'
                   WHEN 'RECEIVED' THEN 'Received'
                   WHEN 'REJECTED' THEN 'Rejected'
                   ELSE 'Unknown'
               END as state_class
        FROM projects p
        JOIN companies c ON p.company_nit = c.nit
    """;
    
    public class Unknown implements ProjectState {
        @Override
        public void manageState(Project project) {
            System.out.println("Proyecto " + project.getName() + " tiene un estado desconocido");
            // Lógica para manejar estados desconocidos
        }
    }
    
    public List<Project> getAllProjects() throws SQLException {
        List<Project> projects = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConexionPostgreSQL.conectar();
            if (conn != null) {
                String sql = """
                    SELECT p.*, c.name as company_name, c.nit as company_nit,
                           c.sector as company_sector, c.contact as company_contact,
                           CASE p.state 
                               WHEN 'ACCEPTED' THEN 'Accepted'
                               WHEN 'RECEIVED' THEN 'Received'
                               WHEN 'REJECTED' THEN 'Rejected'
                               ELSE 'Unknown'
                           END as state_class
                    FROM projects p
                    JOIN companies c ON p.company_nit = c.nit
                    """;

                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    Project project = new Project();
                    project.setId(rs.getInt("id"));
                    project.setName(rs.getString("name"));
                    project.setDescription(rs.getString("description"));

                    // Verificar si state_class es null antes de usarlo
                    String stateClass = rs.getString("state_class");
                    ProjectState state;
                    if (stateClass == null) {
                        state = new Unknown(); // Asumimos un estado Unknown si es null
                    } else {
                        state = switch (stateClass) {
                            case "Accepted" -> new Accepted();
                            case "Received" -> new Received();
                            case "Rejected" -> new Rejected();
                            default -> new Unknown();
                        };
                    }
                    project.setState(state);

                    Company company = new Company();
                    company.setName(rs.getString("company_name"));
                    company.setNit(rs.getInt("company_nit"));
                    company.setSector(rs.getString("company_sector"));
                    company.setContact(rs.getString("company_contact"));

                    project.setCompany(company);
                    projects.add(project);
                }
            }
        } finally {
            ConexionPostgreSQL.closeResources(conn, stmt, rs);
        }
        return projects;
    }
    
    public Project getProjectById(int id) throws SQLException {
        String sql = BASE_QUERY + " WHERE p.id = ?";

        try (Connection conn = ConexionPostgreSQL.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapProject(rs);
                }
            }
        }
        return null;
    }
    private Project mapProject(ResultSet rs) throws SQLException {
        Project project = new Project();
        project.setId(rs.getInt("id"));
        project.setName(rs.getString("name"));
        project.setDescription(rs.getString("description"));

        String stateClass = rs.getString("state_class");
        ProjectState state = switch (stateClass) {
            case "Accepted" -> new Accepted();
            case "Received" -> new Received();
            case "Rejected" -> new Rejected();
            default -> new Unknown();
        };
        project.setState(state);

        Company company = new Company();
        company.setName(rs.getString("company_name"));
        company.setNit(rs.getInt("company_nit"));
        company.setSector(rs.getString("company_sector"));
        company.setContact(rs.getString("company_contact"));

        project.setCompany(company);
        return project;
    }
    
}
