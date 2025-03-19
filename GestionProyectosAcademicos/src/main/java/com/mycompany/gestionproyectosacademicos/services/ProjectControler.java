package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.observer.Observer;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jhonatan LA NOTIFICACION SE ELIMINO DE ESTA CLASE, AHORA SE MANEJA DESDE LA CLASE PROJECT
 */
public class ProjectControler {
    private List<Project> projects = new ArrayList<>();
    private List<Observer> students = new ArrayList<>();
    
    public void addProjects(Project project) {
        projects.add(project);
        // Notificar a los observadores sobre el nuevo proyecto
        notifyObservers(project); 
    }
    
    public List<Project> getProjects() {
        return projects;
    }
    
    public void addStudent(Observer student) {
        students.add(student);
    }
    
    // Método para notificar a todos los observadores
    private void notifyObservers(Object obj) {
        for (Observer observer : students) {
            observer.update(obj);
        }
    }
    
    // Método para notificar a los observadores cuando se actualiza un proyecto existente
    public void updateProject(Project project) {
        for (int i = 0; i < projects.size(); i++) {
            if (projects.get(i).getId() == project.getId()) {
                projects.set(i, project);
                notifyObservers(project);
                return;
            }
        }
        // Si no se encuentra el proyecto, añadirlo
        addProjects(project);
    }
    
    // Método para actualizar todos los proyectos de una vez
    public void refreshProjects(List<Project> newProjects) {
        projects.clear();
        projects.addAll(newProjects);
        
        // Notificar a los observadores sobre la actualización completa
        for (Observer observer : students) {
            if (observer instanceof com.mycompany.gestionproyectosacademicos.presentation.GUIStudentProjectList) {
                ((com.mycompany.gestionproyectosacademicos.presentation.GUIStudentProjectList) observer).updateProjectList(projects);
            }
        }
    }
}
