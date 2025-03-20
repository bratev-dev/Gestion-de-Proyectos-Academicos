
package com.mycompany.gestionproyectosacademicos.access;


import com.mycompany.gestionproyectosacademicos.entities.User;

/**
 * Interfaz para el repositorio de usuarios
 */
public interface IUserRepository {
    /**
     * Busca un usuario por correo y contraseña
     * 
     * @param email Correo del usuario
     * @param password Contraseña del usuario
     * @return Usuario si se encuentra, null en caso contrario
     */
    User validarUsuario(String email, String password);
    boolean saveUser(int id, String email, String password, String role);
    int getUserIdByEmail(String email);
}