package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.sql.SQLException;
import java.util.List;
/**
 * Interfaz para repositorio de Proyectos.
 * Define las operaciones que se pueden realizar sobre los proyectos.
 */
public interface IProjectRepository {
    List<Project> getAllProjects();
    /**
     * @brief Obtiene una lista de proyectos correspondientes a un período académico específico.
     * 
     * @param academicPeriod Cadena que representa el período académico (por ejemplo, "2024-I").
     * @return Lista de objetos Project que pertenecen al período académico especificado.
     */
    List<Project> getProjectsByAcademicPeriod(String academicPeriod);

    /**
     * @throws java.sql.SQLException
     * @brief Obtiene los detalles completos de un proyecto a partir de su identificador único.
     * 
     * @param projectId Identificador único del proyecto.
     * @return Objeto Project con toda la información del proyecto.
     */
    Project getProjectById(int projectId) throws SQLException;

    /**
     * @brief Guarda un nuevo proyecto en el sistema.
     * 
     * @param project Objeto Project que contiene toda la información a registrar.
     */
    void saveProject(Project project);

    /**
     * @brief Elimina un proyecto del sistema a partir de su identificador único.
     * 
     * @param projectId Identificador único del proyecto a eliminar.
     */
    
    void deleteProject(int projectId);
    
    
    public boolean existsProject(String nit, String email);
    public int getNextProjectId();
    public boolean existsCompany(String nit, String email);
}
