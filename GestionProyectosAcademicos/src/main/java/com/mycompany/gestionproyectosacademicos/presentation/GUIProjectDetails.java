package com.mycompany.gestionproyectosacademicos.presentation;

import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.CompanyService;
import com.mycompany.gestionproyectosacademicos.services.UserServices;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
/**
 *
 * @author Jhonatan
 */
public class GUIProjectDetails extends javax.swing.JFrame {

    private Project project;
    
    public GUIProjectDetails() {
        this(null); // Constructor por defecto
    }
    
    /**
     * Constructor que inicializa la ventana con un proyecto específico.
     * @param project El proyecto a mostrar
     */
    public GUIProjectDetails(Project project) {
        this.project = project;
        initComponents();
        setLocationRelativeTo(null);
        if (project != null) {
            loadProjectData();
        }
    }
    
    
    //Personalizacion de los botones del sidebar.
    private void customizeButton(JButton button, String text, boolean isLogout) {
        button.setText(text);
        button.setFont(new Font("Arial", Font.PLAIN, 14));
        button.setForeground(Color.WHITE);
        button.setBackground(isLogout ? new Color(98, 114, 129) : new Color(19, 45, 70));
        button.setBorderPainted(false);
        button.setFocusPainted(false);
        button.setHorizontalAlignment(SwingConstants.LEFT);
        button.setOpaque(true);
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        
        if (isLogout) {
            button.setPreferredSize(new Dimension(150, 40));
        } else {
            button.setPreferredSize(new Dimension(200, 40));
        }
        
        // Añadir borde para simular botones
        button.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createEmptyBorder(5, 10, 5, 10),
            BorderFactory.createMatteBorder(0, 0, 1, 0, new Color(98, 114, 129))
        ));
    }
    
    //Carga datos del proyecto en la interfaz.
    private void loadProjectData() {
        SwingUtilities.invokeLater(() -> {
            JPanel contentPanel = new JPanel(new BorderLayout(20, 20));
            contentPanel.setBackground(Color.WHITE);

            // Configurar el título del proyecto
            JLabel projectTitle = new JLabel(project.getName(), SwingConstants.CENTER);
            projectTitle.setFont(new Font("Arial", Font.BOLD, 24));
            projectTitle.setForeground(new Color(19, 45, 70));

            // Panel de información de la empresa
            JPanel companyPanel = new JPanel(new BorderLayout(10, 10));
            companyPanel.setBackground(Color.WHITE);

            JLabel companyLabel = new JLabel("Nombre Empresa");
            companyLabel.setFont(new Font("Arial", Font.BOLD, 16));

            JTextArea companyDetails = new JTextArea(project.getCompany().getName());
            companyDetails.setEditable(false);
            companyDetails.setLineWrap(true);
            companyDetails.setWrapStyleWord(true);
            companyDetails.setBackground(new Color(236, 236, 236));
            companyDetails.setBorder(BorderFactory.createEmptyBorder(5, 10, 5, 10));
            companyDetails.setPreferredSize(new Dimension(100, 20));

            JLabel companyDetailsLabel = new JLabel("Detalles Empresa");
            companyDetailsLabel.setFont(new Font("Arial", Font.BOLD, 16));

            JTextArea companyDescription = new JTextArea(8, 30);
            companyDescription.setText(project.getDescription());
            companyDescription.setEditable(false);
            companyDescription.setLineWrap(true);
            companyDescription.setWrapStyleWord(true);
            companyDescription.setBackground(new Color(236, 236, 236));
            companyDescription.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
            companyDescription.setPreferredSize(new Dimension(250, 150));

            JScrollPane companyScroll = new JScrollPane(companyDescription);
            companyScroll.setBorder(BorderFactory.createEmptyBorder());

            companyPanel.add(companyLabel, BorderLayout.NORTH);
            companyPanel.add(companyDetails, BorderLayout.CENTER);
            companyPanel.add(companyDetailsLabel, BorderLayout.SOUTH);
            companyPanel.add(companyScroll, BorderLayout.AFTER_LAST_LINE); 

            // Panel de detalles del proyecto
            JPanel projectPanel = new JPanel(new BorderLayout(10, 10));
            projectPanel.setBackground(Color.WHITE);

            JLabel projectDetailsLabel = new JLabel("Detalles Proyecto");
            projectDetailsLabel.setFont(new Font("Arial", Font.BOLD, 16));

            JTextArea projectDescription = new JTextArea(8, 30);
            projectDescription.setText(project.getDescription());
            projectDescription.setEditable(false);
            projectDescription.setLineWrap(true);
            projectDescription.setWrapStyleWord(true);
            projectDescription.setBackground(new Color(236, 236, 236));
            projectDescription.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
            projectDescription.setPreferredSize(new Dimension(250, 100));

            JScrollPane projectScroll = new JScrollPane(projectDescription);
            projectScroll.setBorder(BorderFactory.createEmptyBorder());

            projectPanel.add(projectDetailsLabel, BorderLayout.NORTH);
            projectPanel.add(projectScroll, BorderLayout.CENTER);

            // Panel de botones
            JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 0));
            buttonPanel.setBackground(Color.WHITE);
            
            JButton btnPostulate = new JButton("Postularse");
            btnPostulate.setFont(new Font("Arial", Font.BOLD, 14));
            btnPostulate.setForeground(Color.WHITE);
            btnPostulate.setBackground(new Color(176, 84, 58));
            btnPostulate.setBorderPainted(false);
            btnPostulate.setFocusPainted(false);
            btnPostulate.setCursor(new Cursor(Cursor.HAND_CURSOR));
            btnPostulate.setPreferredSize(new Dimension(120, 40));
            btnPostulate.addActionListener(this::btnPostulateActionPerformed);
            
            JButton btnBack = new JButton("Atrás");
            btnBack.setFont(new Font("Arial", Font.BOLD, 14));
            btnBack.setForeground(Color.WHITE);
            btnBack.setBackground(new Color(19, 45, 70));
            btnBack.setBorderPainted(false);
            btnBack.setFocusPainted(false);
            btnBack.setCursor(new Cursor(Cursor.HAND_CURSOR));
            btnBack.setPreferredSize(new Dimension(120, 40));
            btnBack.addActionListener(this::btnBackActionPerformed);
            
            buttonPanel.add(btnPostulate);
            buttonPanel.add(btnBack);
            
            // Panel para organizar los dos paneles de información
            JPanel infoPanel = new JPanel(new GridLayout(1, 2, 20, 0));
            infoPanel.setBackground(Color.WHITE);
            infoPanel.add(companyPanel);
            infoPanel.add(projectPanel);
            
            // Agregar todos los componentes al panel principal
            contentPanel.add(projectTitle, BorderLayout.NORTH);
            contentPanel.add(infoPanel, BorderLayout.CENTER);
            contentPanel.add(buttonPanel, BorderLayout.SOUTH);
            
            // Configurar el panel principal en la ventana
            jPanelProjectList.removeAll();
            jPanelProjectList.setLayout(new BorderLayout());
            jPanelProjectList.add(contentPanel, BorderLayout.CENTER);
            jPanelProjectList.revalidate();
            jPanelProjectList.repaint();
        });
    }
    
    //Método que se invoca cuando se presiona el botón Postularse.
    private void btnPostulateActionPerformed(ActionEvent evt) {
        JOptionPane.showMessageDialog(this, 
            "Postulación enviada con éxito", 
            "Postulación", 
            JOptionPane.INFORMATION_MESSAGE);
    }
    
    //Método que se invoca cuando se presiona el botón Atrás.
    private void btnBackActionPerformed(ActionEvent evt) {
        dispose();
        new GUIStudentProjectList().setVisible(true);
    }


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanelDashboard = new javax.swing.JPanel();
        sepUserCoord = new javax.swing.JSeparator();
        lblUser = new javax.swing.JLabel();
        lblEstudiante = new javax.swing.JLabel();
        btnProfileStudent = new javax.swing.JButton();
        btnProjectList = new javax.swing.JButton();
        btnMyProjects = new javax.swing.JButton();
        btnCloseSessionStudent = new javax.swing.JButton();
        jPanelProjectList = new javax.swing.JPanel();
        lblTitleProjectList = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanelDashboard.setBackground(new java.awt.Color(19, 45, 70));

        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));

        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        lblUser.setForeground(new java.awt.Color(255, 255, 255));
        lblUser.setText("Usuario");

        lblEstudiante.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblEstudiante.setForeground(new java.awt.Color(255, 255, 255));
        lblEstudiante.setText("Estudiante");

        btnProfileStudent.setBackground(new java.awt.Color(98, 114, 129));
        btnProfileStudent.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnProfileStudent.setForeground(new java.awt.Color(255, 255, 255));
        btnProfileStudent.setLabel("Perfil");
        btnProfileStudent.setMaximumSize(new java.awt.Dimension(28, 17));
        btnProfileStudent.setMinimumSize(new java.awt.Dimension(28, 17));
        btnProfileStudent.setPreferredSize(new java.awt.Dimension(28, 17));

        btnProjectList.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnProjectList.setForeground(new java.awt.Color(19, 45, 70));
        btnProjectList.setLabel("Proyectos Disponibles");
        btnProjectList.setMaximumSize(new java.awt.Dimension(28, 17));
        btnProjectList.setMinimumSize(new java.awt.Dimension(28, 17));
        btnProjectList.setPreferredSize(new java.awt.Dimension(28, 17));

        btnMyProjects.setBackground(new java.awt.Color(98, 114, 129));
        btnMyProjects.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnMyProjects.setForeground(new java.awt.Color(255, 255, 255));
        btnMyProjects.setLabel("Mis Proyectos");
        btnMyProjects.setMaximumSize(new java.awt.Dimension(28, 17));
        btnMyProjects.setMinimumSize(new java.awt.Dimension(28, 17));
        btnMyProjects.setPreferredSize(new java.awt.Dimension(28, 17));

        btnCloseSessionStudent.setBackground(new java.awt.Color(98, 114, 129));
        btnCloseSessionStudent.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnCloseSessionStudent.setForeground(new java.awt.Color(255, 255, 255));
        btnCloseSessionStudent.setLabel("Cerrar Sesíon");
        btnCloseSessionStudent.setMaximumSize(new java.awt.Dimension(75, 19));
        btnCloseSessionStudent.setMinimumSize(new java.awt.Dimension(75, 19));
        btnCloseSessionStudent.setPreferredSize(new java.awt.Dimension(75, 19));
        btnCloseSessionStudent.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCloseSessionStudentActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanelDashboardLayout = new javax.swing.GroupLayout(jPanelDashboard);
        jPanelDashboard.setLayout(jPanelDashboardLayout);
        jPanelDashboardLayout.setHorizontalGroup(
            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanelDashboardLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnProfileStudent, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnMyProjects, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
            .addGroup(jPanelDashboardLayout.createSequentialGroup()
                .addGap(107, 107, 107)
                .addComponent(lblEstudiante)
                .addGap(0, 0, Short.MAX_VALUE))
            .addGroup(jPanelDashboardLayout.createSequentialGroup()
                .addGap(90, 90, 90)
                .addGroup(jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblUser)
                    .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 119, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(86, Short.MAX_VALUE))
        );
        jPanelDashboardLayout.setVerticalGroup(
            jPanelDashboardLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanelDashboardLayout.createSequentialGroup()
                .addGap(18, 18, 18)
                .addComponent(lblUser)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblEstudiante)
                .addGap(56, 56, 56)
                .addComponent(btnProfileStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(29, 29, 29)
                .addComponent(btnProjectList, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(29, 29, 29)
                .addComponent(btnMyProjects, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(58, 58, 58)
                .addComponent(btnCloseSessionStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(78, Short.MAX_VALUE))
        );

        lblTitleProjectList.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        lblTitleProjectList.setForeground(new java.awt.Color(19, 45, 70));
        lblTitleProjectList.setText("Detalles De Proyecto");

        javax.swing.GroupLayout jPanelProjectListLayout = new javax.swing.GroupLayout(jPanelProjectList);
        jPanelProjectList.setLayout(jPanelProjectListLayout);
        jPanelProjectListLayout.setHorizontalGroup(
            jPanelProjectListLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanelProjectListLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblTitleProjectList)
                .addContainerGap(380, Short.MAX_VALUE))
        );
        jPanelProjectListLayout.setVerticalGroup(
            jPanelProjectListLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanelProjectListLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(lblTitleProjectList)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanelDashboard, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanelDashboard, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnCloseSessionStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionStudentActionPerformed
        IUserRepository userRepo = Factory.getInstance().getRepository(IUserRepository.class, "POSTGRE");
        ICompanyRepository compRepo = Factory.getInstance().getRepository(ICompanyRepository.class, "POSTGRE");
        UserServices userService = new UserServices(userRepo);
        CompanyService companyService = new CompanyService(compRepo, userRepo);
        AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación
        GUILogin login = new GUILogin(authService, userService, companyService); // Pasar la instancia al constructor
        login.setVisible(true); // Mostrar la ventana
        this.dispose();
    }//GEN-LAST:event_btnCloseSessionStudentActionPerformed
 
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GUIProjectDetails.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GUIProjectDetails.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GUIProjectDetails.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUIProjectDetails.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                GUIProjectDetails detailsFrame = new GUIProjectDetails();
                detailsFrame.setVisible(true);
                // Cargar datos de ejemplo
                //detailsFrame.loadProjectData(1);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnCloseSessionStudent;
    private javax.swing.JButton btnMyProjects;
    private javax.swing.JButton btnProfileStudent;
    private javax.swing.JButton btnProjectList;
    private javax.swing.JPanel jPanelDashboard;
    private javax.swing.JPanel jPanelProjectList;
    private javax.swing.JLabel lblEstudiante;
    private javax.swing.JLabel lblTitleProjectList;
    private javax.swing.JLabel lblUser;
    private javax.swing.JSeparator sepUserCoord;
    // End of variables declaration//GEN-END:variables
}
