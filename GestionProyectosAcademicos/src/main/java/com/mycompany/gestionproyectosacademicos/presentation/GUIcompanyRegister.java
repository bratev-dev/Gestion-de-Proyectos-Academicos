/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */

package com.mycompany.gestionproyectosacademicos.presentation;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.ConexionPostgreSQL;
import com.mycompany.gestionproyectosacademicos.entities.SaveDateCompany;
import com.mycompany.gestionproyectosacademicos.entities.SaveDateUser;
import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.services.AuthService;

//import com.mycompany.gestionproyectosacademicos.presentacion.PanelRound;
import javax.swing.JOptionPane;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Rubeiro Romero 
 */
//interface Company
public class GUIcompanyRegister extends javax.swing.JFrame {

    /**
     * Creates new form GUIcompanyRegister
     */
    public GUIcompanyRegister() {
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

        textField1 = new java.awt.TextField();
        jPanel1 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jPanel4 = new javax.swing.JPanel();
        button1 = new java.awt.Button();
        label2 = new java.awt.Label();
        label3 = new java.awt.Label();
        label4 = new java.awt.Label();
        label5 = new java.awt.Label();
        label6 = new java.awt.Label();
        label7 = new java.awt.Label();
        label8 = new java.awt.Label();
        JContactLastName = new java.awt.TextField();
        JContactPosition = new java.awt.TextField();
        JCompanyNIT = new java.awt.TextField();
        JContactNumber = new java.awt.TextField();
        label9 = new java.awt.Label();
        label10 = new java.awt.Label();
        label11 = new java.awt.Label();
        JCompanyEmail = new java.awt.TextField();
        JContactName = new java.awt.TextField();
        JCompanyName = new java.awt.TextField();
        label12 = new java.awt.Label();
        jSeparator2 = new javax.swing.JSeparator();
        password = new java.awt.TextField();
        label13 = new java.awt.Label();
        jSector = new javax.swing.JComboBox<>();
        jSeparator1 = new javax.swing.JSeparator();

        textField1.setText("textField1");

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(600, 400));
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(19, 45, 70));
        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(""));
        jPanel1.setForeground(new java.awt.Color(0, 0, 51));
        jPanel1.setPreferredSize(new java.awt.Dimension(400, 300));
        jPanel1.setVerifyInputWhenFocusTarget(false);

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("              Registro de empresa");

        jPanel4.setBackground(new java.awt.Color(219, 219, 219));
        jPanel4.setAlignmentX(0.0F);
        jPanel4.setAlignmentY(0.0F);

        button1.setActionCommand("Registrar");
        button1.setBackground(new java.awt.Color(102, 0, 0));
        button1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        button1.setForeground(new java.awt.Color(255, 255, 255));
        button1.setLabel("Registrar");
        button1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button1ActionPerformed(evt);
            }
        });

        label2.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        label2.setText("NIT de la empresa");

        label3.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label3.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        label3.setForeground(new java.awt.Color(19, 45, 70));
        label3.setText("Datos de la empresa");

        label4.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label4.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label4.setForeground(new java.awt.Color(19, 45, 70));
        label4.setText("Nombres*");

        label5.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label5.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        label5.setForeground(new java.awt.Color(19, 45, 70));
        label5.setText("Datos de contacto");

        label6.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label6.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label6.setForeground(new java.awt.Color(19, 45, 70));
        label6.setText("Telefono*");

        label7.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label7.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label7.setForeground(new java.awt.Color(19, 45, 70));
        label7.setText("Apellidos*");

        label8.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label8.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label8.setForeground(new java.awt.Color(19, 45, 70));
        label8.setText("Cargo*");

        JContactLastName.setText("1");
        JContactLastName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JContactLastNameActionPerformed(evt);
            }
        });

        JContactPosition.setName(""); // NOI18N
        JContactPosition.setText("1");
        JContactPosition.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JContactPositionActionPerformed(evt);
            }
        });

        JCompanyNIT.setName(""); // NOI18N
        JCompanyNIT.setText("1");
        JCompanyNIT.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JCompanyNITActionPerformed(evt);
            }
        });

        JContactNumber.setName(""); // NOI18N
        JContactNumber.setText("1");
        JContactNumber.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JContactNumberActionPerformed(evt);
            }
        });

        label9.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label9.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label9.setForeground(new java.awt.Color(19, 45, 70));
        label9.setText("NIT de la empresa*");

        label10.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label10.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label10.setForeground(new java.awt.Color(19, 45, 70));
        label10.setText("Sector*");

        label11.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label11.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label11.setForeground(new java.awt.Color(19, 45, 70));
        label11.setText("Nombre*");

        JCompanyEmail.setText("1");
        JCompanyEmail.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JCompanyEmailActionPerformed(evt);
            }
        });

        JContactName.setText("1");
        JContactName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JContactNameActionPerformed(evt);
            }
        });

        JCompanyName.setText("1");
        JCompanyName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JCompanyNameActionPerformed(evt);
            }
        });

        label12.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label12.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label12.setForeground(new java.awt.Color(19, 45, 70));
        label12.setText("Email*");

        jSeparator2.setForeground(new java.awt.Color(153, 51, 0));
        jSeparator2.setOrientation(javax.swing.SwingConstants.VERTICAL);
        jSeparator2.setPreferredSize(new java.awt.Dimension(50, 30));

        password.setText("1");
        password.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                passwordActionPerformed(evt);
            }
        });

        label13.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        label13.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        label13.setForeground(new java.awt.Color(19, 45, 70));
        label13.setText("Contraseña*");

        jSector.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Tecnologia", "Salud", "Educacion", "Servicios", "Otros" }));
        jSector.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jSectorActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addGap(26, 26, 26)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(label3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 87, Short.MAX_VALUE)
                        .addComponent(label5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(33, 33, 33))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addComponent(JCompanyEmail, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(password, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jSector, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(51, 51, 51)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                            .addComponent(label8, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(JContactNumber, javax.swing.GroupLayout.DEFAULT_SIZE, 158, Short.MAX_VALUE)
                            .addComponent(JContactPosition, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel4Layout.createSequentialGroup()
                        .addGap(2, 2, 2)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel4Layout.createSequentialGroup()
                                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                            .addComponent(JCompanyName, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                            .addComponent(JCompanyNIT, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                        .addGap(53, 53, 53))
                                    .addGroup(jPanel4Layout.createSequentialGroup()
                                        .addComponent(label12, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(JContactName, javax.swing.GroupLayout.DEFAULT_SIZE, 158, Short.MAX_VALUE)
                                    .addComponent(label6, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(JContactLastName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(label4, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label13, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 7, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(16, 16, 16)
                                .addComponent(label2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label11, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 278, Short.MAX_VALUE)))
                        .addComponent(label7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel4Layout.createSequentialGroup()
                        .addGap(205, 205, 205)
                        .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(25, 25, 25))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(19, 19, 19)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(label5, javax.swing.GroupLayout.PREFERRED_SIZE, 21, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(label3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(label9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(label4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, 0)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(JContactName, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(JCompanyNIT, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, 0)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addGap(2, 2, 2)
                                .addComponent(label11, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(label7, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(JContactLastName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(JCompanyName, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(0, 0, 0)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, 0)
                                .addComponent(JContactNumber, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label12, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, 0)
                                .addComponent(JCompanyEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(label8, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(label10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, 0)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(JContactPosition, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jSector, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, 0)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(label2, javax.swing.GroupLayout.PREFERRED_SIZE, 0, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                                .addComponent(label13, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, 0)
                                .addComponent(password, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(21, 21, 21))))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(2, 2, 2)
                        .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 208, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(16, Short.MAX_VALUE))
        );

        label4.getAccessibleContext().setAccessibleDescription("Nombres");
        JCompanyNIT.getAccessibleContext().setAccessibleDescription("");
        label9.getAccessibleContext().setAccessibleName("Nit de  la empresa");

        jSeparator1.setForeground(new java.awt.Color(153, 51, 0));
        jSeparator1.setPreferredSize(new java.awt.Dimension(50, 30));

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(70, 70, 70)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(99, 99, 99)
                        .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 247, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(112, 112, 112))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(14, 14, 14)
                .addComponent(jLabel2)
                .addGap(0, 0, 0)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 8, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(56, Short.MAX_VALUE))
        );

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 580, 420));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JContactPositionActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactPositionActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JContactPositionActionPerformed

    private void JContactLastNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactLastNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JContactLastNameActionPerformed
 SaveDateCompany saveCompany = new SaveDateCompany(); 
 
    private void button1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button1ActionPerformed
        // TODO add your handling code here:
        
        if(JCompanyNIT.getText().isEmpty()
                ||JCompanyEmail.getText().isEmpty()
                ||JCompanyName.getText().isEmpty()
                ||JContactName.getText().isEmpty()
                ||JContactNumber.getText().isEmpty()
                ||JContactLastName.getText().isEmpty()
                || JContactPosition.getText().isEmpty()){
            JOptionPane.showMessageDialog(null
                    ,"Por favor dijite los campos obligatorios. "
                            + "Estan marcados con: * "
                    , "¡ERROR!",JOptionPane.WARNING_MESSAGE);
        }else{
            try {
                // Validar NIT
                String nitTexto = JCompanyNIT.getText().trim();
                if (!nitTexto.matches("\\d+")) {
                    JOptionPane.showMessageDialog(null, "Error: El NIT solo debe contener números.", "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                int nit = Integer.parseInt(nitTexto);

                // Validar Número de Contacto
                String telefonoTexto = JContactNumber.getText().trim();
                if (!telefonoTexto.matches("\\d+")) {
                    JOptionPane.showMessageDialog(null, "Error: El número de contacto debe contener solo números.", "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                int telefono = Integer.parseInt(telefonoTexto);

                // Crear la empresa
                Company company = new Company(
                    JCompanyName.getText().trim(),
                    nit,
                    JCompanyEmail.getText().trim(),
                    jSector.getSelectedItem().toString().trim(),
                    JContactName.getText().trim(),
                    JContactLastName.getText().trim(),
                    JContactNumber.getText().trim(),
                    JContactPosition.getText().trim()
                );
                SaveDateCompany saveCompany = new SaveDateCompany();
                boolean save = saveCompany.saveCompany(company);

                if (save){
                    User user=new User(nit,JCompanyEmail.getText().trim(),
                        password.getText().trim(), "Empresa");
                SaveDateUser saveUser = new SaveDateUser();
                saveUser.saveUser(user);
                }else{
                    return;
                }
                

            } catch (NumberFormatException e) {
                JOptionPane.showMessageDialog(null, "Error: Ingrese solo números en el NIT y el número de contacto.", "Error", JOptionPane.ERROR_MESSAGE);
            }

                   AuthService authService = new AuthService(null); // Crear la instancia del servicio de autenticación
                   GUILogin login = new GUILogin(authService); // Pasar la instancia al constructor
                   login.setVisible(true); // Mostrar la ventana
                   
                   this.dispose();
        }
    }//GEN-LAST:event_button1ActionPerformed

    private void JCompanyNITActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyNITActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JCompanyNITActionPerformed

    private void JContactNumberActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactNumberActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JContactNumberActionPerformed

    private void JCompanyEmailActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyEmailActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JCompanyEmailActionPerformed

    private void JContactNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JContactNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JContactNameActionPerformed

    private void JCompanyNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JCompanyNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JCompanyNameActionPerformed

    private void passwordActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_passwordActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_passwordActionPerformed

    private void jSectorActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jSectorActionPerformed
        // TODO add your handling code here:
        String sector = jSector.getSelectedItem().toString();
    }//GEN-LAST:event_jSectorActionPerformed


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
            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUIcompanyRegister.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GUIcompanyRegister().setVisible(true);
            }
        });
    }

  
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private java.awt.TextField JCompanyEmail;
    private java.awt.TextField JCompanyNIT;
    private java.awt.TextField JCompanyName;
    private java.awt.TextField JContactLastName;
    private java.awt.TextField JContactName;
    private java.awt.TextField JContactNumber;
    private java.awt.TextField JContactPosition;
    private java.awt.Button button1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JComboBox<String> jSector;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private java.awt.Label label10;
    private java.awt.Label label11;
    private java.awt.Label label12;
    private java.awt.Label label13;
    private java.awt.Label label2;
    private java.awt.Label label3;
    private java.awt.Label label4;
    private java.awt.Label label5;
    private java.awt.Label label6;
    private java.awt.Label label7;
    private java.awt.Label label8;
    private java.awt.Label label9;
    private java.awt.TextField password;
    private java.awt.TextField textField1;
    // End of variables declaration//GEN-END:variables
}
