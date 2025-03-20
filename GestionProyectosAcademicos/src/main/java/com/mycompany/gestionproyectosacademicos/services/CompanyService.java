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
    public boolean registerCompany(Company company, String password) {
        // Validar si ya existe una empresa con el mismo NIT o correo electrónico
        if (companyRepository.existsCompany(company.getNit(), company.getEmail())) {
            System.out.println("Ya existe una empresa con el mismo NIT o correo electrónico.");
            return false; // No continuar si ya existe
        }

        // Paso 1: Guardar el usuario
        boolean userSaved = userRepository.saveUser(company.getEmail(), password, "COMPANY");
        if (!userSaved) {
            System.out.println("No se pudo guardar el usuario.");
            return false; // Si no se pudo guardar el usuario, no continuar
        }

        // Paso 2: Obtener el ID del usuario recién creado
        int userId = userRepository.getUserIdByEmail(company.getEmail());
        if (userId == -1) {
            System.out.println("No se pudo obtener el ID del usuario.");
            return false; // Si no se pudo obtener el ID del usuario, no continuar
        }

        // Paso 3: Asignar el ID del usuario a la empresa
        company.setUserId(userId);

        // Paso 4: Guardar la empresa
        boolean companySaved = companyRepository.save(company, password);
        if (!companySaved) {
            System.out.println("No se pudo guardar la empresa.");
            return false; // Si no se pudo guardar la empresa, no continuar
        }

        System.out.println("Empresa registrada exitosamente.");
        return true;
    }
}