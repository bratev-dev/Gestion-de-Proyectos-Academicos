package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.Project;
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
            
            projects.add(new Project(1, "Sistema de Gestión de Inventarios", 
            "Gestión de inventario en tiempo real", 
            "Gestionar productos, ordenar listas", 
            "Es un proyecto para controlar inventarios de manera eficiente", 
            "6", "3500000", "2024-05-04", "Recibido", company));

        projects.add(new Project(2, "Plataforma de E-learning", 
            "Plataforma para cursos en línea", 
            "Facilitar el aprendizaje remoto", 
            "Ofrecer cursos interactivos y seguimiento del progreso", 
            "12", "5000000", "2024-08-01", "En revisión", company));

        projects.add(new Project(3, "Aplicación de Reservas de Restaurantes", 
            "Sistema para reservar mesas en restaurantes", 
            "Automatizar reservas", 
            "Permitir a los usuarios reservar mesas en línea", 
            "4", "2000000", "2024-12-15", "Recibido", company));

        projects.add(new Project(4, "Sistema de Gestión de Recursos Humanos", 
            "Gestión de empleados y nóminas", 
            "Automatizar procesos de RRHH", 
            "Facilitar la gestión de personal y pagos", 
            "8", "4000000", "2024-08-10", "En progreso", company));

        projects.add(new Project(5, "Plataforma de Comercio Electrónico", 
            "Ventas en línea de productos", 
            "Facilitar las ventas en línea", 
            "Ofrecer a los vendedores una manera fácil de vender sus productos", 
            "18", "7500000", "2024-09-05", "En revisión", company));

        projects.add(new Project(6, "Aplicación de Gestión de Tareas", 
            "Organización de tareas diarias", 
            "Optimizar la gestión de tareas", 
            "Permitir a los usuarios organizar sus tareas de manera eficiente", 
            "6", "1500000", "2024-10-01", "Completado", company));

        projects.add(new Project(7, "Sistema de Gestión de Biblioteca", 
            "Control de libros y préstamos", 
            "Automatizar procesos de biblioteca", 
            "Facilitar la gestión de libros y préstamos", 
            "9", "3000000", "2024-11-15", "En progreso", company));

        projects.add(new Project(8, "Plataforma de Gestión de Eventos", 
            "Organización y gestión de eventos", 
            "Facilitar la organización de eventos", 
            "Permitir a los organizadores gestionar eventos de manera eficiente", 
            "12", "6000000", "2024-12-10", "En revisión", company));

        projects.add(new Project(9, "Aplicación de Monitoreo de Salud", 
            "Seguimiento de salud en tiempo real", 
            "Mejorar el monitoreo de la salud", 
            "Permitir a los usuarios monitorear su salud desde cualquier lugar", 
            "6", "2500000", "2025-01-05", "Completado", company));

        projects.add(new Project(10, "Sistema de Gestión de Transporte", 
            "Control de transporte público", 
            "Optimizar el transporte público", 
            "Facilitar la gestión de rutas y horarios", 
            "12", "4500000", "2025-02-01", "En progreso", company));

        projects.add(new Project(11, "Plataforma de Gestión de Contenidos", 
            "Gestión de contenidos digitales", 
            "Facilitar la gestión de contenidos", 
            "Permitir a los usuarios gestionar sus contenidos digitales", 
            "18", "7000000", "2025-03-15", "En revisión", company));

        projects.add(new Project(12, "Aplicación de Gestión de Finanzas", 
            "Control de finanzas personales", 
            "Optimizar la gestión de finanzas", 
            "Permitir a los usuarios gestionar sus finanzas de manera eficiente", 
            "6", "2000000", "2025-04-10", "Completado", company));

        projects.add(new Project(13, "Sistema de Gestión de Almacenes", 
            "Control de inventarios en almacenes", 
            "Automatizar procesos de almacén", 
            "Facilitar la gestión de inventarios en almacenes", 
            "9", "3500000", "2025-05-05", "En progreso", company));

        projects.add(new Project(14, "Plataforma de Gestión de Redes Sociales", 
            "Gestión de redes sociales", 
            "Facilitar la gestión de redes sociales", 
            "Permitir a los usuarios gestionar sus redes sociales de manera eficiente", 
            "12", "5500000", "2025-06-01", "En revisión", company));

        projects.add(new Project(15, "Aplicación de Gestión de Viajes", 
            "Planificación y gestión de viajes", 
            "Optimizar la gestión de viajes", 
            "Permitir a los usuarios planificar y gestionar sus viajes", 
            "6", "3000000", "2025-07-15", "Completado", company));

        projects.add(new Project(16, "Sistema de Gestión de Clientes", 
            "Gestión de relaciones con clientes", 
            "Automatizar procesos de CRM", 
            "Facilitar la gestión de clientes", 
            "12", "5000000", "2025-08-10", "En progreso", company));

        projects.add(new Project(17, "Plataforma de Gestión de Aprendizaje", 
            "Gestión de aprendizaje personalizado", 
            "Facilitar el aprendizaje personalizado", 
            "Permitir a los usuarios gestionar su aprendizaje de manera eficiente", 
            "18", "8000000", "2025-09-05", "En revisión", company));

        projects.add(new Project(18, "Aplicación de Seguridad en el Hogar", 
            "Monitoreo de seguridad en el hogar", 
            "Mejorar la seguridad en el hogar", 
            "Permitir a los usuarios monitorear sus hogares desde cualquier lugar", 
            "6", "2500000", "2025-10-01", "Completado", company));

        projects.add(new Project(19, "Sistema de Gestión de Proyectos", 
            "Gestión colaborativa de proyectos", 
            "Facilitar la gestión de proyectos", 
            "Permitir a los equipos gestionar proyectos de manera colaborativa", 
            "12", "6000000", "2025-11-15", "En progreso", company));

        projects.add(new Project(20, "Plataforma de Gestión de Contratos", 
            "Gestión de contratos digitales", 
            "Automatizar la gestión de contratos", 
            "Facilitar la creación y gestión de contratos digitales", 
            "9", "4000000", "2025-12-10", "En revisión", company));
        }
    }
    
    @Override
    public List<Project> getAllProjects() {
        return projects;
    }
    
    @Override
    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {
        List<Project> filteredProjects = new ArrayList<>();
        for (Project project : projects) {
            if (project.getAcademicPeriod().equals(academicPeriod)) {
                filteredProjects.add(project);
            }
        }
        return filteredProjects;
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
    public boolean existsProject(String nit, String email) {
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
