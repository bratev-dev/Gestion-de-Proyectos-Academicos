package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * Implementación del repositorio con PostgreSQL
 */
public class CompanyPostgreSQLRepository implements ICompanyRepository {

    private Connection conn;

    // Constructor que acepta una conexión
    public CompanyPostgreSQLRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean save(Company company) {
        ConexionPostgreSQL.conectar();
        
        if (existsCompany(company.getNit(), company.getEmail())) {
            JOptionPane.showMessageDialog(null, "Error: Empresa ya registrada con este NIT o email.","Error",JOptionPane.INFORMATION_MESSAGE);
            return false; 
        }
        
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
                     "contactName, contactLastName, contactNumber, contactPosition) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (Connection conexion = ConexionPostgreSQL.conectar();
                PreparedStatement pstmt = conexion.prepareStatement(sql)
                ) {

            pstmt.setString(1, company.getNit());
            pstmt.setString(2, company.getName());
            pstmt.setString(3, company.getEmail());
            pstmt.setString(4, company.getSector());
            pstmt.setString(5, company.getContactNames());
            pstmt.setString(6, company.getContactLastNames());
            pstmt.setString(7, company.getContactPhoneNumber() );
            pstmt.setString(8, company.getContactPosition());

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "✅ Empresa "
                    + "registrada con éxito", "Éxito",
                    JOptionPane.INFORMATION_MESSAGE);
            return true;

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "❌ Error al guardar "
                    + "la empresa: " + e.getMessage(), "Error",
                    JOptionPane.ERROR_MESSAGE);
            return false;
        }
    }

    @Override
    public boolean existsCompany(String nit, String email) {
        String sql = "SELECT COUNT(*) FROM public.company WHERE nit = ? OR email = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nit);
            pstmt.setString(2, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Si COUNT(*) > 0, ya existe una empresa con ese NIT o email
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompanyPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public Company findByNIT(String idCompany) {
        String sql = "SELECT * FROM company WHERE companyNIT = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, idCompany);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Company(
                    rs.getString("companyNIT"),
                    rs.getString("companyName"),
                    rs.getString("companyEmail"),
                    rs.getString("companySector"),
                    rs.getString("contactName"),
                    rs.getString("contactLastName"),
                    rs.getString("contactNumber"),
                    rs.getString("contactPosition")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Retorna null si la empresa no se encuentra
    }
    
}