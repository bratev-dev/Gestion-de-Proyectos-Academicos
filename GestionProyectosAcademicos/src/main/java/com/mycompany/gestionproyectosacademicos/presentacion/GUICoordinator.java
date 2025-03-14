/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.presentacion;

import java.awt.CardLayout;
import java.awt.Color;
import javax.swing.JButton;

/**
 *
 * @author bryan
 */
public class GUICoordinator extends javax.swing.JFrame {
    // Colores personalizados
    private final Color colorBackSelect = new Color(217, 217, 217); // #D9D9D9
    private final Color colorTxtSelect = new Color(19, 45, 70);    // #132D46
    private final Color colorBackOrigin = new Color(98, 114, 129);      // #627281
    private final Color colorTxtOrigin = new Color(255, 255, 255);     // #FFFFFF
    /**
     * Creates new form GUIMenu
     */
    public GUICoordinator() {
        initComponents();
        this.setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jpIzq = new javax.swing.JPanel();
        lblUser = new javax.swing.JLabel();
        lblCoordinator = new javax.swing.JLabel();
        sepUserCoord = new javax.swing.JSeparator();
        btnPerfil = new javax.swing.JButton();
        btnRequests = new javax.swing.JButton();
        btnMonitoring = new javax.swing.JButton();
        btnAssignment = new javax.swing.JButton();
        btnReports = new javax.swing.JButton();
        btnConnections = new javax.swing.JButton();
        btnCloseSession = new javax.swing.JButton();
        pnlDer = new javax.swing.JPanel();
        pnlRequests = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        jPanel5 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        pnlMonitoring = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        pnlAssingment = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        pnlReports = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        pnlConnections = new javax.swing.JPanel();
        jLabel5 = new javax.swing.JLabel();
        pnlPerfil = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(960, 540));
        setSize(new java.awt.Dimension(960, 540));

        jpIzq.setBackground(new java.awt.Color(19, 45, 70));
        jpIzq.setAlignmentX(0.0F);
        jpIzq.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        lblUser.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        lblUser.setForeground(new java.awt.Color(255, 255, 255));
        lblUser.setText("Usuario");

        lblCoordinator.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblCoordinator.setForeground(new java.awt.Color(255, 255, 255));
        lblCoordinator.setText("Coordinador");

        sepUserCoord.setBackground(new java.awt.Color(155, 70, 47));
        sepUserCoord.setForeground(new java.awt.Color(155, 70, 47));

