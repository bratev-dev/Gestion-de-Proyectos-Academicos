package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.User;
import java.util.ArrayList;
import java.util.List;

/**
 * Repositorio en memoria con una lista de usuarios predefinidos
 */
public class UserArrayRepository implements IUserRepository {
    private static List<User> users;

    public UserArrayRepository() {
        if (users == null) {
            users = new ArrayList<>();
            users.add(new User(1, "admin@gmail.com", "admin123", "ADMIN"));
            users.add(new User(2, "coordinador@gmail.com", "coord123", "COORDINATOR"));
            users.add(new User(3, "estudiante@gmail.com", "estudiante123", "STUDENT"));
            users.add(new User(4, "empresa@gmail.com", "empresa123", "COMPANY"));
        }
    }

    /**
     * Método para validar si un usuario existe con el correo y contraseña dados
     */
    @Override
    public User validarUsuario(String email, String password) {
        for (User user : users) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    /**
     * Método para obtener todos los usuarios (solo para pruebas)
     */
    public List<User> listarUsuarios() {
        return users;
    }

    /**
     * Método para guardar un nuevo usuario en la lista en memoria
     */
    @Override
    public boolean saveUser(String email, String password, String role) {
        // Validar que el email no esté duplicado
        for (User user : users) {
            if (user.getEmail().equals(email)) {
                return false; // El email ya está registrado
            }
        }

        // Crear un nuevo usuario
        int newId = users.size() + 1; // Generar un nuevo ID
        User newUser = new User(newId, email, password, role);
        users.add(newUser);
        return true;
    }

    /**
     * Método para obtener el ID de un usuario por su email
     */
    @Override
    public int getUserIdByEmail(String email) {
        for (User user : users) {
            if (user.getEmail().equals(email)) {
                return user.getId(); // Retornar el ID del usuario
            }
        }
        return -1; // Retornar -1 si no se encuentra el usuario
    }
}