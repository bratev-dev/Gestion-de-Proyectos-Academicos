/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author rubei
 */

 import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;


public class SaveDateUser {
      

        
           
         
    public boolean saveUser(User user) {
        String sql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
        
        try (Connection conexion = ConexionPostgreSQL.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            // Hashear la contraseña antes de guardarla
           // String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword() );
            pstmt.setString(3, user.getRole());

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "✅ Usuario registrado con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);

            return true;
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar El usuario: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();
            return false;
        }
    }
}
 
