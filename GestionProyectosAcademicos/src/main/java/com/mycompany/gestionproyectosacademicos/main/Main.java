/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.main;

import com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;
import com.mycompany.gestionproyectosacademicos.presentation.GUILogin;

import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;
import com.mycompany.gestionproyectosacademicos.presentacion.GUICoordinator;
import com.mycompany.gestionproyectosacademicos.presentacion.GUILogin;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.UserServices;
import javax.swing.JFrame;

/**
 *
 * @author bryan
 */
public class Main {
    public static void main(String[] args) {
        /*Example: ICompanyRepository repository = Factory.getInstance().getRepository("ARRAYS");// Podria ir SQLITE*/ 
        /*Inicializar servicio: (Example: CompanyService service = new CompanyService(repository);)*/

        /*Creación de instancia de menú principal: (Example: GUIMenu instance = new GUIMenu(service);)*/
        /*
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
        */
      
        GUICoordinator instance = new GUICoordinator();
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
        
      
        /*IUserRepository userRepo = new UserArrayRepository(); // Usando datos en memoria
        AuthService authService = new AuthService(userRepo);

        GUILogin loginGUI = new GUILogin(authService);
        loginGUI.setVisible(true);*/
       
    }
}
