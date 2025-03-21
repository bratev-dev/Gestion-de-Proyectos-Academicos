package com.mycompany.gestionproyectosacademicos.state;

import com.mycompany.gestionproyectosacademicos.entities.Project;

public interface ProjectState {
    
    void ManageState(Project project);
    
    String getStateName();
}
