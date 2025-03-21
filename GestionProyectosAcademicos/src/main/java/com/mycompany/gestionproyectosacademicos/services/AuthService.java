
package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.filter.IFilter;
import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;
import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.infra.Messages;
import com.mycompany.gestionproyectosacademicos.presentation.GUICompany;
import com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;
//import com.mycompany.gestionproyectosacademicos.presentacion.GUIStudent;
import javax.swing.JFrame;

/**
 * Servicio de autenticación
 */
public class AuthService {
    private User authenticatedUser; 
    private final IUserRepository userRepository;
    //private ICompanyRepository companyRepository;
    //private final IProjectRepository projectRepository = Factory.getInstance().getRepository(IProjectRepository.class, "ARRAYS");

    public IUserRepository getUserRepository() {
        return userRepository;
    }

    public AuthService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

     public JFrame login(String email, String password) {
        User user = userRepository.validarUsuario(email, password);
        
        if (user == null) {
            return null;
        }
        return getGUIForRole(user);
    }

    private JFrame getGUIForRole(User user) {
        switch (user.getRole()) {
            case "ADMIN":
              //  return new GUIAdmin();
            case "STUDENT":
                //return new GUIStudent();
            case "COMPANY":
                ICompanyRepository companyRepo = Factory.getInstance().getRepository(ICompanyRepository.class, "POSTGRE");

                if (companyRepo == null) {
                    Messages.showMessageDialog("❌ Error: No se encontró el repositorio de Company en Factory", "Error");
                    return null;
                }
                
                CompanyService companyService = new CompanyService(companyRepo);
                
                GUICompany guiCompany = new GUICompany(companyService, String.valueOf(user.getId()));
                
                //GUICompany guiCompany = new GUICompany(user, companyService);
                guiCompany.setExtendedState(JFrame.MAXIMIZED_BOTH);
                return guiCompany;
                   
            case "COORDINATOR":
                ICoordinatorRepository coordRepo = Factory.getInstance().getRepository(ICoordinatorRepository.class, "POSTGRE");
                CoordinatorService coordService = new CoordinatorService(coordRepo);
                
                GUICoordinator instance = new GUICoordinator(coordService, user.getId());
                instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
                return instance;
            default:
                return null;
        }
    }
}