package com.mycompany.gestionproyectosacademicos.observer;

import com.mycompany.gestionproyectosacademicos.entities.Project;
/**
 *
 * @author Jhonatan
 */
public interface Observer {
    
    void update(Project project);
}
