package com.mycompany.gestionproyectosacademicos.state;

import com.mycompany.gestionproyectosacademicos.entities.Project;
/**
 *
 * @author Jhonatan
 */
public class Received implements ProjectState{
    @Override
    public void manageState(Project project) {
        System.out.println("Proyecto recibido: " + project.getName());
    }
}
