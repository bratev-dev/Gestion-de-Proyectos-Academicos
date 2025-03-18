package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;
import com.mycompany.gestionproyectosacademicos.access.IProjectRepository;
import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.access.ProjectArrayRepository;
import com.mycompany.gestionproyectosacademicos.infra.Messages;
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
    //private final IProjectRepository projectRepository = Factory.getInstance().getRepository(IProjectRepository.class, "ARRAYS");

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
                ICoordinatorRepository coordRepo = Factory.getInstance().getRepository(ICoordinatorRepository.class, "ARRAYS");
                /*if(coordRepo != null) {
                    Messages.showMessageDialog("Repositorio traido con la fábrica", "Atención");
                }else{
                    Messages.showMessageDialog("Repositorio no encontrado en AuthService", "Atención");
                }*/
                CoordinatorService coordService = new CoordinatorService(coordRepo);
                /*if(coordService != null) {
                    Messages.showMessageDialog("Servicio creado con el repositorio", "Atención");
                }*/
                
                GUICoordinator instance = new GUICoordinator(coordService, user.getId());
                instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
                return instance;
            default:
                return null;
        }
    }
}
