
package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
//import com.mycompany.gestionproyectosacademicos.presentacion.GUIAdmin;
//import com.mycompany.gestionproyectosacademicos.presentacion.GUICompany;
import com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;
//import com.mycompany.gestionproyectosacademicos.presentacion.GUIStudent;
import javax.swing.JFrame;

/**
 * Servicio de autenticación
 */
public class AuthService {
    private final IUserRepository userRepository;

    public AuthService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public JFrame login(String email, String password) {
        User user = userRepository.validarUsuario(email, password);
        if (user == null) {
            return null; // Manejar esto en la interfaz gráfica
        }
        return getGUIForRole(user);
    }

    private JFrame getGUIForRole(User user) {
        switch (user.getRole()) {
            /*case "ADMIN":
                return new GUIAdmin();
            case "STUDENT":
                return new GUIStudent();
            case "COMPANY":
                return new GUICompany();
             */       
            case "COORDINATOR":
                GUICoordinator instance = new GUICoordinator();
                instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
                return instance;
            default:
                return null;
        }
    }
}