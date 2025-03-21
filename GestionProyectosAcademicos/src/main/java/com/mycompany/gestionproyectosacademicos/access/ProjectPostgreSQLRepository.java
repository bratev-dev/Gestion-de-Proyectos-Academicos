package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.state.Accepted;
import com.mycompany.gestionproyectosacademicos.state.Received;
import com.mycompany.gestionproyectosacademicos.state.Rejected;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author ANACONA
 */
public class ProjectPostgreSQLRepository implements IProjectRepository{
    
    private Connection conn;
    
    private static final String URL = "jdbc:postgresql://localhost:5432/projectmanagement";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "postgres"; //Cambiar por password local de su maquina

    public static Connection conectar() {
        Connection conexion = null;
        try {
            Class.forName("org.postgresql.Driver"); // Cargar el driver
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            JOptionPane.showMessageDialog(null
                    ,"✅ Conexión exitosa a PostgreSQL"
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
        } catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null
                    ,"❌ Error: No se encontró el Driver de PostgreSQL"
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
            e.printStackTrace();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null
                    ,"❌ Error de conexión: "
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
        }
        return conexion;
    }
    
    private static final String BASE_QUERY = """
        SELECT p.*, 
                c.companyname AS companyname, 
                c.companysector AS companysector, 
                c.contactname AS contactname, 
                c.contactlastname AS contactlastname, 
                c.contactnumber AS contactnumber, 
                c.contactposition AS contactposition,
                CASE p.state 
                    WHEN 'Aceptado' THEN 'Accepted'
                    WHEN 'Recibido' THEN 'Received'
                    WHEN 'Rechazado' THEN 'Rejected'
                    ELSE 'Unknown'
                END AS state_class
                FROM projects p
                LEFT JOIN company c ON p.company_nit = c.companynit;
        """;
    
