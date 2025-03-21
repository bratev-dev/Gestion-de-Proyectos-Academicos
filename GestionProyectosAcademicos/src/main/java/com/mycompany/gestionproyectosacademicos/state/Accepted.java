package com.mycompany.gestionproyectosacademicos.state;

import com.mycompany.gestionproyectosacademicos.entities.Project;
/**
 *
 * @author Jhonatan
 */
public class Accepted{
    
    public void manageState(Project project) {
        project.setState(getStateName());
    }
    
    public String getStateName() {
        return "Aceptado";
    }
}
