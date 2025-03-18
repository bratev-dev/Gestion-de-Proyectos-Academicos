package com.mycompany.gestionproyectosacademicos.entities;

/**
 *
 * @author Jhonatan
 */

/*
Esta clase fue creada teniendo en cuanta el diagrama
de clases de entidades dominio(Draw.io)
*/
public class Request {
    private int requestId;
    private String requestDetails ;
    
    public Request(int id, String details){
        this.requestId = id;
        this.requestDetails = details;
    }

    public Request() {
    }
    
    public int getId(){
        return requestId;
    }
    
    public void setId(int id){
        this.requestId = id;
    }
    
    public String getDetails(){
        return requestDetails;
    }
    
    public void setId(String details){
        this.requestDetails = details;
    }
}
