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

    public void saveCompany(int companyNIT, String companyEmail, String companyName, String companySector, 
                        String contactName, String contactLastName, int contactNumber, String contactPosition) {
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
                     "contactName, contactLastName, contactNumber, contactPosition) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (Connection conexion = ConexionPostgreSQL.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            pstmt.setInt(1, companyNIT);
            pstmt.setString(2, companyName);
            pstmt.setString(3, companyEmail);
            pstmt.setString(4, companySector);
            pstmt.setString(5, contactName);
            pstmt.setString(6, contactLastName);
            pstmt.setInt(7, contactNumber);
            pstmt.setString(8, contactPosition);

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "✅ Empresa registrada con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar la empresa: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

}
