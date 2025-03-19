/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.services;

/**
 *
 * @author rubei
 */


import com.mycompany.gestionproyectosacademicos.access.CompanyPostgreSQLRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;


public class CompanyService {
    private ICompanyRepository companyRepository;

    public CompanyService(ICompanyRepository companyRepository) {
        this.companyRepository = companyRepository;
    }

    public boolean registrarEmpresa(String nit, String name, String email, String sector,
                                    String contactName, String contactLastName, String contactNumber,
                                    String contactPosition) {
        try {

            Company company = new Company(nit, name, email, sector, contactName, contactLastName, contactNumber, contactPosition);

            return companyRepository.save(company);
        } catch (NumberFormatException e) {
            System.out.println("Error: El NIT debe ser un número válido.");
            return false;
        }
    }

}
