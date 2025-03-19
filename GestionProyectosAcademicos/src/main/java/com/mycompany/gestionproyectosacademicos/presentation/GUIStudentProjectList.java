package com.mycompany.gestionproyectosacademicos.presentation;

import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.observer.Observer;
import com.mycompany.gestionproyectosacademicos.access.ProjectRepository;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.ProjectControler;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.util.List;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.DefaultCellEditor;
import javax.swing.GroupLayout;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumn;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jhonatan
 */
public class GUIStudentProjectList extends javax.swing.JFrame implements Observer{

    private JTable projectTable;
    private DefaultTableModel tableModel;
    private ProjectRepository projectRepository;
    private ProjectControler projectController;
    private List<Project> allProjects;
    private int currentPage = 1;
    private final int PROJECTS_PER_PAGE = 10;
    private JButton btnPage;
    private JButton btnPrevious;
    private JButton btnNext;
    private GUIProjectDetails currentDetailsFrame = null;
    
    // Clase para el modelo de tabla que no permita edición
    class NonEditableTableModel extends DefaultTableModel {
        @Override
        public boolean isCellEditable(int row, int column) {
            return column == 4; // Solo la columna de detalles es editable (para los botones)
        }
    }

    // Clase para el renderizador de los botones de detalles
    class DetailsButton extends JButton implements TableCellRenderer {
        public DetailsButton() {
            setOpaque(true);
            setBackground(new Color(176, 94, 69));
            setForeground(Color.WHITE);
            setFocusPainted(false);
            setBorderPainted(false);
            setPreferredSize(new Dimension(30, 30));
            setFont(new Font("Arial", Font.BOLD, 16));
        }

        @Override
        public Component getTableCellRendererComponent(JTable table, Object value,
                                                      boolean isSelected, boolean hasFocus, int row, int column) {
            setText("›");
            return this;
        }
    }

    // Clase para el editor de los botones de detalles
    class ButtonEditorDetails extends DefaultCellEditor {
        private JButton button;
        private String label;
        private boolean isPushed;
        private int projectId;

