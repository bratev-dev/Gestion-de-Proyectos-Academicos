package com.mycompany.gestionproyectosacademicos.entities;

import com.mycompany.gestionproyectosacademicos.state.ProjectState;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.mycompany.gestionproyectosacademicos.observer.IObserver;
import java.math.BigDecimal;
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
    private String request;
    private Company company;
    private Student[] students;
    private String summary;
    private String objetives;
    private String maxTime;
    
    private List<IObserver> observers = new ArrayList<>();

    public Project(int id, String name, String description, String state, LocalDate date, int calificacion, String request, Company company, Student[] students, String summary, String objetives, String maxTime) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.state = state;
        this.date = date;
        this.calificacion = calificacion;
        this.request = request;
        this.company = company;
        this.students = students;
        this.summary = summary;
        this.objetives = objetives;
        this.maxTime = maxTime;
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

    public String getSummary() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public String getObjectives() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getMaxTime() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public BigDecimal getBudget() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public String getDate() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
