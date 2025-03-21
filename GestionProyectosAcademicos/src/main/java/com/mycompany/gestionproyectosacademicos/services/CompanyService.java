package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.User;


public class CompanyService {
    private final ICompanyRepository companyRepository;
    //private final IUserRepository userRepository;

    // Constructor que recibe el repositorio para manejar la base de datos
    public CompanyService(ICompanyRepository companyRepository, IUserRepository userRepository) {
        this.companyRepository = companyRepository;
        //this.userRepository = userRepository;
    }
    
    public CompanyService(ICompanyRepository companyRepository) {
        this.companyRepository = companyRepository;
    }

    // Método para registrar una empresa con validaciones
    public boolean registerCompany(Company company, String password) {
        // Validar si ya existe una empresa con el mismo NIT o correo electrónico
        if (companyRepository.existsCompany(company.getNit(), company.getEmail())) {
            System.out.println("Ya existe una empresa con el mismo NIT o correo electrónico.");
            return false; // No continuar si ya existe
        }

        // Paso 1: Guardar el usuario
        /*boolean userSaved = userRepository.saveUser(company.getEmail(), password, "COMPANY");
        if (!userSaved) {
            System.out.println("No se pudo guardar el usuario.");
            return false; // Si no se pudo guardar el usuario, no continuar
        }

        // Paso 2: Obtener el ID del usuario recién creado
        int userId = userRepository.getUserIdByEmail(company.getEmail());
        if (userId == -1) {
            System.out.println("No se pudo obtener el ID del usuario.");
            return false; // Si no se pudo obtener el ID del usuario, no continuar
        }*/

        // Paso 3: Asignar el ID del usuario a la empresa
        //company.setUserId(userId);

        // Paso 4: Guardar la empresa
        boolean companySaved = companyRepository.save(company, password);
        if (!companySaved) {
            System.out.println("No se pudo guardar la empresa.");
            return false; // Si no se pudo guardar la empresa, no continuar
        }

        System.out.println("Empresa registrada exitosamente.");
        return true;
    }
    
    
    // Método privado para validar que los datos no estén vacíos
    private boolean validarEmpresa(Company company) {
        if (company.getNit() == null) return false;
        if (company.getName() == null || company.getName().trim().isEmpty()) return false;
        if (company.getEmail() == null || company.getEmail().trim().isEmpty()) return false;
        if (company.getSector() == null || company.getSector().trim().isEmpty()) return false;
        if (company.getContactNames() == null || company.getContactNames().trim().isEmpty()) return false;
        if (company.getContactLastNames() == null || company.getContactLastNames().trim().isEmpty()) return false;
        if (company.getContactPhoneNumber()== null || company.getContactPhoneNumber().trim().isEmpty()) return false;
        if (company.getContactPosition() == null || company.getContactPosition().trim().isEmpty()) return false;

        return true; // Si todo está correcto, devuelve true
    }
/*
    public Coordinator getCoordinator(int idCoordinator) {
        return repository.getCoordinator(idCoordinator);
    }
    */ 
    
    public Company getCompany(String idCompany) {
        
        //return companyRepository.findByNIT("123456789");
        return (Company) companyRepository; //esto no va
    }
    
    
}
