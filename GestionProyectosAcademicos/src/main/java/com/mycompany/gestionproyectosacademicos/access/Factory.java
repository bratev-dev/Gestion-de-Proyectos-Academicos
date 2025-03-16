
package com.mycompany.gestionproyectosacademicos.access;
import java.util.HashMap;
import java.util.Map;

/**
 * Fábrica que se encarga de instanciar repositorios dinámicamente.
 */
public class Factory {

    private static Factory instance;
    
    // Mapas para almacenar repositorios según su tipo y nombre (ARRAYS, SQLITE, etc.)
    private Map<Class<?>, Object> repositoryMap;
    private Map<String, Map<Class<?>, Object>> repositoriesByType;

    private Factory() {
        repositoryMap = new HashMap<>();
        repositoriesByType = new HashMap<>();

        // Definir diferentes implementaciones según el tipo
        Map<Class<?>, Object> arraysRepositories = new HashMap<>();
       // arraysRepositories.put(ICompanyRepository.class, new CompanyArraysRepository());
        arraysRepositories.put(IUserRepository.class, new UserArrayRepository());
        //arraysRepositories.put(IStudentRepository.class, new StudentArrayRepository());
        //arraysRepositories.put(IProjectRepository.class, new ProjectArrayRepository());

        //Map<Class<?>, Object> sqliteRepositories = new HashMap<>();
        //sqliteRepositories.put(ICompanyRepository.class, new CompanySqliteRepository());
        //sqliteRepositories.put(IUserRepository.class, new UserSqliteRepository());
        //sqliteRepositories.put(IStudentRepository.class, new StudentSqliteRepository());
        //sqliteRepositories.put(IProjectRepository.class, new ProjectSqliteRepository());

        // Agregar tipos de almacenamiento a la fábrica
        repositoriesByType.put("ARRAYS", arraysRepositories);
       // repositoriesByType.put("SQLITE", sqliteRepositories);
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
     * @param storageType Tipo de almacenamiento ("ARRAYS", "SQLITE", etc.)
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
