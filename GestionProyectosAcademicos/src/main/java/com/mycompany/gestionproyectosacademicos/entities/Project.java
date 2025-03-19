package com.mycompany.gestionproyectosacademicos.entities;

import com.mycompany.gestionproyectosacademicos.state.ProjectState;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.mycompany.gestionproyectosacademicos.observer.IObserver;

public class Project {
    
    private int id;
    private String name;
    private String summary;
    private String goals;
    private String description;
    private String maxTimeInMonths;
    private String budget;
    private String date;
    private String state;
    private Company company;
    private List<IObserver> observers = new ArrayList<>();

    public Project(int id, String name, String summary, String goals, String description, String maxTimeInMonths, String budget, String date, String state, Company company) {
        this.id = id;
        this.name = name;
        this.summary = summary;
        this.goals = goals;
        this.description = description;
        this.maxTimeInMonths = maxTimeInMonths;
        this.budget = budget;
        this.date = date;
        this.state = state;
        this.company = company;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getGoals() {
        return goals;
    }

    public void setGoals(String goals) {
        this.goals = goals;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMaxTimeInMonths() {
        return maxTimeInMonths;
    }

    public void setMaxTimeInMonths(String maxTimeInMonths) {
        this.maxTimeInMonths = maxTimeInMonths;
    }

    public String getBudget() {
        return budget;
    }

    public void setBudget(String budget) {
        this.budget = budget;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<IObserver> getObservers() {
        return observers;
    }

    public void setObservers(List<IObserver> observers) {
        this.observers = observers;
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
