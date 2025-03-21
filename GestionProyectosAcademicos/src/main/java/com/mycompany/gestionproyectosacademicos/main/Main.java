package com.mycompany.gestionproyectosacademicos.main;

import com.mycompany.gestionproyectosacademicos.presentation.GUIStudentProjectList;
import com.mycompany.gestionproyectosacademicos.access.Factory;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;
import com.mycompany.gestionproyectosacademicos.presentation.GUICompany;
import com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;
import com.mycompany.gestionproyectosacademicos.presentation.GUILogin;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.CompanyService;
import com.mycompany.gestionproyectosacademicos.services.UserServices;
import com.mycompany.gestionproyectosacademicos.services.CoordinatorService;

import javax.swing.JFrame;

public class Main {
    public static void main(String[] args) {
        IUserRepository userRepo = Factory.getInstance().getRepository(IUserRepository.class, "POSTGRE");
        ICompanyRepository compRepo = Factory.getInstance().getRepository(ICompanyRepository.class, "POSTGRE");
        UserServices userService = new UserServices(userRepo);
        CompanyService companyService = new CompanyService(compRepo, userRepo);
        AuthService authService = new AuthService(userRepo); // Crear la instancia del servicio de autenticación
        GUILogin login = new GUILogin(authService, userService, companyService); // Pasar la instancia al constructor
        login.setVisible(true);
    }
}