    @Override
    public List<Project> getAllProjects(){
        List<Project> projects = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConexionPostgreSQL.conectar();
            if (conn != null) {
                String sql = """
                    SELECT p.*, 
                        c.companyname AS companyname, 
                        c.companysector AS companysector, 
                        c.contactname AS contactname, 
                        c.contactlastname AS contactlastname, 
                        c.contactnumber AS contactnumber, 
                        c.contactposition AS contactposition,
                        CASE p.state 
                            WHEN 'Aceptado' THEN 'Accepted'
                            WHEN 'Recibido' THEN 'Received'
                            WHEN 'Rechazado' THEN 'Rejected'
                            ELSE 'Unknown'
                        END AS state_class
                        FROM projects p
                        LEFT JOIN company c ON p.company_nit = c.companynit;
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
                    String state;

                    if (stateClass != null) {
                        state = switch (stateClass) {
                            case "Aceptado" -> new Accepted().getStateName();
                            case "Recibido" -> new Received().getStateName();
                            case "Rechazado" -> new Rejected().getStateName();
                            default -> null; // Si el estado no es válido, dejamos null
                        };
                    } else {
                        state = null; // No asignamos estado si es null
                    }

                    project.setState(state);

                    Company company = new Company();
                    company.setName(rs.getString("companyname"));
                    company.setNit(rs.getString("companynit"));
                    company.setSector(rs.getString("companysector"));
                    company.setContactNames(rs.getString("contactname"));
                    company.setContactLastNames(rs.getString("contactlastname"));
                    company.setContactPhoneNumber(rs.getString("contactnumber"));
                    company.setContactPosition(rs.getString("contactposition"));

                    project.setCompany(company);
                    projects.add(project);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProjectPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ConexionPostgreSQL.closeResources(conn, stmt, rs);
        }
        return projects;
    }
    
    @Override
    public Project getProjectById(int projectId) throws SQLException {
        String sql = "SELECT p.*, c.companyname, c.companynit " +
                     "FROM projects p " +
                     "LEFT JOIN company c ON p.company_nit = c.companynit " +
                     "WHERE p.id = ?";

        try (Connection conn = ConexionPostgreSQL.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Crear la compañía
                    Company company = new Company();
                    company.setName(rs.getString("companyname"));
                    company.setNit(rs.getString("companynit"));
                    // Añade otros campos de la compañía si los necesitas

                    // Crear y retornar el proyecto
                    return new Project(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("state"),
                        company
                    );
                } else {
                    throw new SQLException("No se encontró el proyecto con ID: " + projectId);
                }
            }
        } catch (SQLException e) {
            // Registrar la excepción y mostrar mensaje
            throw new SQLException("Error al obtener el proyecto: " + e.getMessage(), e);
        }
    }
    
    private Project mapProject(ResultSet rs) throws SQLException {
        Project project = new Project();
        project.setId(rs.getInt("id"));
        project.setName(rs.getString("name"));
        project.setDescription(rs.getString("description"));

        String stateClass = rs.getString("state_class");
        String state;

        if (stateClass != null) {
            state = switch (stateClass) {
                case "Accepted" -> new Accepted().getStateName();
                case "Received" -> new Received().getStateName();
                case "Rejected" -> new Rejected().getStateName();
                default -> null; // Si el estado no es válido, dejamos null
            };
        } else {
            state = null; // No asignamos estado si es null
        }

        project.setState(state);

        Company company = new Company();
        company.setName(rs.getString("companyname"));
        company.setNit(rs.getString("companynit"));
        company.setSector(rs.getString("companysector"));
        company.setContactNames(rs.getString("contactname"));
        company.setContactLastNames(rs.getString("contactlastname"));
        company.setContactPhoneNumber(rs.getString("contactnumber"));
        company.setContactPosition(rs.getString("contactposition"));

        project.setCompany(company);
        return project;
    }

    /*@Override
    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {
        List<Project> projects = new ArrayList<>();
        String sql = BASE_QUERY + " WHERE p.academic_period = ?";

        try (Connection conn = ConexionPostgreSQL.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, academicPeriod);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    projects.add(mapProject(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores, puedes mejorarlo con logs
        }

        return projects;
    }*/

    @Override
    public void deleteProject(int projectId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void saveProject(Project project) {
        String sql = "INSERT INTO projects (name, summary, objectives, description, max_time, budget, date, state, company_nit) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, project.getName());
            pstmt.setString(2, project.getSummary());
            pstmt.setString(3, project.getObjectives());
            pstmt.setString(4, project.getDescription());
            pstmt.setString(5, project.getMaxTimeInMonths());
            pstmt.setString(6, project.getBudget());
            pstmt.setDate(7, Date.valueOf(project.getDate())); // Convertir LocalDate a SQL Date
            pstmt.setString(8, "Received"); // Estado inicial por defecto
            pstmt.setString(9, project.getCompany().getNit()); // Relación con la empresa

            pstmt.executeUpdate(); // Ejecuta la inserción
            System.out.println("✅ Proyecto guardado correctamente");

        } catch (SQLException e) {
            System.out.println("❌ Error al guardar el proyecto: " + e.getMessage());
            e.printStackTrace();
        } 
    }
    
    @Override
    public boolean existsProject(String nit, String email) {
        String sql = "SELECT COUNT(*) FROM project WHERE project_id = ?";

        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            System.out.println("🔍 Verificando NIT: " + nit ); // 👈 Depuración

            pstmt.setString(1, nit);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ Empresas encontradas: " + count); // 👈 Depuración
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public int getNextProjectId() {
        // Consulta SQL para obtener el máximo project_id y sumar 1
        String sql = "SELECT COALESCE(MAX(project_id), 0) + 1 FROM project";

        try (Connection conexion = conectar(); // Establece la conexión a la base de datos
             PreparedStatement pstmt = conexion.prepareStatement(sql); // Prepara la consulta
             ResultSet rs = pstmt.executeQuery()) { // Ejecuta la consulta

            if (rs.next()) { // Si hay resultados
                int nextId = rs.getInt(1); // Obtiene el siguiente ID
                System.out.println("📌 Siguiente project_id disponible: " + nextId); // Depuración
                return nextId; // Retorna el siguiente ID
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        }
        return 1; // Si hay un error o no hay proyectos, devuelve 1 por defecto
    }

    @Override
    public boolean existsCompany(String nit, String email) {
        String sql = "SELECT COUNT(*) FROM company WHERE companynit = ? OR companyemail = ?";

        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            System.out.println("🔍 Verificando NIT: " + nit + " | Email: " + email); // 👈 Depuración

            pstmt.setString(1, nit);
            pstmt.setString(2, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ Empresas encontradas: " + count); // 👈 Depuración
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    

    
}
