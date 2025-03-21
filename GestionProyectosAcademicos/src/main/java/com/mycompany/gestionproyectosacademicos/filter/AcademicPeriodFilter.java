package com.mycompany.gestionproyectosacademicos.filter;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class AcademicPeriodFilter implements IFilter {

    @Override
    public List<Project> filter(List<Project> projects, String academicPeriod) {
        List<Project> filteredProjects = new ArrayList<>();
        for (Project project : projects) {
            if (project.getAcademicPeriod().equalsIgnoreCase(academicPeriod)) {
                filteredProjects.add(project);
            }
        }
        return filteredProjects;
    }
    
}
