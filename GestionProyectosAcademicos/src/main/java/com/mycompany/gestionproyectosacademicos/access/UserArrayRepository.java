/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.User;
import java.util.ArrayList;
import java.util.List;

/**
 * Repositorio en memoria con una lista de usuarios predefinidos
 */
public class UserArrayRepository implements IUserRepository{
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
}
