package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.CompanyPostgreSQLRepository;
import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class UserServices {
    private UserArrayRepository userRepository;

    public UserServices() {
        this.userRepository = new UserArrayRepository(); // Usando repositorio en memoria
    }

    public boolean autenticarUsuario(String email, String password) {
        User user = userRepository.validarUsuario(email, password);
        return user != null;
    }
    public boolean saveUser(User user) {
        String sql = "INSERT INTO users (nit, email, password, role) VALUES (?,?, ?, ?)";
        
        try (Connection conexion = CompanyPostgreSQLRepository.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            // Hashear la contraseña antes de guardarla
           // String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            pstmt.setInt(1, user.getId());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword() );
            pstmt.setString(4, user.getRole());

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
