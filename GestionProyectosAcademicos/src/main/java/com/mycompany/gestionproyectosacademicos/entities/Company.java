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
    
    private int companyNIT;
    private String companyName;
    private String companyEmail;
    private String companySector;
    private String contactName;
    private String contactLastName;
    private int contactNumber;
    private String contactPosition;
    
    public Company (int companyNIT, String companyName, String companyEmail,
             String companySector,String contactName,String contactLastName,
            int contactNumber,String contactPosition){
         
        this.companyNIT = companyNIT;
        this.companyName= companyName;
        this.companyEmail = companyEmail;
        this.companySector = companySector;
        this.contactName = contactName;
        this.contactLastName = contactLastName;
        this.contactNumber = contactNumber;
        this.contactPosition = contactPosition;
       
    }

    /**
     * @return the companyNIT
     */
    public int getCompanyNIT() {
        return companyNIT;
    }

    /**
     * @param companyNIT the companyNIT to set
     */
    public void setCompanyNIT(int companyNIT) {
        this.companyNIT = companyNIT;
    }

    /**
     * @return the companyName
     */
    public String getCompanyName() {
        return companyName;
    }

    /**
     * @param companyName the companyName to set
     */
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    /**
     * @return the companyEmail
     */
    public String getCompanyEmail() {
        return companyEmail;
    }

    /**
     * @param companyEmail the companyEmail to set
     */
    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    /**
     * @return the companySector
     */
    public String getCompanySector() {
        return companySector;
    }

    /**
     * @param companySector the companySector to set
     */
    public void setCompanySector(String companySector) {
        this.companySector = companySector;
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
    public int getContactNumber() {
        return contactNumber;
    }

    /**
     * @param contactNumber the contactNumber to set
     */
    public void setContactNumber(int contactNumber) {
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
