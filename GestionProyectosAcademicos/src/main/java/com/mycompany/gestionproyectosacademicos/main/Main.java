/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.main;

import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;
import com.mycompany.gestionproyectosacademicos.filter.AcademicPeriodFilter;
import com.mycompany.gestionproyectosacademicos.filter.IFilter;
import com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;
import com.mycompany.gestionproyectosacademicos.presentation.GUILogin;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.CoordinatorService;
import com.mycompany.gestionproyectosacademicos.services.UserServices;

import javax.swing.JFrame;

public class Main {
    public static void main(String[] args) {
        IUserRepository userRepo = Factory.getInstance().getRepository(IUserRepository.class, "ARRAYS"); // Usando datos en memoria
        //IUserRepository userRepo = Factory.getInstance().getRepository(IUserRepository.class, "POSTGRE"); // Usando datos en memoria
        AuthService authService = new AuthService(userRepo);
        
        GUILogin loginGUI = new GUILogin(authService);
        loginGUI.setVisible(true);
        
        IFilter filter = new AcademicPeriodFilter();
        ICoordinatorRepository coordRepo = Factory.getInstance().getRepository(ICoordinatorRepository.class, "ARRAYS");
        CoordinatorService coordSer = new CoordinatorService(coordRepo);
        GUICoordinator coord = new GUICoordinator(coordSer, 2, filter);
    }
}
