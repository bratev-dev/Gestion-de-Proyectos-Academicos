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
    private ProjectState state;
    private int calificacion;
    private Request request;
    private Company company;
    private Student[] students;
    private List<Observer> observers = new ArrayList<>();
    
    public Project(){
        
    }
    
    public Project(int id, String name, String description, ProjectState state, Company company) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.state = state;
        this.company = company;
    }
    
    public int getId(){
        return id;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    public String getDescription(){
        return description;
    }
    
    public void setDescription(String des){
        this.description = des;
    }
    
    public ProjectState getState(){
        return state;
    }
    
    public void setState(ProjectState state){
        this.state = state;
    }
   
    public String getName(){
        return name;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public Company getCompany(){
        return company;
    }
    
    public void setCompany(Company company){
        this.company = company;
    }
    
    public void addObserver(Observer observer){
        observers.add(observer);
    }
    
    public void notifyObservers(){
        for(Observer observer : observers){
            observer.update(this);
        }
    }
    
    public void changeState(ProjectState state){
        this.state = state;
        notifyObservers();
    }
    
}
