package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.User;


public class CompanyService {
    private final ICompanyRepository companyRepository;
    private IUserRepository userRepository;

    // Constructor que recibe el repositorio para manejar la base de datos
    public CompanyService(ICompanyRepository companyRepository, IUserRepository userRepository) {
        this.companyRepository = companyRepository;
        this.userRepository = userRepository;
    }
    
    public CompanyService(ICompanyRepository companyRepository) {
        this.companyRepository = companyRepository;
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

        // Paso 4: Guardar la empresa
        boolean companySaved = companyRepository.save(company);
        if (!companySaved) {
            System.out.println("No se pudo guardar la empresa.");
            return false; // Si no se pudo guardar la empresa, no continuar
        }else{
            System.out.println("Empresa registrada exitosamente.");
        }

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

    
    public Company getCompany(String idCompany) {
        
        //return companyRepository.findByNIT("123456789");
        return (Company) companyRepository; //esto no va
    }
    
    
}
