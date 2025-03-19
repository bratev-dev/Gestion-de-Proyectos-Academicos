warning: in the working copy of 'GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.form', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.form', LF will be replaced by CRLF the next time Git touches it
[1mdiff --git a/GestionProyectosAcademicos/pom.xml b/GestionProyectosAcademicos/pom.xml[m
[1mindex ff66541..c48833b 100644[m
[1m--- a/GestionProyectosAcademicos/pom.xml[m
[1m+++ b/GestionProyectosAcademicos/pom.xml[m
[36m@@ -1,6 +1,7 @@[m
 <?xml version="1.0" encoding="UTF-8"?>[m
 <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">[m
     <modelVersion>4.0.0</modelVersion>[m
[32m+[m[41m    [m
     <groupId>com.mycompany</groupId>[m
     <artifactId>GestionProyectosAcademicos</artifactId>[m
     <version>1.0-SNAPSHOT</version>[m
[36m@@ -11,6 +12,13 @@[m
             <artifactId>AbsoluteLayout</artifactId>[m
             <version>RELEASE230</version>[m
         </dependency>[m
[32m+[m[41m        [m
[32m+[m[32m            <dependency>[m
[32m+[m[32m                <groupId>org.postgresql</groupId>[m
[32m+[m[32m                <artifactId>postgresql</artifactId>[m
[32m+[m[32m                <version>42.7.5</version>[m
[32m+[m[32m            </dependency>[m
[32m+[m[41m        [m
     </dependencies>[m
     <properties>[m
         <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/CoordinatorArrayRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/CoordinatorArrayRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..8f7cb20[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/CoordinatorArrayRepository.java[m
[36m@@ -0,0 +1,32 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Coordinator;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.infra.Messages;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m
[32m+[m[32mpublic class CoordinatorArrayRepository implements ICoordinatorRepository{[m
[32m+[m[32m    private static List<Coordinator> coordinators = new ArrayList<>();[m
[32m+[m[41m    [m
[32m+[m[32m    public CoordinatorArrayRepository() {[m
[32m+[m[32m        // Agregar datos de prueba[m
[32m+[m[32m        if (coordinators == null) {[m
[32m+[m[32m            coordinators = new ArrayList<>();[m
[32m+[m[41m            [m
[32m+[m[32m            coordinators.add(new Coordinator(2, "Coordinador 1"));[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public Coordinator getCoordinator(int idCoordinator) {[m
[32m+[m[32m        for(Coordinator coordinator : coordinators) {[m
[32m+[m[32m            if(coordinator.getId() == idCoordinator) {[m
[32m+[m[32m                //Messages.showMessageDialog("Se encontró al coordinador en repository", "Atención");[m
[32m+[m[32m                return coordinator;[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m[32m        return null;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/Factory.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/Factory.java[m
[1mnew file mode 100644[m
[1mindex 0000000..31388b3[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/Factory.java[m
[36m@@ -0,0 +1,71 @@[m
[32m+[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.infra.Messages;[m
[32m+[m[32mimport java.util.HashMap;[m
[32m+[m[32mimport java.util.Map;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Fábrica que se encarga de instanciar repositorios dinámicamente.[m
[32m+[m[32m */[m
[32m+[m[32mpublic class Factory {[m
[32m+[m
[32m+[m[32m    private static Factory instance;[m
[32m+[m[41m    [m
[32m+[m[32m    // Mapas para almacenar repositorios según su tipo y nombre (ARRAYS, SQLITE, etc.)[m
[32m+[m[32m    private Map<Class<?>, Object> repositoryMap;[m
[32m+[m[32m    private Map<String, Map<Class<?>, Object>> repositoriesByType;[m
[32m+[m
[32m+[m[32m    private Factory() {[m
[32m+[m[32m        repositoryMap = new HashMap<>();[m
[32m+[m[32m        repositoriesByType = new HashMap<>();[m
[32m+[m
[32m+[m[32m        // Definir diferentes implementaciones según el tipo[m
[32m+[m[32m        Map<Class<?>, Object> arraysRepositories = new HashMap<>();[m
[32m+[m[32m        //arraysRepositories.put(ICompanyRepository.class, new CompanyArraysRepository());[m
[32m+[m[32m        arraysRepositories.put(IUserRepository.class, new UserArrayRepository());[m
[32m+[m[32m        //arraysRepositories.put(IStudentRepository.class, new StudentArrayRepository());[m
[32m+[m[32m        arraysRepositories.put(IProjectRepository.class, new ProjectArrayRepository());[m
[32m+[m[32m        arraysRepositories.put(ICoordinatorRepository.class, new CoordinatorArrayRepository());[m
[32m+[m[32m        //Map<Class<?>, Object> sqliteRepositories = new HashMap<>();[m
[32m+[m[32m        //sqliteRepositories.put(ICompanyRepository.class, new CompanySqliteRepository());[m
[32m+[m[32m        //sqliteRepositories.put(IUserRepository.class, new UserSqliteRepository());[m
[32m+[m[32m        //sqliteRepositories.put(IStudentRepository.class, new StudentSqliteRepository());[m
[32m+[m[32m        //sqliteRepositories.put(IProjectRepository.class, new ProjectSqliteRepository());[m
[32m+[m[41m        [m
[32m+[m[32m        // Agregar tipos de almacenamiento a la fábrica[m
[32m+[m[32m        repositoriesByType.put("ARRAYS", arraysRepositories);[m
[32m+[m[32m       // repositoriesByType.put("SQLITE", sqliteRepositories);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Implementación Singleton[m
[32m+[m[32m     */[m
[32m+[m[32m    public static Factory getInstance() {[m
[32m+[m[32m        if (instance == null) {[m
[32m+[m[32m            instance = new Factory();[m
[32m+[m[32m        }[m
[32m+[m[32m        return instance;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Obtiene una instancia concreta de un repositorio según el tipo de almacenamiento seleccionado.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param repositoryClass Clase de la interfaz del repositorio[m
[32m+[m[32m     * @param storageType Tipo de almacenamiento ("ARRAYS", "SQLITE", etc.)[m
[32m+[m[32m     * @return Instancia del repositorio[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    public <T> T getRepository(Class<T> repositoryClass, String storageType) {[m
[32m+[m[32m        if (repositoriesByType.containsKey(storageType)) {[m
[32m+[m[32m            return (T) repositoriesByType.get(storageType).get(repositoryClass);[m
[32m+[m[32m        }[m
[32m+[m[32m        return null; // Retorna null si el tipo de almacenamiento no está definido[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Método para registrar dinámicamente nuevos repositorios en la fábrica.[m
[32m+[m[32m     */[m
[32m+[m[32m    public <T> void registerRepository(Class<T> repositoryClass, T repositoryInstance, String storageType) {[m
[32m+[m[32m        repositoriesByType.computeIfAbsent(storageType, k -> new HashMap<>()).put(repositoryClass, repositoryInstance);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ICoordinatorRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ICoordinatorRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..e4ad46e[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ICoordinatorRepository.java[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Coordinator;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m
[32m+[m[32mpublic interface ICoordinatorRepository {[m
[32m+[m[32m    Coordinator getCoordinator(int idCoordinator);[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IProjectRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IProjectRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..b53f583[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IProjectRepository.java[m
[36m@@ -0,0 +1,49 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32m/**[m
[32m+[m[32m * Interfaz para repositorio de Proyectos.[m
[32m+[m[32m * Define las operaciones que se pueden realizar sobre los proyectos.[m
[32m+[m[32m */[m
[32m+[m[32mpublic interface IProjectRepository {[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Obtiene una lista de proyectos correspondientes a un período académico específico.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param academicPeriod Cadena que representa el período académico (por ejemplo, "2024-I").[m
[32m+[m[32m     * @return Lista de objetos Project que pertenecen al período académico especificado.[m
[32m+[m[32m     */[m
[32m+[m[32m    List<Project> getProjectsByAcademicPeriod(String academicPeriod);[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Obtiene los detalles completos de un proyecto a partir de su identificador único.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param projectId Identificador único del proyecto.[m
[32m+[m[32m     * @return Objeto Project con toda la información del proyecto.[m
[32m+[m[32m     */[m
[32m+[m[32m    Project getProjectById(int projectId);[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Actualiza el estado y comentario de un proyecto.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param projectId Identificador único del proyecto a actualizar.[m
[32m+[m[32m     * @param newState Nuevo estado que se asignará al proyecto.[m
[32m+[m[32m     * @param comment Comentario del coordinador asociado al cambio de estado.[m
[32m+[m[32m     */[m
[32m+[m[32m    void updateProjectState(int projectId, String newState, String comment);[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Guarda un nuevo proyecto en el sistema.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param project Objeto Project que contiene toda la información a registrar.[m
[32m+[m[32m     */[m
[32m+[m[32m    void saveProject(Project project);[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Elimina un proyecto del sistema a partir de su identificador único.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param projectId Identificador único del proyecto a eliminar.[m
[32m+[m[32m     */[m
[32m+[m[41m    [m
[32m+[m[32m    void deleteProject(int projectId);[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IUserRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IUserRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..050a55e[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/IUserRepository.java[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Interfaz para el repositorio de usuarios[m
[32m+[m[32m */[m
[32m+[m[32mpublic interface IUserRepository {[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Busca un usuario por correo y contraseña[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param email Correo del usuario[m
[32m+[m[32m     * @param password Contraseña del usuario[m
[32m+[m[32m     * @return Usuario si se encuentra, null en caso contrario[m
[32m+[m[32m     */[m
[32m+[m[32m    User validarUsuario(String email, String password);[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ProjectArrayRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ProjectArrayRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..3ac067e[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/ProjectArrayRepository.java[m
[36m@@ -0,0 +1,61 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Company;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Request;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Student;[m
[32m+[m[32mimport java.time.LocalDate;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Repositorio en memoria con una lista de proyectos predefinidos[m
[32m+[m[32m */[m
[32m+[m[32mpublic class ProjectArrayRepository implements IProjectRepository{[m
[32m+[m[32m    private static List<Project> projects;[m
[32m+[m[41m    [m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Constructor que inicializa la lista de proyectos.[m
[32m+[m[32m     */[m
[32m+[m[32m    public ProjectArrayRepository() {[m
[32m+[m[32m        if (projects == null) {[m
[32m+[m[32m            projects = new ArrayList<>();[m
[32m+[m[32m            // Datos de ejemplo[m
[32m+[m[32m            Company company = new Company("Projects SAS", 4, "empresa@gmail.com", "THECNOLOGY", "EDUARDO", "GALINZDEZ", "3154789645", "MANAGER");[m
[32m+[m[32m            projects.add(new Project(1, "Sistema de Gestión", "Gestión de inventario", "Recibido", LocalDate.parse("2024-05-04"), 0, new Request(), company, new Student[0]));[m
[32m+[m[32m            projects.add(new Project(2, "App Movil", "Aplicación para ventas", "Aceptado", LocalDate.parse("2024-05-04"), 85, new Request(), company, new Student[0]));[m
[32m+[m[32m            projects.add(new Project(3, "Web Corporativa", "Página web institucional", "En Ejecución", LocalDate.parse("2024-05-04"), 90, new Request(), company, new Student[0]));[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public List<Project> getProjectsByAcademicPeriod(String academicPeriod) {[m
[32m+[m[32m        // TO IMPLEMENT[m
[32m+[m[32m        return projects;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public Project getProjectById(int projectId) {[m
[32m+[m[32m        for(Project project : projects) {[m
[32m+[m[32m            if(project.getId() == projectId) {[m
[32m+[m[32m                return project;[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m[32m        return null;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void updateProjectState(int projectId, String newState, String comment) {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void saveProject(Project project) {[m
[32m+[m[32m        projects.add(project); // Agrega a la lista[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void deleteProject(int projectId) {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/UserArrayRepository.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/UserArrayRepository.java[m
[1mnew file mode 100644[m
[1mindex 0000000..ea222e7[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/access/UserArrayRepository.java[m
[36m@@ -0,0 +1,41 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.access;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Repositorio en memoria con una lista de usuarios predefinidos[m
[32m+[m[32m */[m
[32m+[m[32mpublic class UserArrayRepository implements IUserRepository{[m
[32m+[m[32m    private static List<User> users;[m
[32m+[m
[32m+[m[32m    public UserArrayRepository() {[m
[32m+[m[32m        if (users == null) {[m
[32m+[m[32m            users = new ArrayList<>();[m
[32m+[m[32m            users.add(new User(1, "admin@gmail.com", "admin123", "ADMIN"));[m
[32m+[m[32m            users.add(new User(2, "coordinador@gmail.com", "coord123", "COORDINATOR"));[m
[32m+[m[32m            users.add(new User(3, "estudiante@gmail.com", "estudiante123", "STUDENT"));[m
[32m+[m[32m            users.add(new User(4, "empresa@gmail.com", "empresa123", "COMPANY"));[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Método para validar si un usuario existe con el correo y contraseña dados[m
[32m+[m[32m     */[m
[32m+[m[32m   public User validarUsuario(String email, String password) {[m
[32m+[m[32m    for (User user : users) {[m
[32m+[m[32m        if (user.getEmail().equals(email) && user.getPassword().equals(password)) {[m
[32m+[m[32m            return user;[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m    return null;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Método para obtener todos los usuarios (solo para pruebas)[m
[32m+[m[32m     */[m
[32m+[m[32m    public List<User> listarUsuarios() {[m
[32m+[m[32m        return users;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Company.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Company.java[m
[1mindex aecd2d0..01a3a88 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Company.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Company.java[m
[36m@@ -9,5 +9,134 @@[m [mpackage com.mycompany.gestionproyectosacademicos.entities;[m
  * @author bryan[m
  */[m
 public class Company {[m
[32m+[m[32m    private String name;[m
[32m+[m[32m    private int nit;[m
[32m+[m[32m    private String email;[m
[32m+[m[32m    private String sector;[m
[32m+[m[32m    private String contactName;[m
[32m+[m[32m    private String contactLastName;[m
[32m+[m[32m    private String contactNumber;[m
[32m+[m[32m    private String contactPosition;[m
[32m+[m[41m    [m
[32m+[m[32m    public Company(String name, int nit, String email, String sector, String contactName,[m
[32m+[m[32m            String contactLastName, String contactNumber, String contactPosition){[m
[32m+[m[41m    [m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m        this.nit = nit;[m
[32m+[m[32m        this.email = email;[m
[32m+[m[32m        this.sector = sector;[m
[32m+[m[32m        this.contactName = contactName;[m
[32m+[m[32m        this.contactLastName = contactLastName;[m
[32m+[m[32m        this.contactNumber = contactNumber;[m
[32m+[m[32m        this.contactPosition = contactPosition;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Company() {[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    //Getters[m
[32m+[m[32m    public String getName(){[m
[32m+[m[32m        return name;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public int getNit(){[m
[32m+[m[32m        return nit;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getSector(){[m
[32m+[m[32m        return sector;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param name the name to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setName(String name) {[m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param nit the nit to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setNit(int nit) {[m
[32m+[m[32m        this.nit = nit;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return the email[m
[32m+[m[32m     */[m
[32m+[m[32m    public String getEmail() {[m
[32m+[m[32m        return email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param email the email to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setEmail(String email) {[m
[32m+[m[32m        this.email = email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param sector the sector to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setSector(String sector) {[m
[32m+[m[32m        this.sector = sector;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return the contactName[m
[32m+[m[32m     */[m
[32m+[m[32m    public String getContactName() {[m
[32m+[m[32m        return contactName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param contactName the contactName to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setContactName(String contactName) {[m
[32m+[m[32m        this.contactName = contactName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return the contactLastName[m
[32m+[m[32m     */[m
[32m+[m[32m    public String getContactLastName() {[m
[32m+[m[32m        return contactLastName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param contactLastName the contactLastName to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setContactLastName(String contactLastName) {[m
[32m+[m[32m        this.contactLastName = contactLastName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return the contactNumber[m
[32m+[m[32m     */[m
[32m+[m[32m    public String getContactNumber() {[m
[32m+[m[32m        return contactNumber;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param contactNumber the contactNumber to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setContactNumber(String contactNumber) {[m
[32m+[m[32m        this.contactNumber = contactNumber;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return the contactPosition[m
[32m+[m[32m     */[m
[32m+[m[32m    public String getContactPosition() {[m
[32m+[m[32m        return contactPosition;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param contactPosition the contactPosition to set[m
[32m+[m[32m     */[m
[32m+[m[32m    public void setContactPosition(String contactPosition) {[m
[32m+[m[32m        this.contactPosition = contactPosition;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
     [m
 }[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/ConexionPostgreSQL.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/ConexionPostgreSQL.java[m
[1mnew file mode 100644[m
[1mindex 0000000..97f6476[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/ConexionPostgreSQL.java[m
[36m@@ -0,0 +1,49 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[32m+[m[32m */[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.entities;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author rubei[m
[32m+[m[32m */[m
[32m+[m[32mimport java.sql.Connection;[m
[32m+[m[32mimport java.sql.DriverManager;[m
[32m+[m[32mimport java.sql.SQLException;[m
[32m+[m[32mimport javax.swing.JOptionPane;[m
[32m+[m
[32m+[m[32mpublic class ConexionPostgreSQL {[m
[32m+[m[41m    [m
[32m+[m[32m    private static final String URL = "jdbc:postgresql://localhost:5432/projectmanagement";[m
[32m+[m[32m    private static final String USUARIO = "postgres";[m
[32m+[m[32m    private static final String PASSWORD = "1234";[m
[32m+[m
[32m+[m[32m    public static Connection conectar() {[m
[32m+[m[32m        Connection conexion = null;[m
[32m+[m[32m        try {[m
[32m+[m[32m            Class.forName("org.postgresql.Driver"); // Cargar el driver[m
[32m+[m[32m            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);[m
[32m+[m[32m          /*  JOptionPane.showMessageDialog(null[m
[32m+[m[32m                    ,"✅ Conexión exitosa a PostgreSQL"[m
[32m+[m[32m                    , "AVISO",JOptionPane.WARNING_MESSAGE);[m
[32m+[m[32m            */[m
[32m+[m[32m        } catch (ClassNotFoundException e) {[m
[32m+[m[32m            JOptionPane.showMessageDialog(null[m
[32m+[m[32m                    ,"❌ Error: No se encontró el Driver de PostgreSQL"[m
[32m+[m[32m                    , "AVISO",JOptionPane.WARNING_MESSAGE);[m
[32m+[m[41m            [m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        } catch (SQLException e) {[m
[32m+[m[32m            JOptionPane.showMessageDialog(null[m
[32m+[m[32m                    ,"❌ Error de conexión: "[m
[32m+[m[32m                    , "AVISO",JOptionPane.WARNING_MESSAGE);[m
[32m+[m[41m            [m
[32m+[m[32m        }[m
[32m+[m[32m        return conexion;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public static void main(String[] args) {[m
[32m+[m[32m        conectar(); // Probar la conexión[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Coordinator.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Coordinator.java[m
[1mindex b56d459..9c8e1f3 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Coordinator.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Coordinator.java[m
[36m@@ -1,23 +1,19 @@[m
 package com.mycompany.gestionproyectosacademicos.entities;[m
 [m
[31m-/**[m
[31m- *[m
[31m- * @author bratev[m
[31m- */[m
 public class Coordinator {[m
[31m-    private String id;[m
[32m+[m[32m    private int id;[m
     private String name;[m
 [m
[31m-    public Coordinator(String nit, String name) {[m
[32m+[m[32m    public Coordinator(int id, String name) {[m
         this.id = id;[m
         this.name = name;[m
     }[m
 [m
[31m-    public String getId() {[m
[32m+[m[32m    public int getId() {[m
         return id;[m
     }[m
 [m
[31m-    public void setId(String id) {[m
[32m+[m[32m    public void setId(int id) {[m
         this.id = id;[m
     }[m
 [m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Project.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Project.java[m
[1mindex 56cb18a..ae3adf1 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Project.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Project.java[m
[36m@@ -1,13 +1,77 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[31m- */[m
 package com.mycompany.gestionproyectosacademicos.entities;[m
 [m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.state.ProjectState;[m
[32m+[m[32mimport java.time.LocalDate;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObserver;[m
 /**[m
  *[m
  * @author bryan[m
  */[m
 public class Project {[m
     [m
[32m+[m[32m    private int id;[m
[32m+[m[32m    private String name;[m
[32m+[m[32m    private String description;[m
[32m+[m[32m    private String state;[m
[32m+[m[32m    private LocalDate date;[m
[32m+[m[32m    private int calificacion;[m
[32m+[m[32m    private Request request;[m
[32m+[m[32m    private Company company;[m
[32m+[m[32m    private Student[] students;[m
[32m+[m[32m    private List<IObserver> observers = new ArrayList<>();[m
[32m+[m[41m    [m
[32m+[m[32m    public Project(int id, String name, String description, String state, LocalDate date, int calificacion, Request request, Company company, Student[] students) {[m
[32m+[m[32m        this.id = id;[m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m        this.description = description;[m
[32m+[m[32m        this.state = state;[m
[32m+[m[32m        this.date = date;[m
[32m+[m[32m        this.calificacion = calificacion;[m
[32m+[m[32m        this.request = request;[m
[32m+[m[32m        this.company = company;[m
[32m+[m[32m        this.students = students;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public int getId(){[m
[32m+[m[32m        return id;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getDescription(){[m
[32m+[m[32m        return description;[m
[32m+[m[32m    }[m
[32m+[m[41m   [m
[32m+[m[32m    public String getName(){[m
[32m+[m[32m        return name;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getState() {[m
[32m+[m[32m        return state;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public Company getCompany() {[m
[32m+[m[32m        return company;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setState(String state) {[m
[32m+[m[32m        this.state = state;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[41m    [m
[32m+[m[32m    public void addObserver(IObserver observer){[m
[32m+[m[32m        observers.add(observer);[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void notifyObservers(){[m
[32m+[m[32m        for(IObserver observer : observers){[m
[32m+[m[32m            observer.update(this);[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void changeState(ProjectState state){[m
[32m+[m[32m        state.ManageState(this);[m
[32m+[m[32m        notifyObservers();[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
 }[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Request.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Request.java[m
[1mnew file mode 100644[m
[1mindex 0000000..df37717[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Request.java[m
[36m@@ -0,0 +1,39 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.entities;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32mEsta clase fue creada teniendo en cuanta el diagrama[m
[32m+[m[32mde clases de entidades dominio(Draw.io)[m
[32m+[m[32m*/[m
[32m+[m[32mpublic class Request {[m
[32m+[m[32m    private int requestId;[m
[32m+[m[32m    private String requestDetails ;[m
[32m+[m[41m    [m
[32m+[m[32m    public Request(int id, String details){[m
[32m+[m[32m        this.requestId = id;[m
[32m+[m[32m        this.requestDetails = details;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Request() {[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public int getId(){[m
[32m+[m[32m        return requestId;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void setId(int id){[m
[32m+[m[32m        this.requestId = id;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getDetails(){[m
[32m+[m[32m        return requestDetails;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void setId(String details){[m
[32m+[m[32m        this.requestDetails = details;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateCompany.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateCompany.java[m
[1mnew file mode 100644[m
[1mindex 0000000..ca41614[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateCompany.java[m
[36m@@ -0,0 +1,76 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[32m+[m[32m */[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.entities;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author rubei[m
[32m+[m[32m */[m
[32m+[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.ConexionPostgreSQL;[m
[32m+[m[32mimport java.sql.Connection;[m
[32m+[m[32mimport java.sql.PreparedStatement;[m
[32m+[m[32mimport java.sql.ResultSet;[m
[32m+[m[32mimport java.sql.SQLException;[m
[32m+[m[32mimport javax.swing.JOptionPane;[m
[32m+[m
[32m+[m[32mpublic class SaveDateCompany {[m
[32m+[m
[32m+[m[32m    public boolean existsCompany(int nit, String email) {[m
[32m+[m[32m        String sql = "SELECT COUNT(*) FROM company WHERE companynit = ? OR companyemail = ?";[m
[32m+[m[41m        [m
[32m+[m[32m        try (Connection conexion = ConexionPostgreSQL.conectar();[m
[32m+[m[32m             PreparedStatement pstmt = conexion.prepareStatement(sql)) {[m
[32m+[m
[32m+[m[32m            pstmt.setInt(1, nit);[m
[32m+[m[32m            pstmt.setString(2, email);[m
[32m+[m[32m            ResultSet rs = pstmt.executeQuery();[m
[32m+[m[41m            [m
[32m+[m[32m            if (rs.next()) {[m
[32m+[m[32m                return rs.getInt(1) > 0; // Si COUNT(*) > 0, ya existe una empresa con ese NIT o email[m
[32m+[m[32m            }[m
[32m+[m[32m        } catch (SQLException e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return false;[m
[32m+[m[32m    }[m
[32m+[m[32m    public boolean saveCompany(Company company) {[m
[32m+[m[32m        if (existsCompany(company.getNit(), company.getEmail())) {[m
[32m+[m[32m            JOptionPane.showMessageDialog(null, "Error: Empresa ya registrada con este NIT o email.","Error",JOptionPane.INFORMATION_MESSAGE);[m
[32m+[m[32m            return false;[m[41m [m
[32m+[m[32m        }[m
[32m+[m[41m        [m
[32m+[m[32m        String sql = "INSERT INTO company (companyNIT, companyName, companyEmail, companySector, " +[m
[32m+[m[32m                     "contactName, contactLastName, contactNumber, contactPosition) " +[m
[32m+[m[32m                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";[m
[32m+[m
[32m+[m[32m        try (Connection conexion = ConexionPostgreSQL.conectar();[m
[32m+[m[32m             PreparedStatement pstmt = conexion.prepareStatement(sql)) {[m
[32m+[m
[32m+[m[32m            pstmt.setInt(1, company.getNit());[m
[32m+[m[32m            pstmt.setString(2, company.getName());[m
[32m+[m[32m            pstmt.setString(3, company.getEmail());[m
[32m+[m[32m            pstmt.setString(4, company.getSector());[m
[32m+[m[32m            pstmt.setString(5, company.getContactName());[m
[32m+[m[32m            pstmt.setString(6, company.getContactLastName());[m
[32m+[m[32m            pstmt.setString(7, company.getContactNumber());[m
[32m+[m[32m            pstmt.setString(8, company.getContactPosition());[m
[32m+[m
[32m+[m[32m            pstmt.executeUpdate();[m
[32m+[m[32m            JOptionPane.showMessageDialog(null, "✅ Empresa "[m
[32m+[m[32m                    + "registrada con éxito", "Éxito",[m
[32m+[m[32m                    JOptionPane.INFORMATION_MESSAGE);[m
[32m+[m[32m            return true;[m
[32m+[m
[32m+[m[32m        } catch (SQLException e) {[m
[32m+[m[32m            JOptionPane.showMessageDialog(null, "❌ Error al guardar "[m
[32m+[m[32m                    + "la empresa: " + e.getMessage(), "Error",[m
[32m+[m[32m                    JOptionPane.ERROR_MESSAGE);[m
[32m+[m[32m            return false;[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateUser.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateUser.java[m
[1mnew file mode 100644[m
[1mindex 0000000..dfbce8c[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/SaveDateUser.java[m
[36m@@ -0,0 +1,48 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[32m+[m[32m */[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.entities;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author rubei[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m import java.sql.Connection;[m
[32m+[m[32mimport java.sql.PreparedStatement;[m
[32m+[m[32mimport java.sql.SQLException;[m
[32m+[m[32mimport javax.swing.JOptionPane;[m
[32m+[m
[32m+[m
[32m+[m[32mpublic class SaveDateUser {[m
[32m+[m[41m      [m
[32m+[m
[32m+[m[41m        [m
[32m+[m[41m           [m
[32m+[m[41m         [m
[32m+[m[32m    public boolean saveUser(User user) {[m
[32m+[m[32m        String sql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";[m
[32m+[m[41m        [m
[32m+[m[32m        try (Connection conexion = ConexionPostgreSQL.conectar();[m
[32m+[m[32m             PreparedStatement pstmt = conexion.prepareStatement(sql)) {[m
[32m+[m
[32m+[m[32m            // Hashear la contraseña antes de guardarla[m
[32m+[m[32m           // String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());[m
[32m+[m
[32m+[m[32m            pstmt.setString(1, user.getEmail());[m
[32m+[m[32m            pstmt.setString(2, user.getPassword() );[m
[32m+[m[32m            pstmt.setString(3, user.getRole());[m
[32m+[m
[32m+[m[32m            pstmt.executeUpdate();[m
[32m+[m[32m            JOptionPane.showMessageDialog(null, "✅ Usuario registrado con éxito", "Éxito", JOptionPane.INFORMATION_MESSAGE);[m
[32m+[m
[32m+[m[32m            return true;[m
[32m+[m[32m        } catch (SQLException e) {[m
[32m+[m[32m            JOptionPane.showMessageDialog(null, "❌ Error al guardar El usuario: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m            return false;[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m[41m [m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Student.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Student.java[m
[1mindex 2032297..9a734e6 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Student.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/Student.java[m
[36m@@ -1,13 +1,51 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[31m- */[m
[32m+[m
 package com.mycompany.gestionproyectosacademicos.entities;[m
 [m
 /**[m
  *[m
[31m- * @author bryan[m
[32m+[m[32m * @author Jhonatan[m
  */[m
 public class Student {[m
[32m+[m[41m   [m
[32m+[m[32m    private int id;[m
[32m+[m[32m    private String name;[m
[32m+[m[32m    private String semester;[m
[32m+[m[32m    private String skills;[m
[32m+[m[41m    [m
[32m+[m[32m    public Student(int id, String name, String semester, String skills){[m
[32m+[m[32m        this. id = id;[m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m        this.semester = semester;[m
[32m+[m[32m        this.skills = skills;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    //Getters y Setters[m
[32m+[m[32m    public int getId(){[m
[32m+[m[32m        return id;[m
[32m+[m[32m    }[m
[32m+[m[32m    public void setId(int p_id){[m
[32m+[m[32m        this.id = p_id;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getName(){[m
[32m+[m[32m        return name;[m
[32m+[m[32m    }[m
[32m+[m[32m    public void setName(String p_name){[m
[32m+[m[32m        this.name = p_name;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getSemester(){[m
[32m+[m[32m        return semester;[m
[32m+[m[32m    }[m
[32m+[m[32m    public void setSemester(String p_semester){[m
[32m+[m[32m        this.semester = p_semester;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getSkills(){[m
[32m+[m[32m        return skills;[m
[32m+[m[32m    }[m
[32m+[m[32m    public void setSkills(String p_skills){[m
[32m+[m[32m        this.skills = p_skills;[m
[32m+[m[32m    }[m
     [m
 }[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/User.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/User.java[m
[1mindex a1c9819..ff54f93 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/User.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/entities/User.java[m
[36m@@ -1,13 +1,56 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template[m
[31m- */[m
 package com.mycompany.gestionproyectosacademicos.entities;[m
 [m
 /**[m
[31m- *[m
[31m- * @author bryan[m
[32m+[m[32m * Clase que representa un usuario en el sistema.[m
  */[m
 public class User {[m
[31m-    [m
[32m+[m[32m    private int id;[m
[32m+[m[32m    private String email;[m
[32m+[m[32m    private String password;[m
[32m+[m[32m    private String role; // Puede ser ADMIN, COORDINADOR, ESTUDIANTE, EMPRESA[m
[32m+[m
[32m+[m[32m    public User(int id, String email, String password, String role) {[m
[32m+[m[32m        this.id = id;[m
[32m+[m[32m        this.email = email;[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m        this.role = role;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Getters y Setters[m
[32m+[m[32m    public int getId() {[m
[32m+[m[32m        return id;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setId(int id) {[m
[32m+[m[32m        this.id = id;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getEmail() {[m
[32m+[m[32m        return email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setEmail(String email) {[m
[32m+[m[32m        this.email = email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getPassword() {[m
[32m+[m[32m        return password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setPassword(String password) {[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getRole() {[m
[32m+[m[32m        return role;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setRole(String role) {[m
[32m+[m[32m        this.role = role;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public String toString() {[m
[32m+[m[32m        return "User{" + "id=" + id + ", email=" + email + ", role=" + role + '}';[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/infra/Messages.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/infra/Messages.java[m
[1mindex de7109e..d0469b8 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/infra/Messages.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/infra/Messages.java[m
[36m@@ -1,11 +1,17 @@[m
 package com.mycompany.gestionproyectosacademicos.infra;[m
[32m+[m[32m   import javax.swing.JOptionPane;[m
 [m
[31m-import javax.swing.JOptionPane;[m
[32m+[m[32m   /**[m
[32m+[m[32m    *[m
[32m+[m[32m    * @author Libardo Pantoja, Julio A. Hurtado[m
[32m+[m[32m    */[m
[32m+[m[32m   public class Messages {[m
[32m+[m[41m       [m
[32m+[m[32m       public static void showMessageDialog(String message, String title) {[m
[32m+[m[32m           JOptionPane.showMessageDialog(null, message, title, JOptionPane.INFORMATION_MESSAGE);[m
[32m+[m[32m       }[m
 [m
[31m-/**[m
[31m- *[m
[31m- * @author bryan[m
[31m- */[m
[31m-public class Messages {[m
[31m-    [m
[31m-}[m
[32m+[m[32m       public static int showConfirmDialog(String message, String title) {[m
[32m+[m[32m           return JOptionPane.showConfirmDialog(null, message, title, JOptionPane.INFORMATION_MESSAGE);[m
[32m+[m[32m       }[m
[32m+[m[32m   }[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/main/Main.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/main/Main.java[m
[1mindex d0a4323..4a4fd46 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/main/Main.java[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/main/Main.java[m
[36m@@ -4,14 +4,16 @@[m
  */[m
 package com.mycompany.gestionproyectosacademicos.main;[m
 [m
[31m-import com.mycompany.gestionproyectosacademicos.presentacion.GUICoordinator;[m
[31m-import com.mycompany.gestionproyectosacademicos.presentacion.GUILogin;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.Factory;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.IUserRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.presentation.GUILogin;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.AuthService;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.UserServices;[m
[32m+[m
 import javax.swing.JFrame;[m
 [m
[31m-/**[m
[31m- *[m
[31m- * @author bryan[m
[31m- */[m
 public class Main {[m
     public static void main(String[] args) {[m
         /*Example: ICompanyRepository repository = Factory.getInstance().getRepository("ARRAYS");// Podria ir SQLITE*/ [m
[36m@@ -22,12 +24,11 @@[m [mpublic class Main {[m
         instance.setExtendedState(JFrame.MAXIMIZED_BOTH);[m
         instance.setVisible(true);[m
         */[m
[31m-[m
[31m-        GUICoordinator instance = new GUICoordinator();[m
[31m-        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);[m
[31m-        instance.setVisible(false);[m
         [m
[31m-        GUILogin login = new GUILogin();[m
[31m-        login.setVisible(true);[m
[32m+[m[32m        IUserRepository userRepo = Factory.getInstance().getRepository(IUserRepository.class, "ARRAYS"); // Usando datos en memoria[m
[32m+[m[32m        AuthService authService = new AuthService(userRepo);[m
[32m+[m[41m        [m
[32m+[m[32m        GUILogin loginGUI = new GUILogin(authService);[m
[32m+[m[32m        loginGUI.setVisible(true);[m
     }[m
 }[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObservable.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObservable.java[m
[1mnew file mode 100644[m
[1mindex 0000000..33ae2d1[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObservable.java[m
[36m@@ -0,0 +1,7 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.observer;[m
[32m+[m
[32m+[m[32mpublic interface IObservable {[m
[32m+[m[32m    void addObserver(IObserver observer);[m
[32m+[m[32m    void removeObserver(IObserver observer);[m
[32m+[m[32m    void notifyObservers();[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObserver.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObserver.java[m
[1mnew file mode 100644[m
[1mindex 0000000..9b2eaaf[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/IObserver.java[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.observer;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m
[32m+[m[32mpublic interface IObserver {[m
[32m+[m[41m    [m
[32m+[m[32m    void update(Object o);[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/Subject.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/Subject.java[m
[1mnew file mode 100644[m
[1mindex 0000000..37297f7[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/Subject.java[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.observer;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObserver;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m
[32m+[m[32mpublic abstract class Subject {[m
[32m+[m[32m    ArrayList<IObserver> observers;[m
[32m+[m
[32m+[m[32m    public void Subject() {[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Agrega un observador[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param obs[m
[32m+[m[32m     */[m
[32m+[m[32m    public void addObserver(IObserver obs) {[m
[32m+[m[32m        if (observers == null) {[m
[32m+[m[32m            observers = new ArrayList<>();[m
[32m+[m[32m        }[m
[32m+[m[32m        observers.add(obs);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Notifica a todos los observadores que hubo un cambio en el modelo[m
[32m+[m[32m     */[m
[32m+[m[32m    public void notifyAllObserves() {[m
[32m+[m[32m        for (IObserver each : observers) {[m
[32m+[m[32m            each.update(this);[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/projectsCoordinatorObserver.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/projectsCoordinatorObserver.java[m
[1mnew file mode 100644[m
[1mindex 0000000..f1b50f5[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/observer/projectsCoordinatorObserver.java[m
[36m@@ -0,0 +1,43 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.observer;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Coordinator;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.ProjectService;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32mimport javax.swing.JFrame;[m
[32m+[m[32mimport javax.swing.JScrollPane;[m
[32m+[m[32mimport javax.swing.JTable;[m
[32m+[m[32mimport javax.swing.table.DefaultTableModel;[m
[32m+[m
[32m+[m[32mpublic class projectsCoordinatorObserver extends JFrame implements IObserver{[m
[32m+[m[32m    private final JScrollPane jScrollPane1;[m
[32m+[m[32m    private final JTable tableProjects;[m
[32m+[m[32m    private final Coordinator coordinator;[m
[32m+[m[32m    private final ProjectService projectService;[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m    public projectsCoordinatorObserver(Coordinator coordinator, ProjectService projectService, JTable tableProjects, JScrollPane jScrollPane1) {[m
[32m+[m[32m        this.coordinator = coordinator;[m
[32m+[m[32m        this.tableProjects = tableProjects;[m
[32m+[m[32m        this.projectService = projectService;[m
[32m+[m[32m        this.jScrollPane1 = jScrollPane1;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void update(Object o) {[m
[32m+[m[32m        // Obtener los proyectos actualizados[m
[32m+[m[32m        List<Project> projects = projectService.getProjects();[m
[32m+[m[32m        ProjectService projectService = (ProjectService) o;[m
[32m+[m[41m        [m
[32m+[m[32m        // Crear modelo de tabla[m
[32m+[m[32m        DefaultTableModel model = new DefaultTableModel(new String[]{"Proyecto", "Empresa", "Opciones"}, 0);[m
[32m+[m[41m        [m
[32m+[m[32m        for(Project project : projects) {[m
[32m+[m[32m            model.addRow(new Object[]{project.getName(), project.getCompany().getName(), "Ver más"});[m
[32m+[m[32m        }[m
[32m+[m[41m        [m
[32m+[m[32m        tableProjects.setModel(model);[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.form[m
[1mdeleted file mode 100644[m
[1mindex 365286c..0000000[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.form[m
[1m+++ /dev/null[m
[36m@@ -1,482 +0,0 @@[m
[31m-<?xml version="1.0" encoding="UTF-8" ?>[m
[31m-[m
[31m-<Form version="1.9" maxVersion="1.9" type="org.netbeans.modules.form.forminfo.JFrameFormInfo">[m
[31m-  <Properties>[m
[31m-    <Property name="defaultCloseOperation" type="int" value="3"/>[m
[31m-    <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-      <Dimension value="[960, 540]"/>[m
[31m-    </Property>[m
[31m-    <Property name="size" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-      <Dimension value="[960, 540]"/>[m
[31m-    </Property>[m
[31m-  </Properties>[m
[31m-  <SyntheticProperties>[m
[31m-    <SyntheticProperty name="formSizePolicy" type="int" value="1"/>[m
[31m-    <SyntheticProperty name="generateCenter" type="boolean" value="false"/>[m
[31m-  </SyntheticProperties>[m
[31m-  <AuxValues>[m
[31m-    <AuxValue name="FormSettings_autoResourcing" type="java.lang.Integer" value="0"/>[m
[31m-    <AuxValue name="FormSettings_autoSetComponentName" type="java.lang.Boolean" value="false"/>[m
[31m-    <AuxValue name="FormSettings_generateFQN" type="java.lang.Boolean" value="true"/>[m
[31m-    <AuxValue name="FormSettings_generateMnemonicsCode" type="java.lang.Boolean" value="false"/>[m
[31m-    <AuxValue name="FormSettings_i18nAutoMode" type="java.lang.Boolean" value="false"/>[m
[31m-    <AuxValue name="FormSettings_layoutCodeTarget" type="java.lang.Integer" value="1"/>[m
[31m-    <AuxValue name="FormSettings_listenerGenerationStyle" type="java.lang.Integer" value="0"/>[m
[31m-    <AuxValue name="FormSettings_variablesLocal" type="java.lang.Boolean" value="false"/>[m
[31m-    <AuxValue name="FormSettings_variablesModifier" type="java.lang.Integer" value="2"/>[m
[31m-    <AuxValue name="designerSize" type="java.awt.Dimension" value="-84,-19,0,5,115,114,0,18,106,97,118,97,46,97,119,116,46,68,105,109,101,110,115,105,111,110,65,-114,-39,-41,-84,95,68,20,2,0,2,73,0,6,104,101,105,103,104,116,73,0,5,119,105,100,116,104,120,112,0,0,2,28,0,0,3,-64"/>[m
[31m-  </AuxValues>[m
[31m-[m
[31m-  <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
[31m-  <SubComponents>[m
[31m-    <Container class="javax.swing.JPanel" name="jpIzq">[m
[31m-      <Properties>[m
[31m-        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[31m-        </Property>[m
[31m-        <Property name="alignmentX" type="float" value="0.0"/>[m
[31m-        <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[31m-          <Color id="Default Cursor"/>[m
[31m-        </Property>[m
[31m-      </Properties>[m
[31m-      <Constraints>[m
[31m-        <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-          <BorderConstraints direction="Before"/>[m
[31m-        </Constraint>[m
[31m-      </Constraints>[m
[31m-[m
[31m-      <Layout>[m
[31m-        <DimensionLayout dim="0">[m
[31m-          <Group type="103" groupAlignment="0" attributes="0">[m
[31m-              <Component id="btnPerfil" alignment="1" max="32767" attributes="0"/>[m
[31m-              <Component id="btnRequests" alignment="0" max="32767" attributes="0"/>[m
[31m-              <Component id="btnMonitoring" alignment="0" max="32767" attributes="0"/>[m
[31m-              <Group type="102" alignment="1" attributes="0">[m
[31m-                  <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                      <Group type="102" alignment="0" attributes="0">[m
[31m-                          <EmptySpace pref="95" max="32767" attributes="0"/>[m
[31m-                          <Component id="lblUser" min="-2" max="-2" attributes="0"/>[m
[31m-                      </Group>[m
[31m-                      <Group type="102" alignment="1" attributes="0">[m
[31m-                          <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[31m-                          <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                              <Component id="sepUserCoord" min="-2" pref="124" max="-2" attributes="0"/>[m
[31m-                              <Group type="102" alignment="0" attributes="0">[m
[31m-                                  <EmptySpace min="-2" pref="6" max="-2" attributes="0"/>[m
[31m-                                  <Component id="btnCloseSession" min="-2" pref="99" max="-2" attributes="0"/>[m
[31m-                              </Group>[m
[31m-                          </Group>[m
[31m-                      </Group>[m
[31m-                  </Group>[m
[31m-                  <EmptySpace min="-2" pref="90" max="-2" attributes="0"/>[m
[31m-              </Group>[m
[31m-              <Component id="btnAssignment" alignment="0" max="32767" attributes="0"/>[m
[31m-              <Component id="btnReports" alignment="1" max="32767" attributes="0"/>[m
[31m-              <Component id="btnConnections" alignment="1" max="32767" attributes="0"/>[m
[31m-              <Group type="102" alignment="1" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[31m-                  <Component id="lblCoordinator" min="-2" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace min="-2" pref="101" max="-2" attributes="0"/>[m
[31m-              </Group>[m
[31m-          </Group>[m
[31m-        </DimensionLayout>[m
[31m-        <DimensionLayout dim="1">[m
[31m-          <Group type="103" groupAlignment="0" attributes="0">[m
[31m-              <Group type="102" attributes="0">[m
[31m-                  <EmptySpace min="-2" pref="20" max="-2" attributes="0"/>[m
[31m-                  <Component id="lblUser" min="-2" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="sepUserCoord" min="-2" pref="14" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="lblCoordinator" min="-2" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace min="-2" pref="42" max="-2" attributes="0"/>[m
[31m-                  <Component id="btnPerfil" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="btnRequests" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="btnMonitoring" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="btnAssignment" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="btnReports" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace max="-2" attributes="0"/>[m
[31m-                  <Component id="btnConnections" min="-2" pref="45" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace pref="35" max="32767" attributes="0"/>[m
[31m-                  <Component id="btnCloseSession" min="-2" pref="32" max="-2" attributes="0"/>[m
[31m-                  <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[31m-              </Group>[m
[31m-          </Group>[m
[31m-        </DimensionLayout>[m
[31m-      </Layout>[m
[31m-      <SubComponents>[m
[31m-        <Component class="javax.swing.JLabel" name="lblUser">[m
[31m-          <Properties>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="36" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Usuario"/>[m
[31m-          </Properties>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JLabel" name="lblCoordinator">[m
[31m-          <Properties>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="18" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Coordinador"/>[m
[31m-          </Properties>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JSeparator" name="sepUserCoord">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnPerfil">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Perfil"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnPerfilActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnRequests">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Solicitudes"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnRequestsActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnMonitoring">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Monitoreo"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnMonitoringActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnAssignment">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Asignaci&#xf3;n"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnAssignmentActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnReports">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Reportes"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnReportsActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnConnections">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="14" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Conexiones"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="null"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnConnectionsActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-        <Component class="javax.swing.JButton" name="btnCloseSession">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="81" green="72" red="62" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-              <Font name="Tahoma" size="12" style="0"/>[m
[31m-            </Property>[m
[31m-            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-            </Property>[m
[31m-            <Property name="text" type="java.lang.String" value="Cerrar Sesi&#xf3;n"/>[m
[31m-            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[31m-              <Border info="org.netbeans.modules.form.compat2.border.BevelBorderInfo">[m
[31m-                <BevelBorder/>[m
[31m-              </Border>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Events>[m
[31m-            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnCloseSessionActionPerformed"/>[m
[31m-          </Events>[m
[31m-        </Component>[m
[31m-      </SubComponents>[m
[31m-    </Container>[m
[31m-    <Container class="javax.swing.JPanel" name="pnlDer">[m
[31m-      <Properties>[m
[31m-        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-          <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[31m-        </Property>[m
[31m-      </Properties>[m
[31m-      <Constraints>[m
[31m-        <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-          <BorderConstraints direction="Center"/>[m
[31m-        </Constraint>[m
[31m-      </Constraints>[m
[31m-[m
[31m-      <Layout class="org.netbeans.modules.form.compat2.layouts.DesignCardLayout"/>[m
[31m-      <SubComponents>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlRequests">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card2"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Container class="javax.swing.JPanel" name="jPanel1">[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="Last"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-            </Container>[m
[31m-            <Container class="javax.swing.JPanel" name="jPanel2">[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="After"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-            </Container>[m
[31m-            <Container class="javax.swing.JPanel" name="jPanel3">[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="West"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-            </Container>[m
[31m-            <Container class="javax.swing.JPanel" name="jPanel5">[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="First"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-            </Container>[m
[31m-            <Container class="javax.swing.JPanel" name="jPanel4">[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="First"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-            </Container>[m
[31m-            <Container class="javax.swing.JScrollPane" name="jScrollPane1">[m
[31m-              <AuxValues>[m
[31m-                <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[31m-              </AuxValues>[m
[31m-              <Constraints>[m
[31m-                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-                  <BorderConstraints direction="Center"/>[m
[31m-                </Constraint>[m
[31m-              </Constraints>[m
[31m-[m
[31m-              <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[31m-              <SubComponents>[m
[31m-                <Component class="javax.swing.JTable" name="jTable1">[m
[31m-                  <Properties>[m
[31m-                    <Property name="model" type="javax.swing.table.TableModel" editor="org.netbeans.modules.form.editors2.TableModelEditor">[m
[31m-                      <Table columnCount="4" rowCount="4">[m
[31m-                        <Column editable="true" title="Title 1" type="java.lang.Object"/>[m
[31m-                        <Column editable="true" title="Title 2" type="java.lang.Object"/>[m
[31m-                        <Column editable="true" title="Title 3" type="java.lang.Object"/>[m
[31m-                        <Column editable="true" title="Title 4" type="java.lang.Object"/>[m
[31m-                      </Table>[m
[31m-                    </Property>[m
[31m-                  </Properties>[m
[31m-                </Component>[m
[31m-              </SubComponents>[m
[31m-            </Container>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlMonitoring">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card4"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Component class="javax.swing.JLabel" name="jLabel1">[m
[31m-              <Properties>[m
[31m-                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="48" style="0"/>[m
[31m-                </Property>[m
[31m-                <Property name="text" type="java.lang.String" value="Monitoreo"/>[m
[31m-              </Properties>[m
[31m-            </Component>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlAssingment">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card5"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Component class="javax.swing.JLabel" name="jLabel3">[m
[31m-              <Properties>[m
[31m-                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="36" style="0"/>[m
[31m-                </Property>[m
[31m-                <Property name="text" type="java.lang.String" value="Asignaci&#xf3;n de proyectos"/>[m
[31m-              </Properties>[m
[31m-            </Component>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlReports">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card6"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Component class="javax.swing.JLabel" name="jLabel4">[m
[31m-              <Properties>[m
[31m-                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="48" style="0"/>[m
[31m-                </Property>[m
[31m-                <Property name="text" type="java.lang.String" value="Reportes"/>[m
[31m-              </Properties>[m
[31m-            </Component>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlConnections">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card7"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Component class="javax.swing.JLabel" name="jLabel5">[m
[31m-              <Properties>[m
[31m-                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="48" style="0"/>[m
[31m-                </Property>[m
[31m-                <Property name="text" type="java.lang.String" value="Conexiones"/>[m
[31m-              </Properties>[m
[31m-            </Component>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="pnlPerfil">[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[31m-              <CardConstraints cardName="card3"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[31m-          <SubComponents>[m
[31m-            <Component class="javax.swing.JLabel" name="jLabel2">[m
[31m-              <Properties>[m
[31m-                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="48" style="0"/>[m
[31m-                </Property>[m
[31m-                <Property name="text" type="java.lang.String" value="Perfil"/>[m
[31m-              </Properties>[m
[31m-            </Component>[m
[31m-          </SubComponents>[m
[31m-        </Container>[m
[31m-      </SubComponents>[m
[31m-    </Container>[m
[31m-  </SubComponents>[m
[31m-</Form>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.java[m
[1mdeleted file mode 100644[m
[1mindex 449efa2..0000000[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUICoordinator.java[m
[1m+++ /dev/null[m
[36m@@ -1,409 +0,0 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template[m
[31m- */[m
[31m-package com.mycompany.gestionproyectosacademicos.presentacion;[m
[31m-[m
[31m-import java.awt.CardLayout;[m
[31m-import java.awt.Color;[m
[31m-import javax.swing.JButton;[m
[31m-[m
[31m-/**[m
[31m- *[m
[31m- * @author bryan[m
[31m- */[m
[31m-public class GUICoordinator extends javax.swing.JFrame {[m
[31m-    // Colores personalizados[m
[31m-    private final Color colorBackSelect = new Color(217, 217, 217); // #D9D9D9[m
[31m-    private final Color colorTxtSelect = new Color(19, 45, 70);    // #132D46[m
[31m-    private final Color colorBackOrigin = new Color(98, 114, 129);      // #627281[m
[31m-    private final Color colorTxtOrigin = new Color(255, 255, 255);     // #FFFFFF[m
[31m-    /**[m
[31m-     * Creates new form GUIMenu[m
[31m-     */[m
[31m-    public GUICoordinator() {[m
[31m-        initComponents();[m
[31m-        this.setLocationRelativeTo(null);[m
[31m-    }[m
[31m-[m
[31m-    /**[m
[31m-     * This method is called from within the constructor to initialize the form.[m
[31m-     * WARNING: Do NOT modify this code. The content of this method is always[m
[31m-     * regenerated by the Form Editor.[m
[31m-     */[m
[31m-    @SuppressWarnings("unchecked")[m
[31m-    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[31m-    private void initComponents() {[m
[31m-[m
[31m-        jpIzq = new javax.swing.JPanel();[m
[31m-        lblUser = new javax.swing.JLabel();[m
[31m-        lblCoordinator = new javax.swing.JLabel();[m
[31m-        sepUserCoord = new javax.swing.JSeparator();[m
[31m-        btnPerfil = new javax.swing.JButton();[m
[31m-        btnRequests = new javax.swing.JButton();[m
[31m-        btnMonitoring = new javax.swing.JButton();[m
[31m-        btnAssignment = new javax.swing.JButton();[m
[31m-        btnReports = new javax.swing.JButton();[m
[31m-        btnConnections = new javax.swing.JButton();[m
[31m-        btnCloseSession = new javax.swing.JButton();[m
[31m-        pnlDer = new javax.swing.JPanel();[m
[31m-        pnlRequests = new javax.swing.JPanel();[m
[31m-        jPanel1 = new javax.swing.JPanel();[m
[31m-        jPanel2 = new javax.swing.JPanel();[m
[31m-        jPanel3 = new javax.swing.JPanel();[m
[31m-        jPanel5 = new javax.swing.JPanel();[m
[31m-        jPanel4 = new javax.swing.JPanel();[m
[31m-        jScrollPane1 = new javax.swing.JScrollPane();[m
[31m-        jTable1 = new javax.swing.JTable();[m
[31m-        pnlMonitoring = new javax.swing.JPanel();[m
[31m-        jLabel1 = new javax.swing.JLabel();[m
[31m-        pnlAssingment = new javax.swing.JPanel();[m
[31m-        jLabel3 = new javax.swing.JLabel();[m
[31m-        pnlReports = new javax.swing.JPanel();[m
[31m-        jLabel4 = new javax.swing.JLabel();[m
[31m-        pnlConnections = new javax.swing.JPanel();[m
[31m-        jLabel5 = new javax.swing.JLabel();[m
[31m-        pnlPerfil = new javax.swing.JPanel();[m
[31m-        jLabel2 = new javax.swing.JLabel();[m
[31m-[m
[31m-        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[31m-        setMinimumSize(new java.awt.Dimension(960, 540));[m
[31m-        setSize(new java.awt.Dimension(960, 540));[m
[31m-[m
[31m-        jpIzq.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-        jpIzq.setAlignmentX(0.0F);[m
[31m-        jpIzq.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[31m-[m
[31m-        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[31m-        lblUser.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        lblUser.setText("Usuario");[m
[31m-[m
[31m-        lblCoordinator.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N[m
[31m-        lblCoordinator.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        lblCoordinator.setText("Coordinador");[m
[31m-[m
[31m-        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));[m
[31m-        sepUserCoord.setForeground(new java.awt.Color(155, 70, 47));[m
[31m-[m
[31m-        btnPerfil.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnPerfil.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnPerfil.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnPerfil.setText("Perfil");[m
[31m-        btnPerfil.setBorder(null);[m
[31m-        btnPerfil.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnPerfilActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnRequests.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnRequests.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnRequests.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnRequests.setText("Solicitudes");[m
[31m-        btnRequests.setBorder(null);[m
[31m-        btnRequests.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnRequestsActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnMonitoring.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnMonitoring.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnMonitoring.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnMonitoring.setText("Monitoreo");[m
[31m-        btnMonitoring.setBorder(null);[m
[31m-        btnMonitoring.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnMonitoringActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnAssignment.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnAssignment.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnAssignment.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnAssignment.setText("Asignación");[m
[31m-        btnAssignment.setBorder(null);[m
[31m-        btnAssignment.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnAssignmentActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnReports.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnReports.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnReports.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnReports.setText("Reportes");[m
[31m-        btnReports.setBorder(null);[m
[31m-        btnReports.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnReportsActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnConnections.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnConnections.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[31m-        btnConnections.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnConnections.setText("Conexiones");[m
[31m-        btnConnections.setBorder(null);[m
[31m-        btnConnections.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnConnectionsActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        btnCloseSession.setBackground(new java.awt.Color(98, 114, 129));[m
[31m-        btnCloseSession.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[31m-        btnCloseSession.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        btnCloseSession.setText("Cerrar Sesión");[m
[31m-        btnCloseSession.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));[m
[31m-        btnCloseSession.addActionListener(new java.awt.event.ActionListener() {[m
[31m-            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[31m-                btnCloseSessionActionPerformed(evt);[m
[31m-            }[m
[31m-        });[m
[31m-[m
[31m-        javax.swing.GroupLayout jpIzqLayout = new javax.swing.GroupLayout(jpIzq);[m
[31m-        jpIzq.setLayout(jpIzqLayout);[m
[31m-        jpIzqLayout.setHorizontalGroup([m
[31m-            jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addComponent(btnPerfil, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addComponent(btnRequests, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addComponent(btnMonitoring, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()[m
[31m-                .addGroup(jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-                    .addGroup(jpIzqLayout.createSequentialGroup()[m
[31m-                        .addContainerGap(95, Short.MAX_VALUE)[m
[31m-                        .addComponent(lblUser))[m
[31m-                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()[m
[31m-                        .addGap(0, 0, Short.MAX_VALUE)[m
[31m-                        .addGroup(jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-                            .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                            .addGroup(jpIzqLayout.createSequentialGroup()[m
[31m-                                .addGap(6, 6, 6)[m
[31m-                                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 99, javax.swing.GroupLayout.PREFERRED_SIZE)))))[m
[31m-                .addGap(90, 90, 90))[m
[31m-            .addComponent(btnAssignment, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addComponent(btnReports, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addComponent(btnConnections, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()[m
[31m-                .addGap(0, 0, Short.MAX_VALUE)[m
[31m-                .addComponent(lblCoordinator)[m
[31m-                .addGap(101, 101, 101))[m
[31m-        );[m
[31m-        jpIzqLayout.setVerticalGroup([m
[31m-            jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGroup(jpIzqLayout.createSequentialGroup()[m
[31m-                .addGap(20, 20, 20)[m
[31m-                .addComponent(lblUser)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(lblCoordinator)[m
[31m-                .addGap(42, 42, 42)[m
[31m-                .addComponent(btnPerfil, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(btnRequests, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(btnMonitoring, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(btnAssignment, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(btnReports, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(btnConnections, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 35, Short.MAX_VALUE)[m
[31m-                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addGap(19, 19, 19))[m
[31m-        );[m
[31m-[m
[31m-        getContentPane().add(jpIzq, java.awt.BorderLayout.LINE_START);[m
[31m-[m
[31m-        pnlDer.setBackground(new java.awt.Color(255, 255, 255));[m
[31m-        pnlDer.setLayout(new java.awt.CardLayout());[m
[31m-[m
[31m-        pnlRequests.setLayout(new java.awt.BorderLayout());[m
[31m-        pnlRequests.add(jPanel1, java.awt.BorderLayout.PAGE_END);[m
[31m-        pnlRequests.add(jPanel2, java.awt.BorderLayout.LINE_END);[m
[31m-        pnlRequests.add(jPanel3, java.awt.BorderLayout.WEST);[m
[31m-        pnlRequests.add(jPanel5, java.awt.BorderLayout.PAGE_START);[m
[31m-        pnlRequests.add(jPanel4, java.awt.BorderLayout.PAGE_START);[m
[31m-[m
[31m-        jTable1.setModel(new javax.swing.table.DefaultTableModel([m
[31m-            new Object [][] {[m
[31m-                {null, null, null, null},[m
[31m-                {null, null, null, null},[m
[31m-                {null, null, null, null},[m
[31m-                {null, null, null, null}[m
[31m-            },[m
[31m-            new String [] {[m
[31m-                "Title 1", "Title 2", "Title 3", "Title 4"[m
[31m-            }[m
[31m-        ));[m
[31m-        jScrollPane1.setViewportView(jTable1);[m
[31m-[m
[31m-        pnlRequests.add(jScrollPane1, java.awt.BorderLayout.CENTER);[m
[31m-[m
[31m-        pnlDer.add(pnlRequests, "card2");[m
[31m-[m
[31m-        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[31m-        jLabel1.setText("Monitoreo");[m
[31m-        pnlMonitoring.add(jLabel1);[m
[31m-[m
[31m-        pnlDer.add(pnlMonitoring, "card4");[m
[31m-[m
[31m-        jLabel3.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[31m-        jLabel3.setText("Asignación de proyectos");[m
[31m-        pnlAssingment.add(jLabel3);[m
[31m-[m
[31m-        pnlDer.add(pnlAssingment, "card5");[m
[31m-[m
[31m-        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[31m-        jLabel4.setText("Reportes");[m
[31m-        pnlReports.add(jLabel4);[m
[31m-[m
[31m-        pnlDer.add(pnlReports, "card6");[m
[31m-[m
[31m-        jLabel5.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[31m-        jLabel5.setText("Conexiones");[m
[31m-        pnlConnections.add(jLabel5);[m
[31m-[m
[31m-        pnlDer.add(pnlConnections, "card7");[m
[31m-[m
[31m-        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[31m-        jLabel2.setText("Perfil");[m
[31m-        pnlPerfil.add(jLabel2);[m
[31m-[m
[31m-        pnlDer.add(pnlPerfil, "card3");[m
[31m-[m
[31m-        getContentPane().add(pnlDer, java.awt.BorderLayout.CENTER);[m
[31m-[m
[31m-        pack();[m
[31m-    }// </editor-fold>//GEN-END:initComponents[m
[31m-[m
[31m-    private void btnCloseSessionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionActionPerformed[m
[31m-[m
[31m-    }//GEN-LAST:event_btnCloseSessionActionPerformed[m
[31m-[m
[31m-    private void btnConnectionsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConnectionsActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card7");[m
[31m-        changeColorBtn(btnConnections);[m
[31m-    }//GEN-LAST:event_btnConnectionsActionPerformed[m
[31m-[m
[31m-    private void btnReportsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnReportsActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card6");[m
[31m-        changeColorBtn(btnReports);[m
[31m-    }//GEN-LAST:event_btnReportsActionPerformed[m
[31m-[m
[31m-    private void btnAssignmentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAssignmentActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card5");[m
[31m-        changeColorBtn(btnAssignment);[m
[31m-    }//GEN-LAST:event_btnAssignmentActionPerformed[m
[31m-[m
[31m-    private void btnMonitoringActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMonitoringActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card4");[m
[31m-        changeColorBtn(btnMonitoring);[m
[31m-    }//GEN-LAST:event_btnMonitoringActionPerformed[m
[31m-[m
[31m-    private void btnRequestsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRequestsActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card2");[m
[31m-        changeColorBtn(btnRequests);[m
[31m-    }//GEN-LAST:event_btnRequestsActionPerformed[m
[31m-[m
[31m-    private void btnPerfilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPerfilActionPerformed[m
[31m-        CardLayout cl = (CardLayout) pnlDer.getLayout();[m
[31m-        cl.show(pnlDer, "card3");[m
[31m-        changeColorBtn(btnPerfil);[m
[31m-    }//GEN-LAST:event_btnPerfilActionPerformed[m
[31m-[m
[31m-    private void changeColorBtn(JButton botonSeleccionado) {[m
[31m-        // Restaurar el estilo de todos los botones[m
[31m-        for (JButton boton : new JButton[]{btnPerfil, btnRequests, btnMonitoring, btnAssignment, btnReports, btnConnections}) {[m
[31m-            boton.setBackground(colorBackOrigin);[m
[31m-            boton.setForeground(colorTxtOrigin);[m
[31m-        }[m
[31m-[m
[31m-        // Cambiar el estilo del botón seleccionado[m
[31m-        botonSeleccionado.setBackground(colorBackSelect);[m
[31m-        botonSeleccionado.setForeground(colorTxtSelect);[m
[31m-    }[m
[31m-    [m
[31m-    /**[m
[31m-     * @param args the command line arguments[m
[31m-     */[m
[31m-    public static void main(String args[]) {[m
[31m-        /* Set the Nimbus look and feel */[m
[31m-        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">[m
[31m-        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.[m
[31m-         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html [m
[31m-         */[m
[31m-        try {[m
[31m-            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {[m
[31m-                if ("Nimbus".equals(info.getName())) {[m
[31m-                    javax.swing.UIManager.setLookAndFeel(info.getClassName());[m
[31m-                    break;[m
[31m-                }[m
[31m-            }[m
[31m-        } catch (ClassNotFoundException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (InstantiationException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (IllegalAccessException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (javax.swing.UnsupportedLookAndFeelException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        }[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-        //</editor-fold>[m
[31m-[m
[31m-        /* Create and display the form */[m
[31m-        java.awt.EventQueue.invokeLater(new Runnable() {[m
[31m-            public void run() {[m
[31m-                new GUICoordinator().setVisible(true);[m
[31m-            }[m
[31m-        });[m
[31m-    }[m
[31m-[m
[31m-    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[31m-    private javax.swing.JButton btnAssignment;[m
[31m-    private javax.swing.JButton btnCloseSession;[m
[31m-    private javax.swing.JButton btnConnections;[m
[31m-    private javax.swing.JButton btnMonitoring;[m
[31m-    private javax.swing.JButton btnPerfil;[m
[31m-    private javax.swing.JButton btnReports;[m
[31m-    private javax.swing.JButton btnRequests;[m
[31m-    private javax.swing.JLabel jLabel1;[m
[31m-    private javax.swing.JLabel jLabel2;[m
[31m-    private javax.swing.JLabel jLabel3;[m
[31m-    private javax.swing.JLabel jLabel4;[m
[31m-    private javax.swing.JLabel jLabel5;[m
[31m-    private javax.swing.JPanel jPanel1;[m
[31m-    private javax.swing.JPanel jPanel2;[m
[31m-    private javax.swing.JPanel jPanel3;[m
[31m-    private javax.swing.JPanel jPanel4;[m
[31m-    private javax.swing.JPanel jPanel5;[m
[31m-    private javax.swing.JScrollPane jScrollPane1;[m
[31m-    private javax.swing.JTable jTable1;[m
[31m-    private javax.swing.JPanel jpIzq;[m
[31m-    private javax.swing.JLabel lblCoordinator;[m
[31m-    private javax.swing.JLabel lblUser;[m
[31m-    private javax.swing.JPanel pnlAssingment;[m
[31m-    private javax.swing.JPanel pnlConnections;[m
[31m-    private javax.swing.JPanel pnlDer;[m
[31m-    private javax.swing.JPanel pnlMonitoring;[m
[31m-    private javax.swing.JPanel pnlPerfil;[m
[31m-    private javax.swing.JPanel pnlReports;[m
[31m-    private javax.swing.JPanel pnlRequests;[m
[31m-    private javax.swing.JSeparator sepUserCoord;[m
[31m-    // End of variables declaration//GEN-END:variables[m
[31m-}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.java[m
[1mdeleted file mode 100644[m
[1mindex 4e9de63..0000000[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.java[m
[1m+++ /dev/null[m
[36m@@ -1,282 +0,0 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template[m
[31m- */[m
[31m-package com.mycompany.gestionproyectosacademicos.presentacion;[m
[31m-[m
[31m-import java.awt.Cursor;[m
[31m-[m
[31m-/**[m
[31m- *[m
[31m- * @author juand[m
[31m- */[m
[31m-public class GUILogin extends javax.swing.JFrame {[m
[31m-[m
[31m-    /**[m
[31m-     * Creates new form GUILogin[m
[31m-     */[m
[31m-    public GUILogin() {[m
[31m-        initComponents();[m
[31m-        setLocationRelativeTo(null);[m
[31m-    }[m
[31m-[m
[31m-    /**[m
[31m-     * This method is called from within the constructor to initialize the form.[m
[31m-     * WARNING: Do NOT modify this code. The content of this method is always[m
[31m-     * regenerated by the Form Editor.[m
[31m-     */[m
[31m-    @SuppressWarnings("unchecked")[m
[31m-    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[31m-    private void initComponents() {[m
[31m-[m
[31m-        jPanel1 = new javax.swing.JPanel();[m
[31m-        jPanel3 = new javax.swing.JPanel();[m
[31m-        jPanel4 = new javax.swing.JPanel();[m
[31m-        jPanel5 = new javax.swing.JPanel();[m
[31m-        jPanel6 = new javax.swing.JPanel();[m
[31m-        jLabel3 = new javax.swing.JLabel();[m
[31m-        jSeparator1 = new javax.swing.JSeparator();[m
[31m-        jPanel7 = new javax.swing.JPanel();[m
[31m-        jLabel1 = new javax.swing.JLabel();[m
[31m-        jTextField1 = new javax.swing.JTextField();[m
[31m-        jButton1 = new javax.swing.JButton();[m
[31m-        jLabel4 = new javax.swing.JLabel();[m
[31m-        jTextField3 = new javax.swing.JTextField();[m
[31m-        jButton3 = new javax.swing.JButton();[m
[31m-[m
[31m-        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[31m-        setLocation(new java.awt.Point(0, 0));[m
[31m-        setMaximumSize(new java.awt.Dimension(600, 400));[m
[31m-        setMinimumSize(new java.awt.Dimension(600, 400));[m
[31m-        setSize(new java.awt.Dimension(600, 400));[m
[31m-[m
[31m-        jPanel1.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-        jPanel1.setLayout(new java.awt.BorderLayout());[m
[31m-[m
[31m-        jPanel3.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-[m
[31m-        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);[m
[31m-        jPanel3.setLayout(jPanel3Layout);[m
[31m-        jPanel3Layout.setHorizontalGroup([m
[31m-            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 100, Short.MAX_VALUE)[m
[31m-        );[m
[31m-        jPanel3Layout.setVerticalGroup([m
[31m-            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 230, Short.MAX_VALUE)[m
[31m-        );[m
[31m-[m
[31m-        jPanel1.add(jPanel3, java.awt.BorderLayout.LINE_END);[m
[31m-[m
[31m-        jPanel4.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-        jPanel4.setPreferredSize(new java.awt.Dimension(600, 80));[m
[31m-[m
[31m-        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);[m
[31m-        jPanel4.setLayout(jPanel4Layout);[m
[31m-        jPanel4Layout.setHorizontalGroup([m
[31m-            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 600, Short.MAX_VALUE)[m
[31m-        );[m
[31m-        jPanel4Layout.setVerticalGroup([m
[31m-            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 80, Short.MAX_VALUE)[m
[31m-        );[m
[31m-[m
[31m-        jPanel1.add(jPanel4, java.awt.BorderLayout.PAGE_END);[m
[31m-[m
[31m-        jPanel5.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-[m
[31m-        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);[m
[31m-        jPanel5.setLayout(jPanel5Layout);[m
[31m-        jPanel5Layout.setHorizontalGroup([m
[31m-            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 100, Short.MAX_VALUE)[m
[31m-        );[m
[31m-        jPanel5Layout.setVerticalGroup([m
[31m-            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGap(0, 230, Short.MAX_VALUE)[m
[31m-        );[m
[31m-[m
[31m-        jPanel1.add(jPanel5, java.awt.BorderLayout.LINE_START);[m
[31m-[m
[31m-        jPanel6.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-        jPanel6.setPreferredSize(new java.awt.Dimension(600, 90));[m
[31m-[m
[31m-        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N[m
[31m-        jLabel3.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        jLabel3.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[31m-        jLabel3.setText(" Inicio de Sesión");[m
[31m-        jLabel3.setToolTipText("");[m
[31m-[m
[31m-        jSeparator1.setForeground(new java.awt.Color(153, 51, 0));[m
[31m-        jSeparator1.setPreferredSize(new java.awt.Dimension(50, 30));[m
[31m-[m
[31m-        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);[m
[31m-        jPanel6.setLayout(jPanel6Layout);[m
[31m-        jPanel6Layout.setHorizontalGroup([m
[31m-            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGroup(jPanel6Layout.createSequentialGroup()[m
[31m-                .addGap(160, 160, 160)[m
[31m-                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 278, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addContainerGap(162, Short.MAX_VALUE))[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()[m
[31m-                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addGap(206, 206, 206))[m
[31m-        );[m
[31m-        jPanel6Layout.setVerticalGroup([m
[31m-            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()[m
[31m-                .addContainerGap(32, Short.MAX_VALUE)[m
[31m-                .addComponent(jLabel3)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 8, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addGap(15, 15, 15))[m
[31m-        );[m
[31m-[m
[31m-        jPanel1.add(jPanel6, java.awt.BorderLayout.PAGE_START);[m
[31m-[m
[31m-        jLabel1.setDisplayedMnemonic('f');[m
[31m-        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[31m-        jLabel1.setForeground(new java.awt.Color(19, 45, 70));[m
[31m-        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[31m-        jLabel1.setText("Dirección de correo electronico*");[m
[31m-[m
[31m-        jTextField1.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[31m-        jTextField1.setDoubleBuffered(true);[m
[31m-[m
[31m-        jButton1.setBackground(new java.awt.Color(19, 45, 70));[m
[31m-        jButton1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[31m-        jButton1.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        jButton1.setText("Iniciar Sesión");[m
[31m-[m
[31m-        jLabel4.setDisplayedMnemonic('f');[m
[31m-        jLabel4.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[31m-        jLabel4.setForeground(new java.awt.Color(19, 45, 70));[m
[31m-        jLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[31m-        jLabel4.setText("Contraseña*");[m
[31m-[m
[31m-        jTextField3.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[31m-        jTextField3.setDoubleBuffered(true);[m
[31m-[m
[31m-        jButton3.setBackground(new java.awt.Color(102, 0, 0));[m
[31m-        jButton3.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[31m-        jButton3.setForeground(new java.awt.Color(255, 255, 255));[m
[31m-        jButton3.setText("Registrar Empresa");[m
[31m-        jButton3.setFocusPainted(false);[m
[31m-[m
[31m-        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);[m
[31m-        jPanel7.setLayout(jPanel7Layout);[m
[31m-        jPanel7Layout.setHorizontalGroup([m
[31m-            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()[m
[31m-                .addGap(0, 0, Short.MAX_VALUE)[m
[31m-                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()[m
[31m-                        .addComponent(jLabel1)[m
[31m-                        .addGap(96, 96, 96))[m
[31m-                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()[m
[31m-                        .addComponent(jLabel4)[m
[31m-                        .addGap(160, 160, 160))))[m
[31m-            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()[m
[31m-                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-                .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 154, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addGap(122, 122, 122))[m
[31m-            .addGroup(jPanel7Layout.createSequentialGroup()[m
[31m-                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-                    .addGroup(jPanel7Layout.createSequentialGroup()[m
[31m-                        .addGap(85, 85, 85)[m
[31m-                        .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, 230, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 230, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[31m-                    .addGroup(jPanel7Layout.createSequentialGroup()[m
[31m-                        .addGap(143, 143, 143)[m
[31m-                        .addComponent(jButton1)))[m
[31m-                .addContainerGap(85, Short.MAX_VALUE))[m
[31m-        );[m
[31m-        jPanel7Layout.setVerticalGroup([m
[31m-            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addGroup(jPanel7Layout.createSequentialGroup()[m
[31m-                .addGap(30, 30, 30)[m
[31m-                .addComponent(jLabel1)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[31m-                .addComponent(jLabel4)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[31m-                .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addGap(18, 18, 18)[m
[31m-                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 28, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[31m-                .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[31m-                .addContainerGap(14, Short.MAX_VALUE))[m
[31m-        );[m
[31m-[m
[31m-        jPanel1.add(jPanel7, java.awt.BorderLayout.CENTER);[m
[31m-[m
[31m-        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());[m
[31m-        getContentPane().setLayout(layout);[m
[31m-        layout.setHorizontalGroup([m
[31m-            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-        );[m
[31m-        layout.setVerticalGroup([m
[31m-            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[31m-            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[31m-        );[m
[31m-[m
[31m-        pack();[m
[31m-    }// </editor-fold>//GEN-END:initComponents[m
[31m-[m
[31m-    /**[m
[31m-     * @param args the command line arguments[m
[31m-     */[m
[31m-    public static void main(String args[]) {[m
[31m-        /* Set the Nimbus look and feel */[m
[31m-        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">[m
[31m-        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.[m
[31m-         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html [m
[31m-         */[m
[31m-        try {[m
[31m-            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {[m
[31m-                if ("Nimbus".equals(info.getName())) {[m
[31m-                    javax.swing.UIManager.setLookAndFeel(info.getClassName());[m
[31m-                    break;[m
[31m-                }[m
[31m-            }[m
[31m-        } catch (ClassNotFoundException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUILogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (InstantiationException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUILogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (IllegalAccessException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUILogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        } catch (javax.swing.UnsupportedLookAndFeelException ex) {[m
[31m-            java.util.logging.Logger.getLogger(GUILogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[31m-        }[m
[31m-        //</editor-fold>[m
[31m-[m
[31m-        /* Create and display the form */[m
[31m-        java.awt.EventQueue.invokeLater(new Runnable() {[m
[31m-            public void run() {[m
[31m-                new GUILogin().setVisible(true);[m
[31m-            }[m
[31m-        });[m
[31m-    }[m
[31m-[m
[31m-    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[31m-    private javax.swing.JButton jButton1;[m
[31m-    private javax.swing.JButton jButton3;[m
[31m-    private javax.swing.JLabel jLabel1;[m
[31m-    private javax.swing.JLabel jLabel3;[m
[31m-    private javax.swing.JLabel jLabel4;[m
[31m-    private javax.swing.JPanel jPanel1;[m
[31m-    private javax.swing.JPanel jPanel3;[m
[31m-    private javax.swing.JPanel jPanel4;[m
[31m-    private javax.swing.JPanel jPanel5;[m
[31m-    private javax.swing.JPanel jPanel6;[m
[31m-    private javax.swing.JPanel jPanel7;[m
[31m-    private javax.swing.JSeparator jSeparator1;[m
[31m-    private javax.swing.JTextField jTextField1;[m
[31m-    private javax.swing.JTextField jTextField3;[m
[31m-    // End of variables declaration//GEN-END:variables[m
[31m-}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/PanelRound.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/PanelRound.java[m
[1mdeleted file mode 100644[m
[1mindex e2ff17d..0000000[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/PanelRound.java[m
[1m+++ /dev/null[m
[36m@@ -1,127 +0,0 @@[m
[31m-package com.mycompany.gestionproyectosacademicos.presentacion;[m
[31m-[m
[31m-import java.awt.Graphics;[m
[31m-import java.awt.Graphics2D;[m
[31m-import java.awt.RenderingHints;[m
[31m-import java.awt.Shape;[m
[31m-import java.awt.geom.Area;[m
[31m-import java.awt.geom.Rectangle2D;[m
[31m-import java.awt.geom.RoundRectangle2D;[m
[31m-import javax.swing.JPanel;[m
[31m-[m
[31m-// Usando anotaciones estándar de JavaBeans[m
[31m-public class PanelRound extends JPanel {[m
[31m-[m
[31m-    private int roundTopLeft = 0;[m
[31m-    private int roundTopRight = 0;[m
[31m-    private int roundBottomLeft = 0;[m
[31m-    private int roundBottomRight = 0;[m
[31m-[m
[31m-    public PanelRound() {[m
[31m-        setOpaque(false);[m
[31m-    }[m
[31m-[m
[31m-    // Propiedad roundTopLeft[m
[31m-    public int getRoundTopLeft() {[m
[31m-        return roundTopLeft;[m
[31m-    }[m
[31m-[m
[31m-    public void setRoundTopLeft(int roundTopLeft) {[m
[31m-        this.roundTopLeft = roundTopLeft;[m
[31m-        repaint();[m
[31m-    }[m
[31m-[m
[31m-    // Propiedad roundTopRight[m
[31m-    public int getRoundTopRight() {[m
[31m-        return roundTopRight;[m
[31m-    }[m
[31m-[m
[31m-    public void setRoundTopRight(int roundTopRight) {[m
[31m-        this.roundTopRight = roundTopRight;[m
[31m-        repaint();[m
[31m-    }[m
[31m-[m
[31m-    // Propiedad roundBottomLeft[m
[31m-    public int getRoundBottomLeft() {[m
[31m-        return roundBottomLeft;[m
[31m-    }[m
[31m-[m
[31m-    public void setRoundBottomLeft(int roundBottomLeft) {[m
[31m-        this.roundBottomLeft = roundBottomLeft;[m
[31m-        repaint();[m
[31m-    }[m
[31m-[m
[31m-    // Propiedad roundBottomRight[m
[31m-    public int getRoundBottomRight() {[m
[31m-        return roundBottomRight;[m
[31m-    }[m
[31m-[m
[31m-    public void setRoundBottomRight(int roundBottomRight) {[m
[31m-        this.roundBottomRight = roundBottomRight;[m
[31m-        repaint();[m
[31m-    }[m
[31m-[m
[31m-    @Override[m
[31m-    protected void paintComponent(Graphics grphcs) {[m
[31m-        Graphics2D g2 = (Graphics2D) grphcs.create();[m
[31m-        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);[m
[31m-        g2.setColor(getBackground());[m
[31m-        Area area = new Area(createRoundTopLeft());[m
[31m-        if (roundTopRight > 0) {[m
[31m-            area.intersect(new Area(createRoundTopRight()));[m
[31m-        }[m
[31m-        if (roundBottomLeft > 0) {[m
[31m-            area.intersect(new Area(createRoundBottomLeft()));[m
[31m-        }[m
[31m-        if (roundBottomRight > 0) {[m
[31m-            area.intersect(new Area(createRoundBottomRight()));[m
[31m-        }[m
[31m-        g2.fill(area);[m
[31m-        g2.dispose();[m
[31m-        super.paintComponent(grphcs);[m
[31m-    }[m
[31m-[m
[31m-    private Shape createRoundTopLeft() {[m
[31m-        int width = getWidth();[m
[31m-        int height = getHeight();[m
[31m-        int roundX = Math.min(width, roundTopLeft);[m
[31m-        int roundY = Math.min(height, roundTopLeft);[m
[31m-        Area area = new Area(new RoundRectangle2D.Double(0, 0, width, height, roundX, roundY));[m
[31m-        area.add(new Area(new Rectangle2D.Double(roundX / 2, 0, width - roundX / 2, height)));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, roundY / 2, width, height - roundY / 2)));[m
[31m-        return area;[m
[31m-    }[m
[31m-[m
[31m-    private Shape createRoundTopRight() {[m
[31m-        int width = getWidth();[m
[31m-        int height = getHeight();[m
[31m-        int roundX = Math.min(width, roundTopRight);[m
[31m-        int roundY = Math.min(height, roundTopRight);[m
[31m-        Area area = new Area(new RoundRectangle2D.Double(0, 0, width, height, roundX, roundY));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, 0, width - roundX / 2, height)));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, roundY / 2, width, height - roundY / 2)));[m
[31m-        return area;[m
[31m-    }[m
[31m-[m
[31m-    private Shape createRoundBottomLeft() {[m
[31m-        int width = getWidth();[m
[31m-        int height = getHeight();[m
[31m-        int roundX = Math.min(width, roundBottomLeft);[m
[31m-        int roundY = Math.min(height, roundBottomLeft);[m
[31m-        Area area = new Area(new RoundRectangle2D.Double(0, 0, width, height, roundX, roundY));[m
[31m-        area.add(new Area(new Rectangle2D.Double(roundX / 2, 0, width - roundX / 2, height)));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, 0, width, height - roundY / 2)));[m
[31m-        return area;[m
[31m-    }[m
[31m-[m
[31m-    private Shape createRoundBottomRight() {[m
[31m-        int width = getWidth();[m
[31m-        int height = getHeight();[m
[31m-        int roundX = Math.min(width, roundBottomRight);[m
[31m-        int roundY = Math.min(height, roundBottomRight);[m
[31m-        Area area = new Area(new RoundRectangle2D.Double(0, 0, width, height, roundX, roundY));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, 0, width - roundX / 2, height)));[m
[31m-        area.add(new Area(new Rectangle2D.Double(0, 0, width, height - roundY / 2)));[m
[31m-        return area;[m
[31m-    }[m
[31m-}[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonEditor.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonEditor.java[m
[1mnew file mode 100644[m
[1mindex 0000000..a5d9451[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonEditor.java[m
[36m@@ -0,0 +1,66 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport javax.swing.*;[m
[32m+[m[32mimport javax.swing.table.TableCellEditor;[m
[32m+[m[32mimport java.awt.*;[m
[32m+[m[32mimport java.awt.event.ActionEvent;[m
[32m+[m[32mimport java.awt.event.ActionListener;[m
[32m+[m
[32m+[m[32mpublic class ButtonEditor extends DefaultCellEditor {[m
[32m+[m[32m    private JPanel panel;[m
[32m+[m[32m    private JButton btnSeeDetails;[m
[32m+[m[32m    private JButton btnComment;[m
[32m+[m[32m    private int currentRow;[m
[32m+[m
[32m+[m[32m    public ButtonEditor(JCheckBox checkBox) {[m
[32m+[m[32m        super(checkBox);[m
[32m+[m[32m        panel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 0));[m
[32m+[m[32m        panel.setOpaque(false);[m
[32m+[m[41m        [m
[32m+[m[32m        btnSeeDetails = new JButton("Ver más");[m
[32m+[m[32m        customizeButton(btnSeeDetails);[m
[32m+[m[41m        [m
[32m+[m[32m        btnComment = new JButton("Comentar");[m
[32m+[m[32m        customizeButton(btnComment);[m
[32m+[m
[32m+[m[32m        btnSeeDetails.addActionListener(new ActionListener() {[m
[32m+[m[32m            @Override[m
[32m+[m[32m            public void actionPerformed(ActionEvent e) {[m
[32m+[m[32m                // Lógica para el botón "Ver más"[m
[32m+[m[32m                JOptionPane.showMessageDialog(panel, "Ver más en la fila: " + currentRow);[m
[32m+[m[32m                fireEditingStopped();[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        btnComment.addActionListener(new ActionListener() {[m
[32m+[m[32m            @Override[m
[32m+[m[32m            public void actionPerformed(ActionEvent e) {[m
[32m+[m[32m                // Lógica para el botón "Comentar"[m
[32m+[m[32m                JOptionPane.showMessageDialog(panel, "Comentar en la fila: " + currentRow);[m
[32m+[m[32m                fireEditingStopped();[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        panel.add(btnSeeDetails);[m
[32m+[m[32m        panel.add(btnComment);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    private void customizeButton(JButton button) {[m
[32m+[m[32m        button.setOpaque(true);[m
[32m+[m[32m        button.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9[m
[32m+[m[32m        button.setBorder(BorderFactory.createEmptyBorder()); // Sin bordes[m
[32m+[m[32m        button.setFont(new Font("Tahoma", Font.BOLD, 20)); // Fuente Tahoma, Bold, tamaño 20[m
[32m+[m[32m        button.setFocusPainted(false); // Eliminar el borde de enfoque[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    @Override[m
[32m+[m[32m    public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {[m
[32m+[m[32m        currentRow = row;[m
[32m+[m[32m        return panel;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public Object getCellEditorValue() {[m
[32m+[m[32m        return "";[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonRenderer.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonRenderer.java[m
[1mnew file mode 100644[m
[1mindex 0000000..570c2dd[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/ButtonRenderer.java[m
[36m@@ -0,0 +1,46 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport javax.swing.*;[m
[32m+[m[32mimport javax.swing.table.TableCellRenderer;[m
[32m+[m[32mimport java.awt.*;[m
[32m+[m
[32m+[m[32mpublic class ButtonRenderer extends JPanel implements TableCellRenderer {[m
[32m+[m[32m    private JButton btnSeeDetails;[m
[32m+[m[32m    private JButton btnComment;[m
[32m+[m
[32m+[m[32m    public ButtonRenderer() {[m
[32m+[m[32m        setLayout(new FlowLayout(FlowLayout.CENTER, 5, 0));[m
[32m+[m[32m        setOpaque(true);[m
[32m+[m
[32m+[m[32m        btnSeeDetails = new JButton("Ver más");[m
[32m+[m[32m        customizeButton(btnSeeDetails);[m
[32m+[m[41m        [m
[32m+[m[32m        btnComment = new JButton("Comentar");[m
[32m+[m[32m        customizeButton(btnComment);[m
[32m+[m
[32m+[m[32m        add(btnSeeDetails);[m
[32m+[m[32m        add(btnComment);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    private void customizeButton(JButton button) {[m
[32m+[m[32m        button.setOpaque(true);[m
[32m+[m[32m        button.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9[m
[32m+[m[32m        button.setBorder(BorderFactory.createEmptyBorder()); // Sin bordes[m
[32m+[m[32m        button.setFont(new Font("Tahoma", Font.BOLD, 20)); // Fuente Tahoma, Bold, tamaño 20[m
[32m+[m[32m        button.setFocusPainted(false); // Eliminar el borde de enfoque[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Overwarning: in the working copy of 'GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.form', LF will be replaced by CRLF the next time Git touches it
ride[m
[32m+[m[32m    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {[m
[32m+[m[32m        if (isSelected) {[m
[32m+[m[32m            setBackground(table.getSelectionBackground());[m
[32m+[m[32m            btnSeeDetails.setBackground(table.getSelectionBackground());[m
[32m+[m[32m            btnComment.setBackground(table.getSelectionBackground());[m
[32m+[m[32m        } else {[m
[32m+[m[32m            setBackground(table.getBackground());[m
[32m+[m[32m            btnSeeDetails.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9[m
[32m+[m[32m            btnComment.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9[m
[32m+[m[32m        }[m
[32m+[m[32m        return this;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.form[m
[1mnew file mode 100644[m
[1mindex 0000000..5a39b8b[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.form[m
[36m@@ -0,0 +1,826 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8" ?>[m
[32m+[m
[32m+[m[32m<Form version="1.9" maxVersion="1.9" type="org.netbeans.modules.form.forminfo.JFrameFormInfo">[m
[32m+[m[32m  <NonVisualComponents>[m
[32m+[m[32m    <Container class="javax.swing.JFrame" name="SeeDetails">[m
[32m+[m
[32m+[m[32m      <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBoxLayout"/>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlProjectData">[m
[32m+[m
[32m+[m[32m          <Layout>[m
[32m+[m[32m            <DimensionLayout dim="0">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                          <Component id="btnChangeState" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                              <Group type="102" attributes="0">[m
[32m+[m[32m                                  <EmptySpace min="-2" pref="98" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblProyecto" min="-2" pref="53" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                  <EmptySpace min="-2" pref="60" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblProjectName" min="-2" pref="143" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                  <EmptySpace min="-2" pref="22" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                      <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                          <EmptySpace min="-2" pref="98" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Component id="lblGUIState" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Component id="lblState" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      </Group>[m
[32m+[m[32m                                      <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                          <EmptySpace min="-2" pref="77" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                                              <Component id="lblGUIGoals" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblGUIDescription" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblGUISummary" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                          <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                              <Component id="lblGoals" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblDescription" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblSummary" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                      </Group>[m
[32m+[m[32m                                      <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                              <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                                                  <Component id="lblGUIBudget" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                                  <Component id="lblGUIMaxTimeInMonths" min="-2" pref="138" max="-2" attributes="0"/>[m
[32m+[m[32m                                              </Group>[m
[32m+[m[32m                                              <Component id="lblGUIDate" alignment="1" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                          <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                              <Component id="lblDate" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblBudget" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <Component id="lblMaxTimeInMonths" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                      </Group>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace pref="127" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m            <DimensionLayout dim="1">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="lblProyecto" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="lblProjectName" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="26" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUISummary" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblSummary" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                          <Component id="lblGoals" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                              <Component id="lblGUIGoals" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUIDescription" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblDescription" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUIMaxTimeInMonths" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblMaxTimeInMonths" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUIBudget" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblBudget" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUIDate" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblDate" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUIState" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblState" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace pref="32" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnChangeState" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="17" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m          </Layout>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblProyecto">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Proyecto"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblProjectName">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="nombreProyecto"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUISummary">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Resumen:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIGoals">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Objetivos:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIDescription">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Descripci&#xf3;n:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIMaxTimeInMonths">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Tiempo m&#xe1;ximo en meses: "/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIBudget">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Presupuesto: "/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIDate">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Fecha:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JButton" name="btnChangeState">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Cambiar estado"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUIState">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Estado:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblSummary">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel6"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGoals">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel7"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblDescription">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel8"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblMaxTimeInMonths">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel9"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblBudget">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel10"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblDate">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel11"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblState">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel12"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlCompanyData">[m
[32m+[m
[32m+[m[32m          <Layout>[m
[32m+[m[32m            <DimensionLayout dim="0">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" attributes="0">[m
[32m+[m[32m                      <EmptySpace pref="48" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Component id="lblGUICompanyEmail" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanyNit" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanyContactNames" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanyContactPhone" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanySector" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanyContactLastNames" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblGUICompanyContactPosition" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Component id="lblCompanyNit" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanyEmail" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanySector" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanyContactPhone" min="-2" pref="37" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanyContactNames" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanyContactLastNames" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="lblCompanyContactPosition" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="97" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                              <Component id="lblCompanyName" min="-2" pref="142" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="62" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                              <Component id="lblCompany" min="-2" pref="53" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="116" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m            <DimensionLayout dim="1">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="lblCompany" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="lblCompanyName" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="31" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyNit" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyNit" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyEmail" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyEmail" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanySector" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanySector" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyContactPhone" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyContactPhone" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyContactNames" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyContactNames" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyContactLastNames" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyContactLastNames" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="3" attributes="0">[m
[32m+[m[32m                          <Component id="lblGUICompanyContactPosition" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="lblCompanyContactPosition" alignment="3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace pref="78" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m          </Layout>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompany">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Empresa"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyName">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="nombreEmpresa"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyNit">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Nit:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyEmail">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Email:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanySector">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Sector:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyContactPhone">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Tel&#xe9;fono de contacto:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyContactNames">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Nombres del contacto:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyContactLastNames">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Apellidos del contacto:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblGUICompanyContactPosition">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Cargo del contacto:"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyNit">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel6"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyEmail">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel7"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanySector">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel8"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyContactPhone">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel9"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyContactNames">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel10"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyContactLastNames">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel11"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCompanyContactPosition">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="jLabel12"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </NonVisualComponents>[m
[32m+[m[32m  <Properties>[m
[32m+[m[32m    <Property name="defaultCloseOperation" type="int" value="3"/>[m
[32m+[m[32m    <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m      <Dimension value="[960, 540]"/>[m
[32m+[m[32m    </Property>[m
[32m+[m[32m    <Property name="size" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m      <Dimension value="[960, 540]"/>[m
[32m+[m[32m    </Property>[m
[32m+[m[32m  </Properties>[m
[32m+[m[32m  <SyntheticProperties>[m
[32m+[m[32m    <SyntheticProperty name="formSizePolicy" type="int" value="1"/>[m
[32m+[m[32m    <SyntheticProperty name="generateCenter" type="boolean" value="false"/>[m
[32m+[m[32m  </SyntheticProperties>[m
[32m+[m[32m  <AuxValues>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoResourcing" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoSetComponentName" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateFQN" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateMnemonicsCode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_i18nAutoMode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_layoutCodeTarget" type="java.lang.Integer" value="1"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_listenerGenerationStyle" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesLocal" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesModifier" type="java.lang.Integer" value="2"/>[m
[32m+[m[32m    <AuxValue name="designerSize" type="java.awt.Dimension" value="-84,-19,0,5,115,114,0,18,106,97,118,97,46,97,119,116,46,68,105,109,101,110,115,105,111,110,65,-114,-39,-41,-84,95,68,20,2,0,2,73,0,6,104,101,105,103,104,116,73,0,5,119,105,100,116,104,120,112,0,0,2,108,0,0,3,-59"/>[m
[32m+[m[32m  </AuxValues>[m
[32m+[m
[32m+[m[32m  <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
[32m+[m[32m  <SubComponents>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jpLeft">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="alignmentX" type="float" value="0.0"/>[m
[32m+[m[32m        <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m          <Color id="Default Cursor"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m      <Constraints>[m
[32m+[m[32m        <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[32m+[m[32m          <BorderConstraints direction="Before"/>[m
[32m+[m[32m        </Constraint>[m
[32m+[m[32m      </Constraints>[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Component id="btnPerfil" alignment="1" max="32767" attributes="0"/>[m
[32m+[m[32m              <Component id="btnRequests" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m              <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="6" pref="96" max="32767" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnCloseSession" min="-2" pref="99" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="109" max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Component id="jPanel1" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" attributes="0">[m
[32m+[m[32m                  <Component id="jPanel1" min="-2" pref="128" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnPerfil" min="-2" pref="45" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnRequests" min="-2" pref="45" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="315" max="32767" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnCloseSession" min="-2" pref="32" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnPerfil">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="20" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Perfil"/>[m
[32m+[m[32m            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[32m+[m[32m              <Border info="null"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnPerfilActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnRequests">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="20" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Solicitudes"/>[m
[32m+[m[32m            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[32m+[m[32m              <Border info="null"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnRequestsActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnCloseSession">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="12" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Cerrar Sesi&#xf3;n"/>[m
[32m+[m[32m            <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[32m+[m[32m              <Border info="org.netbeans.modules.form.compat2.border.BevelBorderInfo">[m
[32m+[m[32m                <BevelBorder/>[m
[32m+[m[32m              </Border>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnCloseSessionActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="jPanel1">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout">[m
[32m+[m[32m            <Property name="useNullLayout" type="boolean" value="false"/>[m
[32m+[m[32m          </Layout>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblUser">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Usuario"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Constraints>[m
[32m+[m[32m                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout" value="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout$AbsoluteConstraintsDescription">[m
[32m+[m[32m                  <AbsoluteConstraints x="90" y="30" width="-1" height="-1"/>[m
[32m+[m[32m                </Constraint>[m
[32m+[m[32m              </Constraints>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JSeparator" name="sepUserCoord">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Constraints>[m
[32m+[m[32m                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout" value="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout$AbsoluteConstraintsDescription">[m
[32m+[m[32m                  <AbsoluteConstraints x="70" y="80" width="174" height="14"/>[m
[32m+[m[32m                </Constraint>[m
[32m+[m[32m              </Constraints>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblCoordinator">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="18" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Coordinador"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Constraints>[m
[32m+[m[32m                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout" value="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout$AbsoluteConstraintsDescription">[m
[32m+[m[32m                  <AbsoluteConstraints x="100" y="90" width="-1" height="-1"/>[m
[32m+[m[32m                </Constraint>[m
[32m+[m[32m              </Constraints>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="pnlRight">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m      <Constraints>[m
[32m+[m[32m        <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[32m+[m[32m          <BorderConstraints direction="Center"/>[m
[32m+[m[32m        </Constraint>[m
[32m+[m[32m      </Constraints>[m
[32m+[m
[32m+[m[32m      <Layout class="org.netbeans.modules.form.compat2.layouts.DesignCardLayout"/>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlPerfil">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card3"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="jLabel2">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="48" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Perfil"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlRequests">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card2"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="lblSolicitudes">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="48" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Solicitudes de Proyectos"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <AuxValues>[m
[32m+[m[32m                <AuxValue name="JavaCodeGenerator_InitCodePost" type="java.lang.String" value="lblSolicitudes.setBorder(new EmptyBorder(70, 50, 20, 20)); // Margen superior, izquierdo, inferior, derecho"/>[m
[32m+[m[32m              </AuxValues>[m
[32m+[m[32m              <Constraints>[m
[32m+[m[32m                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[32m+[m[32m                  <BorderConstraints direction="North"/>[m
[32m+[m[32m                </Constraint>[m
[32m+[m[32m              </Constraints>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Container class="javax.swing.JPanel" name="jPanel4">[m
[32m+[m[32m              <Constraints>[m
[32m+[m[32m                <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[32m+[m[32m                  <BorderConstraints direction="Center"/>[m
[32m+[m[32m                </Constraint>[m
[32m+[m[32m              </Constraints>[m
[32m+[m
[32m+[m[32m              <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
[32m+[m[32m              <SubComponents>[m
[32m+[m[32m                <Container class="javax.swing.JScrollPane" name="jScrollPane1">[m
[32m+[m[32m                  <Properties>[m
[32m+[m[32m                    <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                      <Color blue="0" green="0" red="0" type="rgb"/>[m
[32m+[m[32m                    </Property>[m
[32m+[m[32m                  </Properties>[m
[32m+[m[32m                  <AuxValues>[m
[32m+[m[32m                    <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m                  </AuxValues>[m
[32m+[m[32m                  <Constraints>[m
[32m+[m[32m                    <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[32m+[m[32m                      <BorderConstraints direction="Center"/>[m
[32m+[m[32m                    </Constraint>[m
[32m+[m[32m                  </Constraints>[m
[32m+[m
[32m+[m[32m                  <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[32m+[m[32m                  <SubComponents>[m
[32m+[m[32m                    <Component class="javax.swing.JTable" name="tblRequests">[m
[32m+[m[32m                      <Properties>[m
[32m+[m[32m                        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                          <Color blue="e8" green="e8" red="e8" type="rgb"/>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                          <Font name="Tahoma" size="20" style="0"/>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                          <Color blue="0" green="0" red="0" type="rgb"/>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="model" type="javax.swing.table.TableModel" editor="org.netbeans.modules.form.editors2.TableModelEditor" postCode="// Personalizar el contenido de la tabla&#xa;DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();&#xa;renderer.setHorizontalAlignment(JLabel.CENTER); // Centrar el contenido&#xa;&#xa;// Aplicar el renderizador a todas las columnas&#xa;for (int i = 0; i &lt; tblRequests.getColumnCount(); i++) {&#xa;    tblRequests.getColumnModel().getColumn(i).setCellRenderer(renderer);&#xa;}&#xa;&#xa;// Ajustar solo columna &quot;Opciones&quot;&#xa;tblRequests.getColumnModel().getColumn(2).setPreferredWidth(250);&#xa;&#xa;// Personalizar el encabezado de la tabla&#xa;JTableHeader header = tblRequests.getTableHeader();&#xa;header.setBackground(new Color(157, 157, 157)); // Color de fondo del encabezado&#xa;header.setForeground(new Color(255, 255, 255)); // Color del texto del encabezado&#xa;header.setFont(new Font(&quot;Tahoma&quot;, Font.BOLD, 24)); // Fuente del encabezado&#xa;&#xa;// Ajustar la altura del encabezado para que coincida con las filas&#xa;header.setPreferredSize(new Dimension(header.getPreferredSize().width, 80)); // Ancho autom&#xe1;tico, altura establecida manualmente">[m
[32m+[m[32m                          <Table columnCount="3" rowCount="4">[m
[32m+[m[32m                            <Column editable="true" title="Empresa" type="java.lang.Object">[m
[32m+[m[32m                              <Data value="JuanCompanies"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                            <Column editable="true" title="Proyecto" type="java.lang.Object">[m
[32m+[m[32m                              <Data value="Mu&#xf1;ecas Inflables"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                            <Column editable="true" title="Opciones" type="java.lang.Object">[m
[32m+[m[32m                              <Data value="Ver m&#xe1;s"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                              <Data value="null"/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                          </Table>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="columnModel" type="javax.swing.table.TableColumnModel" editor="org.netbeans.modules.form.editors2.TableColumnModelEditor" preCode="centerContentCells(tblRequests);">[m
[32m+[m[32m                          <TableColumnModel selectionModel="0">[m
[32m+[m[32m                            <Column maxWidth="-1" minWidth="-1" prefWidth="-1" resizable="true">[m
[32m+[m[32m                              <Title/>[m
[32m+[m[32m                              <Editor/>[m
[32m+[m[32m                              <Renderer/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                            <Column maxWidth="-1" minWidth="-1" prefWidth="-1" resizable="true">[m
[32m+[m[32m                              <Title/>[m
[32m+[m[32m                              <Editor/>[m
[32m+[m[32m                              <Renderer/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                            <Column maxWidth="-1" minWidth="-1" prefWidth="-1" resizable="true">[m
[32m+[m[32m                              <Title/>[m
[32m+[m[32m                              <Editor/>[m
[32m+[m[32m                              <Renderer/>[m
[32m+[m[32m                            </Column>[m
[32m+[m[32m                          </TableColumnModel>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="rowHeight" type="int" value="60"/>[m
[32m+[m[32m                        <Property name="showHorizontalLines" type="boolean" value="true"/>[m
[32m+[m[32m                        <Property name="showVerticalLines" type="boolean" editor="org.netbeans.modules.form.RADConnectionPropertyEditor">[m
[32m+[m[32m                          <Connection code="false" type="code"/>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                        <Property name="tableHeader" type="javax.swing.table.JTableHeader" editor="org.netbeans.modules.form.editors2.JTableHeaderEditor">[m
[32m+[m[32m                          <TableHeader reorderingAllowed="true" resizingAllowed="true"/>[m
[32m+[m[32m                        </Property>[m
[32m+[m[32m                      </Properties>[m
[32m+[m[32m                      <AuxValues>[m
[32m+[m[32m                        <AuxValue name="JavaCodeGenerator_AddingCodePost" type="java.lang.String" value="jScrollPane1.setBorder(new EmptyBorder(20,50,50,50)); // Margen superior, izquierdo, inferior, derecho&#xa;jPanel4.add(jScrollPane1, java.awt.BorderLayout.CENTER);"/>[m
[32m+[m[32m                      </AuxValues>[m
[32m+[m[32m                    </Component>[m
[32m+[m[32m                  </SubComponents>[m
[32m+[m[32m                </Container>[m
[32m+[m[32m              </SubComponents>[m
[32m+[m[32m            </Container>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlMonitoring">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card4"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="jLabel1">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="48" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Monitoreo"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlAssingment">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card5"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="jLabel3">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Asignaci&#xf3;n de proyectos"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlReports">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card6"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="jLabel4">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="48" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Reportes"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="pnlConnections">[m
[32m+[m[32m          <Constraints>[m
[32m+[m[32m            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignCardLayout" value="org.netbeans.modules.form.compat2.layouts.DesignCardLayout$CardConstraintsDescription">[m
[32m+[m[32m              <CardConstraints cardName="card7"/>[m
[32m+[m[32m            </Constraint>[m
[32m+[m[32m          </Constraints>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.DesignFlowLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JLabel" name="jLabel5">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="48" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Conexiones"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </SubComponents>[m
[32m+[m[32m</Form>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.java[m
[1mnew file mode 100644[m
[1mindex 0000000..3032801[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUICoordinator.java[m
[36m@@ -0,0 +1,692 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.Factory;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.IProjectRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Coordinator;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObserver;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.CoordinatorService;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.ProjectService;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.AuthService;[m
[32m+[m[32mimport java.awt.CardLayout;[m
[32m+[m[32mimport java.awt.Color;[m
[32m+[m[32mimport java.awt.Dimension;[m
[32m+[m[32mimport java.awt.Font;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32mimport javax.swing.border.EmptyBorder;[m
[32m+[m[32mimport javax.swing.table.JTableHeader;[m
[32m+[m[32mimport javax.swing.JButton;[m
[32m+[m[32mimport javax.swing.JCheckBox;[m
[32m+[m[32mimport javax.swing.JLabel;[m
[32m+[m[32mimport javax.swing.JTable;[m
[32m+[m[32mimport javax.swing.table.DefaultTableCellRenderer;[m
[32m+[m[32mimport javax.swing.table.DefaultTableModel;[m
[32m+[m
[32m+[m
[32m+[m[32mpublic class GUICoordinator extends javax.swing.JFrame implements IObserver{[m
[32m+[m[32m    private final Coordinator coordinator;[m
[32m+[m[32m    private final ProjectService projectService;[m
[32m+[m[32m    // Colores personalizados[m
[32m+[m[32m    private final Color colorBackSelect = new Color(217, 217, 217); // #D9D9D9[m
[32m+[m[32m    private final Color colorTxtSelect = new Color(19, 45, 70);    // #132D46[m
[32m+[m[32m    private final Color colorBackOrigin = new Color(98, 114, 129);      // #627281[m
[32m+[m[32m    private final Color colorTxtOrigin = new Color(255, 255, 255);     // #FFFFFF[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Creates new form GUIMenu[m
[32m+[m[32m     */[m
[32m+[m[32m    public GUICoordinator(CoordinatorService coordinatorService, int idCoordinator) {[m
[32m+[m[32m        IProjectRepository projectRepository = Factory.getInstance().getRepository(IProjectRepository.class, "ARRAYS");[m
[32m+[m[41m        [m
[32m+[m[32m        this.projectService = new ProjectService(projectRepository);[m
[32m+[m[32m        this.coordinator = coordinatorService.getCoordinator(idCoordinator);[m
[32m+[m[41m        [m
[32m+[m[32m        // Registrar GUICoordinator como observador de ProjectService[m
[32m+[m[32m        this.projectService.addObserver(this);[m
[32m+[m[41m        [m
[32m+[m[32m        initComponents();[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    /*private void fillProjects() {[m
[32m+[m[32m        List<Project> projects = projectService.getProjects();[m
[32m+[m[32m        DefaultTableModel model = new DefaultTableModel(new String[]{"Nombre", "Empresa", "Opciones"}, 0);[m
[32m+[m
[32m+[m[32m        model.setRowCount(0); // Limpiar la tabla antes de llenarla[m
[32m+[m[32m        for (Project project : projects) {[m
[32m+[m[32m            model.addRow(new Object[]{project.getName(), project.getCompany().getName(),""});[m
[32m+[m[32m        }[m
[32m+[m[32m        tblRequests.setModel(model);[m
[32m+[m[41m        [m
[32m+[m[32m        // Configurar el renderizador y editor para la columna "Opciones"[m
[32m+[m[32m        tblRequests.getColumn("Opciones").setCellRenderer(new ButtonRenderer());[m
[32m+[m[32m        tblRequests.getColumn("Opciones").setCellEditor(new ButtonEditor(new JCheckBox()));[m
[32m+[m[41m        [m
[32m+[m[32m        centerContentCells(tblRequests);[m
[32m+[m[32m        //update(projectService.getProjects());   // Llamar a update() para llenar la tabla[m
[32m+[m[32m    }*/[m
[32m+[m[41m    [m
[32m+[m[32m    private void centerContentCells(JTable table) {[m
[32m+[m[32m        // Crear un renderizador centrado[m
[32m+[m[32m        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();[m
[32m+[m[32m        centerRenderer.setHorizontalAlignment(JLabel.CENTER); // Centrar el contenido[m
[32m+[m
[32m+[m[32m        for (int i = 0; i < table.getColumnCount(); i++) {[m
[32m+[m[32m        table.getColumnModel().getColumn(i).setCellRenderer(centerRenderer);[m
[32m+[m[32m    }[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    /**[m
[32m+[m[32m     * This method is called from within the constructor to initialize the form.[m
[32m+[m[32m     * WARNING: Do NOT modify this code. The content of this method is always[m
[32m+[m[32m     * regenerated by the Form Editor.[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[32m+[m[32m    private void initComponents() {[m
[32m+[m
[32m+[m[32m        SeeDetails = new javax.swing.JFrame();[m
[32m+[m[32m        pnlProjectData = new javax.swing.JPanel();[m
[32m+[m[32m        lblProyecto = new javax.swing.JLabel();[m
[32m+[m[32m        lblProjectName = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUISummary = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUIGoals = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUIDescription = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUIMaxTimeInMonths = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUIBudget = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUIDate = new javax.swing.JLabel();[m
[32m+[m[32m        btnChangeState = new javax.swing.JButton();[m
[32m+[m[32m        lblGUIState = new javax.swing.JLabel();[m
[32m+[m[32m        lblSummary = new javax.swing.JLabel();[m
[32m+[m[32m        lblGoals = new javax.swing.JLabel();[m
[32m+[m[32m        lblDescription = new javax.swing.JLabel();[m
[32m+[m[32m        lblMaxTimeInMonths = new javax.swing.JLabel();[m
[32m+[m[32m        lblBudget = new javax.swing.JLabel();[m
[32m+[m[32m        lblDate = new javax.swing.JLabel();[m
[32m+[m[32m        lblState = new javax.swing.JLabel();[m
[32m+[m[32m        pnlCompanyData = new javax.swing.JPanel();[m
[32m+[m[32m        lblCompany = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyName = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyNit = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyEmail = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanySector = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyContactPhone = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyContactNames = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyContactLastNames = new javax.swing.JLabel();[m
[32m+[m[32m        lblGUICompanyContactPosition = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyNit = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyEmail = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanySector = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyContactPhone = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyContactNames = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyContactLastNames = new javax.swing.JLabel();[m
[32m+[m[32m        lblCompanyContactPosition = new javax.swing.JLabel();[m
[32m+[m[32m        jpLeft = new javax.swing.JPanel();[m
[32m+[m[32m        btnPerfil = new javax.swing.JButton();[m
[32m+[m[32m        btnRequests = new javax.swing.JButton();[m
[32m+[m[32m        btnCloseSession = new javax.swing.JButton();[m
[32m+[m[32m        jPanel1 = new javax.swing.JPanel();[m
[32m+[m[32m        lblUser = new javax.swing.JLabel();[m
[32m+[m[32m        sepUserCoord = new javax.swing.JSeparator();[m
[32m+[m[32m        lblCoordinator = new javax.swing.JLabel();[m
[32m+[m[32m        pnlRight = new javax.swing.JPanel();[m
[32m+[m[32m        pnlPerfil = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel2 = new javax.swing.JLabel();[m
[32m+[m[32m        pnlRequests = new javax.swing.JPanel();[m
[32m+[m[32m        lblSolicitudes = new javax.swing.JLabel();[m
[32m+[m[32m        jPanel4 = new javax.swing.JPanel();[m
[32m+[m[32m        jScrollPane1 = new javax.swing.JScrollPane();[m
[32m+[m[32m        tblRequests = new javax.swing.JTable();[m
[32m+[m[32m        pnlMonitoring = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel1 = new javax.swing.JLabel();[m
[32m+[m[32m        pnlAssingment = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel3 = new javax.swing.JLabel();[m
[32m+[m[32m        pnlReports = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel4 = new javax.swing.JLabel();[m
[32m+[m[32m        pnlConnections = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel5 = new javax.swing.JLabel();[m
[32m+[m
[32m+[m[32m        SeeDetails.getContentPane().setLayout(new javax.swing.BoxLayout(SeeDetails.getContentPane(), javax.swing.BoxLayout.LINE_AXIS));[m
[32m+[m
[32m+[m[32m        lblProyecto.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[32m+[m[32m        lblProyecto.setText("Proyecto");[m
[32m+[m
[32m+[m[32m        lblProjectName.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        lblProjectName.setText("nombreProyecto");[m
[32m+[m
[32m+[m[32m        lblGUISummary.setText("Resumen:");[m
[32m+[m
[32m+[m[32m        lblGUIGoals.setText("Objetivos:");[m
[32m+[m
[32m+[m[32m        lblGUIDescription.setText("Descripción:");[m
[32m+[m
[32m+[m[32m        lblGUIMaxTimeInMonths.setText("Tiempo máximo en meses: ");[m
[32m+[m
[32m+[m[32m        lblGUIBudget.setText("Presupuesto: ");[m
[32m+[m
[32m+[m[32m        lblGUIDate.setText("Fecha:");[m
[32m+[m
[32m+[m[32m        btnChangeState.setText("Cambiar estado");[m
[32m+[m
[32m+[m[32m        lblGUIState.setText("Estado:");[m
[32m+[m
[32m+[m[32m        lblSummary.setText("jLabel6");[m
[32m+[m
[32m+[m[32m        lblGoals.setText("jLabel7");[m
[32m+[m
[32m+[m[32m        lblDescription.setText("jLabel8");[m
[32m+[m
[32m+[m[32m        lblMaxTimeInMonths.setText("jLabel9");[m
[32m+[m
[32m+[m[32m        lblBudget.setText("jLabel10");[m
[32m+[m
[32m+[m[32m        lblDate.setText("jLabel11");[m
[32m+[m
[32m+[m[32m        lblState.setText("jLabel12");[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout pnlProjectDataLayout = new javax.swing.GroupLayout(pnlProjectData);[m
[32m+[m[32m        pnlProjectData.setLayout(pnlProjectDataLayout);[m
[32m+[m[32m        pnlProjectDataLayout.setHorizontalGroup([m
[32m+[m[32m            pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                    .addComponent(btnChangeState)[m
[32m+[m[32m                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                        .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                            .addGap(98, 98, 98)[m
[32m+[m[32m                            .addComponent(lblProyecto, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                            .addGap(60, 60, 60)[m
[32m+[m[32m                            .addComponent(lblProjectName, javax.swing.GroupLayout.PREFERRED_SIZE, 143, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                            .addGap(22, 22, 22)[m
[32m+[m[32m                            .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                                    .addGap(98, 98, 98)[m
[32m+[m[32m                                    .addComponent(lblGUIState)[m
[32m+[m[32m                                    .addGap(18, 18, 18)[m
[32m+[m[32m                                    .addComponent(lblState))[m
[32m+[m[32m                                .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                                    .addGap(77, 77, 77)[m
[32m+[m[32m                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                                        .addComponent(lblGUIGoals)[m
[32m+[m[32m                                        .addComponent(lblGUIDescription)[m
[32m+[m[32m                                        .addComponent(lblGUISummary))[m
[32m+[m[32m                                    .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                        .addComponent(lblGoals, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                        .addComponent(lblDescription, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                        .addComponent(lblSummary, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                                .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                        .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                                            .addComponent(lblGUIBudget)[m
[32m+[m[32m                                            .addComponent(lblGUIMaxTimeInMonths, javax.swing.GroupLayout.PREFERRED_SIZE, 138, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                                        .addComponent(lblGUIDate, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                                    .addGap(18, 18, 18)[m
[32m+[m[32m                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                        .addComponent(lblDate)[m
[32m+[m[32m                                        .addComponent(lblBudget)[m
[32m+[m[32m                                        .addComponent(lblMaxTimeInMonths, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))))))[m
[32m+[m[32m                .addContainerGap(127, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        pnlProjectDataLayout.setVerticalGroup([m
[32m+[m[32m            pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(pnlProjectDataLayout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap()[m
[32m+[m[32m                .addComponent(lblProyecto)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(lblProjectName)[m
[32m+[m[32m                .addGap(26, 26, 26)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUISummary)[m
[32m+[m[32m                    .addComponent(lblSummary))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addComponent(lblGoals, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                        .addComponent(lblGUIGoals)))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUIDescription)[m
[32m+[m[32m                    .addComponent(lblDescription))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUIMaxTimeInMonths)[m
[32m+[m[32m                    .addComponent(lblMaxTimeInMonths))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUIBudget)[m
[32m+[m[32m                    .addComponent(lblBudget))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUIDate)[m
[32m+[m[32m                    .addComponent(lblDate))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUIState)[m
[32m+[m[32m                    .addComponent(lblState))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 32, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(btnChangeState)[m
[32m+[m[32m                .addGap(17, 17, 17))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        SeeDetails.getContentPane().add(pnlProjectData);[m
[32m+[m
[32m+[m[32m        lblCompany.setText("Empresa");[m
[32m+[m
[32m+[m[32m        lblCompanyName.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        lblCompanyName.setText("nombreEmpresa");[m
[32m+[m
[32m+[m[32m        lblGUICompanyNit.setText("Nit:");[m
[32m+[m
[32m+[m[32m        lblGUICompanyEmail.setText("Email:");[m
[32m+[m
[32m+[m[32m        lblGUICompanySector.setText("Sector:");[m
[32m+[m
[32m+[m[32m        lblGUICompanyContactPhone.setText("Teléfono de contacto:");[m
[32m+[m
[32m+[m[32m        lblGUICompanyContactNames.setText("Nombres del contacto:");[m
[32m+[m
[32m+[m[32m        lblGUICompanyContactLastNames.setText("Apellidos del contacto:");[m
[32m+[m
[32m+[m[32m        lblGUICompanyContactPosition.setText("Cargo del contacto:");[m
[32m+[m
[32m+[m[32m        lblCompanyNit.setText("jLabel6");[m
[32m+[m
[32m+[m[32m        lblCompanyEmail.setText("jLabel7");[m
[32m+[m
[32m+[m[32m        lblCompanySector.setText("jLabel8");[m
[32m+[m
[32m+[m[32m        lblCompanyContactPhone.setText("jLabel9");[m
[32m+[m
[32m+[m[32m        lblCompanyContactNames.setText("jLabel10");[m
[32m+[m
[32m+[m[32m        lblCompanyContactLastNames.setText("jLabel11");[m
[32m+[m
[32m+[m[32m        lblCompanyContactPosition.setText("jLabel12");[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout pnlCompanyDataLayout = new javax.swing.GroupLayout(pnlCompanyData);[m
[32m+[m[32m        pnlCompanyData.setLayout(pnlCompanyDataLayout);[m
[32m+[m[32m        pnlCompanyDataLayout.setHorizontalGroup([m
[32m+[m[32m            pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(pnlCompanyDataLayout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap(48, Short.MAX_VALUE)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()[m
[32m+[m[32m                        .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyEmail, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyNit, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyContactNames, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyContactPhone, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanySector, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyContactLastNames, javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(lblGUICompanyContactPosition, javax.swing.GroupLayout.Alignment.TRAILING))[m
[32m+[m[32m                        .addGap(18, 18, 18)[m
[32m+[m[32m                        .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(lblCompanyNit, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(lblCompanyEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(lblCompanySector, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(lblCompanyContactPhone, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(lblCompanyContactNames)[m
[32m+[m[32m                            .addComponent(lblCompanyContactLastNames)[m
[32m+[m[32m                            .addComponent(lblCompanyContactPosition))[m
[32m+[m[32m                        .addGap(97, 97, 97))[m
[32m+[m[32m                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()[m
[32m+[m[32m                        .addComponent(lblCompanyName, javax.swing.GroupLayout.PREFERRED_SIZE, 142, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addGap(62, 62, 62))[m
[32m+[m[32m                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()[m
[32m+[m[32m                        .addComponent(lblCompany, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addGap(116, 116, 116))))[m
[32m+[m[32m        );[m
[32m+[m[32m        pnlCompanyDataLayout.setVerticalGroup([m
[32m+[m[32m            pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(pnlCompanyDataLayout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap()[m
[32m+[m[32m                .addComponent(lblCompany)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(lblCompanyName)[m
[32m+[m[32m                .addGap(31, 31, 31)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyNit)[m
[32m+[m[32m                    .addComponent(lblCompanyNit))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyEmail)[m
[32m+[m[32m                    .addComponent(lblCompanyEmail))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanySector)[m
[32m+[m[32m                    .addComponent(lblCompanySector))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyContactPhone)[m
[32m+[m[32m                    .addComponent(lblCompanyContactPhone))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyContactNames)[m
[32m+[m[32m                    .addComponent(lblCompanyContactNames))[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyContactLastNames)[m
[32m+[m[32m                    .addComponent(lblCompanyContactLastNames))[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)[m
[32m+[m[32m                    .addComponent(lblGUICompanyContactPosition)[m
[32m+[m[32m                    .addComponent(lblCompanyContactPosition))[m
[32m+[m[32m                .addContainerGap(78, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        SeeDetails.getContentPane().add(pnlCompanyData);[m
[32m+[m
[32m+[m[32m        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[32m+[m[32m        setMinimumSize(new java.awt.Dimension(960, 540));[m
[32m+[m[32m        setSize(new java.awt.Dimension(960, 540));[m
[32m+[m
[32m+[m[32m        jpLeft.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jpLeft.setAlignmentX(0.0F);[m
[32m+[m[32m        jpLeft.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m
[32m+[m[32m        btnPerfil.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnPerfil.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N[m
[32m+[m[32m        btnPerfil.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnPerfil.setText("Perfil");[m
[32m+[m[32m        btnPerfil.setBorder(null);[m
[32m+[m[32m        btnPerfil.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnPerfilActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        btnRequests.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnRequests.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N[m
[32m+[m[32m        btnRequests.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnRequests.setText("Solicitudes");[m
[32m+[m[32m        btnRequests.setBorder(null);[m
[32m+[m[32m        btnRequests.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnRequestsActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        btnCloseSession.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnCloseSession.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[32m+[m[32m        btnCloseSession.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnCloseSession.setText("Cerrar Sesión");[m
[32m+[m[32m        btnCloseSession.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));[m
[32m+[m[32m        btnCloseSession.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnCloseSessionActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        jPanel1.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());[m
[32m+[m
[32m+[m[32m        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        lblUser.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblUser.setText("Usuario");[m
[32m+[m[32m        jPanel1.add(lblUser, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 30, -1, -1));[m
[32m+[m
[32m+[m[32m        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));[m
[32m+[m[32m        sepUserCoord.setForeground(new java.awt.Color(155, 70, 47));[m
[32m+[m[32m        jPanel1.add(sepUserCoord, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 80, 174, 14));[m
[32m+[m
[32m+[m[32m        lblCoordinator.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N[m
[32m+[m[32m        lblCoordinator.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblCoordinator.setText("Coordinador");[m
[32m+[m[32m        jPanel1.add(lblCoordinator, new org.netbeans.lib.awtextra.AbsoluteConstraints(100, 90, -1, -1));[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jpLeftLayout = new javax.swing.GroupLayout(jpLeft);[m
[32m+[m[32m        jpLeft.setLayout(jpLeftLayout);[m
[32m+[m[32m        jpLeftLayout.setHorizontalGroup([m
[32m+[m[32m            jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addComponent(btnPerfil, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m            .addComponent(btnRequests, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpLeftLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(6, 96, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 99, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(109, 109, 109))[m
[32m+[m[32m            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m[32m        jpLeftLayout.setVerticalGroup([m
[32m+[m[32m            jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jpLeftLayout.createSequentialGroup()[m
[32m+[m[32m                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(btnPerfil, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(btnRequests, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 315, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(19, 19, 19))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        getContentPane().add(jpLeft, java.awt.BorderLayout.LINE_START);[m
[32m+[m
[32m+[m[32m        pnlRight.setBackground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        pnlRight.setLayout(new java.awt.CardLayout());[m
[32m+[m
[32m+[m[32m        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[32m+[m[32m        jLabel2.setText("Perfil");[m
[32m+[m[32m        pnlPerfil.add(jLabel2);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlPerfil, "card3");[m
[32m+[m
[32m+[m[32m        pnlRequests.setLayout(new java.awt.BorderLayout());[m
[32m+[m
[32m+[m[32m        lblSolicitudes.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[32m+[m[32m        lblSolicitudes.setText("Solicitudes de Proyectos");[m
[32m+[m[32m        lblSolicitudes.setBorder(new EmptyBorder(70, 50, 20, 20)); // Margen superior, izquierdo, inferior, derecho[m
[32m+[m[32m        pnlRequests.add(lblSolicitudes, java.awt.BorderLayout.NORTH);[m
[32m+[m
[32m+[m[32m        jPanel4.setLayout(new java.awt.BorderLayout());[m
[32m+[m
[32m+[m[32m        jScrollPane1.setForeground(new java.awt.Color(0, 0, 0));[m
[32m+[m
[32m+[m[32m        tblRequests.setBackground(new java.awt.Color(232, 232, 232));[m
[32m+[m[32m        tblRequests.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N[m
[32m+[m[32m        tblRequests.setForeground(new java.awt.Color(0, 0, 0));[m
[32m+[m[32m        tblRequests.setModel(new javax.swing.table.DefaultTableModel([m
[32m+[m[32m            new Object [][] {[m
[32m+[m[32m                {"JuanCompanies", "Muñecas Inflables", "Ver más"},[m
[32m+[m[32m                {null, null, null},[m
[32m+[m[32m                {null, null, null},[m
[32m+[m[32m                {null, null, null}[m
[32m+[m[32m            },[m
[32m+[m[32m            new String [] {[m
[32m+[m[32m                "Empresa", "Proyecto", "Opciones"[m
[32m+[m[32m            }[m
[32m+[m[32m        ));[m
[32m+[m[32m        // Personalizar el contenido de la tabla[m
[32m+[m[32m        DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();[m
[32m+[m[32m        renderer.setHorizontalAlignment(JLabel.CENTER); // Centrar el contenido[m
[32m+[m
[32m+[m[32m        // Aplicar el renderizador a todas las columnas[m
[32m+[m[32m        for (int i = 0; i < tblRequests.getColumnCount(); i++) {[m
[32m+[m[32m            tblRequests.getColumnModel().getColumn(i).setCellRenderer(renderer);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        // Ajustar solo columna "Opciones"[m
[32m+[m[32m        tblRequests.getColumnModel().getColumn(2).setPreferredWidth(250);[m
[32m+[m
[32m+[m[32m        // Personalizar el encabezado de la tabla[m
[32m+[m[32m        JTableHeader header = tblRequests.getTableHeader();[m
[32m+[m[32m        header.setBackground(new Color(157, 157, 157)); // Color de fondo del encabezado[m
[32m+[m[32m        header.setForeground(new Color(255, 255, 255)); // Color del texto del encabezado[m
[32m+[m[32m        header.setFont(new Font("Tahoma", Font.BOLD, 24)); // Fuente del encabezado[m
[32m+[m
[32m+[m[32m        // Ajustar la altura del encabezado para que coincida con las filas[m
[32m+[m[32m        header.setPreferredSize(new Dimension(header.getPreferredSize().width, 80)); // Ancho automático, altura establecida manualmente[m
[32m+[m[32m        tblRequests.setRowHeight(60);[m
[32m+[m[32m        tblRequests.setShowHorizontalLines(true);[m
[32m+[m[32m        tblRequests.setShowVerticalLines(false);[m
[32m+[m[32m        jScrollPane1.setViewportView(tblRequests);[m
[32m+[m[32m        centerContentCells(tblRequests);[m
[32m+[m[32m        jScrollPane1.setBorder(new EmptyBorder(20,50,50,50)); // Margen superior, izquierdo, inferior, derecho[m
[32m+[m[32m        jPanel4.add(jScrollPane1, java.awt.BorderLayout.CENTER);[m
[32m+[m
[32m+[m[32m        jPanel4.add(jScrollPane1, java.awt.BorderLayout.CENTER);[m
[32m+[m
[32m+[m[32m        pnlRequests.add(jPanel4, java.awt.BorderLayout.CENTER);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlRequests, "card2");[m
[32m+[m
[32m+[m[32m        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[32m+[m[32m        jLabel1.setText("Monitoreo");[m
[32m+[m[32m        pnlMonitoring.add(jLabel1);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlMonitoring, "card4");[m
[32m+[m
[32m+[m[32m        jLabel3.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        jLabel3.setText("Asignación de proyectos");[m
[32m+[m[32m        pnlAssingment.add(jLabel3);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlAssingment, "card5");[m
[32m+[m
[32m+[m[32m        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[32m+[m[32m        jLabel4.setText("Reportes");[m
[32m+[m[32m        pnlReports.add(jLabel4);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlReports, "card6");[m
[32m+[m
[32m+[m[32m        jLabel5.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N[m
[32m+[m[32m        jLabel5.setText("Conexiones");[m
[32m+[m[32m        pnlConnections.add(jLabel5);[m
[32m+[m
[32m+[m[32m        pnlRight.add(pnlConnections, "card7");[m
[32m+[m
[32m+[m[32m        getContentPane().add(pnlRight, java.awt.BorderLayout.CENTER);[m
[32m+[m
[32m+[m[32m        pack();[m
[32m+[m[32m    }// </editor-fold>//GEN-END:initComponents[m
[32m+[m
[32m+[m[32m    private void btnCloseSessionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionActionPerformed[m
[32m+[m[41m        [m
[32m+[m[32m        AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación[m
[32m+[m[32m        GUILogin login = new GUILogin(authService); // Pasar la instancia al constructor[m
[32m+[m[32m        login.setVisible(true); // Mostrar la ventana[m
[32m+[m[32m        this.dispose();[m
[32m+[m[32m    }//GEN-LAST:event_btnCloseSessionActionPerformed[m
[32m+[m
[32m+[m[32m    private void btnRequestsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRequestsActionPerformed[m
[32m+[m[32m        CardLayout cl = (CardLayout) pnlRight.getLayout();[m
[32m+[m[32m        cl.show(pnlRight, "card2");[m
[32m+[m[32m        changeColorBtn(btnRequests);[m
[32m+[m[41m        [m
[32m+[m[32m        // Notificar a los observers para llenar la tabla[m
[32m+[m[32m        this.projectService.notifyObservers();[m
[32m+[m[32m    }//GEN-LAST:event_btnRequestsActionPerformed[m
[32m+[m
[32m+[m[32m    private void btnPerfilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPerfilActionPerformed[m
[32m+[m[32m        CardLayout cl = (CardLayout) pnlRight.getLayout();[m
[32m+[m[32m        cl.show(pnlRight, "card3");[m
[32m+[m[32m        changeColorBtn(btnPerfil);[m
[32m+[m[32m    }//GEN-LAST:event_btnPerfilActionPerformed[m
[32m+[m
[32m+[m[32m    private void changeColorBtn(JButton botonSeleccionado) {[m
[32m+[m[32m        // Restaurar el estilo de todos los botones[m
[32m+[m[32m        for (JButton boton : new JButton[]{btnPerfil, btnRequests}) {[m
[32m+[m[32m            boton.setBackground(colorBackOrigin);[m
[32m+[m[32m            boton.setForeground(colorTxtOrigin);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        // Cambiar el estilo del botón seleccionado[m
[32m+[m[32m        botonSeleccionado.setBackground(colorBackSelect);[m
[32m+[m[32m        botonSeleccionado.setForeground(colorTxtSelect);[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public static void main(String args[]) {[m
[32m+[m[41m        [m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m        public void update(Object o) {[m
[32m+[m[32m            // Verificar si el objeto notificado es una lista de proyectos[m
[32m+[m[32m            if (o instanceof List<?>) {[m
[32m+[m[32m                List<?> projects = (List<?>) o;[m
[32m+[m
[32m+[m[32m                // Crear un modelo de tabla para tblRequests[m
[32m+[m[32m                DefaultTableModel model = new DefaultTableModel(new String[]{"Nombre", "Empresa", "Opciones"}, 0);[m
[32m+[m
[32m+[m[32m                // Llenar la tabla con los proyectos[m
[32m+[m[32m                for (Object project : projects) {[m
[32m+[m[32m                    if (project instanceof Project) {[m
[32m+[m[32m                        Project p = (Project) project;[m
[32m+[m[32m                        model.addRow(new Object[]{p.getName(), p.getCompany().getName(), ""});[m
[32m+[m[32m                    }[m
[32m+[m[32m                }[m
[32m+[m[41m                [m
[32m+[m[32m                // Asignar el modelo a la tabla[m
[32m+[m[32m                tblRequests.setModel(model);[m
[32m+[m[41m                [m
[32m+[m[32m                tblRequests.getColumn("Opciones").setCellRenderer(new ButtonRenderer());[m
[32m+[m[32m                tblRequests.getColumn("Opciones").setCellEditor(new ButtonEditor(new JCheckBox()));[m
[32m+[m
[32m+[m[32m                // Centrar el contenido de las celdas en las columnas[m
[32m+[m[32m                centerContentCells(tblRequests);[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m[41m    [m
[32m+[m
[32m+[m[32m    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[32m+[m[32m    private javax.swing.JFrame SeeDetails;[m
[32m+[m[32m    private javax.swing.JButton btnChangeState;[m
[32m+[m[32m    private javax.swing.JButton btnCloseSession;[m
[32m+[m[32m    private javax.swing.JButton btnPerfil;[m
[32m+[m[32m    private javax.swing.JButton btnRequests;[m
[32m+[m[32m    private javax.swing.JLabel jLabel1;[m
[32m+[m[32m    private javax.swing.JLabel jLabel2;[m
[32m+[m[32m    private javax.swing.JLabel jLabel3;[m
[32m+[m[32m    private javax.swing.JLabel jLabel4;[m
[32m+[m[32m    private javax.swing.JLabel jLabel5;[m
[32m+[m[32m    private javax.swing.JPanel jPanel1;[m
[32m+[m[32m    private javax.swing.JPanel jPanel4;[m
[32m+[m[32m    private javax.swing.JScrollPane jScrollPane1;[m
[32m+[m[32m    private javax.swing.JPanel jpLeft;[m
[32m+[m[32m    private javax.swing.JLabel lblBudget;[m
[32m+[m[32m    private javax.swing.JLabel lblCompany;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyContactLastNames;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyContactNames;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyContactPhone;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyContactPosition;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyEmail;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyName;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanyNit;[m
[32m+[m[32m    private javax.swing.JLabel lblCompanySector;[m
[32m+[m[32m    private javax.swing.JLabel lblCoordinator;[m
[32m+[m[32m    private javax.swing.JLabel lblDate;[m
[32m+[m[32m    private javax.swing.JLabel lblDescription;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIBudget;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyContactLastNames;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyContactNames;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyContactPhone;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyContactPosition;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyEmail;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanyNit;[m
[32m+[m[32m    private javax.swing.JLabel lblGUICompanySector;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIDate;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIDescription;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIGoals;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIMaxTimeInMonths;[m
[32m+[m[32m    private javax.swing.JLabel lblGUIState;[m
[32m+[m[32m    private javax.swing.JLabel lblGUISummary;[m
[32m+[m[32m    private javax.swing.JLabel lblGoals;[m
[32m+[m[32m    private javax.swing.JLabel lblMaxTimeInMonths;[m
[32m+[m[32m    private javax.swing.JLabel lblProjectName;[m
[32m+[m[32m    private javax.swing.JLabel lblProyecto;[m
[32m+[m[32m    private javax.swing.JLabel lblSolicitudes;[m
[32m+[m[32m    private javax.swing.JLabel lblState;[m
[32m+[m[32m    private javax.swing.JLabel lblSummary;[m
[32m+[m[32m    private javax.swing.JLabel lblUser;[m
[32m+[m[32m    private javax.swing.JPanel pnlAssingment;[m
[32m+[m[32m    private javax.swing.JPanel pnlCompanyData;[m
[32m+[m[32m    private javax.swing.JPanel pnlConnections;[m
[32m+[m[32m    private javax.swing.JPanel pnlMonitoring;[m
[32m+[m[32m    private javax.swing.JPanel pnlPerfil;[m
[32m+[m[32m    private javax.swing.JPanel pnlProjectData;[m
[32m+[m[32m    private javax.swing.JPanel pnlReports;[m
[32m+[m[32m    private javax.swing.JPanel pnlRequests;[m
[32m+[m[32m    private javax.swing.JPanel pnlRight;[m
[32m+[m[32m    private javax.swing.JSeparator sepUserCoord;[m
[32m+[m[32m    private javax.swing.JTable tblRequests;[m
[32m+[m[32m    // End of variables declaration//GEN-END:variables[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.form[m
[1msimilarity index 68%[m
[1mrename from GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.form[m
[1mrename to GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.form[m
[1mindex 7615c19..c6e6fa0 100644[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentacion/GUILogin.form[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.form[m
[36m@@ -7,13 +7,14 @@[m
       <Point value="[0, 0]"/>[m
     </Property>[m
     <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-      <Dimension value="[600, 400]"/>[m
[32m+[m[32m      <Dimension value="[400, 400]"/>[m
     </Property>[m
     <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-      <Dimension value="[600, 400]"/>[m
[32m+[m[32m      <Dimension value="[400, 400]"/>[m
     </Property>[m
[32m+[m[32m    <Property name="resizable" type="boolean" value="false"/>[m
     <Property name="size" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-      <Dimension value="[600, 400]"/>[m
[32m+[m[32m      <Dimension value="[400, 400]"/>[m
     </Property>[m
   </Properties>[m
   <SyntheticProperties>[m
[36m@@ -50,42 +51,26 @@[m
         <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
           <Color blue="46" green="2d" red="13" type="rgb"/>[m
         </Property>[m
[32m+[m[32m        <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[400, 400]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[400, 400]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[400, 400]"/>[m
[32m+[m[32m        </Property>[m
       </Properties>[m
 [m
       <Layout class="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout"/>[m
       <SubComponents>[m
[31m-        <Container class="javax.swing.JPanel" name="jPanel3">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-              <BorderConstraints direction="After"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout>[m
[31m-            <DimensionLayout dim="0">[m
[31m-              <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="100" max="32767" attributes="0"/>[m
[31m-              </Group>[m
[31m-            </DimensionLayout>[m
[31m-            <DimensionLayout dim="1">[m
[31m-              <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="230" max="32767" attributes="0"/>[m
[31m-              </Group>[m
[31m-            </DimensionLayout>[m
[31m-          </Layout>[m
[31m-        </Container>[m
         <Container class="javax.swing.JPanel" name="jPanel4">[m
           <Properties>[m
             <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
               <Color blue="46" green="2d" red="13" type="rgb"/>[m
             </Property>[m
             <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-              <Dimension value="[600, 80]"/>[m
[32m+[m[32m              <Dimension value="[600, 70]"/>[m
             </Property>[m
           </Properties>[m
           <Constraints>[m
[36m@@ -97,37 +82,12 @@[m
           <Layout>[m
             <DimensionLayout dim="0">[m
               <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="600" max="32767" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="0" pref="400" max="32767" attributes="0"/>[m
               </Group>[m
             </DimensionLayout>[m
             <DimensionLayout dim="1">[m
               <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="80" max="32767" attributes="0"/>[m
[31m-              </Group>[m
[31m-            </DimensionLayout>[m
[31m-          </Layout>[m
[31m-        </Container>[m
[31m-        <Container class="javax.swing.JPanel" name="jPanel5">[m
[31m-          <Properties>[m
[31m-            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[31m-            </Property>[m
[31m-          </Properties>[m
[31m-          <Constraints>[m
[31m-            <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
[31m-              <BorderConstraints direction="Before"/>[m
[31m-            </Constraint>[m
[31m-          </Constraints>[m
[31m-[m
[31m-          <Layout>[m
[31m-            <DimensionLayout dim="0">[m
[31m-              <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="100" max="32767" attributes="0"/>[m
[31m-              </Group>[m
[31m-            </DimensionLayout>[m
[31m-            <DimensionLayout dim="1">[m
[31m-              <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <EmptySpace min="0" pref="230" max="32767" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="0" pref="70" max="32767" attributes="0"/>[m
               </Group>[m
             </DimensionLayout>[m
           </Layout>[m
[36m@@ -150,15 +110,16 @@[m
           <Layout>[m
             <DimensionLayout dim="0">[m
               <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <Group type="102" attributes="0">[m
[31m-                      <EmptySpace min="-2" pref="160" max="-2" attributes="0"/>[m
[31m-                      <Component id="jLabel3" min="-2" pref="278" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace pref="162" max="32767" attributes="0"/>[m
[31m-                  </Group>[m
[31m-                  <Group type="102" alignment="1" attributes="0">[m
[31m-                      <EmptySpace max="32767" attributes="0"/>[m
[31m-                      <Component id="jSeparator1" min="-2" pref="183" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace min="-2" pref="206" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="-2" pref="54" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                          <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                              <EmptySpace min="-2" pref="35" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Component id="jPanel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Component id="jLabel3" alignment="0" min="-2" pref="278" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace pref="68" max="32767" attributes="0"/>[m
                   </Group>[m
               </Group>[m
             </DimensionLayout>[m
[36m@@ -168,8 +129,8 @@[m
                       <EmptySpace pref="32" max="32767" attributes="0"/>[m
                       <Component id="jLabel3" min="-2" max="-2" attributes="0"/>[m
                       <EmptySpace max="-2" attributes="0"/>[m
[31m-                      <Component id="jSeparator1" min="-2" pref="8" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace min="-2" pref="15" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jPanel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="18" max="-2" attributes="0"/>[m
                   </Group>[m
               </Group>[m
             </DimensionLayout>[m
[36m@@ -178,7 +139,7 @@[m
             <Component class="javax.swing.JLabel" name="jLabel3">[m
               <Properties>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="24" style="1"/>[m
[32m+[m[32m                  <Font name="Tahoma" size="24" style="0"/>[m
                 </Property>[m
                 <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[36m@@ -188,19 +149,37 @@[m
                 <Property name="toolTipText" type="java.lang.String" value=""/>[m
               </Properties>[m
             </Component>[m
[31m-            <Component class="javax.swing.JSeparator" name="jSeparator1">[m
[32m+[m[32m            <Container class="javax.swing.JPanel" name="jPanel2">[m
               <Properties>[m
[31m-                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="0" green="33" red="99" type="rgb"/>[m
                 </Property>[m
                 <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[31m-                  <Dimension value="[50, 30]"/>[m
[32m+[m[32m                  <Dimension value="[212, 5]"/>[m
                 </Property>[m
               </Properties>[m
[31m-            </Component>[m
[32m+[m
[32m+[m[32m              <Layout>[m
[32m+[m[32m                <DimensionLayout dim="0">[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="0" pref="212" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                </DimensionLayout>[m
[32m+[m[32m                <DimensionLayout dim="1">[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="0" pref="5" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                </DimensionLayout>[m
[32m+[m[32m              </Layout>[m
[32m+[m[32m            </Container>[m
           </SubComponents>[m
         </Container>[m
         <Container class="javax.swing.JPanel" name="jPanel7">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
           <Constraints>[m
             <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout" value="org.netbeans.modules.form.compat2.layouts.DesignBorderLayout$BorderConstraintsDescription">[m
               <BorderConstraints direction="Center"/>[m
[36m@@ -210,58 +189,54 @@[m
           <Layout>[m
             <DimensionLayout dim="0">[m
               <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                  <Group type="102" alignment="1" attributes="0">[m
[31m-                      <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[31m-                      <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                          <Group type="102" alignment="1" attributes="0">[m
[31m-                              <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
[31m-                              <EmptySpace min="-2" pref="96" max="-2" attributes="0"/>[m
[31m-                          </Group>[m
[31m-                          <Group type="102" alignment="1" attributes="0">[m
[31m-                              <Component id="jLabel4" min="-2" max="-2" attributes="0"/>[m
[31m-                              <EmptySpace min="-2" pref="160" max="-2" attributes="0"/>[m
[31m-                          </Group>[m
[31m-                      </Group>[m
[31m-                  </Group>[m
[31m-                  <Group type="102" alignment="1" attributes="0">[m
[31m-                      <EmptySpace max="32767" attributes="0"/>[m
[31m-                      <Component id="jButton3" min="-2" pref="154" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace min="-2" pref="122" max="-2" attributes="0"/>[m
[31m-                  </Group>[m
                   <Group type="102" attributes="0">[m
                       <Group type="103" groupAlignment="0" attributes="0">[m
                           <Group type="102" attributes="0">[m
[31m-                              <EmptySpace min="-2" pref="85" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="72" max="-2" attributes="0"/>[m
                               <Group type="103" groupAlignment="0" attributes="0">[m
[31m-                                  <Component id="jTextField3" min="-2" pref="230" max="-2" attributes="0"/>[m
[31m-                                  <Component id="jTextField1" min="-2" pref="230" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="txtEmail" alignment="0" min="-2" pref="247" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="25" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="65" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="btnLogin" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="9" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="txtPassword" min="-2" pref="230" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="86" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="jLabel4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
                               </Group>[m
                           </Group>[m
                           <Group type="102" alignment="0" attributes="0">[m
[31m-                              <EmptySpace min="-2" pref="143" max="-2" attributes="0"/>[m
[31m-                              <Component id="jButton1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="116" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Component id="jButtonRegistrar" min="-2" pref="154" max="-2" attributes="0"/>[m
                           </Group>[m
                       </Group>[m
[31m-                      <EmptySpace pref="85" max="32767" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace pref="81" max="32767" attributes="0"/>[m
                   </Group>[m
               </Group>[m
             </DimensionLayout>[m
             <DimensionLayout dim="1">[m
               <Group type="103" groupAlignment="0" attributes="0">[m
                   <Group type="102" alignment="0" attributes="0">[m
[31m-                      <EmptySpace min="-2" pref="30" max="-2" attributes="0"/>[m
[31m-                      <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
                       <EmptySpace max="-2" attributes="0"/>[m
[31m-                      <Component id="jTextField1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
                       <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="txtEmail" min="-2" pref="27" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
                       <Component id="jLabel4" min="-2" max="-2" attributes="0"/>[m
                       <EmptySpace max="-2" attributes="0"/>[m
[31m-                      <Component id="jTextField3" min="-2" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace min="-2" pref="18" max="-2" attributes="0"/>[m
[31m-                      <Component id="jButton1" min="-2" pref="28" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[31m-                      <Component id="jButton3" min="-2" pref="32" max="-2" attributes="0"/>[m
[31m-                      <EmptySpace pref="14" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="txtPassword" min="-2" pref="27" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace pref="26" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnLogin" min="-2" pref="34" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jButtonRegistrar" min="-2" pref="32" max="-2" attributes="0"/>[m
                   </Group>[m
               </Group>[m
             </DimensionLayout>[m
[36m@@ -271,16 +246,16 @@[m
               <Properties>[m
                 <Property name="displayedMnemonic" type="int" value="102"/>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="0"/>[m
                 </Property>[m
                 <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                  <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
                 </Property>[m
                 <Property name="horizontalAlignment" type="int" value="0"/>[m
                 <Property name="text" type="java.lang.String" value="Direcci&#xf3;n de correo electronico*"/>[m
               </Properties>[m
             </Component>[m
[31m-            <Component class="javax.swing.JTextField" name="jTextField1">[m
[32m+[m[32m            <Component class="javax.swing.JTextField" name="txtEmail">[m
               <Properties>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
                   <Font name="Tahoma" size="12" style="0"/>[m
[36m@@ -288,48 +263,54 @@[m
                 <Property name="doubleBuffered" type="boolean" value="true"/>[m
               </Properties>[m
             </Component>[m
[31m-            <Component class="javax.swing.JButton" name="jButton1">[m
[32m+[m[32m            <Component class="javax.swing.JButton" name="btnLogin">[m
               <Properties>[m
                 <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="46" green="2d" red="13" type="rgb"/>[m
                 </Property>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="0"/>[m
                 </Property>[m
                 <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
                 </Property>[m
                 <Property name="text" type="java.lang.String" value="Iniciar Sesi&#xf3;n"/>[m
               </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnLoginActionPerformed"/>[m
[32m+[m[32m              </Events>[m
             </Component>[m
             <Component class="javax.swing.JLabel" name="jLabel4">[m
               <Properties>[m
                 <Property name="displayedMnemonic" type="int" value="102"/>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="0"/>[m
                 </Property>[m
                 <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[31m-                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                  <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
                 </Property>[m
                 <Property name="horizontalAlignment" type="int" value="0"/>[m
                 <Property name="text" type="java.lang.String" value="Contrase&#xf1;a*"/>[m
               </Properties>[m
             </Component>[m
[31m-            <Component class="javax.swing.JTextField" name="jTextField3">[m
[32m+[m[32m            <Component class="javax.swing.JTextField" name="txtPassword">[m
               <Properties>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
                   <Font name="Tahoma" size="12" style="0"/>[m
                 </Property>[m
                 <Property name="doubleBuffered" type="boolean" value="true"/>[m
               </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="keyPressed" listener="java.awt.event.KeyListener" parameters="java.awt.event.KeyEvent" handler="txtPasswordKeyPressed"/>[m
[32m+[m[32m              </Events>[m
             </Component>[m
[31m-            <Component class="javax.swing.JButton" name="jButton3">[m
[32m+[m[32m            <Component class="javax.swing.JButton" name="jButtonRegistrar">[m
               <Properties>[m
                 <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="0" green="0" red="66" type="rgb"/>[m
                 </Property>[m
                 <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[31m-                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="0"/>[m
                 </Property>[m
                 <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
                   <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[36m@@ -337,6 +318,9 @@[m
                 <Property name="text" type="java.lang.String" value="Registrar Empresa"/>[m
                 <Property name="focusPainted" type="boolean" value="false"/>[m
               </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="jButtonRegistrarActionPerformed"/>[m
[32m+[m[32m              </Events>[m
             </Component>[m
           </SubComponents>[m
         </Container>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.java[m
[1mnew file mode 100644[m
[1mindex 0000000..a039753[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUILogin.java[m
[36m@@ -0,0 +1,342 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template[m
[32m+[m[32m */[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.infra.Messages;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.AuthService;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.UserServices;[m
[32m+[m[32mimport java.awt.Color;[m
[32m+[m[32mimport java.awt.event.FocusEvent;[m
[32m+[m[32mimport java.awt.event.FocusListener;[m
[32m+[m[32mimport java.awt.event.KeyEvent;[m
[32m+[m[32mimport java.util.logging.Level;[m
[32m+[m[32mimport java.util.logging.Logger;[m
[32m+[m[32mimport java.util.regex.Matcher;[m
[32m+[m[32mimport java.util.regex.Pattern;[m
[32m+[m[32mimport javax.swing.JFrame;[m
[32m+[m[32mimport javax.swing.JPanel;[m
[32m+[m[32mimport javax.swing.JTextField;[m
[32m+[m
[32m+[m[32mpublic class GUILogin extends javax.swing.JFrame {[m
[32m+[m[32m    private final AuthService authService;[m
[32m+[m[41m    [m
[32m+[m[32m    public GUILogin(AuthService authService) {[m
[32m+[m[32m        initComponents(); // Llamada al código autogenerado[m
[32m+[m[32m        setLocationRelativeTo(null); // Para centrar la ventana[m
[32m+[m[32m        this.authService = new AuthService(new UserArrayRepository());[m
[32m+[m[32m        // Agregar placeholders después de que se inicialicen los componentes[m
[32m+[m[32m        agregarPlaceholder(txtEmail, "Ingrese su correo!");[m
[32m+[m[32m        agregarPlaceholder(txtPassword, "Ingrese su contraseña!");[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m    private void agregarPlaceholder(JTextField textField, String placeholder) {[m
[32m+[m[32m        textField.setText(placeholder);[m
[32m+[m[32m        textField.setForeground(Color.GRAY);[m
[32m+[m
[32m+[m[32m        textField.addFocusListener(new FocusListener() {[m
[32m+[m[32m            @Override[m
[32m+[m[32m            public void focusGained(FocusEvent e) {[m
[32m+[m[32m                if (textField.getText().equals(placeholder)) {[m
[32m+[m[32m                    textField.setText("");[m
[32m+[m[32m                    textField.setForeground(Color.BLACK);[m
[32m+[m[32m                }[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            @Override[m
[32m+[m[32m            public void focusLost(FocusEvent e) {[m
[32m+[m[32m                if (textField.getText().isEmpty()) {[m
[32m+[m[32m                    textField.setText(placeholder);[m
[32m+[m[32m                    textField.setForeground(Color.GRAY);[m
[32m+[m[32m                }[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[41m  [m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * This method is called from within the constructor to initialize the form.[m
[32m+[m[32m     * WARNING: Do NOT modify this code. The content of this method is always[m
[32m+[m[32m     * regenerated by the Form Editor.[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[32m+[m[32m    private void initComponents() {[m
[32m+[m
[32m+[m[32m        jPanel1 = new javax.swing.JPanel();[m
[32m+[m[32m        jPanel4 = new javax.swing.JPanel();[m
[32m+[m[32m        jPanel6 = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel3 = new javax.swing.JLabel();[m
[32m+[m[32m        jPanel2 = new javax.swing.JPanel();[m
[32m+[m[32m        jPanel7 = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel1 = new javax.swing.JLabel();[m
[32m+[m[32m        txtEmail = new javax.swing.JTextField();[m
[32m+[m[32m        btnLogin = new javax.swing.JButton();[m
[32m+[m[32m        jLabel4 = new javax.swing.JLabel();[m
[32m+[m[32m        txtPassword = new javax.swing.JTextField();[m
[32m+[m[32m        jButtonRegistrar = new javax.swing.JButton();[m
[32m+[m
[32m+[m[32m        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[32m+[m[32m        setLocation(new java.awt.Point(0, 0));[m
[32m+[m[32m        setMaximumSize(new java.awt.Dimension(400, 400));[m
[32m+[m[32m        setMinimumSize(new java.awt.Dimension(400, 400));[m
[32m+[m[32m        setResizable(false);[m
[32m+[m[32m        setSize(new java.awt.Dimension(400, 400));[m
[32m+[m
[32m+[m[32m        jPanel1.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanel1.setMaximumSize(new java.awt.Dimension(400, 400));[m
[32m+[m[32m        jPanel1.setMinimumSize(new java.awt.Dimension(400, 400));[m
[32m+[m[32m        jPanel1.setPreferredSize(new java.awt.Dimension(400, 400));[m
[32m+[m[32m        jPanel1.setLayout(new java.awt.BorderLayout());[m
[32m+[m
[32m+[m[32m        jPanel4.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanel4.setPreferredSize(new java.awt.Dimension(600, 70));[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);[m
[32m+[m[32m        jPanel4.setLayout(jPanel4Layout);[m
[32m+[m[32m        jPanel4Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 400, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel4Layout.setVerticalGroup([m
[32m+[m[32m            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 70, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        jPanel1.add(jPanel4, java.awt.BorderLayout.PAGE_END);[m
[32m+[m
[32m+[m[32m        jPanel6.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanel6.setPreferredSize(new java.awt.Dimension(600, 90));[m
[32m+[m
[32m+[m[32m        jLabel3.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N[m
[32m+[m[32m        jLabel3.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        jLabel3.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[32m+[m[32m        jLabel3.setText(" Inicio de Sesión");[m
[32m+[m[32m        jLabel3.setToolTipText("");[m
[32m+[m
[32m+[m[32m        jPanel2.setBackground(new java.awt.Color(153, 51, 0));[m
[32m+[m[32m        jPanel2.setPreferredSize(new java.awt.Dimension(212, 5));[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);[m
[32m+[m[32m        jPanel2.setLayout(jPanel2Layout);[m
[32m+[m[32m        jPanel2Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 212, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel2Layout.setVerticalGroup([m
[32m+[m[32m            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 5, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);[m
[32m+[m[32m        jPanel6.setLayout(jPanel6Layout);[m
[32m+[m[32m        jPanel6Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel6Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(54, 54, 54)[m
[32m+[m[32m                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addGroup(jPanel6Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(35, 35, 35)[m
[32m+[m[32m                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                    .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 278, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                .addContainerGap(68, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel6Layout.setVerticalGroup([m
[32m+[m[32m            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap(32, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(jLabel3)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        jPanel1.add(jPanel6, java.awt.BorderLayout.PAGE_START);[m
[32m+[m
[32m+[m[32m        jPanel7.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m
[32m+[m[32m        jLabel1.setDisplayedMnemonic('f');[m
[32m+[m[32m        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        jLabel1.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[32m+[m[32m        jLabel1.setText("Dirección de correo electronico*");[m
[32m+[m
[32m+[m[32m        txtEmail.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[32m+[m[32m        txtEmail.setDoubleBuffered(true);[m
[32m+[m
[32m+[m[32m        btnLogin.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        btnLogin.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnLogin.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnLogin.setText("Iniciar Sesión");[m
[32m+[m[32m        btnLogin.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnLoginActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        jLabel4.setDisplayedMnemonic('f');[m
[32m+[m[32m        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        jLabel4.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        jLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);[m
[32m+[m[32m        jLabel4.setText("Contraseña*");[m
[32m+[m
[32m+[m[32m        txtPassword.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[32m+[m[32m        txtPassword.setDoubleBuffered(true);[m
[32m+[m[32m        txtPassword.addKeyListener(new java.awt.event.KeyAdapter() {[m
[32m+[m[32m            public void keyPressed(java.awt.event.KeyEvent evt) {[m
[32m+[m[32m                txtPasswordKeyPressed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        jButtonRegistrar.setBackground(new java.awt.Color(102, 0, 0));[m
[32m+[m[32m        jButtonRegistrar.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        jButtonRegistrar.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        jButtonRegistrar.setText("Registrar Empresa");[m
[32m+[m[32m        jButtonRegistrar.setFocusPainted(false);[m
[32m+[m[32m        jButtonRegistrar.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                jButtonRegistrarActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);[m
[32m+[m[32m        jPanel7.setLayout(jPanel7Layout);[m
[32m+[m[32m        jPanel7Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(72, 72, 72)[m
[32m+[m[32m                        .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(txtEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 247, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(25, 25, 25)[m
[32m+[m[32m                                .addComponent(jLabel1))[m
[32m+[m[32m                            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(65, 65, 65)[m
[32m+[m[32m                                .addComponent(btnLogin))[m
[32m+[m[32m                            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(9, 9, 9)[m
[32m+[m[32m                                .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, 230, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(86, 86, 86)[m
[32m+[m[32m                                .addComponent(jLabel4))))[m
[32m+[m[32m                    .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(116, 116, 116)[m
[32m+[m[32m                        .addComponent(jButtonRegistrar, javax.swing.GroupLayout.PREFERRED_SIZE, 154, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                .addContainerGap(81, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel7Layout.setVerticalGroup([m
[32m+[m[32m            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel7Layout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap()[m
[32m+[m[32m                .addComponent(jLabel1)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(txtEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(jLabel4)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 26, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(btnLogin, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(jButtonRegistrar, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        jPanel1.add(jPanel7, java.awt.BorderLayout.CENTER);[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());[m
[32m+[m[32m        getContentPane().setLayout(layout);[m
[32m+[m[32m        layout.setHorizontalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m[32m        layout.setVerticalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        pack();[m
[32m+[m[32m    }// </editor-fold>//GEN-END:initComponents[m
[32m+[m
[32m+[m[32m    private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnLoginActionPerformed[m
[32m+[m[32m    String email = txtEmail.getText().trim();[m
[32m+[m[32m    String password = txtPassword.getText().trim(); // Para evitar espacios en blanco[m
[32m+[m
[32m+[m[32m    // Expresión regular para validar el correo[m
[32m+[m[32m    String regExEmail = "^[A-Za-z0-9+_.-]+@(.+)\\.com$";[m
[32m+[m[32m    Pattern patternEmail = Pattern.compile(regExEmail);[m
[32m+[m[32m    Matcher matcherEmail = patternEmail.matcher(email);[m
[32m+[m[41m    [m
[32m+[m[32m    // Si el email no es válido, mostrar mensaje y detener el proceso[m
[32m+[m[32m    if (!matcherEmail.matches()) {[m
[32m+[m[32m        Messages.showMessageDialog("El email ingresado no es válido.", "Atención");[m
[32m+[m[32m        txtEmail.requestFocus();[m
[32m+[m[32m        return;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Si el email está vacío[m
[32m+[m[32m    if (email.isEmpty()) {[m
[32m+[m[32m        Messages.showMessageDialog("Debe agregar el Email", "Atención");[m
[32m+[m[32m        txtEmail.requestFocus();[m
[32m+[m[32m        return;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Si la contraseña está vacía[m
[32m+[m[32m    if (password.isEmpty()) {[m
[32m+[m[32m        Messages.showMessageDialog("Debe ingresar la contraseña", "Atención");[m
[32m+[m[32m        txtPassword.requestFocus();[m
[32m+[m[32m        return;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Llamar a AuthService para autenticar al usuario[m
[32m+[m[32m    JFrame nextGUI = authService.login(email, password);[m
[32m+[m
[32m+[m[32m    if (nextGUI != null) {[m
[32m+[m[32m        Messages.showMessageDialog("Inicio de sesión exitoso", "Éxito");[m
[32m+[m[32m        nextGwarning: in the working copy of 'GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.form', LF will be replaced by CRLF the next time Git touches it
UI.setVisible(true); // Mostrar la GUI correspondiente[m
[32m+[m[32m        this.dispose(); // Cerrar la ventana de login[m
[32m+[m[32m    } else {[m
[32m+[m[32m        Messages.showMessageDialog("Credenciales incorrectas", "Error");[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[41m        [m
[32m+[m[32m    }//GEN-LAST:event_btnLoginActionPerformed[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32m    private void txtPasswordKeyPressed(java.awt.event.KeyEvent evt) {[m
[32m+[m[32m        if (evt.getKeyCode() == KeyEvent.VK_ENTER) {[m
[32m+[m[32m            btnLogin.doClick();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[41m  [m
[32m+[m[32m    private void jButtonRegistrarActionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m        GUIcompanyRegister newFrame = new GUIcompanyRegister();[m
[32m+[m[32m         newFrame.setVisible(true);[m
[32m+[m[32m         this.dispose();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[32m+[m[32m    private javax.swing.JButton btnLogin;[m
[32m+[m[32m    private javax.swing.JButton jButtonRegistrar;[m
[32m+[m[32m    private javax.swing.JLabel jLabel1;[m
[32m+[m[32m    private javax.swing.JLabel jLabel3;[m
[32m+[m[32m    private javax.swing.JLabel jLabel4;[m
[32m+[m[32m    private javax.swing.JPanel jPanel1;[m
[32m+[m[32m    private javax.swing.JPanel jPanel2;[m
[32m+[m[32m    private javax.swing.JPanel jPanel4;[m
[32m+[m[32m    private javax.swing.JPanel jPanel6;[m
[32m+[m[32m    private javax.swing.JPanel jPanel7;[m
[32m+[m[32m    private javax.swing.JTextField txtEmail;[m
[32m+[m[32m    private javax.swing.JTextField txtPassword;[m
[32m+[m[32m    // End of variables declaration//GEN-END:variables[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.form[m
[1mnew file mode 100644[m
[1mindex 0000000..3f78e1f[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.form[m
[36m@@ -0,0 +1,279 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8" ?>[m
[32m+[m
[32m+[m[32m<Form version="1.3" maxVersion="1.9" type="org.netbeans.modules.form.forminfo.JFrameFormInfo">[m
[32m+[m[32m  <NonVisualComponents>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanel1">[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <EmptySpace min="0" pref="100" max="32767" attributes="0"/>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <EmptySpace min="0" pref="100" max="32767" attributes="0"/>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </NonVisualComponents>[m
[32m+[m[32m  <Properties>[m
[32m+[m[32m    <Property name="defaultCloseOperation" type="int" value="3"/>[m
[32m+[m[32m  </Properties>[m
[32m+[m[32m  <SyntheticProperties>[m
[32m+[m[32m    <SyntheticProperty name="formSizePolicy" type="int" value="1"/>[m
[32m+[m[32m    <SyntheticProperty name="generateCenter" type="boolean" value="false"/>[m
[32m+[m[32m  </SyntheticProperties>[m
[32m+[m[32m  <AuxValues>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoResourcing" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoSetComponentName" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateFQN" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateMnemonicsCode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_i18nAutoMode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_layoutCodeTarget" type="java.lang.Integer" value="1"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_listenerGenerationStyle" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesLocal" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesModifier" type="java.lang.Integer" value="2"/>[m
[32m+[m[32m  </AuxValues>[m
[32m+[m
[32m+[m[32m  <Layout>[m
[32m+[m[32m    <DimensionLayout dim="0">[m
[32m+[m[32m      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m          <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m              <Component id="jPanelDashboard" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m              <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m              <Component id="jPanelProjectList" max="32767" attributes="0"/>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m      </Group>[m
[32m+[m[32m    </DimensionLayout>[m
[32m+[m[32m    <DimensionLayout dim="1">[m
[32m+[m[32m      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m          <Component id="jPanelDashboard" max="32767" attributes="0"/>[m
[32m+[m[32m          <Component id="jPanelProjectList" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m      </Group>[m
[32m+[m[32m    </DimensionLayout>[m
[32m+[m[32m  </Layout>[m
[32m+[m[32m  <SubComponents>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanelDashboard">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" attributes="0">[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <Component id="btnProfileStudent" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnProjectList" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnMyProjects" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="107" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblEstudiante" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Group type="102" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="90" pref="90" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <Component id="sepUserCoord" min="-2" pref="124" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="lblUser" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnCloseSessionStudent" alignment="0" min="-2" pref="119" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace pref="86" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="18" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblUser" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="sepUserCoord" min="-2" pref="14" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblEstudiante" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="56" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnProfileStudent" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="29" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnProjectList" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="29" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnMyProjects" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="58" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnCloseSessionStudent" min="-2" pref="40" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="78" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JSeparator" name="sepUserCoord">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="lblUser">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Usuario"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="lblEstudiante">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="18" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Estudiante"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnProfileStudent">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Perfil"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnProfileStudentActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnProjectList">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Proyectos Disponibles"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnMyProjects">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Mis Proyectos"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnCloseSessionStudent">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Cerrar Ses&#xed;on"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnCloseSessionStudentActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanelProjectList">[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblTitleProjectList" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="370" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblTitleProjectList" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="lblTitleProjectList">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Proyectos Disponibles"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </SubComponents>[m
[32m+[m[32m</Form>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.java[m
[1mnew file mode 100644[m
[1mindex 0000000..1b2a6ad[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIStudentProjectList.java[m
[36m@@ -0,0 +1,276 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport javax.swing.*;[m
[32m+[m[32mimport javax.swing.table.DefaultTableModel;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObserver;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class GUIStudentProjectList extends javax.swing.JFrame implements IObserver{[m
[32m+[m
[32m+[m[32m    private JTable projectTable;[m
[32m+[m[32m    private DefaultTableModel tableModel;[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Creates new form GUIStudentProjectList[m
[32m+[m[32m     */[m
[32m+[m[32m    public GUIStudentProjectList() {[m
[32m+[m[32m        initComponents();[m
[32m+[m[32m        initTable();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * This method is called from within the constructor to initialize the form.[m
[32m+[m[32m     * WARNING: Do NOT modify this code. The content of this method is always[m
[32m+[m[32m     * regenerated by the Form Editor.[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[32m+[m[32m    private void initComponents() {[m
[32m+[m
[32m+[m[32m        jPanel1 = new javax.swing.JPanel();[m
[32m+[m[32m        jPanelDashboard = new javax.swing.JPanel();[m
[32m+[m[32m        sepUserCoord = new javax.swing.JSeparator();[m
[32m+[m[32m        lblUser = new javax.swing.JLabel();[m
[32m+[m[32m        lblEstudiante = new javax.swing.JLabel();[m
[32m+[m[32m        btnProfileStudent = new javax.swing.JButton();[m
[32m+[m[32m        btnProjectList = new javax.swing.JButton();[m
[32m+[m[32m        btnMyProjects = new javax.swing.JButton();[m
[32m+[m[32m        btnCloseSessionStudent = new javax.swing.JButton();[m
[32m+[m[32m        jPanelProjectList = new javax.swing.JPanel();[m
[32m+[m[32m        lblTitleProjectList = new javax.swing.JLabel();[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);[m
[32m+[m[32m        jPanel1.setLayout(jPanel1Layout);[m
[32m+[m[32m        jPanel1Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 100, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel1Layout.setVerticalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGap(0, 100, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[32m+[m
[32m+[m[32m        jPanelDashboard.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m
[32m+[m[32m        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));[m
[32m+[m
[32m+[m[32m        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        lblUser.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblUser.setText("Usuario");[m
[32m+[m
[32m+[m[32m        lblEstudiante.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N[m
[32m+[m[32m        lblEstudiante.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblEstudiante.setText("Estudiante");[m
[32m+[m
[32m+[m[32m        btnProfileStudent.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnProfileStudent.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnProfileStudent.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnProfileStudent.setLabel("Perfil");[m
[32m+[m[32m        btnProfileStudent.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnProfileStudentActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        btnProjectList.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnProjectList.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        btnProjectList.setLabel("Proyectos Disponibles");[m
[32m+[m[32m        btnProjectList.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProjectList.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProjectList.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m
[32m+[m[32m        btnMyProjects.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnMyProjects.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnMyProjects.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnMyProjects.setLabel("Mis Proyectos");[m
[32m+[m[32m        btnMyProjects.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnMyProjects.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnMyProjects.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m
[32m+[m[32m        btnCloseSessionStudent.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnCloseSessionStudent.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnCloseSessionStudent.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnCloseSessionStudent.setLabel("Cerrar Sesíon");[m
[32m+[m[32m        btnCloseSessionStudent.setMaximumSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.setMinimumSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.setPreferredSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnCloseSessionStudentActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanelDashboardLayout = new javax.swing.GroupLayout(jPanelDashboard);[m
[32m+[m[32m        jPanelDashboard.setLayout(jPanelDashboardLayout);[m
[32m+[m[32m        jPanelDashboardLayout.setHorizontalGroup([m
[32m+[m[32m            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap()[m
[32m+[m[32m                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addComponent(btnProfileStudent, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                    .addComponent(btnProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                    .addComponent(btnMyProjects, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m                .addContainerGap())[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(107, 107, 107)[m
[32m+[m[32m                .addComponent(lblEstudiante)[m
[32m+[m[32m                .addGap(0, 0, Short.MAX_VALUE))[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(90, 90, 90)[m
[32m+[m[32m                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                    .addComponent(lblUser)[m
[32m+[m[32m                    .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 119, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                .addContainerGap(86, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanelDashboardLayout.setVerticalGroup([m
[32m+[m[32m            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(lblUser)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(lblEstudiante)[m
[32m+[m[32m                .addGap(56, 56, 56)[m
[32m+[m[32m                .addComponent(btnProfileStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(29, 29, 29)[m
[32m+[m[32m                .addComponent(btnProjectList, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(29, 29, 29)[m
[32m+[m[32m                .addComponent(btnMyProjects, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(58, 58, 58)[m
[32m+[m[32m                .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addContainerGap(78, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        lblTitleProjectList.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        lblTitleProjectList.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        lblTitleProjectList.setText("Proyectos Disponibles");[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanelProjectListLayout = new javax.swing.GroupLayout(jPanelProjectList);[m
[32m+[m[32m        jPanelProjectList.setLayout(jPanelProjectListLayout);[m
[32m+[m[32m        jPanelProjectListLayout.setHorizontalGroup([m
[32m+[m[32m            jPanelProjectListLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelProjectListLayout.createSequentialGroup()[m
[32m+[m[32m                .addContainerGap()[m
[32m+[m[32m                .addComponent(lblTitleProjectList)[m
[32m+[m[32m                .addContainerGap(370, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanelProjectListLayout.setVerticalGroup([m
[32m+[m[32m            jPanelProjectListLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelProjectListLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(20, 20, 20)[m
[32m+[m[32m                .addComponent(lblTitleProjectList)[m
[32m+[m[32m                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());[m
[32m+[m[32m        getContentPane().setLayout(layout);[m
[32m+[m[32m        layout.setHorizontalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                .addComponent(jPanelDashboard, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        layout.setVerticalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addComponent(jPanelDashboard, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m            .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        pack();[m
[32m+[m[32m    }// </editor-fold>//GEN-END:initComponents[m
[32m+[m
[32m+[m[32m    private void initTable() {[m
[32m+[m[32m        tableModel = new DefaultTableModel(new Object[]{"ID", "Nombre", "Descripción", "Estado"}, 0);[m
[32m+[m[32m        projectTable = new JTable();[m
[32m+[m[32m        jPanelProjectList.add(new JScrollPane(projectTable));[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    private void btnCloseSessionStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionStudentActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_btnCloseSessionStudentActionPerformed[m
[32m+[m
[32m+[m[32m    private void btnProfileStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnProfileStudentActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_btnProfileStudentActionPerformed[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param args the command line arguments[m
[32m+[m[32m     */[m
[32m+[m[32m    public static void main(String args[]) {[m
[32m+[m[32m        /* Set the Nimbus look and feel */[m
[32m+[m[32m        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">[m
[32m+[m[32m        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.[m
[32m+[m[32m         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html[m[41m [m
[32m+[m[32m         */[m
[32m+[m[32m        try {[m
[32m+[m[32m            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {[m
[32m+[m[32m                if ("Nimbus".equals(info.getName())) {[m
[32m+[m[32m                    javax.swing.UIManager.setLookAndFeel(info.getClassName());[m
[32m+[m[32m                    break;[m
[32m+[m[32m                }[m
[32m+[m[32m            }[m
[32m+[m[32m        } catch (ClassNotFoundException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIStudentProjectList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (InstantiationException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIStudentProjectList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (IllegalAccessException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIStudentProjectList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (javax.swing.UnsupportedLookAndFeelException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIStudentProjectList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        }[m
[32m+[m[32m        //</editor-fold>[m
[32m+[m
[32m+[m[32m        /* Create and display the form */[m
[32m+[m[32m        java.awt.EventQueue.invokeLater(new Runnable() {[m
[32m+[m[32m            public void run() {[m
[32m+[m[32m                new GUIStudentProjectList().setVisible(true);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[32m+[m[32m    private javax.swing.JButton btnCloseSessionStudent;[m
[32m+[m[32m    private javax.swing.JButton btnMyProjects;[m
[32m+[m[32m    private javax.swing.JButton btnProfileStudent;[m
[32m+[m[32m    private javax.swing.JButton btnProjectList;[m
[32m+[m[32m    private javax.swing.JPanel jPanel1;[m
[32m+[m[32m    private javax.swing.JPanel jPanelDashboard;[m
[32m+[m[32m    private javax.swing.JPanel jPanelProjectList;[m
[32m+[m[32m    private javax.swing.JLabel lblEstudiante;[m
[32m+[m[32m    private javax.swing.JLabel lblTitleProjectList;[m
[32m+[m[32m    private javax.swing.JLabel lblUser;[m
[32m+[m[32m    private javax.swing.JSeparator sepUserCoord;[m
[32m+[m[32m    // End of variables declaration//GEN-END:variables[m
[32m+[m
[32m+[m[41m    [m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void update(Object o) {[m
[32m+[m[32m        // Verificar si el objeto es una instancia de Project[m
[32m+[m[32m        if (o instanceof Project) {[m
[32m+[m[32m            Project project = (Project) o; // Hacer el casting a Project[m
[32m+[m
[32m+[m[32m            // Agregar los datos del proyecto a la tabla[m
[32m+[m[32m            tableModel.addRow(new Object[]{[m
[32m+[m[32m                project.getId(),[m
[32m+[m[32m                project.getName(),[m
[32m+[m[32m                project.getDescription(),[m
[32m+[m[32m                project.getState()[m
[32m+[m[32m            });[m
[32m+[m[32m        } else {[m
[32m+[m[32m            // Manejar otros tipos de objetos (opcional)[m
[32m+[m[32m            System.out.println("El objeto recibido no es un Project: " + o);[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.form[m
[1mnew file mode 100644[m
[1mindex 0000000..3e789e6[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.form[m
[36m@@ -0,0 +1,609 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8" ?>[m
[32m+[m
[32m+[m[32m<Form version="1.3" maxVersion="1.9" type="org.netbeans.modules.form.forminfo.JPanelFormInfo">[m
[32m+[m[32m  <NonVisualComponents>[m
[32m+[m[32m    <Container class="javax.swing.JScrollPane" name="jScrollPane1">[m
[32m+[m[32m      <AuxValues>[m
[32m+[m[32m        <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m      </AuxValues>[m
[32m+[m
[32m+[m[32m      <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JTextArea" name="jTextArea1">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="columns" type="int" value="20"/>[m
[32m+[m[32m            <Property name="rows" type="int" value="5"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </NonVisualComponents>[m
[32m+[m[32m  <Properties>[m
[32m+[m[32m    <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m      <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m    </Property>[m
[32m+[m[32m  </Properties>[m
[32m+[m[32m  <AuxValues>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoResourcing" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoSetComponentName" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateFQN" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateMnemonicsCode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_i18nAutoMode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_layoutCodeTarget" type="java.lang.Integer" value="1"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_listenerGenerationStyle" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesLocal" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesModifier" type="java.lang.Integer" value="2"/>[m
[32m+[m[32m  </AuxValues>[m
[32m+[m
[32m+[m[32m  <Layout>[m
[32m+[m[32m    <DimensionLayout dim="0">[m
[32m+[m[32m      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m          <Group type="102" attributes="0">[m
[32m+[m[32m              <EmptySpace min="-2" pref="26" max="-2" attributes="0"/>[m
[32m+[m[32m              <Component id="jPanelDashboard" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m              <EmptySpace pref="51" max="32767" attributes="0"/>[m
[32m+[m[32m              <Group type="103" groupAlignment="0" max="-2" attributes="0">[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <Group type="102" attributes="0">[m
[32m+[m[32m                          <Component id="jPanel1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <EmptySpace type="separate" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="jPanel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <EmptySpace min="-2" pref="130" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                          <Component id="btnPublish1" min="-2" pref="149" max="-2" attributes="0"/>[m
[32m+[m[32m                          <EmptySpace min="-2" pref="220" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <Component id="lblTitleProjectList" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabel3" min="-2" pref="75" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="21" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m      </Group>[m
[32m+[m[32m    </DimensionLayout>[m
[32m+[m[32m    <DimensionLayout dim="1">[m
[32m+[m[32m      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m              <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                  <Group type="102" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                          <Component id="lblTitleProjectList" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="jLabel3" min="-2" pref="70" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                          <Component id="jPanel1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="jPanel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace pref="19" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnPublish1" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <Group type="102" attributes="0">[m
[32m+[m[32m                      <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jPanelDashboard" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <EmptySpace min="-2" pref="52" max="-2" attributes="0"/>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m      </Group>[m
[32m+[m[32m    </DimensionLayout>[m
[32m+[m[32m  </Layout>[m
[32m+[m[32m  <SubComponents>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanelDashboard">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.RADConnectionPropertyEditor">[m
[32m+[m[32m          <Connection code="BorderFactory.createLineBorder(Color.BLACK, 2, true)" type="code"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="107" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblEstudiante" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Group type="102" attributes="0">[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                          <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                              <Component id="btnPublish" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                              <Component id="btnMyProjects" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <Group type="102" attributes="0">[m
[32m+[m[32m                          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                  <EmptySpace min="90" pref="90" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="sepUserCoord" alignment="0" min="-2" pref="124" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="lblUser" alignment="0" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                  <EmptySpace min="-2" pref="17" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="btnCloseSessionStudent" min="-2" pref="119" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <EmptySpace min="0" pref="80" max="32767" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Group type="103" rootIndex="1" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" attributes="0">[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnProfileStudent1" max="32767" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="18" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblUser" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="sepUserCoord" min="-2" pref="14" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="lblEstudiante" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="135" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnPublish" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="29" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnMyProjects" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="93" max="32767" attributes="0"/>[m
[32m+[m[32m                  <Component id="btnCloseSessionStudent" min="-2" pref="40" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="22" max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m              <Group type="103" rootIndex="1" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="-2" pref="176" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="btnProfileStudent1" min="-2" pref="50" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace pref="303" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JSeparator" name="sepUserCoord">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="lblUser">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Usuario"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="lblEstudiante">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="18" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Estudiante"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnPublish">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Publicar"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnMyProjects">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Mis Proyectos"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnCloseSessionStudent">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Cerrar Ses&#xed;on"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[75, 19]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnCloseSessionStudentActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JButton" name="btnProfileStudent1">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="81" green="72" red="62" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="0"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="label" type="java.lang.String" value="Perfil"/>[m
[32m+[m[32m            <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[28, 17]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnProfileStudent1ActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m    <Component class="javax.swing.JLabel" name="lblTitleProjectList">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m          <Font name="Tahoma" size="36" style="0"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="text" type="java.lang.String" value="Publicaci&#xf3;n de Proyectos"/>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m    </Component>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanel1">[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="17" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" max="-2" attributes="0">[m
[32m+[m[32m                      <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabelBudget" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabelObjetives" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabelNameProject" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jTextBudget" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jTextMaxTime" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jTextNameProject" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jScrollPane2" alignment="0" pref="316" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jTextDate" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace pref="17" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabelNameProject" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jTextNameProject" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabelObjetives" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jScrollPane2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="51" max="32767" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabel1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jTextMaxTime" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabelBudget" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jTextBudget" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jTextDate" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="18" max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabelNameProject">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Nombre Proyecto"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JTextField" name="jTextNameProject">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabelObjetives">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Objetivos"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabel1">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Tiempo m&#xe1;ximo"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JTextField" name="jTextMaxTime">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="jTextMaxTimeActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabelBudget">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Presupuesto"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JTextField" name="jTextBudget">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m          <Events>[m
[32m+[m[32m            <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="jTextBudgetActionPerformed"/>[m
[32m+[m[32m          </Events>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabel2">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Fecha"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JTextField" name="jTextDate">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Container class="javax.swing.JScrollPane" name="jScrollPane2">[m
[32m+[m[32m          <AuxValues>[m
[32m+[m[32m            <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m          </AuxValues>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JTextArea" name="jTextObjetives">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="columns" type="int" value="20"/>[m
[32m+[m[32m                <Property name="rows" type="int" value="5"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanel2">[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="12" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" max="-2" attributes="0">[m
[32m+[m[32m                      <Component id="jScrollPane3" pref="301" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabel4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jLabelSummary" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Component id="jScrollPane4" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace pref="15" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabelSummary" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jScrollPane4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="22" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabel4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="26" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jScrollPane3" min="-2" pref="143" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="71" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabelSummary">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Resumen"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabel4">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="Descripci&#xf3;n de necesidad"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Container class="javax.swing.JScrollPane" name="jScrollPane3">[m
[32m+[m[32m          <AuxValues>[m
[32m+[m[32m            <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m          </AuxValues>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JTextArea" name="jTextArea2">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="columns" type="int" value="20"/>[m
[32m+[m[32m                <Property name="rows" type="int" value="5"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Container class="javax.swing.JScrollPane" name="jScrollPane4">[m
[32m+[m[32m          <AuxValues>[m
[32m+[m[32m            <AuxValue name="autoScrollPane" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m          </AuxValues>[m
[32m+[m
[32m+[m[32m          <Layout class="org.netbeans.modules.form.compat2.layouts.support.JScrollPaneSupportLayout"/>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="javax.swing.JTextArea" name="jTextArea3">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="cc" green="cc" red="cc" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="columns" type="int" value="20"/>[m
[32m+[m[32m                <Property name="rows" type="int" value="5"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m    <Component class="javax.swing.JLabel" name="jLabel3">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="icon" type="javax.swing.Icon" editor="org.netbeans.modules.form.editors2.IconEditor">[m
[32m+[m[32m          <Image iconType="3" name="/com/mycompany/gestionproyectosacademicos/resources/image 11.png"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m    </Component>[m
[32m+[m[32m    <Component class="javax.swing.JButton" name="btnPublish1">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="2f" green="46" red="9b" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m          <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="text" type="java.lang.String" value="Publicar"/>[m
[32m+[m[32m        <Property name="maximumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[28, 17]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[28, 17]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[28, 17]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m      <Events>[m
[32m+[m[32m        <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="btnPublish1ActionPerformed"/>[m
[32m+[m[32m      </Events>[m
[32m+[m[32m    </Component>[m
[32m+[m[32m  </SubComponents>[m
[32m+[m[32m</Form>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.java[m
[1mnew file mode 100644[m
[1mindex 0000000..d3d05ec[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIUploadProject.java[m
[36m@@ -0,0 +1,436 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JPanel.java to edit this template[m
[32m+[m[32m */[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m
[32m+[m[32mimport java.awt.Color;[m
[32m+[m[32mimport javax.swing.BorderFactory;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author ANACONA[m
[32m+[m[32m */[m
[32m+[m[32mpublic class GUIUploadProject extends javax.swing.JPanel {[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Creates new form GUIUploadProject[m
[32m+[m[32m     */[m
[32m+[m[32m    public GUIUploadProject() {[m
[32m+[m[32m        initComponents();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * This method is called from within the constructor to initialize the form.[m
[32m+[m[32m     * WARNING: Do NOT modify this code. The content of this method is always[m
[32m+[m[32m     * regenerated by the Form Editor.[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[32m+[m[32m    private void initComponents() {[m
[32m+[m
[32m+[m[32m        jScrollPane1 = new javax.swing.JScrollPane();[m
[32m+[m[32m        jTextArea1 = new javax.swing.JTextArea();[m
[32m+[m[32m        jPanelDashboard = new javax.swing.JPanel();[m
[32m+[m[32m        sepUserCoord = new javax.swing.JSeparator();[m
[32m+[m[32m        lblUser = new javax.swing.JLabel();[m
[32m+[m[32m        lblEstudiante = new javax.swing.JLabel();[m
[32m+[m[32m        btnPublish = new javax.swing.JButton();[m
[32m+[m[32m        btnMyProjects = new javax.swing.JButton();[m
[32m+[m[32m        btnCloseSessionStudent = new javax.swing.JButton();[m
[32m+[m[32m        btnProfileStudent1 = new javax.swing.JButton();[m
[32m+[m[32m        lblTitleProjectList = new javax.swing.JLabel();[m
[32m+[m[32m        jPanel1 = new javax.swing.JPanel();[m
[32m+[m[32m        jLabelNameProject = new javax.swing.JLabel();[m
[32m+[m[32m        jTextNameProject = new javax.swing.JTextField();[m
[32m+[m[32m        jLabelObjetives = new javax.swing.JLabel();[m
[32m+[m[32m        jLabel1 = new javax.swing.JLabel();[m
[32m+[m[32m        jTextMaxTime = new javax.swing.JTextField();[m
[32m+[m[32m        jLabelBudget = new javax.swing.JLabel();[m
[32m+[m[32m        jTextBudget = new javax.swing.JTextField();[m
[32m+[m[32m        jLabel2 = new javax.swing.JLabel();[m
[32m+[m[32m        jTextDate = new javax.swing.JTextField();[m
[32m+[m[32m        jScrollPane2 = new javax.swing.JScrollPane();[m
[32m+[m[32m        jTextObjetives = new javax.swing.JTextArea();[m
[32m+[m[32m        jPanel2 = new javax.swing.JPanel();[m
[32m+[m[32m        jLabelSummary = new javax.swing.JLabel();[m
[32m+[m[32m        jLabel4 = new javax.swing.JLabel();[m
[32m+[m[32m        jScrollPane3 = new javax.swing.JScrollPane();[m
[32m+[m[32m        jTextArea2 = new javax.swing.JTextArea();[m
[32m+[m[32m        jScrollPane4 = new javax.swing.JScrollPane();[m
[32m+[m[32m        jTextArea3 = new javax.swing.JTextArea();[m
[32m+[m[32m        jLabel3 = new javax.swing.JLabel();[m
[32m+[m[32m        btnPublish1 = new javax.swing.JButton();[m
[32m+[m
[32m+[m[32m        jTextArea1.setColumns(20);[m
[32m+[m[32m        jTextArea1.setRows(5);[m
[32m+[m[32m        jScrollPane1.setViewportView(jTextArea1);[m
[32m+[m
[32m+[m[32m        setBackground(new java.awt.Color(255, 255, 255));[m
[32m+[m
[32m+[m[32m        jPanelDashboard.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanelDashboard.setBorder(BorderFactory.createLineBorder(Color.BLACK, 2, true));[m
[32m+[m
[32m+[m[32m        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));[m
[32m+[m[32m        sepUserCoord.setForeground(new java.awt.Color(155, 70, 47));[m
[32m+[m
[32m+[m[32m        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        lblUser.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblUser.setText("Usuario");[m
[32m+[m
[32m+[m[32m        lblEstudiante.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N[m
[32m+[m[32m        lblEstudiante.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        lblEstudiante.setText("Estudiante");[m
[32m+[m
[32m+[m[32m        btnPublish.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnPublish.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        btnPublish.setText("Publicar");[m
[32m+[m[32m        btnPublish.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnPublish.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnPublish.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m
[32m+[m[32m        btnMyProjects.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnMyProjects.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnMyProjects.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnMyProjects.setLabel("Mis Proyectos");[m
[32m+[m[32m        btnMyProjects.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnMyProjects.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnMyProjects.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m
[32m+[m[32m        btnCloseSessionStudent.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnCloseSessionStudent.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnCloseSessionStudent.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnCloseSessionStudent.setLabel("Cerrar Sesíon");[m
[32m+[m[32m        btnCloseSessionStudent.setMaximumSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.setMinimumSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.setPreferredSize(new java.awt.Dimension(75, 19));[m
[32m+[m[32m        btnCloseSessionStudent.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnCloseSessionStudentActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        btnProfileStudent1.setBackground(new java.awt.Color(98, 114, 129));[m
[32m+[m[32m        btnProfileStudent1.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N[m
[32m+[m[32m        btnProfileStudent1.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnProfileStudent1.setLabel("Perfil");[m
[32m+[m[32m        btnProfileStudent1.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent1.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent1.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnProfileStudent1.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnProfileStudent1ActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanelDashboardLayout = new javax.swing.GroupLayout(jPanelDashboard);[m
[32m+[m[32m        jPanelDashboard.setLayout(jPanelDashboardLayout);[m
[32m+[m[32m        jPanelDashboardLayout.setHorizontalGroup([m
[32m+[m[32m            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(107, 107, 107)[m
[32m+[m[32m                .addComponent(lblEstudiante)[m
[32m+[m[32m                .addGap(0, 0, Short.MAX_VALUE))[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                        .addContainerGap()[m
[32m+[m[32m                        .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(btnPublish, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                            .addComponent(btnMyProjects, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))[m
[32m+[m[32m                    .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                        .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(90, 90, 90)[m
[32m+[m[32m                                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                    .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                    .addComponent(lblUser)))[m
[32m+[m[32m                            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(17, 17, 17)[m
[32m+[m[32m                                .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 119, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                        .addGap(0, 80, Short.MAX_VALUE)))[m
[32m+[m[32m                .addContainerGap())[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                    .addContainerGap()[m
[32m+[m[32m                    .addComponent(btnProfileStudent1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                    .addContainerGap()))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanelDashboardLayout.setVerticalGroup([m
[32m+[m[32m            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                .addGap(18, 18, 18)[m
[32m+[m[32m                .addComponent(lblUser)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(lblEstudiante)[m
[32m+[m[32m                .addGap(135, 135, 135)[m
[32m+[m[32m                .addComponent(btnPublish, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(29, 29, 29)[m
[32m+[m[32m                .addComponent(btnMyProjects, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 93, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(22, 22, 22))[m
[32m+[m[32m            .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                .addGroup(jPanelDashboardLayout.createSequentialGroup()[m
[32m+[m[32m                    .addGap(176, 176, 176)[m
[32m+[m[32m                    .addComponent(btnProfileStudent1, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                    .addContainerGap(303, Short.MAX_VALUE)))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        lblTitleProjectList.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N[m
[32m+[m[32m        lblTitleProjectList.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        lblTitleProjectList.setText("Publicación de Proyectos");[m
[32m+[m
[32m+[m[32m        jLabelNameProject.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabelNameProject.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabelNameProject.setText("Nombre Proyecto");[m
[32m+[m
[32m+[m[32m        jTextNameProject.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m
[32m+[m[32m        jLabelObjetives.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabelObjetives.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabelObjetives.setText("Objetivos");[m
[32m+[m
[32m+[m[32m        jLabel1.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabel1.setText("Tiempo máximo");[m
[32m+[m
[32m+[m[32m        jTextMaxTime.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m[32m        jTextMaxTime.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                jTextMaxTimeActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        jLabelBudget.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabelBudget.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabelBudget.setText("Presupuesto");[m
[32m+[m
[32m+[m[32m        jTextBudget.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m[32m        jTextBudget.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                jTextBudgetActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        jLabel2.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabel2.setText("Fecha");[m
[32m+[m
[32m+[m[32m        jTextDate.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m
[32m+[m[32m        jTextObjetives.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m[32m        jTextObjetives.setColumns(20);[m
[32m+[m[32m        jTextObjetives.setRows(5);[m
[32m+[m[32m        jScrollPane2.setViewportView(jTextObjetives);[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);[m
[32m+[m[32m        jPanel1.setLayout(jPanel1Layout);[m
[32m+[m[32m        jPanel1Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel1Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(17, 17, 17)[m
[32m+[m[32m                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)[m
[32m+[m[32m                    .addComponent(jLabel1)[m
[32m+[m[32m                    .addComponent(jLabel2)[m
[32m+[m[32m                    .addComponent(jLabelBudget)[m
[32m+[m[32m                    .addComponent(jLabelObjetives)[m
[32m+[m[32m                    .addComponent(jLabelNameProject)[m
[32m+[m[32m                    .addComponent(jTextBudget)[m
[32m+[m[32m                    .addComponent(jTextMaxTime)[m
[32m+[m[32m                    .addComponent(jTextNameProject)[m
[32m+[m[32m                    .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 316, Short.MAX_VALUE)[m
[32m+[m[32m                    .addComponent(jTextDate))[m
[32m+[m[32m                .addContainerGap(17, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel1Layout.setVerticalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel1Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(19, 19, 19)[m
[32m+[m[32m                .addComponent(jLabelNameProject)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jTextNameProject, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(jLabelObjetives)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 51, Short.MAX_VALUE)[m
[32m+[m[32m                .addComponent(jLabel1)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jTextMaxTime, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(jLabelBudget)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jTextBudget, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(jLabel2)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)[m
[32m+[m[32m                .addComponent(jTextDate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(18, 18, 18))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        jLabelSummary.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabelSummary.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabelSummary.setText("Resumen");[m
[32m+[m
[32m+[m[32m        jLabel4.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jLabel4.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        jLabel4.setText("Descripción de necesidad");[m
[32m+[m
[32m+[m[32m        jTextArea2.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m[32m        jTextArea2.setColumns(20);[m
[32m+[m[32m        jTextArea2.setRows(5);[m
[32m+[m[32m        jScrollPane3.setViewportView(jTextArea2);[m
[32m+[m
[32m+[m[32m        jTextArea3.setBackground(new java.awt.Color(204, 204, 204));[m
[32m+[m[32m        jTextArea3.setColumns(20);[m
[32m+[m[32m        jTextArea3.setRows(5);[m
[32m+[m[32m        jScrollPane4.setViewportView(jTextArea3);[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);[m
[32m+[m[32m        jPanel2.setLayout(jPanel2Layout);[m
[32m+[m[32m        jPanel2Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel2Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(12, 12, 12)[m
[32m+[m[32m                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)[m
[32m+[m[32m                    .addComponent(jScrollPane3, javax.swing.GroupLayout.DEFAULT_SIZE, 301, Short.MAX_VALUE)[m
[32m+[m[32m                    .addComponent(jLabel4)[m
[32m+[m[32m                    .addComponent(jLabelSummary)[m
[32m+[m[32m                    .addComponent(jScrollPane4))[m
[32m+[m[32m                .addContainerGap(15, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel2Layout.setVerticalGroup([m
[32m+[m[32m            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel2Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(19, 19, 19)[m
[32m+[m[32m                .addComponent(jLabelSummary)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(jScrollPane4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addGap(22, 22, 22)[m
[32m+[m[32m                .addComponent(jLabel4)[m
[32m+[m[32m                .addGap(26, 26, 26)[m
[32m+[m[32m                .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 143, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addContainerGap(71, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        jLabel3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/mycompany/gestionproyectosacademicos/resources/image 11.png"))); // NOI18N[m
[32m+[m
[32m+[m[32m        btnPublish1.setBackground(new java.awt.Color(155, 70, 47));[m
[32m+[m[32m        btnPublish1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        btnPublish1.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        btnPublish1.setText("Publicar");[m
[32m+[m[32m        btnPublish1.setMaximumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnPublish1.setMinimumSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnPublish1.setPreferredSize(new java.awt.Dimension(28, 17));[m
[32m+[m[32m        btnPublish1.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                btnPublish1ActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);[m
[32m+[m[32m        this.setLayout(layout);[m
[32m+[m[32m        layout.setHorizontalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(26, 26, 26)[m
[32m+[m[32m                .addComponent(jPanelDashboard, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 51, Short.MAX_VALUE)[m
[32m+[m[32m                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)[m
[32m+[m[32m                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                        .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addGap(18, 18, 18)[m
[32m+[m[32m                            .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addGap(130, 130, 130))[m
[32m+[m[32m                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()[m
[32m+[m[32m                            .addComponent(btnPublish1, javax.swing.GroupLayout.PREFERRED_SIZE, 149, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addGap(220, 220, 220)))[m
[32m+[m[32m                    .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                        .addComponent(lblTitleProjectList)[m
[32m+[m[32m                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                        .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 75, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addGap(21, 21, 21))))[m
[32m+[m[32m        );[m
[32m+[m[32m        layout.setVerticalGroup([m
[32m+[m[32m            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()[m
[32m+[m[32m                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                    .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(20, 20, 20)[m
[32m+[m[32m                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(lblTitleProjectList)[m
[32m+[m[32m                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 70, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGap(19, 19, 19)[m
[32m+[m[32m                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 19, Short.MAX_VALUE)[m
[32m+[m[32m                        .addComponent(btnPublish1, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                    .addGroup(layout.createSequentialGroup()[m
[32m+[m[32m                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                        .addComponent(jPanelDashboard, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                .addGap(52, 52, 52))[m
[32m+[m[32m        );[m
[32m+[m[32m    }// </editor-fold>//GEN-END:initComponents[m
[32m+[m
[32m+[m[32m    private void btnCloseSessionStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionStudentActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_btnCloseSessionStudentActionPerformed[m
[32m+[m
[32m+[m[32m    private void jTextMaxTimeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextMaxTimeActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_jTextMaxTimeActionPerformed[m
[32m+[m
[32m+[m[32m    private void jTextBudgetActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextBudgetActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_jTextBudgetActionPerformed[m
[32m+[m
[32m+[m[32m    private void btnProfileStudent1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnProfileStudent1ActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_btnProfileStudent1ActionPerformed[m
[32m+[m
[32m+[m[32m    private void btnPublish1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPublish1ActionPerformed[m
[32m+[m[41m        [m
[32m+[m[32m// TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_btnPublish1ActionPerformed[m
[32m+[m
[32m+[m
[32m+[m[32m    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[32m+[m[32m    private javax.swing.JButton btnCloseSessionStudent;[m
[32m+[m[32m    private javax.swing.JButton btnMyProjects;[m
[32m+[m[32m    private javax.swing.JButton btnProfileStudent1;[m
[32m+[m[32m    private javax.swing.JButton btnPublish;[m
[32m+[m[32m    private javax.swing.JButton btnPublish1;[m
[32m+[m[32m    private javax.swing.JLabel jLabel1;[m
[32m+[m[32m    private javax.swing.JLabel jLabel2;[m
[32m+[m[32m    private javax.swing.JLabel jLabel3;[m
[32m+[m[32m    private javax.swing.JLabel jLabel4;[m
[32m+[m[32m    private javax.swing.JLabel jLabelBudget;[m
[32m+[m[32m    private javax.swing.JLabel jLabelNameProject;[m
[32m+[m[32m    private javax.swing.JLabel jLabelObjetives;[m
[32m+[m[32m    private javax.swing.JLabel jLabelSummary;[m
[32m+[m[32m    private javax.swing.JPanel jPanel1;[m
[32m+[m[32m    private javax.swing.JPanel jPanel2;[m
[32m+[m[32m    private javax.swing.JPanel jPanelDashboard;[m
[32m+[m[32m    private javax.swing.JScrollPane jScrollPane1;[m
[32m+[m[32m    private javax.swing.JScrollPane jScrollPane2;[m
[32m+[m[32m    private javax.swing.JScrollPane jScrollPane3;[m
[32m+[m[32m    private javax.swing.JScrollPane jScrollPane4;[m
[32m+[m[32m    private javax.swing.JTextArea jTextArea1;[m
[32m+[m[32m    private javax.swing.JTextArea jTextArea2;[m
[32m+[m[32m    private javax.swing.JTextArea jTextArea3;[m
[32m+[m[32m    private javax.swing.JTextField jTextBudget;[m
[32m+[m[32m    private javax.swing.JTextField jTextDate;[m
[32m+[m[32m    private javax.swing.JTextField jTextMaxTime;[m
[32m+[m[32m    private javax.swing.JTextField jTextNameProject;[m
[32m+[m[32m    private javax.swing.JTextArea jTextObjetives;[m
[32m+[m[32m    private javax.swing.JLabel lblEstudiante;[m
[32m+[m[32m    private javax.swing.JLabel lblTitleProjectList;[m
[32m+[m[32m    private javax.swing.JLabel lblUser;[m
[32m+[m[32m    private javax.swing.JSeparator sepUserCoord;[m
[32m+[m[32m    // End of variables declaration//GEN-END:variables[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.form b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.form[m
[1mnew file mode 100644[m
[1mindex 0000000..f564a7d[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.form[m
[36m@@ -0,0 +1,579 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8" ?>[m
[32m+[m
[32m+[m[32m<Form version="1.3" maxVersion="1.9" type="org.netbeans.modules.form.forminfo.JFrameFormInfo">[m
[32m+[m[32m  <NonVisualComponents>[m
[32m+[m[32m    <Component class="java.awt.TextField" name="textField1">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="text" type="java.lang.String" value="textField1"/>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m    </Component>[m
[32m+[m[32m  </NonVisualComponents>[m
[32m+[m[32m  <Properties>[m
[32m+[m[32m    <Property name="defaultCloseOperation" type="int" value="3"/>[m
[32m+[m[32m    <Property name="minimumSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m      <Dimension value="[600, 400]"/>[m
[32m+[m[32m    </Property>[m
[32m+[m[32m  </Properties>[m
[32m+[m[32m  <SyntheticProperties>[m
[32m+[m[32m    <SyntheticProperty name="formSizePolicy" type="int" value="1"/>[m
[32m+[m[32m    <SyntheticProperty name="generateCenter" type="boolean" value="false"/>[m
[32m+[m[32m  </SyntheticProperties>[m
[32m+[m[32m  <AuxValues>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoResourcing" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_autoSetComponentName" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateFQN" type="java.lang.Boolean" value="true"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_generateMnemonicsCode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_i18nAutoMode" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_layoutCodeTarget" type="java.lang.Integer" value="1"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_listenerGenerationStyle" type="java.lang.Integer" value="0"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesLocal" type="java.lang.Boolean" value="false"/>[m
[32m+[m[32m    <AuxValue name="FormSettings_variablesModifier" type="java.lang.Integer" value="2"/>[m
[32m+[m[32m    <AuxValue name="designerSize" type="java.awt.Dimension" value="-84,-19,0,5,115,114,0,18,106,97,118,97,46,97,119,116,46,68,105,109,101,110,115,105,111,110,65,-114,-39,-41,-84,95,68,20,2,0,2,73,0,6,104,101,105,103,104,116,73,0,5,119,105,100,116,104,120,112,0,0,1,-116,0,0,2,67"/>[m
[32m+[m[32m  </AuxValues>[m
[32m+[m
[32m+[m[32m  <Layout class="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout">[m
[32m+[m[32m    <Property name="useNullLayout" type="boolean" value="false"/>[m
[32m+[m[32m  </Layout>[m
[32m+[m[32m  <SubComponents>[m
[32m+[m[32m    <Container class="javax.swing.JPanel" name="jPanel1">[m
[32m+[m[32m      <Properties>[m
[32m+[m[32m        <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="border" type="javax.swing.border.Border" editor="org.netbeans.modules.form.editors2.BorderEditor">[m
[32m+[m[32m          <Border info="org.netbeans.modules.form.compat2.border.TitledBorderInfo">[m
[32m+[m[32m            <TitledBorder/>[m
[32m+[m[32m          </Border>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m          <Color blue="33" green="0" red="0" type="rgb"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m          <Dimension value="[400, 300]"/>[m
[32m+[m[32m        </Property>[m
[32m+[m[32m        <Property name="verifyInputWhenFocusTarget" type="boolean" value="false"/>[m
[32m+[m[32m      </Properties>[m
[32m+[m[32m      <Constraints>[m
[32m+[m[32m        <Constraint layoutClass="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout" value="org.netbeans.modules.form.compat2.layouts.DesignAbsoluteLayout$AbsoluteConstraintsDescription">[m
[32m+[m[32m          <AbsoluteConstraints x="0" y="0" width="580" height="420"/>[m
[32m+[m[32m        </Constraint>[m
[32m+[m[32m      </Constraints>[m
[32m+[m
[32m+[m[32m      <Layout>[m
[32m+[m[32m        <DimensionLayout dim="0">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="70" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                      <Component id="jLabel2" max="32767" attributes="0"/>[m
[32m+[m[32m                      <Component id="jPanel4" alignment="0" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                          <EmptySpace min="-2" pref="99" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="jSeparator1" min="-2" pref="247" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m                  <EmptySpace min="-2" pref="112" max="-2" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m        <DimensionLayout dim="1">[m
[32m+[m[32m          <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m              <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                  <EmptySpace min="-2" pref="14" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jLabel2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jSeparator1" min="-2" pref="8" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace type="unrelated" max="-2" attributes="0"/>[m
[32m+[m[32m                  <Component id="jPanel4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                  <EmptySpace pref="56" max="32767" attributes="0"/>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m          </Group>[m
[32m+[m[32m        </DimensionLayout>[m
[32m+[m[32m      </Layout>[m
[32m+[m[32m      <SubComponents>[m
[32m+[m[32m        <Component class="javax.swing.JLabel" name="jLabel2">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m              <Font name="Tahoma" size="24" style="1"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="text" type="java.lang.String" value="              Registro de empresa"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m        <Container class="javax.swing.JPanel" name="jPanel4">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="db" green="db" red="db" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="alignmentX" type="float" value="0.0"/>[m
[32m+[m[32m            <Property name="alignmentY" type="float" value="0.0"/>[m
[32m+[m[32m          </Properties>[m
[32m+[m
[32m+[m[32m          <Layout>[m
[32m+[m[32m            <DimensionLayout dim="0">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="-2" pref="26" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                              <Component id="label3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace pref="87" max="32767" attributes="0"/>[m
[32m+[m[32m                              <Component id="label5" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="33" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" attributes="0">[m
[32m+[m[32m                                      <Component id="label10" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Component id="JCompanyEmail" alignment="1" max="32767" attributes="0"/>[m
[32m+[m[32m                                  <Component id="password" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                                  <Component id="jSector" max="32767" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="-2" pref="51" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="1" max="-2" attributes="0">[m
[32m+[m[32m                                  <Component id="label8" min="-2" pref="55" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="JContactNumber" alignment="1" pref="158" max="32767" attributes="0"/>[m
[32m+[m[32m                                  <Component id="JContactPosition" alignment="1" max="32767" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                              <EmptySpace min="-2" pref="2" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" attributes="0">[m
[32m+[m[32m                                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                          <Group type="102" attributes="0">[m
[32m+[m[32m                                              <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                                                  <Component id="JCompanyName" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                                                  <Component id="JCompanyNIT" max="32767" attributes="0"/>[m
[32m+[m[32m                                              </Group>[m
[32m+[m[32m                                              <EmptySpace min="-2" pref="53" max="-2" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                          <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                              <Component id="label12" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                              <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                                          </Group>[m
[32m+[m[32m                                      </Group>[m
[32m+[m[32m                                      <Group type="103" groupAlignment="0" max="-2" attributes="0">[m
[32m+[m[32m                                          <Component id="JContactName" pref="158" max="32767" attributes="0"/>[m
[32m+[m[32m                                          <Component id="label6" alignment="1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                          <Component id="JContactLastName" alignment="0" max="32767" attributes="0"/>[m
[32m+[m[32m                                      </Group>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="label9" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                                      <Component id="label4" min="-2" pref="71" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" attributes="0">[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="label13" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                                      <Component id="jSeparator2" min="-2" pref="7" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="16" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="label2" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" attributes="0">[m
[32m+[m[32m                                      <Component id="label11" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace pref="278" max="32767" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Component id="label7" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                              <EmptySpace min="-2" pref="205" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Component id="button1" min="-2" pref="106" max="-2" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <EmptySpace min="-2" pref="25" max="-2" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m            <DimensionLayout dim="1">[m
[32m+[m[32m              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                  <Group type="102" attributes="0">[m
[32m+[m[32m                      <EmptySpace min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                      <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                          <Component id="label5" min="-2" pref="21" max="-2" attributes="0"/>[m
[32m+[m[32m                          <Component id="label3" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                          <Group type="102" attributes="0">[m
[32m+[m[32m                              <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                                  <Component id="label9" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="label4" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Component id="JContactName" min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="JCompanyNIT" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="label11" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Component id="label7" alignment="0" min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" max="-2" attributes="0">[m
[32m+[m[32m                                  <Component id="JContactLastName" max="32767" attributes="0"/>[m
[32m+[m[32m                                  <Component id="JCompanyName" max="32767" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="label6" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="JContactNumber" min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="label12" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="JCompanyEmail" min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Component id="label8" alignment="0" min="-2" pref="19" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="label10" alignment="0" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="1" attributes="0">[m
[32m+[m[32m                                  <Component id="JContactPosition" min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                                  <Component id="jSector" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                              <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Group type="103" groupAlignment="0" attributes="0">[m
[32m+[m[32m                                  <Group type="102" alignment="0" attributes="0">[m
[32m+[m[32m                                      <Component id="label2" min="-2" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="0" pref="0" max="32767" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                                  <Group type="102" alignment="1" attributes="0">[m
[32m+[m[32m                                      <Component id="label13" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="0" pref="0" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <Component id="password" min="-2" pref="20" max="-2" attributes="0"/>[m
[32m+[m[32m                                      <EmptySpace min="-2" pref="21" max="-2" attributes="0"/>[m
[32m+[m[32m                                  </Group>[m
[32m+[m[32m                              </Group>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                          <Group type="102" attributes="0">[m
[32m+[m[32m                              <EmptySpace min="-2" pref="2" max="-2" attributes="0"/>[m
[32m+[m[32m                              <Component id="jSeparator2" min="-2" pref="208" max="-2" attributes="0"/>[m
[32m+[m[32m                              <EmptySpace max="32767" attributes="0"/>[m
[32m+[m[32m                          </Group>[m
[32m+[m[32m                      </Group>[m
[32m+[m[32m                      <Component id="button1" min="-2" max="-2" attributes="0"/>[m
[32m+[m[32m                      <EmptySpace pref="16" max="32767" attributes="0"/>[m
[32m+[m[32m                  </Group>[m
[32m+[m[32m              </Group>[m
[32m+[m[32m            </DimensionLayout>[m
[32m+[m[32m          </Layout>[m
[32m+[m[32m          <SubComponents>[m
[32m+[m[32m            <Component class="java.awt.Button" name="button1">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="actionCommand" type="java.lang.String" value="Registrar"/>[m
[32m+[m[32m                <Property name="background" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="0" green="0" red="66" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="ff" green="ff" red="ff" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="label" type="java.lang.String" value="Registrar"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="button1ActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label2">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="0"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="NIT de la empresa"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label3">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Datos de la empresa"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label4">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Nombres*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <AccessibilityProperties>[m
[32m+[m[32m                <Property name="AccessibleContext.accessibleDescription" type="java.lang.String" value="Nombres"/>[m
[32m+[m[32m              </AccessibilityProperties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label5">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="14" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Datos de contacto"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label6">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Telefono*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label7">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Apellidos*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label8">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Cargo*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JContactLastName">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JContactLastNameActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JContactPosition">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="name" type="java.lang.String" value="" noResource="true"/>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JContactPositionActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JCompanyNIT">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="name" type="java.lang.String" value="" noResource="true"/>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <AccessibilityProperties>[m
[32m+[m[32m                <Property name="AccessibleContext.accessibleDescription" type="java.lang.String" value=""/>[m
[32m+[m[32m              </AccessibilityProperties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JCompanyNITActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JContactNumber">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="name" type="java.lang.String" value="" noResource="true"/>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JContactNumberActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label9">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="NIT de la empresa*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <AccessibilityProperties>[m
[32m+[m[32m                <Property name="AccessibleContext.accessibleName" type="java.lang.String" value="Nit de  la empresa"/>[m
[32m+[m[32m              </AccessibilityProperties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label10">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Sector*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label11">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Nombre*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JCompanyEmail">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JCompanyEmailActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JContactName">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JContactNameActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="JCompanyName">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="JCompanyNameActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label12">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Email*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JSeparator" name="jSeparator2">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="0" green="33" red="99" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="orientation" type="int" value="1"/>[m
[32m+[m[32m                <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m                  <Dimension value="[50, 30]"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.TextField" name="password">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="1"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="passwordActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="java.awt.Label" name="label13">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="cursor" type="java.awt.Cursor" editor="org.netbeans.modules.form.editors2.CursorEditor">[m
[32m+[m[32m                  <Color id="Default Cursor"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="font" type="java.awt.Font" editor="org.netbeans.beaninfo.editors.FontEditor">[m
[32m+[m[32m                  <Font name="Tahoma" size="12" style="1"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m                  <Color blue="46" green="2d" red="13" type="rgb"/>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m                <Property name="text" type="java.lang.String" value="Contrase&#xf1;a*"/>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m            <Component class="javax.swing.JComboBox" name="jSector">[m
[32m+[m[32m              <Properties>[m
[32m+[m[32m                <Property name="model" type="javax.swing.ComboBoxModel" editor="org.netbeans.modules.form.editors2.ComboBoxModelEditor">[m
[32m+[m[32m                  <StringArray count="5">[m
[32m+[m[32m                    <StringItem index="0" value="Tecnologia"/>[m
[32m+[m[32m                    <StringItem index="1" value="Salud"/>[m
[32m+[m[32m                    <StringItem index="2" value="Educacion"/>[m
[32m+[m[32m                    <StringItem index="3" value="Servicios"/>[m
[32m+[m[32m                    <StringItem index="4" value="Otros"/>[m
[32m+[m[32m                  </StringArray>[m
[32m+[m[32m                </Property>[m
[32m+[m[32m              </Properties>[m
[32m+[m[32m              <Events>[m
[32m+[m[32m                <EventHandler event="actionPerformed" listener="java.awt.event.ActionListener" parameters="java.awt.event.ActionEvent" handler="jSectorActionPerformed"/>[m
[32m+[m[32m              </Events>[m
[32m+[m[32m              <AuxValues>[m
[32m+[m[32m                <AuxValue name="JavaCodeGenerator_TypeParameters" type="java.lang.String" value="&lt;String&gt;"/>[m
[32m+[m[32m              </AuxValues>[m
[32m+[m[32m            </Component>[m
[32m+[m[32m          </SubComponents>[m
[32m+[m[32m        </Container>[m
[32m+[m[32m        <Component class="javax.swing.JSeparator" name="jSeparator1">[m
[32m+[m[32m          <Properties>[m
[32m+[m[32m            <Property name="foreground" type="java.awt.Color" editor="org.netbeans.beaninfo.editors.ColorEditor">[m
[32m+[m[32m              <Color blue="0" green="33" red="99" type="rgb"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m            <Property name="preferredSize" type="java.awt.Dimension" editor="org.netbeans.beaninfo.editors.DimensionEditor">[m
[32m+[m[32m              <Dimension value="[50, 30]"/>[m
[32m+[m[32m            </Property>[m
[32m+[m[32m          </Properties>[m
[32m+[m[32m        </Component>[m
[32m+[m[32m      </SubComponents>[m
[32m+[m[32m    </Container>[m
[32m+[m[32m  </SubComponents>[m
[32m+[m[32m</Form>[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.java[m
[1mnew file mode 100644[m
[1mindex 0000000..d052d1b[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/presentation/GUIcompanyRegister.java[m
[36m@@ -0,0 +1,567 @@[m
[32m+[m[32m/*[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[32m+[m[32m * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.presentation;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Company;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.ConexionPostgreSQL;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.SaveDateCompany;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.SaveDateUser;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.services.AuthService;[m
[32m+[m
[32m+[m[32m//import com.mycompany.gestionproyectosacademicos.presentacion.PanelRound;[m
[32m+[m[32mimport javax.swing.JOptionPane;[m
[32m+[m
[32m+[m[32mimport java.sql.Connection;[m
[32m+[m[32mimport java.sql.PreparedStatement;[m
[32m+[m[32mimport java.sql.SQLException;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Rubeiro Romero[m[41m [m
[32m+[m[32m */[m
[32m+[m[32m//interface Company[m
[32m+[m[32mpublic class GUIcompanyRegister extends javax.swing.JFrame {[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Creates new form GUIcompanyRegister[m
[32m+[m[32m     */[m
[32m+[m[32m    public GUIcompanyRegister() {[m
[32m+[m[32m        initComponents();[m
[32m+[m[32m        this.setLocationRelativeTo(null);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * This method is called from within the constructor to initialize the form.[m
[32m+[m[32m     * WARNING: Do NOT modify this code. The content of this method is always[m
[32m+[m[32m     * regenerated by the Form Editor.[m
[32m+[m[32m     */[m
[32m+[m[32m    @SuppressWarnings("unchecked")[m
[32m+[m[32m    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents[m
[32m+[m[32m    private void initComponents() {[m
[32m+[m
[32m+[m[32m        textField1 = new java.awt.TextField();[m
[32m+[m[32m        jPanel1 = new javax.swing.JPanel();[m
[32m+[m[32m        jLabel2 = new javax.swing.JLabel();[m
[32m+[m[32m        jPanel4 = new javax.swing.JPanel();[m
[32m+[m[32m        button1 = new java.awt.Button();[m
[32m+[m[32m        label2 = new java.awt.Label();[m
[32m+[m[32m        label3 = new java.awt.Label();[m
[32m+[m[32m        label4 = new java.awt.Label();[m
[32m+[m[32m        label5 = new java.awt.Label();[m
[32m+[m[32m        label6 = new java.awt.Label();[m
[32m+[m[32m        label7 = new java.awt.Label();[m
[32m+[m[32m        label8 = new java.awt.Label();[m
[32m+[m[32m        JContactLastName = new java.awt.TextField();[m
[32m+[m[32m        JContactPosition = new java.awt.TextField();[m
[32m+[m[32m        JCompanyNIT = new java.awt.TextField();[m
[32m+[m[32m        JContactNumber = new java.awt.TextField();[m
[32m+[m[32m        label9 = new java.awt.Label();[m
[32m+[m[32m        label10 = new java.awt.Label();[m
[32m+[m[32m        label11 = new java.awt.Label();[m
[32m+[m[32m        JCompanyEmail = new java.awt.TextField();[m
[32m+[m[32m        JContactName = new java.awt.TextField();[m
[32m+[m[32m        JCompanyName = new java.awt.TextField();[m
[32m+[m[32m        label12 = new java.awt.Label();[m
[32m+[m[32m        jSeparator2 = new javax.swing.JSeparator();[m
[32m+[m[32m        password = new java.awt.TextField();[m
[32m+[m[32m        label13 = new java.awt.Label();[m
[32m+[m[32m        jSector = new javax.swing.JComboBox<>();[m
[32m+[m[32m        jSeparator1 = new javax.swing.JSeparator();[m
[32m+[m
[32m+[m[32m        textField1.setText("textField1");[m
[32m+[m
[32m+[m[32m        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);[m
[32m+[m[32m        setMinimumSize(new java.awt.Dimension(600, 400));[m
[32m+[m[32m        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());[m
[32m+[m
[32m+[m[32m        jPanel1.setBackground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(""));[m
[32m+[m[32m        jPanel1.setForeground(new java.awt.Color(0, 0, 51));[m
[32m+[m[32m        jPanel1.setPreferredSize(new java.awt.Dimension(400, 300));[m
[32m+[m[32m        jPanel1.setVerifyInputWhenFocusTarget(false);[m
[32m+[m
[32m+[m[32m        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N[m
[32m+[m[32m        jLabel2.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        jLabel2.setText("              Registro de empresa");[m
[32m+[m
[32m+[m[32m        jPanel4.setBackground(new java.awt.Color(219, 219, 219));[m
[32m+[m[32m        jPanel4.setAlignmentX(0.0F);[m
[32m+[m[32m        jPanel4.setAlignmentY(0.0F);[m
[32m+[m
[32m+[m[32m        button1.setActionCommand("Registrar");[m
[32m+[m[32m        button1.setBackground(new java.awt.Color(102, 0, 0));[m
[32m+[m[32m        button1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        button1.setForeground(new java.awt.Color(255, 255, 255));[m
[32m+[m[32m        button1.setLabel("Registrar");[m
[32m+[m[32m        button1.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                button1ActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        label2.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N[m
[32m+[m[32m        label2.setText("NIT de la empresa");[m
[32m+[m
[32m+[m[32m        label3.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label3.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        label3.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label3.setText("Datos de la empresa");[m
[32m+[m
[32m+[m[32m        label4.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label4.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label4.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label4.setText("Nombres*");[m
[32m+[m
[32m+[m[32m        label5.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label5.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N[m
[32m+[m[32m        label5.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label5.setText("Datos de contacto");[m
[32m+[m
[32m+[m[32m        label6.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label6.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label6.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label6.setText("Telefono*");[m
[32m+[m
[32m+[m[32m        label7.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label7.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label7.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label7.setText("Apellidos*");[m
[32m+[m
[32m+[m[32m        label8.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label8.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label8.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label8.setText("Cargo*");[m
[32m+[m
[32m+[m[32m        JContactLastName.setText("1");[m
[32m+[m[32m        JContactLastName.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JContactLastNameActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        JContactPosition.setName(""); // NOI18N[m
[32m+[m[32m        JContactPosition.setText("1");[m
[32m+[m[32m        JContactPosition.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JContactPositionActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        JCompanyNIT.setName(""); // NOI18N[m
[32m+[m[32m        JCompanyNIT.setText("1");[m
[32m+[m[32m        JCompanyNIT.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JCompanyNITActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        JContactNumber.setName(""); // NOI18N[m
[32m+[m[32m        JContactNumber.setText("1");[m
[32m+[m[32m        JContactNumber.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JContactNumberActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        label9.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label9.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label9.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label9.setText("NIT de la empresa*");[m
[32m+[m
[32m+[m[32m        label10.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label10.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label10.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label10.setText("Sector*");[m
[32m+[m
[32m+[m[32m        label11.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label11.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label11.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label11.setText("Nombre*");[m
[32m+[m
[32m+[m[32m        JCompanyEmail.setText("1");[m
[32m+[m[32m        JCompanyEmail.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JCompanyEmailActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        JContactName.setText("1");[m
[32m+[m[32m        JContactName.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JContactNameActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        JCompanyName.setText("1");[m
[32m+[m[32m        JCompanyName.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                JCompanyNameActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        label12.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label12.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label12.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label12.setText("Email*");[m
[32m+[m
[32m+[m[32m        jSeparator2.setForeground(new java.awt.Color(153, 51, 0));[m
[32m+[m[32m        jSeparator2.setOrientation(javax.swing.SwingConstants.VERTICAL);[m
[32m+[m[32m        jSeparator2.setPreferredSize(new java.awt.Dimension(50, 30));[m
[32m+[m
[32m+[m[32m        password.setText("1");[m
[32m+[m[32m        password.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                passwordActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        label13.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));[m
[32m+[m[32m        label13.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N[m
[32m+[m[32m        label13.setForeground(new java.awt.Color(19, 45, 70));[m
[32m+[m[32m        label13.setText("Contraseña*");[m
[32m+[m
[32m+[m[32m        jSector.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Tecnologia", "Salud", "Educacion", "Servicios", "Otros" }));[m
[32m+[m[32m        jSector.addActionListener(new java.awt.event.ActionListener() {[m
[32m+[m[32m            public void actionPerformed(java.awt.event.ActionEvent evt) {[m
[32m+[m[32m                jSectorActionPerformed(evt);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);[m
[32m+[m[32m        jPanel4.setLayout(jPanel4Layout);[m
[32m+[m[32m        jPanel4Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(26, 26, 26)[m
[32m+[m[32m                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addComponent(label3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 87, Short.MAX_VALUE)[m
[32m+[m[32m                        .addComponent(label5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addGap(33, 33, 33))[m
[32m+[m[32m                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(0, 0, Short.MAX_VALUE))[m
[32m+[m[32m                            .addComponent(JCompanyEmail, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                            .addComponent(password, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                            .addComponent(jSector, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m                        .addGap(51, 51, 51)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)[m
[32m+[m[32m                            .addComponent(label8, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(JContactNumber, javax.swing.GroupLayout.DEFAULT_SIZE, 158, Short.MAX_VALUE)[m
[32m+[m[32m                            .addComponent(JContactPosition, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))[m
[32m+[m[32m                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(2, 2, 2)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                                            .addComponent(JCompanyName, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                                            .addComponent(JCompanyNIT, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m                                        .addGap(53, 53, 53))[m
[32m+[m[32m                                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                        .addComponent(label12, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))[m
[32m+[m[32m                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)[m
[32m+[m[32m                                    .addComponent(JContactName, javax.swing.GroupLayout.DEFAULT_SIZE, 158, Short.MAX_VALUE)[m
[32m+[m[32m                                    .addComponent(label6, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                    .addComponent(JContactLastName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                                .addComponent(label4, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))))[m
[32m+[m[32m                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label13, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                                .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 7, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(16, 16, 16)[m
[32m+[m[32m                                .addComponent(label2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label11, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 278, Short.MAX_VALUE)))[m
[32m+[m[32m                        .addComponent(label7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(205, 205, 205)[m
[32m+[m[32m                        .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                .addGap(25, 25, 25))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel4Layout.setVerticalGroup([m
[32m+[m[32m            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(19, 19, 19)[m
[32m+[m[32m                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                    .addComponent(label5, javax.swing.GroupLayout.PREFERRED_SIZE, 21, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                    .addComponent(label3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(label9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(label4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGap(0, 0, 0)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(JContactName, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(JCompanyNIT, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGap(0, 0, 0)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addGap(2, 2, 2)[m
[32m+[m[32m                                .addComponent(label11, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                            .addComponent(label7, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)[m
[32m+[m[32m                            .addComponent(JContactLastName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                            .addComponent(JCompanyName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))[m
[32m+[m[32m                        .addGap(0, 0, 0)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(0, 0, 0)[m
[32m+[m[32m                                .addComponent(JContactNumber, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label12, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(0, 0, 0)[m
[32m+[m[32m                                .addComponent(JCompanyEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addComponent(label8, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(label10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGap(0, 0, 0)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)[m
[32m+[m[32m                            .addComponent(JContactPosition, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                            .addComponent(jSector, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))[m
[32m+[m[32m                        .addGap(0, 0, 0)[m
[32m+[m[32m                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                            .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label2, javax.swing.GroupLayout.PREFERRED_SIZE, 0, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(0, 0, Short.MAX_VALUE))[m
[32m+[m[32m                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                                .addComponent(label13, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(0, 0, 0)[m
[32m+[m[32m                                .addComponent(password, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                                .addGap(21, 21, 21))))[m
[32m+[m[32m                    .addGroup(jPanel4Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(2, 2, 2)[m
[32m+[m[32m                        .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 208, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))[m
[32m+[m[32m                .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addContainerGap(16, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        label4.getAccessibleContext().setAccessibleDescription("Nombres");[m
[32m+[m[32m        JCompanyNIT.getAccessibleContext().setAccessibleDescription("");[m
[32m+[m[32m        label9.getAccessibleContext().setAccessibleName("Nit de  la empresa");[m
[32m+[m
[32m+[m[32m        jSeparator1.setForeground(new java.awt.Color(153, 51, 0));[m
[32m+[m[32m        jSeparator1.setPreferredSize(new java.awt.Dimension(50, 30));[m
[32m+[m
[32m+[m[32m        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);[m
[32m+[m[32m        jPanel1.setLayout(jPanel1Layout);[m
[32m+[m[32m        jPanel1Layout.setHorizontalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel1Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(70, 70, 70)[m
[32m+[m[32m                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m                    .addComponent(jLabel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)[m
[32m+[m[32m                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                    .addGroup(jPanel1Layout.createSequentialGroup()[m
[32m+[m[32m                        .addGap(99, 99, 99)[m
[32m+[m[32m                        .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 247, javax.swing.GroupLayout.PREFERRED_SIZE)))[m
[32m+[m[32m                .addGap(112, 112, 112))[m
[32m+[m[32m        );[m
[32m+[m[32m        jPanel1Layout.setVerticalGroup([m
[32m+[m[32m            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)[m
[32m+[m[32m            .addGroup(jPanel1Layout.createSequentialGroup()[m
[32m+[m[32m                .addGap(14, 14, 14)[m
[32m+[m[32m                .addComponent(jLabel2)[m
[32m+[m[32m                .addGap(0, 0, 0)[m
[32m+[m[32m                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 8, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)[m
[32m+[m[32m                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)[m
[32m+[m[32m                .addContainerGap(56, Short.MAX_VALUE))[m
[32m+[m[32m        );[m
[32m+[m
[32m+[m[32m        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 580, 420));[m
[32m+[m
[32m+[m[32m        pack();[m
[32m+[m[32m    }// </editor-fold>//GEN-END:initComponents[m
[32m+[m
[32m+[m[32m    private void JContactPositionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactPositionActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JContactPositionActionPerformed[m
[32m+[m
[32m+[m[32m    private void JContactLastNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactLastNameActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JContactLastNameActionPerformed[m
[32m+[m[32m SaveDateCompany saveCompany = new SaveDateCompany();[m[41m [m
[32m+[m[41m [m
[32m+[m[32m    private void button1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button1ActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[41m        [m
[32m+[m[32m        if(JCompanyNIT.getText().isEmpty()[m
[32m+[m[32m                ||JCompanyEmail.getText().isEmpty()[m
[32m+[m[32m                ||JCompanyName.getText().isEmpty()[m
[32m+[m[32m                ||JContactName.getText().isEmpty()[m
[32m+[m[32m                ||JContactNumber.getText().isEmpty()[m
[32m+[m[32m                ||JContactLastName.getText().isEmpty()[m
[32m+[m[32m                || JContactPosition.getText().isEmpty()){[m
[32m+[m[32m            JOptionPane.showMessageDialog(null[m
[32m+[m[32m                    ,"Por favor dijite los campos obligatorios. "[m
[32m+[m[32m                            + "Estan marcados con: * "[m
[32m+[m[32m                    , "¡ERROR!",JOptionPane.WARNING_MESSAGE);[m
[32m+[m[32m        }else{[m
[32m+[m[32m            try {[m
[32m+[m[32m                // Validar NIT[m
[32m+[m[32m                String nitTexto = JCompanyNIT.getText().trim();[m
[32m+[m[32m                if (!nitTexto.matches("\\d+")) {[m
[32m+[m[32m                    JOptionPane.showMessageDialog(null, "Error: El NIT solo debe contener números.", "Error", JOptionPane.ERROR_MESSAGE);[m
[32m+[m[32m                    return;[m
[32m+[m[32m                }[m
[32m+[m[32m                int nit = Integer.parseInt(nitTexto);[m
[32m+[m
[32m+[m[32m                // Validar Número de Contacto[m
[32m+[m[32m                String telefonoTexto = JContactNumber.getText().trim();[m
[32m+[m[32m                if (!telefonoTexto.matches("\\d+")) {[m
[32m+[m[32m                    JOptionPane.showMessageDialog(null, "Error: El número de contacto debe contener solo números.", "Error", JOptionPane.ERROR_MESSAGE);[m
[32m+[m[32m                    return;[m
[32m+[m[32m                }[m
[32m+[m[32m                int telefono = Integer.parseInt(telefonoTexto);[m
[32m+[m
[32m+[m[32m                // Crear la empresa[m
[32m+[m[32m                Company company = new Company([m
[32m+[m[32m                    JCompanyName.getText().trim(),[m
[32m+[m[32m                    nit,[m
[32m+[m[32m                    JCompanyEmail.getText().trim(),[m
[32m+[m[32m                    jSector.getSelectedItem().toString().trim(),[m
[32m+[m[32m                    JContactName.getText().trim(),[m
[32m+[m[32m                    JContactLastName.getText().trim(),[m
[32m+[m[32m                    JContactNumber.getText().trim(),[m
[32m+[m[32m                    JContactPosition.getText().trim()[m
[32m+[m[32m                );[m
[32m+[m[32m                SaveDateCompany saveCompany = new SaveDateCompany();[m
[32m+[m[32m                boolean save = saveCompany.saveCompany(company);[m
[32m+[m
[32m+[m[32m                if (save){[m
[32m+[m[32m                    User user=new User(nit,JCompanyEmail.getText().trim(),[m
[32m+[m[32m                        password.getText().trim(), "Empresa");[m
[32m+[m[32m                SaveDateUser saveUser = new SaveDateUser();[m
[32m+[m[32m                saveUser.saveUser(user);[m
[32m+[m[32m                }else{[m
[32m+[m[32m                    return;[m
[32m+[m[32m                }[m
[32m+[m[41m                [m
[32m+[m
[32m+[m[32m            } catch (NumberFormatException e) {[m
[32m+[m[32m                JOptionPane.showMessageDialog(null, "Error: Ingrese solo números en el NIT y el número de contacto.", "Error", JOptionPane.ERROR_MESSAGE);[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m                   AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación[m
[32m+[m[32m                   GUILogin login = new GUILogin(authService); // Pasar la instancia al constructor[m
[32m+[m[32m                   login.setVisible(true); // Mostrar la ventana[m
[32m+[m[41m                   [m
[32m+[m[32m                   this.dispose();[m
[32m+[m[32m        }[m
[32m+[m[32m    }//GEN-LAST:event_button1ActionPerformed[m
[32m+[m
[32m+[m[32m    private void JCompanyNITActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyNITActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JCompanyNITActionPerformed[m
[32m+[m
[32m+[m[32m    private void JContactNumberActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactNumberActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JContactNumberActionPerformed[m
[32m+[m
[32m+[m[32m    private void JCompanyEmailActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyEmailActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JCompanyEmailActionPerformed[m
[32m+[m
[32m+[m[32m    private void JContactNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactNameActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JContactNameActionPerformed[m
[32m+[m
[32m+[m[32m    private void JCompanyNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyNameActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_JCompanyNameActionPerformed[m
[32m+[m
[32m+[m[32m    private void passwordActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_passwordActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m    }//GEN-LAST:event_passwordActionPerformed[m
[32m+[m
[32m+[m[32m    private void jSectorActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jSectorActionPerformed[m
[32m+[m[32m        // TODO add your handling code here:[m
[32m+[m[32m        String sector = jSector.getSelectedItem().toString();[m
[32m+[m[32m    }//GEN-LAST:event_jSectorActionPerformed[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param args the command line arguments[m
[32m+[m[32m     */[m
[32m+[m[32m    public static void main(String args[]) {[m
[32m+[m[32m        /* Set the Nimbus look and feel */[m
[32m+[m[32m        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">[m
[32m+[m[32m        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.[m
[32m+[m[32m         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html[m[41m [m
[32m+[m[32m         */[m
[32m+[m[32m        try {[m
[32m+[m[32m            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {[m
[32m+[m[32m                if ("Nimbus".equals(info.getName())) {[m
[32m+[m[32m                    javax.swing.UIManager.setLookAndFeel(info.getClassName());[m
[32m+[m[32m                    break;[m
[32m+[m[32m                }[m
[32m+[m[32m            }[m
[32m+[m[32m        } catch (ClassNotFoundException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (InstantiationException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (IllegalAccessException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        } catch (javax.swing.UnsupportedLookAndFeelException ex) {[m
[32m+[m[32m            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);[m
[32m+[m[32m        }[m
[32m+[m[32m        //</editor-fold>[m
[32m+[m
[32m+[m[32m        /* Create and display the form */[m
[32m+[m[32m        java.awt.EventQueue.invokeLater(new Runnable() {[m
[32m+[m[32m            public void run() {[m
[32m+[m[32m                new GUIcompanyRegister().setVisible(true);[m
[32m+[m[32m            }[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32m    // Variables declaration - do not modify//GEN-BEGIN:variables[m
[32m+[m[32m    private java.awt.TextField JCompanyEmail;[m
[32m+[m[32m    private java.awt.TextField JCompanyNIT;[m
[32m+[m[32m    private java.awt.TextField JCompanyName;[m
[32m+[m[32m    private java.awt.TextField JContactLastName;[m
[32m+[m[32m    private java.awt.TextField JContactName;[m
[32m+[m[32m    private java.awt.TextField JContactNumber;[m
[32m+[m[32m    private java.awt.TextField JContactPosition;[m
[32m+[m[32m    private java.awt.Button button1;[m
[32m+[m[32m    private javax.swing.JLabel jLabel2;[m
[32m+[m[32m    private javax.swing.JPanel jPanel1;[m
[32m+[m[32m    private javax.swing.JPanel jPanel4;[m
[32m+[m[32m    private javax.swing.JComboBox<String> jSector;[m
[32m+[m[32m    private javax.swing.JSeparator jSeparator1;[m
[32m+[m[32m    private javax.swing.JSeparator jSeparator2;[m
[32m+[m[32m    private java.awt.Label label10;[m
[32m+[m[32m    private java.awt.Label label11;[m
[32m+[m[32m    private java.awt.Label label12;[m
[32m+[m[32m    private java.awt.Label label13;[m
[32m+[m[32m    private java.awt.Label label2;[m
[32m+[m[32m    private java.awt.Label label3;[m
[32m+[m[32m    private java.awt.Label label4;[m
[32m+[m[32m    private java.awt.Label label5;[m
[32m+[m[32m    private java.awt.Label label6;[m
[32m+[m[32m    private java.awt.Label label7;[m
[32m+[m[32m    private java.awt.Label label8;[m
[32m+[m[32m    private java.awt.Label label9;[m
[32m+[m[32m    private java.awt.TextField password;[m
[32m+[m[32m    private java.awt.TextField textField1;[m
[32m+[m[32m    // End of variables declaration//GEN-END:variables[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/resources/image 11.png b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/resources/image 11.png[m
[1mnew file mode 100644[m
[1mindex 0000000..2ac8892[m
Binary files /dev/null and b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/resources/image 11.png differ
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/AuthService.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/AuthService.java[m
[1mnew file mode 100644[m
[1mindex 0000000..87ef09a[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/AuthService.java[m
[36m@@ -0,0 +1,65 @@[m
[32m+[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.services;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.Factory;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.IProjectRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.IUserRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.ProjectArrayRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.infra.Messages;[m
[32m+[m[32m//import com.mycompany.gestionproyectosacademicos.presentacion.GUIAdmin;[m
[32m+[m[32m//import com.mycompany.gestionproyectosacademicos.presentacion.GUICompany;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.presentation.GUICoordinator;[m
[32m+[m[32m//import com.mycompany.gestionproyectosacademicos.presentacion.GUIStudent;[m
[32m+[m[32mimport javax.swing.JFrame;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Servicio de autenticación[m
[32m+[m[32m */[m
[32m+[m[32mpublic class AuthService {[m
[32m+[m[32m    private final IUserRepository userRepository;[m
[32m+[m[32m    //private final IProjectRepository projectRepository = Factory.getInstance().getRepository(IProjectRepository.class, "ARRAYS");[m
[32m+[m
[32m+[m[32m    public AuthService(IUserRepository userRepository) {[m
[32m+[m[32m        this.userRepository = userRepository;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public JFrame login(String email, String password) {[m
[32m+[m[32m        User user = userRepository.validarUsuario(email, password);[m
[32m+[m[32m        if (user == null) {[m
[32m+[m[32m            return null; // Manejar esto en la interfaz gráfica[m
[32m+[m[32m        }[m
[32m+[m[32m        return getGUIForRole(user);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    private JFrame getGUIForRole(User user) {[m
[32m+[m[32m        switch (user.getRole()) {[m
[32m+[m[32m            /*case "ADMIN":[m
[32m+[m[32m                return new GUIAdmin();[m
[32m+[m[32m            case "STUDENT":[m
[32m+[m[32m                return new GUIStudent();[m
[32m+[m[32m            */[m
[32m+[m[32m            /*case "COMPANY":[m
[32m+[m[32m                return new GUICompany();*/[m
[32m+[m[41m                   [m
[32m+[m[32m            case "COORDINATOR":[m
[32m+[m[32m                ICoordinatorRepository coordRepo = Factory.getInstance().getRepository(ICoordinatorRepository.class, "ARRAYS");[m
[32m+[m[32m                /*if(coordRepo != null) {[m
[32m+[m[32m                    Messages.showMessageDialog("Repositorio traido con la fábrica", "Atención");[m
[32m+[m[32m                }else{[m
[32m+[m[32m                    Messages.showMessageDialog("Repositorio no encontrado en AuthService", "Atención");[m
[32m+[m[32m                }*/[m
[32m+[m[32m                CoordinatorService coordService = new CoordinatorService(coordRepo);[m
[32m+[m[32m                /*if(coordService != null) {[m
[32m+[m[32m                    Messages.showMessageDialog("Servicio creado con el repositorio", "Atención");[m
[32m+[m[32m                }*/[m
[32m+[m[41m                [m
[32m+[m[32m                GUICoordinator instance = new GUICoordinator(coordService, user.getId());[m
[32m+[m[32m                instance.setExtendedState(JFrame.MAXIMIZED_BOTH);[m
[32m+[m[32m                return instance;[m
[32m+[m[32m            default:[m
[32m+[m[32m                return null;[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/CoordinatorService.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/CoordinatorService.java[m
[1mnew file mode 100644[m
[1mindex 0000000..1f1bd5e[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/CoordinatorService.java[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.services;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.ICoordinatorRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Coordinator;[m
[32m+[m
[32m+[m[32mpublic class CoordinatorService {[m
[32m+[m[32m    private final ICoordinatorRepository repository;[m
[32m+[m
[32m+[m[32m    public CoordinatorService(ICoordinatorRepository repository) {[m
[32m+[m[32m        this.repository = repository;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public Coordinator getCoordinator(int idCoordinator) {[m
[32m+[m[32m        return repository.getCoordinator(idCoordinator);[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/ProjectService.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/ProjectService.java[m
[1mnew file mode 100644[m
[1mindex 0000000..4485891[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/ProjectService.java[m
[36m@@ -0,0 +1,57 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.services;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.IProjectRepository;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObserver;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.observer.IObservable;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class ProjectService implements IObservable{[m
[32m+[m[32m    private IProjectRepository repository;[m
[32m+[m[32m    private List<Project> projects = new ArrayList<>();[m
[32m+[m[32m    private final List<IObserver> observers = new ArrayList<>();[m
[32m+[m[41m    [m
[32m+[m[32m    public ProjectService(IProjectRepository repository) {[m
[32m+[m[32m        this.repository = repository;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void addProject(Project project) {[m
[32m+[m[32m        repository.saveProject(project); // Agrega al repositorio[m
[32m+[m[32m        notifyObservers(); // Notifica a todos los observers que la lista cambió[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void deleteProject(int projectId) {[m
[32m+[m[32m        repository.deleteProject(projectId);[m
[32m+[m[32m        notifyObservers();[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public List<Project> getProjects(){[m
[32m+[m[32m        return projects;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Métodos de Observer[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void addObserver(IObserver observer) {[m
[32m+[m[32m        observers.add(observer);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void removeObserver(IObserver observer) {[m
[32m+[m[32m        observers.remove(observer);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void notifyObservers() {[m
[32m+[m[32m        List<Project> projects = repository.getProjectsByAcademicPeriod("2");[m
[32m+[m[32m        for (IObserver observer : observers) {[m
[32m+[m[32m            observer.update(projects); // Notificar a los observadores con la lista de proyectos[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/StudentServices.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/StudentServices.java[m
[1mnew file mode 100644[m
[1mindex 0000000..34ea3fe[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/StudentServices.java[m
[36m@@ -0,0 +1,9 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.services;[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class StudentServices {[m
[32m+[m[32m    //POR IMPLEMENTAR Y DECIDIR SI EL PAQUETE "SERVICES" SE MANTIENE O SE ELIMINA[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/UserServices.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/UserServices.java[m
[1mnew file mode 100644[m
[1mindex 0000000..886201a[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/services/UserServices.java[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.services;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.User;[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;[m
[32m+[m
[32m+[m[32mpublic class UserServices {[m
[32m+[m[32m    private UserArrayRepository userRepository;[m
[32m+[m
[32m+[m[32m    public UserServices() {[m
[32m+[m[32m        this.userRepository = new UserArrayRepository(); // Usando repositorio en memoria[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public boolean autenticarUsuario(String email, String password) {[m
[32m+[m[32m        User user = userRepository.validarUsuario(email, password);[m
[32m+[m[32m        return user != null;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Accepted.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Accepted.java[m
[1mnew file mode 100644[m
[1mindex 0000000..7b41e4e[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Accepted.java[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class Accepted {[m
[32m+[m[32m    public void manageState(Project project) {[m
[32m+[m[32m        project.setState(getStateName());[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getStateName() {[m
[32m+[m[32m        return "aceptado";[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Closed.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Closed.java[m
[1mnew file mode 100644[m
[1mindex 0000000..93558b8[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Closed.java[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m
[32m+[m[32mpublic class Closed implements ProjectState{[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void ManageState(Project project) {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public String getStateName() {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/InProgress.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/InProgress.java[m
[1mnew file mode 100644[m
[1mindex 0000000..3608b56[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/InProgress.java[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m
[32m+[m[32mpublic class InProgress implements ProjectState{[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public void ManageState(Project project) {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public String getStateName() {[m
[32m+[m[32m        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/ProjectState.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/ProjectState.java[m
[1mnew file mode 100644[m
[1mindex 0000000..a65dd1f[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/ProjectState.java[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m
[32m+[m[32mpublic interface ProjectState {[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Cambia el estado del proyecto a otro estado válido.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @param project Proyecto al cual se le cambiará el estado.[m
[32m+[m[32m     */[m
[32m+[m[32m    void ManageState(Project project);[m
[32m+[m[41m    [m
[32m+[m[32m    /**[m
[32m+[m[32m     * @brief Devuelve el nombre del estado.[m
[32m+[m[32m     *[m[41m [m
[32m+[m[32m     * @return Nombre del estado.[m
[32m+[m[32m     */[m
[32m+[m[32m    String getStateName();[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Received.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Received.java[m
[1mnew file mode 100644[m
[1mindex 0000000..0b79c80[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Received.java[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class Received {[m
[32m+[m[32m    public void manageState(Project project) {[m
[32m+[m[32m        project.setState(getStateName());[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getStateName() {[m
[32m+[m[32m        return "recibido";[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Rejected.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Rejected.java[m
[1mnew file mode 100644[m
[1mindex 0000000..55c80a0[m
[1m--- /dev/null[m
[1m+++ b/GestionProyectosAcademicos/src/main/java/com/mycompany/gestionproyectosacademicos/state/Rejected.java[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32mpackage com.mycompany.gestionproyectosacademicos.state;[m
[32m+[m
[32m+[m[32mimport com.mycompany.gestionproyectosacademicos.entities.Project;[m
[32m+[m[32m/**[m
[32m+[m[32m *[m
[32m+[m[32m * @author Jhonatan[m
[32m+[m[32m */[m
[32m+[m[32mpublic class Rejected {[m
[32m+[m[32m    public void manageState(Project project) {[m
[32m+[m[32m        project.setState(getStateName());[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getStateName() {[m
[32m+[m[32m        return "rechazado";[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/GestionProyectosAcademicos/src/main/java/com/mycompany/projects/domain/entities/GestionProyectosAcademicos.java b/GestionProyectosAcademicos/src/main/java/com/mycompany/projects/domain/entities/GestionProyectosAcademicos.java[m
[1mdeleted file mode 100644[m
[1mindex 22f3960..0000000[m
[1m--- a/GestionProyectosAcademicos/src/main/java/com/mycompany/projects/domain/entities/GestionProyectosAcademicos.java[m
[1m+++ /dev/null[m
[36m@@ -1,16 +0,0 @@[m
[31m-/*[m
[31m- * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license[m
[31m- */[m
[31m-[m
[31m-package com.mycompany.projects.domain.entities;[m
[31m-[m
[31m-/**[m
[31m- *[m
[31m- * @author bryan[m
[31m- */[m
[31m-public class GestionProyectosAcademicos {[m
[31m-[m
[31m-    public static void main(String[] args) {[m
[31m-        System.out.println("Hello World!");[m
[31m-    }[m
[31m-}[m
