package com.mycompany.gestionproyectosacademicos.entities;

public class Company {
    private String name;
    private Long nit;
    private String email;
    private String sector;
    private String contactNames;
    private String contactLastNames;
    private String contactPhoneNumber;
    private String contactPosition;
    private String password;
    
    public Company(String name, Long nit, String email, String sector, String contactNames,
        String contactLastNames, String contactPhoneNumber, String contactPosition, String password){
        this.name = name;
        this.nit = nit;
        this.email = email;
        this.sector = sector;
        this.contactNames = contactNames;
        this.contactLastNames = contactLastNames;
        this.contactPhoneNumber = contactPhoneNumber;
        this.contactPosition = contactPosition;
        this.password=password;
    }

    public Company() {
    }
    
    
    
    //Getters
    public String getName(){
        return name;
    }

    public Long getNit() {
        return nit;
    }

    public void setNit(Long nit) {
        this.nit = nit;
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
     * @return the contactNames
     */
    public String getContactNames() {
        return contactNames;
    }

    /**
     * @param contactNames the contactNames to set
     */
    public void setContactNames(String contactNames) {
        this.contactNames = contactNames;
    }

    /**
     * @return the contactLastNames
     */
    public String getContactLastNames() {
        return contactLastNames;
    }

    /**
     * @param contactLastNames the contactLastNames to set
     */
    public void setContactLastNames(String contactLastNames) {
        this.contactLastNames = contactLastNames;
    }

    /**
     * @return the contactPhoneNumber
     */
    public String getContactPhoneNumber() {
        return contactPhoneNumber;
    }

    /**
     * @param contactPhoneNumber the contactPhoneNumber to set
     */
    public void setContactPhoneNumber(String contactPhoneNumber) {
        this.contactPhoneNumber = contactPhoneNumber;
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

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
}
