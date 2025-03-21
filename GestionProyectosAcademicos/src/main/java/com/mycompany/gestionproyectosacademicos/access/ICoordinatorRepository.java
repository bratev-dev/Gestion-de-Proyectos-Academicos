package com.mycompany.gestionproyectosacademicos.access;

import com.mycompany.gestionproyectosacademicos.entities.Coordinator;
import java.util.List;

public interface ICoordinatorRepository {
     Coordinator getCoordinator(int idCoordinator);
}
