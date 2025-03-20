/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author ANACONA
 */
public class ProjectPostgreSQLRepository implements IProjectRepository{
    private static final String URL = "jdbc:postgresql://localhost:5432/projectmanagement";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "alexis";
    private Connection conectar() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
    
    @Override
    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Project getProjectById(int projectId) {
        
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
  
    
    @Override
    public void updateProjectState(int projectId, String newState, String comment) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void saveProject(Project project) {
        String sql = "INSERT INTO project (name, summary, objectives, description, max_time, budget, date, state, companyNIT) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, project.getName());
            pstmt.setString(2, project.getSummary());
            pstmt.setString(3, project.getObjectives());
            pstmt.setString(4, project.getDescription());
            pstmt.setInt(5, project.getMaxTime());
            pstmt.setBigDecimal(6, project.getBudget());
            pstmt.setDate(7, Date.valueOf(project.getDate())); // Convertir LocalDate a SQL Date
            pstmt.setString(8, "Recibido"); // Estado inicial por defecto
            pstmt.setString(9, project.getCompany().getNit()); // Relación con la empresa

            
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
    
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void deleteProject(int projectId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public boolean existsProjec(String nit, String email) {
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
    

    
}
