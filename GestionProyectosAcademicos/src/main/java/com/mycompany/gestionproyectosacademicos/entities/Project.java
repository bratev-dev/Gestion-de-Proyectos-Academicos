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
    private int qualification;
    private Request request;
    private Company company;
    private Student[] students;
    private List<Observer> observadores = new ArrayList<>();
}
