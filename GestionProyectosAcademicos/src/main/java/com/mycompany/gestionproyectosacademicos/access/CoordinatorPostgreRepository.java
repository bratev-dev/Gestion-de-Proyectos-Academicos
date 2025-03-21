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

    private Connection conn;

    // Constructor que acepta una conexión
    public CoordinatorPostgreRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Coordinator getCoordinator(int idCoordinator) {
        String sql = "SELECT id, name, user_id FROM public.coordinator WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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