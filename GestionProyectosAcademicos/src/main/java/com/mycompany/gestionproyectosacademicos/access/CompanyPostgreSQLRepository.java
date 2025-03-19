/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author rubei
 */
public class CompanyPostgreSQLRepository implements ICompanyRepository {

    private static final String URL = "jdbc:postgresql://localhost:5432/projectmanagement";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "1234";
    private Connection conexion;

    public CompanyPostgreSQLRepository(Connection conexion) {
        this.conexion = conexion;
    }
     public static Connection conectar() {
        Connection conexion = null;
        try {
            Class.forName("org.postgresql.Driver"); // Cargar el driver
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
           /* JOptionPane.showMessageDialog(null
                    ,"✅ Conexión exitosa a PostgreSQL"
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            */
        } catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null
                    ,"❌ Error: No se encontró el Driver de PostgreSQL"
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
            e.printStackTrace();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null
                    ,"❌ Error de conexión: "
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
        }
        return conexion;
    }

     
    public boolean existsCompany(String nit, String email) {
        String sql = "SELECT COUNT(*) FROM company WHERE companynit = ? OR companyemail = ?";

        try (Connection conexion = CompanyPostgreSQLRepository.conectar();
             PreparedStatement pstmt = conexion.prepareStatement(sql)) {

            System.out.println("🔍 Verificando NIT: " + nit + " | Email: " + email); // 👈 Depuración

            pstmt.setString(1, nit);
            pstmt.setString(2, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ Empresas encontradas: " + count); // 👈 Depuración
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean save(Company company) {
        conectar();
        
        if (existsCompany(company.getNit(), company.getEmail())) {
            JOptionPane.showMessageDialog(null, "Error: Empresa ya registrada con este NIT o email.","Error",JOptionPane.INFORMATION_MESSAGE);
            return false; 
        }
        
        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
                     "contactName, contactLastName, contactNumber, contactPosition) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (Connection conexion = CompanyPostgreSQLRepository.conectar();
                PreparedStatement pstmt = conexion.prepareStatement(sql)
                ) {

            pstmt.setString(1, company.getNit());
            pstmt.setString(2, company.getName());
            pstmt.setString(3, company.getEmail());
            pstmt.setString(4, company.getSector());
            pstmt.setString(5, company.getContactName());
            pstmt.setString(6, company.getContactLastName());
            pstmt.setString(7, company.getContactNumber());
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
    
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Company> listAll() {
        
         List<Company> companies = new ArrayList<>();
        String sql = "SELECT * FROM company";

        try (Statement stmt = conexion.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Company company = new Company(
                    rs.getString("companyNIT"),
                    rs.getString("companyName"),
                    rs.getString("companyEmail"),
                    rs.getString("companySector"),
                    rs.getString("contactName"),
                    rs.getString("contactLastName"),
                    rs.getString("contactNumber"),
                    rs.getString("contactPosition")
                );
                companies.add(company);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return companies;
       // throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
