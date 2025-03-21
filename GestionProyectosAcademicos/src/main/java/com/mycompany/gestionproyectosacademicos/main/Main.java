package com.mycompany.gestionproyectosacademicos.main;

import com.mycompany.gestionproyectosacademicos.presentation.GUIStudentProjectList;

import javax.swing.JFrame;

public class Main {
    public static void main(String[] args) {
        /*Example: ICompanyRepository repository = Factory.getInstance().getRepository("ARRAYS");// Podria ir SQLITE*/ 
        /*Inicializar servicio: (Example: CompanyService service = new CompanyService(repository);)*/

        /*Creación de instancia de menú principal: (Example: GUIMenu instance = new GUIMenu(service);)*/
        /*
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
        */
      
        GUIStudentProjectList instance = new GUIStudentProjectList();
        instance.setExtendedState(JFrame.MAXIMIZED_BOTH);
        instance.setVisible(true);
        
        
        
    }
}
