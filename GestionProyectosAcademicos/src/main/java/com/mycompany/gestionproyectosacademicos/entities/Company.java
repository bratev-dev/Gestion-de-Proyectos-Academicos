/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author bryan
 */
public class Company {
    private String name;
    private String nit;
    private String sector;
    private String contact;
    
    public Company(String name, String nit, String sector, String contact){
        this.name = name;
        this.nit = nit;
        this.sector = sector;
        this.contact = contact;
    }
    
    //Getters
    public String getName(){
        return name;
    }
    
    public String getNit(){
        return nit;
    }
    
    public String getSector(){
        return sector;
    }
    
    public String getContact(){
        return contact;
    }
}
