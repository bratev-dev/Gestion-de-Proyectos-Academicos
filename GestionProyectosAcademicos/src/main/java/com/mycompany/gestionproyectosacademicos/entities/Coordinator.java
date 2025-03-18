package com.mycompany.gestionproyectosacademicos.entities;

public class Coordinator {
    private int id;
    private String name;

    public Coordinator(int id, String name) {
        this.id = id;
        this.name = name;
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
    
    
    /*public void reviewRequest(Request req){
        
    }*/
    
    /*public void assingProject(Project pro, Student stu){
        
    }*/
    
    /*public void projectTrack(Project pro){
        
    }*/
    
}
