package com.mycompany.gestionproyectosacademicos.state;

import com.mycompany.gestionproyectosacademicos.entities.Project;

public class InProgress implements ProjectState{

    @Override
    public void manageState(Project project) {
        project.setState(getStateName());
    }

    @Override
    public String getStateName() {
        return "En ejecucion";
    }
    
}
