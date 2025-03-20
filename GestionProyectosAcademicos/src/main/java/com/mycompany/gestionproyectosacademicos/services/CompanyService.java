package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;

public class CompanyService {

    private final ICompanyRepository companyRepository;
    private final IUserRepository userRepository;

    /**
     * Constructor que recibe los repositorios como dependencias.
     *
     * @param companyRepository Repositorio de empresas.
     * @param userRepository    Repositorio de usuarios.
     */
    public CompanyService(ICompanyRepository companyRepository, IUserRepository userRepository) {
        this.companyRepository = companyRepository;
        this.userRepository = userRepository;
    }

    /**
     * Registra una nueva empresa y su usuario asociado.
     *
     * @param company  La empresa a registrar.
     * @param password La contraseña del usuario asociado.
     * @return true si el registro fue exitoso, false en caso contrario.
     */
    public boolean registerCompany(Company company) {
        // Validar si ya existe una empresa con el mismo NIT o correo electrónico
        if (companyRepository.existsCompany(company.getNit(), company.getEmail())) {
            System.out.println("Ya existe una empresa con el mismo NIT o correo electrónico.");
            return false; // No continuar si ya existe
        }

        boolean companySaved = companyRepository.save(company);
        if (!companySaved) {
            System.out.println("No se pudo guardar la empresa.");
            return false; // Si no se pudo guardar la empresa, no continuar
        }else{
            System.out.println("Empresa registrada exitosamente.");
        }

        
        
        // Paso 1: Guardar el usuario
       /* if(companySaved ){
            boolean userSaved = userRepository.saveUser(company.getNit() , company.getEmail(), password, "COMPANY");
            if (!userSaved) {
                System.out.println("No se pudo guardar el usuario.");
                return false; // Si no se pudo guardar el usuario, no continuar
            }
        }*/
  
        // Paso 4: Guardar la empresa
        
        return true;
    }
}