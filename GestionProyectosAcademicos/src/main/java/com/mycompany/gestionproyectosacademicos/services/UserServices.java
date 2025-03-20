package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;

public class UserServices {
    private UserArrayRepository userRepository;
    
    public UserServices() {
        this.userRepository = new UserArrayRepository(); // Usando repositorio en memoria
    }

    public boolean autenticarUsuario(String email, String password) {
        User user = userRepository.validarUsuario(email, password);
        return user != null;
    }
}
