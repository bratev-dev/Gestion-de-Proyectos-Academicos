/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.main;

import com.mycompany.gestionproyectosacademicos.presentacion.GUICoordinatorProfile;
import javax.swing.JFrame;

/**
 *
 * @author bryan
 */
public class Main {
    public static void main(String[] args) {
        /*Example: ICompanyRepository repository = Factory.getInstance().getRepository("ARRAYS");// Podria ir SQLITE*/ 
        /*Inicializar servicio: (Example: CompanyService service = new CompanyService(repository);)*/

        /*Creación de instancia de menú principal: (Example: GUIMenu instance = new GUIMenu(service);)*/
        /*
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
        */

        GUICoordinatorProfile instance = new GUICoordinatorProfile();
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
    }
}