        btnPerfil.setBackground(new java.awt.Color(98, 114, 129));
        btnPerfil.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnPerfil.setForeground(new java.awt.Color(255, 255, 255));
        btnPerfil.setText("Perfil");
        btnPerfil.setBorder(null);
        btnPerfil.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnPerfilActionPerformed(evt);
            }
        });

        btnRequests.setBackground(new java.awt.Color(98, 114, 129));
        btnRequests.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnRequests.setForeground(new java.awt.Color(255, 255, 255));
        btnRequests.setText("Solicitudes");
        btnRequests.setBorder(null);
        btnRequests.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRequestsActionPerformed(evt);
            }
        });

        btnMonitoring.setBackground(new java.awt.Color(98, 114, 129));
        btnMonitoring.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnMonitoring.setForeground(new java.awt.Color(255, 255, 255));
        btnMonitoring.setText("Monitoreo");
        btnMonitoring.setBorder(null);
        btnMonitoring.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMonitoringActionPerformed(evt);
            }
        });

        btnAssignment.setBackground(new java.awt.Color(98, 114, 129));
        btnAssignment.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnAssignment.setForeground(new java.awt.Color(255, 255, 255));
        btnAssignment.setText("Asignación");
        btnAssignment.setBorder(null);
        btnAssignment.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAssignmentActionPerformed(evt);
            }
        });

        btnReports.setBackground(new java.awt.Color(98, 114, 129));
        btnReports.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnReports.setForeground(new java.awt.Color(255, 255, 255));
        btnReports.setText("Reportes");
        btnReports.setBorder(null);
        btnReports.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnReportsActionPerformed(evt);
            }
        });

        btnConnections.setBackground(new java.awt.Color(98, 114, 129));
        btnConnections.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnConnections.setForeground(new java.awt.Color(255, 255, 255));
        btnConnections.setText("Conexiones");
        btnConnections.setBorder(null);
        btnConnections.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnConnectionsActionPerformed(evt);
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

        javax.swing.GroupLayout jpIzqLayout = new javax.swing.GroupLayout(jpIzq);
        jpIzq.setLayout(jpIzqLayout);
        jpIzqLayout.setHorizontalGroup(
            jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(btnPerfil, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(btnRequests, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(btnMonitoring, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()
                .addGroup(jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jpIzqLayout.createSequentialGroup()
                        .addContainerGap(95, Short.MAX_VALUE)
                        .addComponent(lblUser))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addGroup(jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(sepUserCoord, javax.swing.GroupLayout.PREFERRED_SIZE, 124, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jpIzqLayout.createSequentialGroup()
                                .addGap(6, 6, 6)
                                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 99, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addGap(90, 90, 90))
            .addComponent(btnAssignment, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(btnReports, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(btnConnections, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jpIzqLayout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(lblCoordinator)
                .addGap(101, 101, 101))
        );
        jpIzqLayout.setVerticalGroup(
            jpIzqLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jpIzqLayout.createSequentialGroup()
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
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnMonitoring, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnAssignment, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnReports, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnConnections, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 35, Short.MAX_VALUE)
                .addComponent(btnCloseSession, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(19, 19, 19))
        );

        getContentPane().add(jpIzq, java.awt.BorderLayout.LINE_START);

        pnlDer.setBackground(new java.awt.Color(255, 255, 255));
        pnlDer.setLayout(new java.awt.CardLayout());

        pnlRequests.setLayout(new java.awt.BorderLayout());
        pnlRequests.add(jPanel1, java.awt.BorderLayout.PAGE_END);
        pnlRequests.add(jPanel2, java.awt.BorderLayout.LINE_END);
        pnlRequests.add(jPanel3, java.awt.BorderLayout.WEST);
        pnlRequests.add(jPanel5, java.awt.BorderLayout.PAGE_START);
        pnlRequests.add(jPanel4, java.awt.BorderLayout.PAGE_START);

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPane1.setViewportView(jTable1);

        pnlRequests.add(jScrollPane1, java.awt.BorderLayout.CENTER);

        pnlDer.add(pnlRequests, "card2");

        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel1.setText("Monitoreo");
        pnlMonitoring.add(jLabel1);

        pnlDer.add(pnlMonitoring, "card4");

        jLabel3.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        jLabel3.setText("Asignación de proyectos");
        pnlAssingment.add(jLabel3);

        pnlDer.add(pnlAssingment, "card5");

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel4.setText("Reportes");
        pnlReports.add(jLabel4);

        pnlDer.add(pnlReports, "card6");

        jLabel5.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel5.setText("Conexiones");
        pnlConnections.add(jLabel5);

        pnlDer.add(pnlConnections, "card7");

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        jLabel2.setText("Perfil");
        pnlPerfil.add(jLabel2);

        pnlDer.add(pnlPerfil, "card3");

        getContentPane().add(pnlDer, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnCloseSessionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseSessionActionPerformed

    }//GEN-LAST:event_btnCloseSessionActionPerformed

    private void btnConnectionsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnConnectionsActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card7");
        changeColorBtn(btnConnections);
    }//GEN-LAST:event_btnConnectionsActionPerformed

    private void btnReportsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnReportsActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card6");
        changeColorBtn(btnReports);
    }//GEN-LAST:event_btnReportsActionPerformed

    private void btnAssignmentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAssignmentActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card5");
        changeColorBtn(btnAssignment);
    }//GEN-LAST:event_btnAssignmentActionPerformed

    private void btnMonitoringActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMonitoringActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card4");
        changeColorBtn(btnMonitoring);
    }//GEN-LAST:event_btnMonitoringActionPerformed

    private void btnRequestsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRequestsActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card2");
        changeColorBtn(btnRequests);
    }//GEN-LAST:event_btnRequestsActionPerformed

    private void btnPerfilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnPerfilActionPerformed
        CardLayout cl = (CardLayout) pnlDer.getLayout();
        cl.show(pnlDer, "card3");
        changeColorBtn(btnPerfil);
    }//GEN-LAST:event_btnPerfilActionPerformed

    private void changeColorBtn(JButton botonSeleccionado) {
        // Restaurar el estilo de todos los botones
        for (JButton boton : new JButton[]{btnPerfil, btnRequests, btnMonitoring, btnAssignment, btnReports, btnConnections}) {
            boton.setBackground(colorBackOrigin);
            boton.setForeground(colorTxtOrigin);
        }

        // Cambiar el estilo del botón seleccionado
        botonSeleccionado.setBackground(colorBackSelect);
        botonSeleccionado.setForeground(colorTxtSelect);
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUICoordinator.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GUICoordinator().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAssignment;
    private javax.swing.JButton btnCloseSession;
    private javax.swing.JButton btnConnections;
    private javax.swing.JButton btnMonitoring;
    private javax.swing.JButton btnPerfil;
    private javax.swing.JButton btnReports;
    private javax.swing.JButton btnRequests;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JPanel jpIzq;
    private javax.swing.JLabel lblCoordinator;
    private javax.swing.JLabel lblUser;
    private javax.swing.JPanel pnlAssingment;
    private javax.swing.JPanel pnlConnections;
    private javax.swing.JPanel pnlDer;
    private javax.swing.JPanel pnlMonitoring;
    private javax.swing.JPanel pnlPerfil;
    private javax.swing.JPanel pnlReports;
    private javax.swing.JPanel pnlRequests;
    private javax.swing.JSeparator sepUserCoord;
    // End of variables declaration//GEN-END:variables
}
