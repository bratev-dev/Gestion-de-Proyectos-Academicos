package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author bryan
 */
public class Company {
    private String name;
    private int nit;
    private String sector;
    private String contact;
    
    public Company(){
        
    }
    
    public Company(String name, int nit, String sector, String contact){
        this.name = name;
        this.nit = nit;
        this.sector = sector;
        this.contact = contact;
    }
    
    //Getters
    public String getName(){
        return name;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public int getNit(){
        return nit;
    }
    
    public void setNit(int nit){
        this.nit = nit;
    }
    
    public String getSector(){
        return sector;
    }
    
    public void setSector(String sec){
        this.sector = sec;
    }
    
    public String getContact(){
        return contact;
    }
    
    public void setContact(String cont){
        this.contact = cont;
    }
}
