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
    private int nit;
    private String email;
    private String sector;
    private String contactName;
    private String contactLastName;
    private String contactNumber;
    private String contactPosition;
    
    public Company(String name, int nit, String email, String sector, String contactName,
            String contactLastName, String contactNumber, String contactPosition){
    
        this.name = name;
        this.nit = nit;
        this.email = email;
        this.sector = sector;
        this.contactName = contactName;
        this.contactLastName = contactLastName;
        this.contactNumber = contactNumber;
        this.contactPosition = contactPosition;
    }

    public Company() {
    }
    
    //Getters
    public String getName(){
        return name;
    }
    
    public int getNit(){
        return nit;
    }
    
    public String getSector(){
        return sector;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @param nit the nit to set
     */
    public void setNit(int nit) {
        this.nit = nit;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @param sector the sector to set
     */
    public void setSector(String sector) {
        this.sector = sector;
    }

    /**
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * @return the contactLastName
     */
    public String getContactLastName() {
        return contactLastName;
    }

    /**
     * @param contactLastName the contactLastName to set
     */
    public void setContactLastName(String contactLastName) {
        this.contactLastName = contactLastName;
    }

    /**
     * @return the contactNumber
     */
    public String getContactNumber() {
        return contactNumber;
    }

    /**
     * @param contactNumber the contactNumber to set
     */
    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    /**
     * @return the contactPosition
     */
    public String getContactPosition() {
        return contactPosition;
    }

    /**
     * @param contactPosition the contactPosition to set
     */
    public void setContactPosition(String contactPosition) {
        this.contactPosition = contactPosition;
    }
    
    
}
