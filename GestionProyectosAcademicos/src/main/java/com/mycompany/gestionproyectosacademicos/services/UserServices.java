package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.User;
import javax.swing.JOptionPane;

public class UserServices {

    private IUserRepository userRepository;

    /**
     * Constructor que recibe el repositorio como dependencia.
     *
     * @param userRepository Implementación de IUserRepository.
     */
    public UserServices(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * Autentica a un usuario verificando su correo y contraseña.
     *
     * @param email    Correo electrónico del usuario.
     * @param password Contraseña del usuario.
     * @return true si la autenticación es exitosa, false en caso contrario.
     */
    public boolean autenticarUsuario(String email, String password) {
        User user = userRepository.validarUsuario(email, password);
        return user != null;
    }

    /**
     * Guarda un nuevo usuario en la base de datos.
     *
     * @param user Usuario a guardar.
     * @return true si el usuario se guardó correctamente, false en caso contrario.
     */
    public boolean saveUser(User user) {
        // Validar si el usuario ya existe
        if (userRepository.getUserIdByEmail(user.getEmail()) != -1) {
            JOptionPane.showMessageDialog(null, "❌ Ya existe un usuario con el mismo correo electrónico.", "Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }

        // Guardar el usuario en la base de datos
        boolean saved = userRepository.saveUser(user.getEmail(), user.getPassword(), user.getRole());
        if (saved) {
            JOptionPane.showMessageDialog(null, "✅ Usuario registrado con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);
            return true;
        } else {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar el usuario.", "Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }
    }
}