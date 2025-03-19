/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.services;

/**
 *
 * @author rubei
 */


import com.mycompany.gestionproyectosacademicos.access.CompanyPostgreSQLRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class CompanyService {

    public boolean existsCompany(String nit, String email) {
        String sql = "SELECT COUNT(*) FROM company WHERE companynit = ? OR companyemail = ?";
        
        try (Connection conexion = CompanyPostgreSQLRepository.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, nit);
            pstmt.setString(2, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0; // Si COUNT(*) > 0, ya existe una empresa con ese NIT o email
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean saveCompany(Company company) {
        if (existsCompany(company.getNit(), company.getEmail())) {
            JOptionPane.showMessageDialog(null, "Error: Empresa ya registrada con este NIT o email.","Error",JOptionPane.INFORMATION_MESSAGE);
            return false; 
        }
        
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
                     "contactName, contactLastName, contactNumber, contactPosition) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (Connection conexion = CompanyPostgreSQLRepository.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setString(1, company.getNit());
            pstmt.setString(2, company.getName());
            pstmt.setString(3, company.getEmail());
            pstmt.setString(4, company.getSector());
            pstmt.setString(5, company.getContactName());
            pstmt.setString(6, company.getContactLastName());
            pstmt.setString(7, company.getContactNumber());
            pstmt.setString(8, company.getContactPosition());

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "✅ Empresa "
                    + "registrada con éxito", "Éxito",
                    JOptionPane.INFORMATION_MESSAGE);
            return true;

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar "
                    + "la empresa: " + e.getMessage(), "Error",
                    JOptionPane.ERROR_MESSAGE);
            return false;
        }
    }

}
