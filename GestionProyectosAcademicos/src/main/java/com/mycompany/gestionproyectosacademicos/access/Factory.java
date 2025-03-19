package com.mycompany.gestionproyectosacademicos.access;

import java.util.HashMap;
import java.util.Map;

/**
 * Fábrica que se encarga de instanciar repositorios dinámicamente.
 */
public class Factory {

    private static Factory instance;

    // Mapas para almacenar repositorios según su tipo y nombre (ARRAYS, POSTGRE, etc.)
    private Map<String, Map<Class<?>, Object>> repositoriesByType;

    private Factory() {
        repositoriesByType = new HashMap<>();

        // Definir diferentes implementaciones según el tipo
        Map<Class<?>, Object> arraysRepositories = new HashMap<>();
        arraysRepositories.put(IUserRepository.class, new UserArrayRepository());
        arraysRepositories.put(ICoordinatorRepository.class, new CoordinatorArrayRepository());
        arraysRepositories.put(IProjectRepository.class, new ProjectArrayRepository());

        // Repositorios de PostgreSQL
        Map<Class<?>, Object> postgreRepositories = new HashMap<>();
        postgreRepositories.put(IUserRepository.class, new UserPostgreRepository());
        postgreRepositories.put(ICoordinatorRepository.class, new CoordinatorPostgreRepository());
        // Aquí puedes agregar más repositorios de PostgreSQL si los tienes, por ejemplo:
        // postgreRepositories.put(IProjectRepository.class, new ProjectPostgreRepository());

        // Agregar tipos de almacenamiento a la fábrica
        repositoriesByType.put("ARRAYS", arraysRepositories);
        repositoriesByType.put("POSTGRE", postgreRepositories);
    }

    /**
     * Implementación Singleton
     */
    public static Factory getInstance() {
        if (instance == null) {
            instance = new Factory();
        }
        return instance;
    }

    /**
     * Obtiene una instancia concreta de un repositorio según el tipo de almacenamiento seleccionado.
     * 
     * @param repositoryClass Clase de la interfaz del repositorio
     * @param storageType Tipo de almacenamiento ("ARRAYS", "POSTGRE", etc.)
     * @return Instancia del repositorio
     */
    @SuppressWarnings("unchecked")
    public <T> T getRepository(Class<T> repositoryClass, String storageType) {
        if (repositoriesByType.containsKey(storageType)) {
            return (T) repositoriesByType.get(storageType).get(repositoryClass);
        }
        return null; // Retorna null si el tipo de almacenamiento no está definido
    }

    /**
     * Método para registrar dinámicamente nuevos repositorios en la fábrica.
     */
    public <T> void registerRepository(Class<T> repositoryClass, T repositoryInstance, String storageType) {
        repositoriesByType.computeIfAbsent(storageType, k -> new HashMap<>()).put(repositoryClass, repositoryInstance);
    }
}