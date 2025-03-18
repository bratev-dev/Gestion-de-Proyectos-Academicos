package com.mycompany.gestionproyectosacademicos.presentation;

import com.mycompany.gestionproyectosacademicos.access.Factory;
import com.mycompany.gestionproyectosacademicos.access.IProjectRepository;
import com.mycompany.gestionproyectosacademicos.entities.Coordinator;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import com.mycompany.gestionproyectosacademicos.observer.IObserver;
import com.mycompany.gestionproyectosacademicos.services.CoordinatorService;
import com.mycompany.gestionproyectosacademicos.services.ProjectService;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.util.List;
import javax.swing.border.EmptyBorder;
import javax.swing.table.JTableHeader;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;


public class GUICoordinator extends javax.swing.JFrame implements IObserver{
    private final Coordinator coordinator;
    private final ProjectService projectService;
    // Colores personalizados
    private final Color colorBackSelect = new Color(217, 217, 217); // #D9D9D9
    private final Color colorTxtSelect = new Color(19, 45, 70);    // #132D46
    private final Color colorBackOrigin = new Color(98, 114, 129);      // #627281
    private final Color colorTxtOrigin = new Color(255, 255, 255);     // #FFFFFF
    /**
     * Creates new form GUIMenu
     */
    public GUICoordinator(CoordinatorService coordinatorService, int idCoordinator) {
        IProjectRepository projectRepository = Factory.getInstance().getRepository(IProjectRepository.class, "ARRAYS");
        
        this.projectService = new ProjectService(projectRepository);
        this.coordinator = coordinatorService.getCoordinator(idCoordinator);
        
        // Registrar GUICoordinator como observador de ProjectService
        this.projectService.addObserver(this);
        
        initComponents();
    }
    
    private void fillProjects() {
        List<Project> projects = projectService.getProjects();
        DefaultTableModel model = new DefaultTableModel(new String[]{"Nombre", "Empresa", "Opciones"}, 0);

        model.setRowCount(0); // Limpiar la tabla antes de llenarla
        for (Project project : projects) {
            model.addRow(new Object[]{project.getName(), project.getCompany().getName(),""});
        }
        tblRequests.setModel(model);
        
        // Configurar el renderizador y editor para la columna "Opciones"
        tblRequests.getColumn("Opciones").setCellRenderer(new ButtonRenderer());
        tblRequests.getColumn("Opciones").setCellEditor(new ButtonEditor(new JCheckBox()));
        
        centerContentCells(tblRequests);
        //update(projectService.getProjects());   // Llamar a update() para llenar la tabla
    }
    
    private void centerContentCells(JTable table) {
        // Crear un renderizador centrado
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.CENTER); // Centrar el contenido

