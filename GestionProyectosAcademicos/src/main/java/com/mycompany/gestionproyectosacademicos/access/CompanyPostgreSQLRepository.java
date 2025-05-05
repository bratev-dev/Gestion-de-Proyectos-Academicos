//package com.mycompany.gestionproyectosacademicos.access;
//
//import com.mycompany.gestionproyectosacademicos.entities.Company;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import javax.swing.JOptionPane;
//
///**
// * Implementación del repositorio con PostgreSQL
// */
//public class CompanyPostgreSQLRepository implements ICompanyRepository {
//
//    private Connection conn;
//
//    // Constructor que acepta una conexión
//    public CompanyPostgreSQLRepository(Connection conn) {
//        this.conn = conn;
//    }
//
//    @Override
//    public boolean save(Company company) {
//        ConexionPostgreSQL.conectar();
//        
//        if (existsCompany(company.getNit(), company.getEmail())) {
//            JOptionPane.showMessageDialog(null, "Error: Empresa ya registrada con este NIT o email.","Error",JOptionPane.INFORMATION_MESSAGE);
//            return false; 
//        }
//        
//        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +
//                     "contactName, contactLastName, contactNumber, contactPosition) " +
//                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
//
//        try (Connection conexion = ConexionPostgreSQL.conectar();
//                PreparedStatement pstmt = conexion.prepareStatement(sql)
//                ) {
//
//            pstmt.setString(1, company.getNit());
//            pstmt.setString(2, company.getName());
//            pstmt.setString(3, company.getEmail());
//            pstmt.setString(4, company.getSector());
//            pstmt.setString(5, company.getContactNames());
//            pstmt.setString(6, company.getContactLastNames());
//            pstmt.setString(7, company.getContactPhoneNumber() );
//            pstmt.setString(8, company.getContactPosition());
//
//            pstmt.executeUpdate();
//            JOptionPane.showMessageDialog(null, "✅ Empresa "
//                    + "registrada con éxito", "Éxito",
//                    JOptionPane.INFORMATION_MESSAGE);
//            return true;
//
//        } catch (SQLException e) {
//            JOptionPane.showMessageDialog(null, "❌ Error al guardar "
//                    + "la empresa: " + e.getMessage(), "Error",
//                    JOptionPane.ERROR_MESSAGE);
//            return false;
//        }
//    }
//
//    @Override
//    public boolean existsCompany(String nit, String email) {
//        String sql = "SELECT COUNT(*) FROM public.company WHERE nit = ? OR email = ?";
//        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            pstmt.setString(1, nit);
//            pstmt.setString(2, email);
//
//            try (ResultSet rs = pstmt.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1) > 0; // Si COUNT(*) > 0, ya existe una empresa con ese NIT o email
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CompanyPostgreSQLRepository.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//    public Company findByNIT(String idCompany) {
//        String sql = "SELECT * FROM company WHERE companyNIT = ?";
//
//        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setString(1, idCompany);
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                return new Company(
//                    rs.getString("companyNIT"),
//                    rs.getString("companyName"),
//                    rs.getString("companyEmail"),
//                    rs.getString("companySector"),
//                    rs.getString("contactName"),
//                    rs.getString("contactLastName"),
//                    rs.getString("contactNumber"),
//                    rs.getString("contactPosition")
//                );
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return null;  // Retorna null si la empresa no se encuentra
//    }
//    
//}

package com.mycompany.gestionproyectosacademicos.access;



import javax.swing.JOptionPane;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.services.CompanyService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.swing.*;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.nio.charset.StandardCharsets;
import org.apache.http.HttpResponse;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class CompanyPostgreSQLRepository implements ICompanyRepository {


    private final Connection connection;

   
    public CompanyPostgreSQLRepository(Connection connection) {
        this.connection = connection;
    }

    private static final String SERVICE_URL = "http://localhost:8081/api/companies";
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public boolean save(Company company) {
    try {
        URL url = new URL(SERVICE_URL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json; utf-8");
        con.setDoOutput(true);

        String json = mapper.writeValueAsString(company);
        System.out.println("📦 JSON enviado: " + json);

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = json.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int code = con.getResponseCode();
        System.out.println("🔁 Código HTTP: " + code);

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                (code >= 200 && code < 300) ? con.getInputStream() : con.getErrorStream(), "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            System.out.println("📨 Respuesta del servidor: " + response.toString());
        }

        con.disconnect();

        if (code == HttpURLConnection.HTTP_OK || code == HttpURLConnection.HTTP_CREATED) {
            JOptionPane.showMessageDialog(null, "✅ Empresa registrada con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);
            return true;
        } else {
            JOptionPane.showMessageDialog(null, "❌ Error al registrar empresa. Código HTTP: " + code, "Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }
    } catch (Exception e) {
        JOptionPane.showMessageDialog(null, "❌ Excepción al llamar al servicio: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        e.printStackTrace();  // también muestra en consola
        return false;
    }
}


    @Override
   public boolean existsCompany(Long nit, String email) {
    CloseableHttpClient httpClient = HttpClients.createDefault();
    boolean exists = false;

    try {
        // Codificar el parámetro email por si tiene caracteres especiales
        String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8.toString());

        // Construir la URL con los parámetros
        String apiUrl = "http://localhost:8080/api/companies/exists?nit=" + nit + "&email=" + encodedEmail;

        // Crear solicitud GET
        HttpGet request = new HttpGet(apiUrl);
        HttpResponse response = httpClient.execute(request);

        int statusCode = response.getStatusLine().getStatusCode();

        if (statusCode == 200) {
            String jsonResponse = EntityUtils.toString(response.getEntity());
            exists = Boolean.parseBoolean(jsonResponse); // Interpretar la respuesta JSON "true"/"false"
        } else {
            Logger.getLogger(getClass().getName()).log(Level.WARNING,
                "Fallo al verificar existencia de empresa. Código: " + statusCode);
        }
    } catch (IOException e) {
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Error en existsCompany", e);
    }

    return exists;
}


    @Override
    public Company findByNIT(Long idCompany) {
    CloseableHttpClient httpClient = HttpClients.createDefault();
    ObjectMapper mapper = new ObjectMapper();
    Company company = null;

    try {
        // Definir la URL de la API REST de empresas
        String apiUrl = "http://localhost:8080/api/companies/nit/" + idCompany;
        HttpGet request = new HttpGet(apiUrl);

        // Ejecutar la solicitud
        HttpResponse response = httpClient.execute(request);

        int statusCode = response.getStatusLine().getStatusCode();
        if (statusCode == 200) {
            String jsonResponse = EntityUtils.toString(response.getEntity());
            company = mapper.readValue(jsonResponse, Company.class); // Mapear a Company
        } else {
            Logger.getLogger(CompanyService.class.getName()).log(Level.SEVERE, 
                "Error al obtener compañía. Código de estado: " + statusCode);
        }
    } catch (IOException ex) {
        Logger.getLogger(CompanyService.class.getName()).log(Level.SEVERE, null, ex);
    }

    return company;
}

}