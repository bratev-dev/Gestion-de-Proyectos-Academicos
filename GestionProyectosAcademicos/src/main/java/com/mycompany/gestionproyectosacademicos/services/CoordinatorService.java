package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;
import com.mycompany.gestionproyectosacademicos.entities.Coordinator;

public class CoordinatorService {
    private final ICoordinatorRepository repository;

    public CoordinatorService(ICoordinatorRepository repository) {
        this.repository = repository;
    }
    
    public Coordinator getCoordinator(int idCoordinator) {
        return repository.getCoordinator(idCoordinator);
    }
    
}
