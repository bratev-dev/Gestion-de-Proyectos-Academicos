/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author rubei
 */
public class CompanyPostgreSQLRepository implements ICompanyRepository {

    private static final String URL = "jdbc:postgresql://localhost:5432/projectmanagement";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "alexis";
    
    private Connection conectar() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }

    @Override
    public boolean save(Company newCompany) {
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, contactName, contactLastName, contactNumber, contactPosition) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, newCompany.getNit());
            pstmt.setString(2, newCompany.getName());
            pstmt.setString(3, newCompany.getEmail());
            pstmt.setString(4, newCompany.getSector());
            pstmt.setString(5, newCompany.getContactName());
            pstmt.setString(6, newCompany.getContactLastName());
            pstmt.setString(7, newCompany.getContactNumber());
            pstmt.setString(8, newCompany.getContactPosition());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Company findByNIT(String nit) {
        String sql = "SELECT * FROM company WHERE companyNIT = ?";

        try (Connection conexion = conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, nit);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Company(
                    rs.getString("companyNIT"),
                    rs.getString("companyName"),
                    rs.getString("companyEmail"),
                    rs.getString("companySector"),
                    rs.getString("contactName"),
                    rs.getString("contactLastName"),
                    rs.getString("contactNumber"),
                    rs.getString("contactPosition")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
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

