/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author rubei
 */


import com.mycompany.gestionproyectosacademicos.entities.ConexionPostgreSQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class SaveDateCompany {

    public void saveCompany(Company company) {
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
                     "contactName, contactLastName, contactNumber, contactPosition) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (Connection conexion = ConexionPostgreSQL.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setInt(1, company.getNit());
            pstmt.setString(2, company.getName());
            pstmt.setString(3, company.getEmail());
            pstmt.setString(4, company.getSector());
            pstmt.setString(5, company.getContactName());
            pstmt.setString(6, company.getContactLastName());
            pstmt.setInt(7, company.getContactNumber());
            pstmt.setString(8, company.getContactPosition());

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "✅ Empresa registrada con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar la empresa: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

}
