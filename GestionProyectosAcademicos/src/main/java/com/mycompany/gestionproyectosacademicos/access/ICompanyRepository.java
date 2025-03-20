/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;

/**
 *
 * @author rubei
 */
public interface ICompanyRepository {
    boolean save(Company newCompany, String password);
    boolean existsCompany(String nit, String email);
}
