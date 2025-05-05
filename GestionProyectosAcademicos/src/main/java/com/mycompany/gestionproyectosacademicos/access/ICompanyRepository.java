package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author rubei
 */
public interface ICompanyRepository {
    boolean save(Company newCompany);
    boolean existsCompany(Long nit, String email);
    Company findByNIT(Long idCompany);
}