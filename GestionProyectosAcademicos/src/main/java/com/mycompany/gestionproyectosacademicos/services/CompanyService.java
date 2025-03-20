/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.User;

/**
 *
 * @author ANACONA
 */
public class CompanyService {
    private final ICompanyRepository companyRepository;

    // Constructor que recibe el repositorio para manejar la base de datos
    public CompanyService(ICompanyRepository companyRepository) {
        this.companyRepository = companyRepository;
    }

    // Método para registrar una empresa con validaciones
    public boolean registerCompany(Company company) {
        if (!validarEmpresa(company)) {
            return false; // Si la validación falla, no se guarda la empresa
        }
        return companyRepository.save(company);
    }
    
    
    // Método privado para validar que los datos no estén vacíos
    private boolean validarEmpresa(Company company) {
        if (company.getNit() == null) return false;
        if (company.getName() == null || company.getName().trim().isEmpty()) return false;
        if (company.getEmail() == null || company.getEmail().trim().isEmpty()) return false;
        if (company.getSector() == null || company.getSector().trim().isEmpty()) return false;
        if (company.getContactName() == null || company.getContactName().trim().isEmpty()) return false;
        if (company.getContactLastName() == null || company.getContactLastName().trim().isEmpty()) return false;
        if (company.getContactNumber() == null || company.getContactNumber().trim().isEmpty()) return false;
        if (company.getContactPosition() == null || company.getContactPosition().trim().isEmpty()) return false;

        return true; // Si todo está correcto, devuelve true
    }
/*
    public Coordinator getCoordinator(int idCoordinator) {
        return repository.getCoordinator(idCoordinator);
    }
    */   
    
    public Company getCompany(String idCompany) {
        
        return companyRepository.findByNIT("123456789");
    }
    
    
}