        for (int i = 0; i < table.getColumnCount(); i++) {
        table.getColumnModel().getColumn(i).setCellRenderer(centerRenderer);
    }
    }
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        SeeDetails = new javax.swing.JFrame();
        pnlProjectData = new javax.swing.JPanel();
        lblProyecto = new javax.swing.JLabel();
        lblProjectName = new javax.swing.JLabel();
        lblGUISummary = new javax.swing.JLabel();
        lblGUIGoals = new javax.swing.JLabel();
        lblGUIDescription = new javax.swing.JLabel();
        lblGUIMaxTimeInMonths = new javax.swing.JLabel();
        lblGUIBudget = new javax.swing.JLabel();
        lblGUIDate = new javax.swing.JLabel();
        btnChangeState = new javax.swing.JButton();
        lblGUIState = new javax.swing.JLabel();
        lblSummary = new javax.swing.JLabel();
        lblGoals = new javax.swing.JLabel();
        lblDescription = new javax.swing.JLabel();
        lblMaxTimeInMonths = new javax.swing.JLabel();
        lblBudget = new javax.swing.JLabel();
        lblDate = new javax.swing.JLabel();
        lblState = new javax.swing.JLabel();
        pnlCompanyData = new javax.swing.JPanel();
        lblCompany = new javax.swing.JLabel();
        lblCompanyName = new javax.swing.JLabel();
        lblGUICompanyNit = new javax.swing.JLabel();
        lblGUICompanyEmail = new javax.swing.JLabel();
        lblGUICompanySector = new javax.swing.JLabel();
        lblGUICompanyContactPhone = new javax.swing.JLabel();
        lblGUICompanyContactNames = new javax.swing.JLabel();
        lblGUICompanyContactLastNames = new javax.swing.JLabel();
        lblGUICompanyContactPosition = new javax.swing.JLabel();
        lblCompanyNit = new javax.swing.JLabel();
        lblCompanyEmail = new javax.swing.JLabel();
        lblCompanySector = new javax.swing.JLabel();
        lblCompanyContactPhone = new javax.swing.JLabel();
        lblCompanyContactNames = new javax.swing.JLabel();
        lblCompanyContactLastNames = new javax.swing.JLabel();
        lblCompanyContactPosition = new javax.swing.JLabel();
        jpLeft = new javax.swing.JPanel();
        lblUser = new javax.swing.JLabel();
        lblCoordinator = new javax.swing.JLabel();
        sepUserCoord = new javax.swing.JSeparator();
        btnPerfil = new javax.swing.JButton();
        btnRequests = new javax.swing.JButton();
        btnCloseSession = new javax.swing.JButton();
        pnlRight = new javax.swing.JPanel();
        pnlPerfil = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        pnlRequests = new javax.swing.JPanel();
        lblSolicitudes = new javax.swing.JLabel();
        jPanel4 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblRequests = new javax.swing.JTable();
        pnlMonitoring = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        pnlAssingment = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        pnlReports = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        pnlConnections = new javax.swing.JPanel();
        jLabel5 = new javax.swing.JLabel();

        SeeDetails.getContentPane().setLayout(new javax.swing.BoxLayout(SeeDetails.getContentPane(), javax.swing.BoxLayout.LINE_AXIS));

        lblProyecto.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        lblProyecto.setText("Proyecto");

        lblProjectName.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblProjectName.setText("nombreProyecto");

        lblGUISummary.setText("Resumen:");

        lblGUIGoals.setText("Objetivos:");

        lblGUIDescription.setText("Descripción:");

        lblGUIMaxTimeInMonths.setText("Tiempo máximo en meses: ");

        lblGUIBudget.setText("Presupuesto: ");

        lblGUIDate.setText("Fecha:");

        btnChangeState.setText("Cambiar estado");

        lblGUIState.setText("Estado:");

        lblSummary.setText("jLabel6");

        lblGoals.setText("jLabel7");

        lblDescription.setText("jLabel8");

        lblMaxTimeInMonths.setText("jLabel9");

        lblBudget.setText("jLabel10");

        lblDate.setText("jLabel11");

        lblState.setText("jLabel12");

        javax.swing.GroupLayout pnlProjectDataLayout = new javax.swing.GroupLayout(pnlProjectData);
        pnlProjectData.setLayout(pnlProjectDataLayout);
        pnlProjectDataLayout.setHorizontalGroup(
            pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlProjectDataLayout.createSequentialGroup()
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(btnChangeState)
                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(pnlProjectDataLayout.createSequentialGroup()
                            .addGap(98, 98, 98)
                            .addComponent(lblProyecto, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGroup(pnlProjectDataLayout.createSequentialGroup()
                            .addGap(60, 60, 60)
                            .addComponent(lblProjectName, javax.swing.GroupLayout.PREFERRED_SIZE, 143, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGroup(pnlProjectDataLayout.createSequentialGroup()
                            .addGap(22, 22, 22)
                            .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addGroup(pnlProjectDataLayout.createSequentialGroup()
                                    .addGap(98, 98, 98)
                                    .addComponent(lblGUIState)
                                    .addGap(18, 18, 18)
                                    .addComponent(lblState))
                                .addGroup(pnlProjectDataLayout.createSequentialGroup()
                                    .addGap(77, 77, 77)
                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                        .addComponent(lblGUIGoals)
                                        .addComponent(lblGUIDescription)
                                        .addComponent(lblGUISummary))
                                    .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(lblGoals, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(lblDescription, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(lblSummary, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))
                                .addGroup(pnlProjectDataLayout.createSequentialGroup()
                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                            .addComponent(lblGUIBudget)
                                            .addComponent(lblGUIMaxTimeInMonths, javax.swing.GroupLayout.PREFERRED_SIZE, 138, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addComponent(lblGUIDate, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGap(18, 18, 18)
                                    .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(lblDate)
                                        .addComponent(lblBudget)
                                        .addComponent(lblMaxTimeInMonths, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))))))
                .addContainerGap(127, Short.MAX_VALUE))
        );
        pnlProjectDataLayout.setVerticalGroup(
            pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlProjectDataLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblProyecto)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblProjectName)
                .addGap(26, 26, 26)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUISummary)
                    .addComponent(lblSummary))
                .addGap(18, 18, 18)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIGoals)
                    .addComponent(lblGoals))
                .addGap(18, 18, 18)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIDescription)
                    .addComponent(lblDescription))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIMaxTimeInMonths)
                    .addComponent(lblMaxTimeInMonths))
                .addGap(18, 18, 18)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIBudget)
                    .addComponent(lblBudget))
                .addGap(18, 18, 18)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIDate)
                    .addComponent(lblDate))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlProjectDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUIState)
                    .addComponent(lblState))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 32, Short.MAX_VALUE)
                .addComponent(btnChangeState)
                .addGap(17, 17, 17))
        );

        SeeDetails.getContentPane().add(pnlProjectData);

        lblCompany.setText("Empresa");

        lblCompanyName.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblCompanyName.setText("nombreEmpresa");

        lblGUICompanyNit.setText("Nit:");

        lblGUICompanyEmail.setText("Email:");

        lblGUICompanySector.setText("Sector:");

        lblGUICompanyContactPhone.setText("Teléfono de contacto:");

        lblGUICompanyContactNames.setText("Nombres del contacto:");

        lblGUICompanyContactLastNames.setText("Apellidos del contacto:");

        lblGUICompanyContactPosition.setText("Cargo del contacto:");

        lblCompanyNit.setText("jLabel6");

        lblCompanyEmail.setText("jLabel7");

        lblCompanySector.setText("jLabel8");

        lblCompanyContactPhone.setText("jLabel9");

        lblCompanyContactNames.setText("jLabel10");

        lblCompanyContactLastNames.setText("jLabel11");

        lblCompanyContactPosition.setText("jLabel12");

        javax.swing.GroupLayout pnlCompanyDataLayout = new javax.swing.GroupLayout(pnlCompanyData);
        pnlCompanyData.setLayout(pnlCompanyDataLayout);
        pnlCompanyDataLayout.setHorizontalGroup(
            pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlCompanyDataLayout.createSequentialGroup()
                .addContainerGap(48, Short.MAX_VALUE)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()
                        .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblGUICompanyEmail, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanyNit, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanyContactNames, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanyContactPhone, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanySector, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanyContactLastNames, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblGUICompanyContactPosition, javax.swing.GroupLayout.Alignment.TRAILING))
                        .addGap(18, 18, 18)
                        .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblCompanyNit, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblCompanyEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblCompanySector, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblCompanyContactPhone, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblCompanyContactNames)
                            .addComponent(lblCompanyContactLastNames)
                            .addComponent(lblCompanyContactPosition))
                        .addGap(97, 97, 97))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()
                        .addComponent(lblCompanyName, javax.swing.GroupLayout.PREFERRED_SIZE, 142, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(62, 62, 62))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlCompanyDataLayout.createSequentialGroup()
                        .addComponent(lblCompany, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(116, 116, 116))))
        );
        pnlCompanyDataLayout.setVerticalGroup(
            pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlCompanyDataLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblCompany)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblCompanyName)
                .addGap(31, 31, 31)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyNit)
                    .addComponent(lblCompanyNit))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyEmail)
                    .addComponent(lblCompanyEmail))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanySector)
                    .addComponent(lblCompanySector))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyContactPhone)
                    .addComponent(lblCompanyContactPhone))
                .addGap(18, 18, 18)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyContactNames)
                    .addComponent(lblCompanyContactNames))
                .addGap(18, 18, 18)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyContactLastNames)
                    .addComponent(lblCompanyContactLastNames))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(pnlCompanyDataLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblGUICompanyContactPosition)
                    .addComponent(lblCompanyContactPosition))
                .addContainerGap(78, Short.MAX_VALUE))
        );

        SeeDetails.getContentPane().add(pnlCompanyData);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(960, 540));
        setSize(new java.awt.Dimension(960, 540));

        jpLeft.setBackground(new java.awt.Color(19, 45, 70));
        jpLeft.setAlignmentX(0.0F);
        jpLeft.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        lblUser.setForeground(new java.awt.Color(255, 255, 255));
        lblUser.setText("Usuario");

        lblCoordinator.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblCoordinator.setForeground(new java.awt.Color(255, 255, 255));
        lblCoordinator.setText("Coordinador");

        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));
        sepUserCoord.setForeground(new java.awt.Color(155, 70, 47));

        btnPerfil.setBackground(new java.awt.Color(98, 114, 129));
        btnPerfil.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N
        btnPerfil.setForeground(new java.awt.Color(255, 255, 255));
        btnPerfil.setText("Perfil");
        btnPerfil.setBorder(null);
        btnPerfil.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnPerfilActionPerformed(evt);
            }
        });

        btnRequests.setBackground(new java.awt.Color(98, 114, 129));
        btnRequests.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N
        btnRequests.setForeground(new java.awt.Color(255, 255, 255));
        btnRequests.setText("Solicitudes");
        btnRequests.setBorder(null);
        btnRequests.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRequestsActionPerformed(evt);
            }
        });

        btnCloseSession.setBackground(new java.awt.Color(98, 114, 129));
        btnCloseSession.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        btnCloseSession.setForeground(new java.awt.Color(255, 255, 255));
        btnCloseSession.setText("Cerrar Sesión");
        btnCloseSession.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        btnCloseSession.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCloseSessionActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jpLeftLayout = new javax.swing.GroupLayout(jpLeft);
        jpLeft.setLayout(jpLeftLayout);
        jpLeftLayout.setHorizontalGroup(
            jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(btnPerfil, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(btnRequests, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpLeftLayout.createSequentialGroup()
                .addGroup(jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jpLeftLayout.createSequentialGroup()
                        .addContainerGap(95, Short.MAX_VALUE)
                        .addComponent(lblUser))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpLeftLayout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addGroup(jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jpLeftLayout.createSequentialGroup()
                                .addGap(6, 6, 6)
                                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 99, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addGap(90, 90, 90))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpLeftLayout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(lblCoordinator)
                .addGap(101, 101, 101))
        );
        jpLeftLayout.setVerticalGroup(
            jpLeftLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jpLeftLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(lblUser)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblCoordinator)
                .addGap(42, 42, 42)
                .addComponent(btnPerfil, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnRequests, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 319, Short.MAX_VALUE)
                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(19, 19, 19))
        );

        getContentPane().add(jpLeft, java.awt.BorderLayout.LINE_START);

        pnlRight.setBackground(new java.awt.Color(255, 255, 255));
        pnlRight.setLayout(new java.awt.CardLayout());

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel2.setText("Perfil");
        pnlPerfil.add(jLabel2);

        pnlRight.add(pnlPerfil, "card3");

        pnlRequests.setLayout(new java.awt.BorderLayout());

        lblSolicitudes.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        lblSolicitudes.setText("Solicitudes de Proyectos");
        lblSolicitudes.setBorder(new EmptyBorder(70, 50, 20, 20)); // Margen superior, izquierdo, inferior, derecho
        pnlRequests.add(lblSolicitudes, java.awt.BorderLayout.NORTH);

        jPanel4.setLayout(new java.awt.BorderLayout());

        tblRequests.setBackground(new java.awt.Color(232, 232, 232));
        tblRequests.setFont(new java.awt.Font("Tahoma", 0, 20)); // NOI18N
        tblRequests.setForeground(new java.awt.Color(40, 40, 40));
        tblRequests.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {"JuanCompanies", "Muñecas Inflables", "Ver más"},
                {null, null, null},
                {null, null, null},
                {null, null, null}
            },
            new String [] {
                "Empresa", "Proyecto", "Opciones"
            }
        ));
        // Personalizar el contenido de la tabla
        DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
        renderer.setHorizontalAlignment(JLabel.CENTER); // Centrar el contenido

        // Aplicar el renderizador a todas las columnas
        for (int i = 0; i < tblRequests.getColumnCount(); i++) {
            tblRequests.getColumnModel().getColumn(i).setCellRenderer(renderer);
        }

        // Ajustar solo columna "Opciones"
        tblRequests.getColumnModel().getColumn(2).setPreferredWidth(250);

        // Personalizar el encabezado de la tabla
        JTableHeader header = tblRequests.getTableHeader();
        header.setBackground(new Color(157, 157, 157)); // Color de fondo del encabezado
        header.setForeground(new Color(255, 255, 255)); // Color del texto del encabezado
        header.setFont(new Font("Tahoma", Font.BOLD, 24)); // Fuente del encabezado

        // Ajustar la altura del encabezado para que coincida con las filas
        header.setPreferredSize(new Dimension(header.getPreferredSize().width, 80)); // Ancho automático, altura establecida manualmente
        DefaultTableCellRenderer headerRenderer = (DefaultTableCellRenderer) header.getDefaultRenderer();
        headerRenderer.setHorizontalAlignment(JLabel.CENTER);   // Centrar el contenido
        tblRequests.setRowHeight(60);
        tblRequests.setShowHorizontalLines(true);
        tblRequests.setShowVerticalLines(false);
        jScrollPane1.setViewportView(tblRequests);
        centerContentCells(tblRequests);
        jScrollPane1.setBorder(new EmptyBorder(20,50,50,50)); // Margen superior, izquierdo, inferior, derecho
        jPanel4.add(jScrollPane1, java.awt.BorderLayout.CENTER);

        jPanel4.add(jScrollPane1, java.awt.BorderLayout.CENTER);

        pnlRequests.add(jPanel4, java.awt.BorderLayout.CENTER);

        pnlRight.add(pnlRequests, "card2");

        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel1.setText("Monitoreo");
        pnlMonitoring.add(jLabel1);

        pnlRight.add(pnlMonitoring, "card4");

        jLabel3.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        jLabel3.setText("Asignación de proyectos");
        pnlAssingment.add(jLabel3);

        pnlRight.add(pnlAssingment, "card5");

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel4.setText("Reportes");
        pnlReports.add(jLabel4);

        pnlRight.add(pnlReports, "card6");

        jLabel5.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel5.setText("Conexiones");
        pnlConnections.add(jLabel5);

        pnlRight.add(pnlConnections, "card7");

        getContentPane().add(pnlRight, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnCloseSessionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionActionPerformed
        
        AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación
        GUILogin login = new GUILogin(authService); // Pasar la instancia al constructor
        login.setVisible(true); // Mostrar la ventana
        this.dispose();
    }//GEN-LAST:event_btnCloseSessionActionPerformed

    private void btnRequestsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRequestsActionPerformed
        CardLayout cl = (CardLayout) pnlRight.getLayout();
        cl.show(pnlRight, "card2");
        changeColorBtn(btnRequests);
        
        // Registrar observer solo una vez
        //this.projectService.addObserver(new projectsCoordinatorObserver(coordinator, projectService, tblRequests, jScrollPane1));
        
        // Notificar a los observers para llenar la tabla
        this.projectService.notifyObservers();
    }//GEN-LAST:event_btnRequestsActionPerformed

    private void btnPerfilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPerfilActionPerformed
        CardLayout cl = (CardLayout) pnlRight.getLayout();
        cl.show(pnlRight, "card3");
        changeColorBtn(btnPerfil);
    }//GEN-LAST:event_btnPerfilActionPerformed

    private void changeColorBtn(JButton botonSeleccionado) {
        // Restaurar el estilo de todos los botones
        for (JButton boton : new JButton[]{btnPerfil, btnRequests}) {
            boton.setBackground(colorBackOrigin);
            boton.setForeground(colorTxtOrigin);
        }

        // Cambiar el estilo del botón seleccionado
        botonSeleccionado.setBackground(colorBackSelect);
        botonSeleccionado.setForeground(colorTxtSelect);
    }
    
    public static void main(String args[]) {
        
    }
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JFrame SeeDetails;
    private javax.swing.JButton btnChangeState;
    private javax.swing.JButton btnCloseSession;
    private javax.swing.JButton btnPerfil;
    private javax.swing.JButton btnRequests;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JPanel jpLeft;
    private javax.swing.JLabel lblBudget;
    private javax.swing.JLabel lblCompany;
    private javax.swing.JLabel lblCompanyContactLastNames;
    private javax.swing.JLabel lblCompanyContactNames;
    private javax.swing.JLabel lblCompanyContactPhone;
    private javax.swing.JLabel lblCompanyContactPosition;
    private javax.swing.JLabel lblCompanyEmail;
    private javax.swing.JLabel lblCompanyName;
    private javax.swing.JLabel lblCompanyNit;
    private javax.swing.JLabel lblCompanySector;
    private javax.swing.JLabel lblCoordinator;
    private javax.swing.JLabel lblDate;
    private javax.swing.JLabel lblDescription;
    private javax.swing.JLabel lblGUIBudget;
    private javax.swing.JLabel lblGUICompanyContactLastNames;
    private javax.swing.JLabel lblGUICompanyContactNames;
    private javax.swing.JLabel lblGUICompanyContactPhone;
    private javax.swing.JLabel lblGUICompanyContactPosition;
    private javax.swing.JLabel lblGUICompanyEmail;
    private javax.swing.JLabel lblGUICompanyNit;
    private javax.swing.JLabel lblGUICompanySector;
    private javax.swing.JLabel lblGUIDate;
    private javax.swing.JLabel lblGUIDescription;
    private javax.swing.JLabel lblGUIGoals;
    private javax.swing.JLabel lblGUIMaxTimeInMonths;
    private javax.swing.JLabel lblGUIState;
    private javax.swing.JLabel lblGUISummary;
    private javax.swing.JLabel lblGoals;
    private javax.swing.JLabel lblMaxTimeInMonths;
    private javax.swing.JLabel lblProjectName;
    private javax.swing.JLabel lblProyecto;
    private javax.swing.JLabel lblSolicitudes;
    private javax.swing.JLabel lblState;
    private javax.swing.JLabel lblSummary;
    private javax.swing.JLabel lblUser;
    private javax.swing.JPanel pnlAssingment;
    private javax.swing.JPanel pnlCompanyData;
    private javax.swing.JPanel pnlConnections;
    private javax.swing.JPanel pnlMonitoring;
    private javax.swing.JPanel pnlPerfil;
    private javax.swing.JPanel pnlProjectData;
    private javax.swing.JPanel pnlReports;
    private javax.swing.JPanel pnlRequests;
    private javax.swing.JPanel pnlRight;
    private javax.swing.JSeparator sepUserCoord;
    private javax.swing.JTable tblRequests;
    // End of variables declaration//GEN-END:variables

    @Override
    public void update(Object o) {
        // Verificar si el objeto notificado es una lista de proyectos
        if (o instanceof List<?>) {
            List<?> projects = (List<?>) o;

            // Crear un modelo de tabla para tblRequests
            DefaultTableModel model = new DefaultTableModel(new String[]{"Nombre", "Empresa", "Opciones"}, 0);

            // Llenar la tabla con los proyectos
            for (Object project : projects) {
                if (project instanceof Project) {
                    Project p = (Project) project;
                    model.addRow(new Object[]{p.getName(), p.getCompany().getName(), ""});
                }
            }

            // Asignar el modelo a la tabla
            tblRequests.setModel(model);
            tblRequests.getColumn("Opciones").setCellRenderer(new ButtonRenderer());
            tblRequests.getColumn("Opciones").setCellEditor(new ButtonEditor(new JCheckBox()));
        }
    }
}
