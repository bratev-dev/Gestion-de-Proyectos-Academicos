package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.IProjectRepository;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class ProjectServiceTest {

    @Mock
    private IProjectRepository projectRepository;

    private ProjectService projectService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Inicializa los mocks
        projectService = new ProjectService(projectRepository); // Inyecta el mock
    }

    @Test
    void testAddProject() {
        // Configuración del mock
        Project project = new Project(1, "Project Alpha", "Summary", "Goals", 
                                      "Description", "12", "100000", "2023-10-01", "ACTIVE", null);

        doNothing().when(projectRepository).saveProject(project); // Simula guardado exitoso

        // Ejecución del método
        projectService.addProject(project);

        // Verificaciones
        verify(projectRepository, times(1)).saveProject(project);
    }

    @Test
    void testDeleteProject() {
        // Configuración del mock
        doNothing().when(projectRepository).deleteProject(1); // Simula eliminación exitosa

        // Ejecución del método
        projectService.deleteProject(1);

        // Verificaciones
        verify(projectRepository, times(1)).deleteProject(1);
    }

    @Test
    void testGetProjects() {
        // Configuración del mock
        when(projectRepository.getAllProjects()).thenReturn(List.of(
            new Project(1, "Project Alpha", "Summary", "Goals", "Description", "12", "100000", "2023-10-01", "ACTIVE", null),
            new Project(2, "Project Beta", "Summary", "Goals", "Description", "24", "200000", "2024-01-01", "PENDING", null)
        ));

        // Ejecución del método
        List<Project> projects = projectService.getProjects();

        // Verificaciones
        assertNotNull(projects);
        assertEquals(2, projects.size());
        verify(projectRepository, times(1)).getAllProjects();
    }
}