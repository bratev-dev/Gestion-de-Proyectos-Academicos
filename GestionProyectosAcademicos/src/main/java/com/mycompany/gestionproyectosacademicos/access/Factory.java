package com.mycompany.gestionproyectosacademicos.access;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

public class Factory {
    private static Factory instance;
    private final Connection connection;
    private final Map<Class<?>, Object> repositoryCache = new HashMap<>();

    private Factory() {
        this.connection = ConexionPostgreSQL.conectar(); // Establece una única conexión
    }

    public static Factory getInstance() {
        if (instance == null) {
            instance = new Factory();
        }
        return instance;
    }

    public <T> T getRepository(Class<T> repoClass, String type) {
        if (repositoryCache.containsKey(repoClass)) {
            return repoClass.cast(repositoryCache.get(repoClass));
        }

        Object repository = createRepository(repoClass, type);
        if (repository != null) {
            repositoryCache.put(repoClass, repository);
        }
        return repoClass.cast(repository);
    }

    private Object createRepository(Class<?> repoClass, String type) {
        if (repoClass == ICoordinatorRepository.class) {
         if ("POSTGRE".equalsIgnoreCase(type)) {
             return new CoordinatorPostgreRepository(connection);
         }
     } else if (repoClass == IUserRepository.class) {
         if ("POSTGRE".equalsIgnoreCase(type)) {
             return new UserPostgreRepository(connection);
         } else if ("ARRAYS".equalsIgnoreCase(type)) {
             return new UserArrayRepository(); // Para pruebas sin BD
         }
     }
        else if (repoClass == IProjectRepository.class) {
         if ("POSTGRE".equalsIgnoreCase(type)) {
            // return new ProjectPostgreRepository(connection);
         } else if ("ARRAYS".equalsIgnoreCase(type)) {
             return new ProjectArrayRepository(); // Para pruebas sin BD
         }
     }
         else if (repoClass == ICompanyRepository.class) {
         if ("POSTGRE".equalsIgnoreCase(type)) {
             return new CompanyPostgreSQLRepository(connection);
         } else if ("ARRAYS".equalsIgnoreCase(type)) {
            // return new ProjectArrayRepository(); // Para pruebas sin BD
         }
     }
        
        return null; // Agregar más casos según sea necesario
    }

    public void closeConnection() {
        ConexionPostgreSQL.closeResources(connection);
    }
}