package com.mycompany.gestionproyectosacademicos.access;

/**
 *
 * @author rubei
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class ConexionPostgreSQL {
    
    private static final String URL = "jdbc:postgresql://localhost:5432/gestion_proyectos";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "postgres"; //Cambiar por password local de su maquina

    public static Connection conectar() {
        Connection conexion = null;
        try {
            Class.forName("org.postgresql.Driver"); // Cargar el driver
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            JOptionPane.showMessageDialog(null
                    ,"✅ Conexión exitosa a PostgreSQL"
                    , "AVISO",JOptionPane.WARNING_MESSAGE);
            
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
    
    public static void closeResources(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            try {
                if (resource != null) {
                    resource.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        //conectar(); // Probar la conexión
    }
}