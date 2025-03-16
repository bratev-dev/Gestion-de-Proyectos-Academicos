package com.mycompany.gestionproyectosacademicos.entities;

/**
 * Clase que representa un usuario en el sistema.
 */
public class User {
    private int id;
    private String email;
    private String password;
    private String role; // Puede ser ADMIN, COORDINADOR, ESTUDIANTE, EMPRESA

    public User(int id, String email, String password, String role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", email=" + email + ", role=" + role + '}';
    }
}
