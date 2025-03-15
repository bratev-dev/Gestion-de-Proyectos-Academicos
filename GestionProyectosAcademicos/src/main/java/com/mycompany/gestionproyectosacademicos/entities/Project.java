package com.mycompany.gestionproyectosacademicos.entities;

import com.mycompany.gestionproyectosacademicos.observer.Observer;
import com.mycompany.gestionproyectosacademicos.state.ProjectState;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author bryan
 */
public class Project {
    
    private int id;
    private String name;
    private String description;
    private String state;
    private int calificacion;
    private Request request;
    private Company company;
    private Student[] students;
    private List<Observer> observers = new ArrayList<>();
    
    public Project(int id, String name, String description, String state, int calificacion, Request request, Company company, Student[] students) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.state = state;
        this.calificacion = calificacion;
        this.request = request;
        this.company = company;
        this.students = students;
    }
}
