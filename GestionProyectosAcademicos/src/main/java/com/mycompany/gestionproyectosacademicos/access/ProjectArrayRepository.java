package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.entities.Request;
import com.mycompany.gestionproyectosacademicos.entities.Student;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Repositorio en memoria con una lista de proyectos predefinidos
 */


public class ProjectArrayRepository implements IProjectRepository{
    private static List<Project> projects;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    /**
     * @brief Constructor que inicializa la lista de proyectos.
     */
    
    public ProjectArrayRepository() {
        if (projects == null) {
            projects = new ArrayList<>();
            // Datos de ejemplo
            Company company = new Company("Projects SAS", "4", "empresa@gmail.com", "THECNOLOGY", "EDUARDO", "GALINZDEZ", "3154789645", "MANAGER");
            
            projects.add(new Project(2,  
    "App Movil",  
    "Aplicación para ventas",  
    "Aceptado",  
    LocalDate.parse("02-02-2014",formatter),  
    85,  
    "Nota",  
    company, 
    new Student[0],  
    "Desarrollo de una aplicación móvil para gestionar ventas",  // Summary  
    "Optimizar las ventas y mejorar la experiencia del usuario",  // Objetives  
    "6 meses"  // MaxTime 
            ));
            /*
            projects.add(new Project(2, "App Movil", "Aplicación para ventas", "Aceptado", LocalDate.parse("2024-05-04"), 85, new Request(), company, new Student[0]));
            projects.add(new Project(3, "Web Corporativa", "Página web institucional", "En Ejecución", LocalDate.parse("2024-05-04"), 90, new Request(), company, new Student[0]));
               */
        }
    }

    @Override
    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {
        // TO IMPLEMENT
        return projects;
    }

    @Override
    public Project getProjectById(int projectId) {
        for(Project project : projects) {
            if(project.getId() == projectId) {
                return project;
            }
        }
        return null;
    }

    @Override
    public void updateProjectState(int projectId, String newState, String comment) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void saveProject(Project project) {
        if (projects == null) {
            projects = new ArrayList<>();
        }
        projects.add(project); // Agrega a la lista
    }

    @Override
    public void deleteProject(int projectId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean existsProjec(String nit, String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int getNextProjectId() {
        throw new UnsupportedOperationException("Not supported yet ."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean existsCompany(String nit, String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
