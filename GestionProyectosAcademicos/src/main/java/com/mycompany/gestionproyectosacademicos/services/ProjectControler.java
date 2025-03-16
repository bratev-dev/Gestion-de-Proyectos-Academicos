package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jhonatan
 */
public class ProjectControler {
    private List<Project> projects = new ArrayList<>();
    
    public void addProjects(Project project){
        projects.add(project);
        project.notifyObservers();
    }
    
    public List<Project> getProjects(){
        return projects;
    }
}
