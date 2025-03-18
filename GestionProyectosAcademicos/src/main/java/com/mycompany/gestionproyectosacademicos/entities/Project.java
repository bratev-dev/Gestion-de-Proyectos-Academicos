package com.mycompany.gestionproyectosacademicos.entities;

import com.mycompany.gestionproyectosacademicos.state.ProjectState;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.mycompany.gestionproyectosacademicos.observer.IObserver;
/**
 *
 * @author bryan
 */
public class Project {
    
    private int id;
    private String name;
    private String description;
    private String state;
    private LocalDate date;
    private int calificacion;
    private Request request;
    private Company company;
    private Student[] students;
    private List<IObserver> observers = new ArrayList<>();
    
    public Project(int id, String name, String description, String state, LocalDate date, int calificacion, Request request, Company company, Student[] students) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.state = state;
        this.date = date;
        this.calificacion = calificacion;
        this.request = request;
        this.company = company;
        this.students = students;
    }
    
    public int getId(){
        return id;
    }
    
    public String getDescription(){
        return description;
    }
   
    public String getName(){
        return name;
    }

    public String getState() {
        return state;
    }
    
    public Company getCompany() {
        return company;
    }

    public void setState(String state) {
        this.state = state;
    }

    
    public void addObserver(IObserver observer){
        observers.add(observer);
    }
    
    public void notifyObservers(){
        for(IObserver observer : observers){
            observer.update(this);
        }
    }
    
    public void changeState(ProjectState state){
        state.ManageState(this);
        notifyObservers();
    }
    
}
