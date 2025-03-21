package com.mycompany.gestionproyectosacademicos.state;

import com.mycompany.gestionproyectosacademicos.entities.Project;

public interface ProjectState {
    /**
     * @brief Cambia el estado del proyecto a otro estado válido.
     * 
     * @param project Proyecto al cual se le cambiará el estado.
     */
    void manageState(Project project);
    
    String getStateName();
}
