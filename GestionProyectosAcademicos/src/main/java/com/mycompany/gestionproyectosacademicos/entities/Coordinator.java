package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author bratev
 */
public class Coordinator {
    private String id;
    private String name;

    public Coordinator(String nit, String name) {
        this.id = id;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
    public void reviewRequest(Request req){
        
    }
    
    public void assingProject(Project pro, Student stu){
        
    }
    
    public void projectTrack(Project pro){
        
    }
    
}