        public ButtonEditorDetails(JCheckBox checkBox) {
            super(checkBox);
            button = new JButton();
            button.setOpaque(true);
            button.setBackground(new Color(176, 94, 69));
            button.setForeground(Color.WHITE);
            button.setFocusPainted(false);
            button.setBorderPainted(false);
            button.setFont(new Font("Arial", Font.BOLD, 16));
            
            button.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    fireEditingStopped();
                }
            });
        }

        @Override
        public Component getTableCellEditorComponent(JTable table, Object value,
                                                boolean isSelected, int row, int column) {
            label = "›";
            button.setText(label);
            projectId = Integer.parseInt(table.getValueAt(row, 0).toString());
            isPushed = true;
            
            // Obtener la ventana principal que contiene la tabla
            JFrame parentFrame = (JFrame) SwingUtilities.getWindowAncestor(table);
            
            // Crear y mostrar la ventana de detalles
            SwingUtilities.invokeLater(() -> {
                try {
                    // Cerrar la ventana anterior si existe
                    if (currentDetailsFrame != null) {
                        currentDetailsFrame.dispose();
                    }
                    
                    if (parentFrame != null) {
                    parentFrame.setVisible(false);
                    }   

                    Project project = projectRepository.getProjectById(projectId);
                    if (project != null) {
                        currentDetailsFrame = new GUIProjectDetails(project);
                        currentDetailsFrame.setVisible(true);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(GUIStudentProjectList.class.getName()).log(Level.SEVERE, null, ex);
                }
            });
            return button;
        }

        @Override
        public Object getCellEditorValue() {
            if (isPushed) {
            // Solo llamar una vez al método showProjectDetails
            showProjectDetails(projectId);
            }
            isPushed = false;
            return label;
        }

        private void showProjectDetails(int projectId) {
            try {
                // Verificar que el proyecto existe antes de intentar cargarlo
                if (projectRepository == null) {
                    JOptionPane.showMessageDialog(null, 
                        "Error: El repositorio de proyectos no está inicializado",
                        "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }

                Project project = projectRepository.getProjectById(projectId);
                if (project == null) {
                    JOptionPane.showMessageDialog(null, 
                        "No se encontró el proyecto con ID: " + projectId,
                        "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }

                // Crear una nueva ventana para mostrar los detalles
                GUIProjectDetails detailsFrame = new GUIProjectDetails();
                //detailsFrame.setVisible(true);
                
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, 
                    "Error al cargar los detalles del proyecto: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
            }
        }

        @Override
        public boolean stopCellEditing() {
            isPushed = false;
            return super.stopCellEditing();
        }
    }
    
    /**
     * Creates new form GUIStudentProjectList
     */
    public GUIStudentProjectList() {
        initComponents();
        
        // Inicializar repositorio y controlador
        projectRepository = new ProjectRepository();
        projectController = new ProjectControler();
        projectController.addStudent(this);
        
        // Inicializar tabla
        initTable();
        
        // Cargar proyectos desde la BD
        loadProjectsFromDatabase();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
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

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

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
                    .addGroup(jPanelDashboardLayout.createSequentialGroup()
                        .addComponent(btnProfileStudent, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addContainerGap())
                    .addGroup(jPanelDashboardLayout.createSequentialGroup()
                        .addComponent(btnProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addContainerGap())
                    .addGroup(jPanelDashboardLayout.createSequentialGroup()
                        .addComponent(btnMyProjects, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addContainerGap())))
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
        lblTitleProjectList.setText("Proyectos Disponibles");

        javax.swing.GroupLayout jPanelProjectListLayout = new javax.swing.GroupLayout(jPanelProjectList);
        jPanelProjectList.setLayout(jPanelProjectListLayout);
        jPanelProjectListLayout.setHorizontalGroup(
            jPanelProjectListLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanelProjectListLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblTitleProjectList)
                .addContainerGap(370, Short.MAX_VALUE))
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
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanelDashboard, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanelProjectList, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void initTable() {
        // Creacion de modelo de la tabla no modificable
        tableModel = new NonEditableTableModel();
        tableModel.addColumn("No");
        tableModel.addColumn("Nombre Empresa");
        tableModel.addColumn("Nombre Proyecto");
        tableModel.addColumn("Resumen Proyecto");
        tableModel.addColumn("Detalles");
        
        btnPage = new JButton("1");
        btnPage.setBackground(new Color(19, 45, 70));
        btnPage.setForeground(Color.WHITE);
        btnPage.setFocusPainted(false);
        
        // Creacion de la tabla
        projectTable = new JTable(tableModel);
        
        // Configuracion de apariencia de la tabla no modificable
        projectTable.setRowHeight(50);
        projectTable.setIntercellSpacing(new Dimension(0, 5));
        projectTable.setShowGrid(false);
        projectTable.setBackground(Color.WHITE);
        projectTable.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Configuracion de la cabecera de la tabla
        JTableHeader header = projectTable.getTableHeader();
        header.setBackground(new Color(19, 45, 70));
        header.setForeground(Color.WHITE);
        header.setFont(new Font("Tahoma", Font.BOLD, 14));
        header.setBorder(BorderFactory.createEmptyBorder());
        header.setPreferredSize(new Dimension(header.getWidth(), 40));
        
        // Configuracion del renderizador para las celdas
        DefaultTableCellRenderer renderer = new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable table, Object value,
                                                          boolean isSelected, boolean hasFocus, int row, int column) {
                Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                if (row % 2 == 0) {
                    c.setBackground(new Color(245, 245, 245));
                } else {
                    c.setBackground(new Color(250, 250, 250));
                }
                return c;
            }
        };
        
        // Aplicar el renderizador a todas las columnas excepto la última
        for (int i = 0; i < projectTable.getColumnCount() - 1; i++) {
            projectTable.getColumnModel().getColumn(i).setCellRenderer(renderer);
        }
        
        // Configurar renderizador para la columna de botones
        TableColumn buttonColumn = projectTable.getColumnModel().getColumn(4);
        buttonColumn.setCellRenderer(new DetailsButton());
        buttonColumn.setCellEditor(new ButtonEditorDetails(new JCheckBox()));
        buttonColumn.setMaxWidth(70);
        
        // Configurar anchos de columnas
        projectTable.getColumnModel().getColumn(0).setPreferredWidth(50);  // No
        projectTable.getColumnModel().getColumn(1).setPreferredWidth(150); // Nombre Empresa
        projectTable.getColumnModel().getColumn(2).setPreferredWidth(150); // Nombre Proyecto
        projectTable.getColumnModel().getColumn(3).setPreferredWidth(250); // Resumen Proyecto
        
        // Crear JScrollPane para la tabla
        JScrollPane scrollPane = new JScrollPane(projectTable);
        scrollPane.setBorder(BorderFactory.createEmptyBorder());
        scrollPane.setBackground(Color.WHITE);
        
        // Añadir datos de prueba
        addSampleData();
        
        // Añadir botones de navegación
        JPanel navigationPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 5));
        navigationPanel.setBackground(Color.WHITE);
        
        //BOTONES PARA LA NAVEGACION DE LAS PAGINAS DE LA LISTA DE PROYECTOS
        btnPrevious = new JButton("Anterior");
        btnPrevious.setBackground(new Color(19, 45, 70));
        btnPrevious.setForeground(Color.WHITE);
        btnPrevious.setFocusPainted(false);
        btnPrevious.setEnabled(false);
        btnPrevious.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (currentPage > 1) {
                    currentPage--;
                    displayCurrentPage();
                }
            }
        });
        
        btnNext = new JButton("Siguiente");
        btnNext.setBackground(new Color(19, 45, 70));
        btnNext.setForeground(Color.WHITE);
        btnNext.setFocusPainted(false);
        btnNext.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int maxPages = (int) Math.ceil((double) allProjects.size() / PROJECTS_PER_PAGE);
                if (currentPage < maxPages) {
                    currentPage++;
                    displayCurrentPage();
                }
            }
        });
        
        // Agregar botones al panel
        navigationPanel.add(btnPrevious);
        navigationPanel.add(btnPage);
        navigationPanel.add(btnNext);
        
        // Configurar layout del panel principal
        GroupLayout layout = (GroupLayout) jPanelProjectList.getLayout();
        layout.setHorizontalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(lblTitleProjectList)
                    .addComponent(scrollPane, GroupLayout.DEFAULT_SIZE, 600, Short.MAX_VALUE)
                    .addComponent(navigationPanel, GroupLayout.DEFAULT_SIZE, 600, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(lblTitleProjectList)
                .addGap(20, 20, 20)
                .addComponent(scrollPane, GroupLayout.DEFAULT_SIZE, 400, Short.MAX_VALUE)
                .addGap(10, 10, 10)
                .addComponent(navigationPanel, GroupLayout.PREFERRED_SIZE, 40, GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
    }
    
    private void loadProjectsFromDatabase() {
        try {
            allProjects = projectRepository.getAllProjects();
            
            // Actualizar el controlador con todos los proyectos
            for (Project project : allProjects) {
                projectController.addProjects(project);
            }
            
            // Mostrar la primera página
            displayCurrentPage();
            
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar proyectos: " + e.getMessage(), 
                "Error de Base de Datos", 
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void displayCurrentPage() {
        // Limpiar tabla
        tableModel.setRowCount(0);

        // Calcular índices para la página actual
        int startIndex = (currentPage - 1) * PROJECTS_PER_PAGE;
        int endIndex = Math.min(startIndex + PROJECTS_PER_PAGE, allProjects.size());

        // Actualizar el botón de página con formato [2..3]
        int totalPages = (int) Math.ceil((double) allProjects.size() / PROJECTS_PER_PAGE);
        btnPage.setText("[" + currentPage + "..." + totalPages + "]");

        // Habilitar/deshabilitar botones de navegación
        btnPrevious.setEnabled(currentPage > 1);
        btnNext.setEnabled(currentPage < totalPages);

        // Mostrar proyectos para esta página
        for (int i = startIndex; i < endIndex; i++) {
            Project project = allProjects.get(i);
            tableModel.addRow(new Object[]{
                project.getId(),
                project.getCompany().getName(),
                project.getName(),
                project.getDescription(),
                ">"
            });
        }
    }
    
    private void addSampleData() {
        tableModel.addRow(new Object[]{"00000", "Nombre Empresa", "Nombre Proyecto", "resumen del proyecto resumen del proyecto", ">"});
        tableModel.addRow(new Object[]{"00000", "Nombre Empresa", "Nombre Proyecto", "resumen del proyecto resumen del proyecto", ">"});
        tableModel.addRow(new Object[]{"00000", "Nombre Empresa", "Nombre Proyecto", "resumen del proyecto resumen del proyecto", ">"});
        tableModel.addRow(new Object[]{"00000", "Nombre Empresa", "Nombre Proyecto", "resumen del proyecto resumen del proyecto", ">"});
    }
    
    private void btnCloseSessionStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionStudentActionPerformed
        AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación
        GUILogin login = new GUILogin(authService); // Pasar la instancia al constructor
        login.setVisible(true); // Mostrar la ventana
        this.dispose();
    }//GEN-LAST:event_btnCloseSessionStudentActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUIStudentProjectList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GUIStudentProjectList().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnCloseSessionStudent;
    private javax.swing.JButton btnMyProjects;
    private javax.swing.JButton btnProfileStudent;
    private javax.swing.JButton btnProjectList;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanelDashboard;
    private javax.swing.JPanel jPanelProjectList;
    private javax.swing.JLabel lblEstudiante;
    private javax.swing.JLabel lblTitleProjectList;
    private javax.swing.JLabel lblUser;
    private javax.swing.JSeparator sepUserCoord;
    // End of variables declaration//GEN-END:variables
   
    @Override
    public void update(Object obj) {
        if(obj instanceof Project) {
            Project project = (Project) obj;
            
            // Verificar si el proyecto ya existe en la lista
            boolean exists = false;
            for (Project p : allProjects) {
                if (p.getId() == project.getId()) {
                    exists = true;
                    // Actualizar el proyecto existente
                    p.setName(project.getName());
                    p.setDescription(project.getDescription());
                    p.setState(project.getState());
                    p.setCompany(project.getCompany());
                    break;
                }
            }
            
            // Si no existe, añadirlo a la lista
            if (!exists) {
                allProjects.add(project);
            }
            
            // Actualizar la vista
            displayCurrentPage();
        }
    }
    
    // Método para actualizar toda la lista de proyectos
    public void updateProjectList(List<Project> projects) {
        // Actualizar la lista completa
        allProjects = new ArrayList<>(projects);
        
        // Actualizar la vista
        displayCurrentPage();
    }
}
