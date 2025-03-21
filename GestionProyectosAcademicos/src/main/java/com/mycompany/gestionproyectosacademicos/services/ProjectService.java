package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.IProjectRepository;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.observer.IObserver;
import com.mycompany.gestionproyectosacademicos.observer.IObservable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jhonatan
 */
public class ProjectService implements IObservable{
    private IProjectRepository repository;
    private List<Project> projects;
    private final List<IObserver> observers = new ArrayList<>();
    
    public ProjectService(IProjectRepository repository) {
        this.repository = repository;
        //this.projects = repository.getProjectsByAcademicPeriod("2");
    }
    
    public void addProject(Project project) {
        repository.saveProject(project); // Agrega al repositorio
        notifyObservers(); // Notifica a todos los observers que la lista cambió
    }
    
    public void deleteProject(int projectId) {
        repository.deleteProject(projectId);
        notifyObservers();
    }
    
    public List<Project> getProjects(){
        return projects;
    }

    // Métodos de Observer
    @Override
    public void addObserver(IObserver observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(IObserver observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (IObserver observer : observers) {
            observer.update(projects); // Notificar a los observadores con la lista de proyectos
        }
    }
    
    public int getNextProjectId(){
        return repository.getNextProjectId();
    }
    
    
}
