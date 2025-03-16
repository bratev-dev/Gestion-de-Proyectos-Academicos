
package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author Jhonatan
 */
public class Student {
   
    private int id;
    private String name;
    private String semester;
    private String skills;
    
    public Student(int id, String name, String semester, String skills){
        this. id = id;
        this.name = name;
        this.semester = semester;
        this.skills = skills;
    }
    
    //Getters y Setters
    public int getId(){
        return id;
    }
    public void setId(int p_id){
        this.id = p_id;
    }
    
    public String getName(){
        return name;
    }
    public void setName(String p_name){
        this.name = p_name;
    }
    
    public String getSemester(){
        return semester;
    }
    public void setSemester(String p_semester){
        this.semester = p_semester;
    }
    
    public String getSkills(){
        return skills;
    }
    public void setSkills(String p_skills){
        this.skills = p_skills;
    }
    
}
