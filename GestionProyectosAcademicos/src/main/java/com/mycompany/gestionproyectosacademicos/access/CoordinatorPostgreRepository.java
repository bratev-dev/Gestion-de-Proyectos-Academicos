package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Coordinator;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CoordinatorPostgreRepository implements ICoordinatorRepository {

    private Connection connection;

    public CoordinatorPostgreRepository() {
        // Configura la conexión a la base de datos PostgreSQL
        String url = "jdbc:postgresql://localhost:5432/gestion_proyectos";
        String user = "postgres";
        String password = "software";

        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Coordinator getCoordinator(int idCoordinator) {
        String sql = "SELECT id, name, user_id FROM public.coordinator WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idCoordinator);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Coordinator(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("user_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retorna null si no encuentra el coordinador
    }
}