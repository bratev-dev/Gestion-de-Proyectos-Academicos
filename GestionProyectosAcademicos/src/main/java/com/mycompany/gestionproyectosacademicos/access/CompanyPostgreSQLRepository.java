package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.Sector;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Implementación del repositorio con PostgreSQL
 */
public class CompanyPostgreSQLRepository implements ICompanyRepository {

    private Connection conn;

    public void connect() {
        // PostgreSQL connection string
        String url = "jdbc:postgresql://localhost:5432/gestion_proyectos";
        String user = "postgres";
        String password = "software";

        try {
            conn = DriverManager.getConnection(url, user, password);
        } catch (SQLException ex) {
            Logger.getLogger(CompanyPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void disconnect() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public boolean save(Company newCompany, String password) {
    try {
        // Validar la empresa
        if (newCompany == null || newCompany.getNit().isBlank() || newCompany.getName().isBlank() 
            || newCompany.getEmail().isBlank() || password.isBlank()) {
            return false;
        }

        this.connect();

        // Paso 1: Guardar el usuario en la tabla user
        String userSql = "INSERT INTO public.user (email, password, role) VALUES (?, ?, ?)";
        PreparedStatement userStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
        userStmt.setString(1, newCompany.getEmail());
        userStmt.setString(2, password); // Contraseña proporcionada
        userStmt.setString(3, "COMPANY"); // Rol fijo para empresas
        userStmt.executeUpdate();

        // Obtener el ID del usuario recién creado
        ResultSet generatedKeys = userStmt.getGeneratedKeys();
        int userId = -1;
        if (generatedKeys.next()) {
            userId = generatedKeys.getInt(1);
        } else {
            throw new SQLException("No se pudo obtener el ID del usuario.");
        }

        // Paso 2: Guardar la empresa en la tabla company
        String companySql = "INSERT INTO public.company (name, nit, email, sector, contact_names, contact_last_names, contact_phone_number, contact_position, user_id) "
                          + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement companyStmt = conn.prepareStatement(companySql);
        companyStmt.setString(1, newCompany.getName());
        companyStmt.setString(2, newCompany.getNit());
        companyStmt.setString(3, newCompany.getEmail());
        companyStmt.setString(4, newCompany.getSector());
        companyStmt.setString(5, newCompany.getContactNames());
        companyStmt.setString(6, newCompany.getContactLastNames());
        companyStmt.setString(7, newCompany.getContactPhoneNumber());
        companyStmt.setString(8, newCompany.getContactPosition());
        companyStmt.setInt(9, userId); // user_id obtenido del registro en la tabla user

        companyStmt.executeUpdate();
        this.disconnect();
        return true;
    } catch (SQLException ex) {
        Logger.getLogger(CompanyPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        this.disconnect(); // Asegurarse de cerrar la conexión
    }
    return false;
}
    @Override
    public boolean existsCompany(String nit, String email) {
        this.connect();
        String sql = "SELECT COUNT(*) FROM public.company WHERE nit = ? OR email = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) { // Cambia connection por conn
            pstmt.setString(1, nit);
            pstmt.setString(2, email);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Si COUNT(*) > 0, ya existe una empresa con ese NIT o email
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompanyPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
        }finally {
        this.disconnect(); // Cerrar la conexión a la base de datos
    }
        return false;
    }
}