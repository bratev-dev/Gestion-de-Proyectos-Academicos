package com.mycompany.gestionproyectosacademicos.observer;

import com.mycompany.gestionproyectosacademicos.entities.Coordinator;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.services.ProjectService;
import java.util.List;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class projectsCoordinatorObserver extends JFrame implements IObserver{
    private final JScrollPane jScrollPane1;
    private final JTable tableProjects;
    private final Coordinator coordinator;
    private final ProjectService projectService;
    
    
    public projectsCoordinatorObserver(Coordinator coordinator, ProjectService projectService, JTable tableProjects, JScrollPane jScrollPane1) {
        this.coordinator = coordinator;
        this.tableProjects = tableProjects;
        this.projectService = projectService;
        this.jScrollPane1 = jScrollPane1;
    }
    
    @Override
    public void update(Object o) {
        // Obtener los proyectos actualizados
        List<Project> projects = projectService.getProjects();
        ProjectService projectService = (ProjectService) o;
        
        // Crear modelo de tabla
        DefaultTableModel model = new DefaultTableModel(new String[]{"Proyecto", "Empresa", "Opciones"}, 0);
        
        for(Project project : projects) {
            model.addRow(new Object[]{project.getName(), project.getCompany().getName(), "Ver más"});
        }
        
        tableProjects.setModel(model);
    }
    
    
}
