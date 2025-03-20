/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;

/**
 *
 * @author ANACONA
 */
public interface ICompanyRepository {
    public boolean save(Company newCompany);
    public Company findByNIT(String nit) ;
}
