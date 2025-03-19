package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Coordinator;
import com.mycompany.gestionproyectosacademicos.infra.Messages;
import java.util.ArrayList;
import java.util.List;

public class CoordinatorArrayRepository implements ICoordinatorRepository{
    private static List<Coordinator> coordinators = new ArrayList<>();
    
    public CoordinatorArrayRepository() {
        // Agregar datos de prueba
        if (coordinators == null) {
            coordinators = new ArrayList<>();
            
            coordinators.add(new Coordinator(2, "Coordinador 1", 2));
        }
    }

    @Override
    public Coordinator getCoordinator(int idCoordinator) {
        for(Coordinator coordinator : coordinators) {
            if(coordinator.getId() == idCoordinator) {
                //Messages.showMessageDialog("Se encontró al coordinador en repository", "Atención");
                return coordinator;
            }
        }
        return null;
    }
    
    
}
