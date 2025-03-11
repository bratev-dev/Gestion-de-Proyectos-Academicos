
package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author Jhonatan
 */
public class Student {
   
    private int id;
    private String nombre;
    private String semestre;
    private String habilidades;
    
    public Student(int id, String nombre, String semestre, String habilidades){
        this. id = id;
        this.nombre = nombre;
        this.semestre = semestre;
        this.habilidades = habilidades;
    }
    
    //Getters y Setters
    public int getId(){
        return id;
    }
    public void setId(int p_id){
        this.id = p_id;
    }
    
    public String getNombre(){
        return nombre;
    }
    public void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    
    public String getSemestre(){
        return semestre;
    }
    public void setSemestre(String p_semestre){
        this.semestre = p_semestre;
    }
    
    public String getHabilidades(){
        return habilidades;
    }
    public void setHabilidades(String p_habilidades){
        this.habilidades = p_habilidades;
    }
    
}
