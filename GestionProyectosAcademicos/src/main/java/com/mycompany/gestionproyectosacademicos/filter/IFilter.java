package com.mycompany.gestionproyectosacademicos.filter;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.util.List;

public interface IFilter {
    List<Project> filter(List<Project> projects, String criter);
}
