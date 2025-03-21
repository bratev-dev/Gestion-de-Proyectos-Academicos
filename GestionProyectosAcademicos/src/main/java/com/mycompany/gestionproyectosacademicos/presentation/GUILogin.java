/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.mycompany.gestionproyectosacademicos.presentation;

import com.mycompany.gestionproyectosacademicos.access.CompanyPostgreSQLRepository;
import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.UserArrayRepository;
import com.mycompany.gestionproyectosacademicos.access.ConexionPostgreSQL;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.access.UserPostgreRepository;
import com.mycompany.gestionproyectosacademicos.infra.Messages;
import com.mycompany.gestionproyectosacademicos.entities.User;
import com.mycompany.gestionproyectosacademicos.services.AuthService;
import com.mycompany.gestionproyectosacademicos.services.CompanyService;
import com.mycompany.gestionproyectosacademicos.services.UserServices;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class GUILogin extends javax.swing.JFrame {
    private AuthService authService;
    private UserServices userService;
    private CompanyService companyService;
    
    public GUILogin(AuthService authService, UserServices userService, CompanyService companyService) {
        initComponents(); // Llamada al código autogenerado
        setLocationRelativeTo(null); // Para centrar la ventana
        this.authService = authService;
        this.userService = userService;
        this.companyService = companyService;
        // Agregar placeholders después de que se inicialicen los componentes
        agregarPlaceholder(txtEmail, "Ingrese su correo!");
        agregarPlaceholder(txtPassword, "Ingrese su contraseña!");
    }
    
    public GUILogin(AuthService authService) {
        initComponents(); // Llamada al código autogenerado
        setLocationRelativeTo(null); // Para centrar la ventana
        this.authService = authService;
        // Agregar placeholders después de que se inicialicen los componentes
        agregarPlaceholder(txtEmail, "Ingrese su correo!");
        agregarPlaceholder(txtPassword, "Ingrese su contraseña!");
    }
    
    
    private void agregarPlaceholder(JTextField textField, String placeholder) {
        textField.setText(placeholder);
        textField.setForeground(Color.GRAY);

        textField.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
                if (textField.getText().equals(placeholder)) {
                    textField.setText("");
                    textField.setForeground(Color.BLACK);
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
                if (textField.getText().isEmpty()) {
                    textField.setText(placeholder);
                    textField.setForeground(Color.GRAY);
                }
            }
        });
    }
    
    

  

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel4 = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        jPanel7 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        txtEmail = new javax.swing.JTextField();
        btnLogin = new javax.swing.JButton();
        jLabel4 = new javax.swing.JLabel();
        txtPassword = new javax.swing.JTextField();
        btnRegister = new javax.swing.JButton();
        lblUser = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();

        jPanel4.setBackground(new java.awt.Color(19, 45, 70));
        jPanel4.setPreferredSize(new java.awt.Dimension(600, 70));

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 616, Short.MAX_VALUE)
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 70, Short.MAX_VALUE)
        );

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setAutoRequestFocus(false);
        setBackground(new java.awt.Color(19, 45, 70));
        setLocation(new java.awt.Point(0, 0));
        setMaximumSize(new java.awt.Dimension(400, 400));
        setMinimumSize(new java.awt.Dimension(400, 400));
        setResizable(false);
        setSize(new java.awt.Dimension(400, 400));

        jPanel1.setBackground(new java.awt.Color(19, 45, 70));
        jPanel1.setMaximumSize(new java.awt.Dimension(400, 400));
        jPanel1.setMinimumSize(new java.awt.Dimension(960, 540));
        jPanel1.setName(""); // NOI18N
        jPanel1.setPreferredSize(new java.awt.Dimension(400, 400));
        jPanel1.setLayout(new java.awt.BorderLayout());

        jPanel7.setBackground(new java.awt.Color(19, 45, 70));
        jPanel7.setDebugGraphicsOptions(javax.swing.DebugGraphics.NONE_OPTION);
        jPanel7.setDoubleBuffered(false);

        jLabel1.setDisplayedMnemonic('f');
        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Dirección de correo electronico*");

        txtEmail.setBackground(new java.awt.Color(227, 227, 227));
        txtEmail.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        txtEmail.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        txtEmail.setDoubleBuffered(true);
        txtEmail.setMaximumSize(new java.awt.Dimension(214, 214));
        txtEmail.setName(""); // NOI18N
        txtEmail.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtEmailActionPerformed(evt);
            }
        });

        btnLogin.setBackground(new java.awt.Color(42, 74, 104));
        btnLogin.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnLogin.setForeground(new java.awt.Color(255, 255, 255));
        btnLogin.setText("Iniciar Sesión");
        btnLogin.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        btnLogin.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnLogin.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnLoginMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnLoginMouseExited(evt);
            }
        });
        btnLogin.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnLoginActionPerformed(evt);
            }
        });

        jLabel4.setDisplayedMnemonic('f');
        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel4.setText("Contraseña*");

        txtPassword.setBackground(new java.awt.Color(227, 227, 227));
        txtPassword.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        txtPassword.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        txtPassword.setDoubleBuffered(true);
        txtPassword.setMaximumSize(new java.awt.Dimension(214, 214));
        txtPassword.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                txtPasswordKeyPressed(evt);
            }
        });

        btnRegister.setBackground(new java.awt.Color(102, 0, 0));
        btnRegister.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnRegister.setForeground(new java.awt.Color(255, 255, 255));
        btnRegister.setText("Registrar Empresa");
        btnRegister.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        btnRegister.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnRegister.setFocusPainted(false);
        btnRegister.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnRegisterMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnRegisterMouseExited(evt);
            }
        });
        btnRegister.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegisterActionPerformed(evt);
            }
        });

        lblUser.setFont(new java.awt.Font("Tahoma", 0, 30)); // NOI18N
        lblUser.setForeground(new java.awt.Color(255, 255, 255));
        lblUser.setText("Iniciar Sesión");

        jPanel2.setBackground(new java.awt.Color(102, 0, 0));
        jPanel2.setForeground(new java.awt.Color(102, 0, 0));
        jPanel2.setPreferredSize(new java.awt.Dimension(217, 5));

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 226, Short.MAX_VALUE)
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 5, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel7Layout.createSequentialGroup()
                        .addGap(134, 134, 134)
                        .addComponent(btnLogin, javax.swing.GroupLayout.PREFERRED_SIZE, 115, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel7Layout.createSequentialGroup()
                        .addGap(99, 99, 99)
                        .addComponent(lblUser))
                    .addGroup(jPanel7Layout.createSequentialGroup()
                        .addGap(76, 76, 76)
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, 226, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                .addGap(0, 44, Short.MAX_VALUE)
                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                        .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 300, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel7Layout.createSequentialGroup()
                                .addGap(111, 111, 111)
                                .addComponent(jLabel4))
                            .addGroup(jPanel7Layout.createSequentialGroup()
                                .addGap(25, 25, 25)
                                .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, 250, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel7Layout.createSequentialGroup()
                                .addGap(41, 41, 41)
                                .addComponent(jLabel1)))
                        .addGap(42, 42, 42))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                        .addComponent(btnRegister, javax.swing.GroupLayout.PREFERRED_SIZE, 154, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(115, 115, 115))))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addComponent(lblUser)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(28, 28, 28)
                .addComponent(jLabel1)
                .addGap(12, 12, 12)
                .addComponent(txtEmail, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(14, 14, 14)
                .addComponent(jLabel4)
                .addGap(8, 8, 8)
                .addComponent(txtPassword, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(41, 41, 41)
                .addComponent(btnLogin, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(btnRegister, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(47, Short.MAX_VALUE))
        );

        jPanel1.add(jPanel7, java.awt.BorderLayout.CENTER);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        setBounds(0, 0, 400, 400);
    }// </editor-fold>//GEN-END:initComponents

    private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnLoginActionPerformed
        String email = txtEmail.getText().trim();
        String password = txtPassword.getText().trim();

        if (!validarEntrada(email, password)) {
            return;
        }

        JFrame nextGUI = autenticarUsuario(email, password);
        if (nextGUI != null) {
            Messages.showMessageDialog("Inicio de sesión exitoso", "Éxito");
            nextGUI.setVisible(true);
            this.dispose();
        } else {
            Messages.showMessageDialog("Credenciales incorrectas", "Error");
        }
    }

    private boolean validarEntrada(String email, String password) {
        if (email.isEmpty()) {
            Messages.showMessageDialog("Debe agregar el Email", "Atención");
            txtEmail.requestFocus();
            return false;
        }

        String regExEmail = "^[A-Za-z0-9+_.-]+@(.+)\\.com$";
        if (!Pattern.matches(regExEmail, email)) {
            Messages.showMessageDialog("El email ingresado no es válido.", "Atención");
            txtEmail.requestFocus();
            return false;
        }

        if (password.isEmpty()) {
            Messages.showMessageDialog("Debe ingresar la contraseña", "Atención");
            txtPassword.requestFocus();
            return false;
        }

        return true;
    }

    private JFrame autenticarUsuario(String email, String password) {
        return authService.login(email, password);
        
    }//GEN-LAST:event_btnLoginActionPerformed

    private void btnLoginMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnLoginMouseEntered
        btnLogin.setBackground(Color.gray);        // TODO add your handling code here:
    }//GEN-LAST:event_btnLoginMouseEntered

    private void btnLoginMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnLoginMouseExited
        Color colorNormal = new Color(42, 74, 104);
        btnLogin.setBackground(colorNormal);// TODO add your handling code here:
    }//GEN-LAST:event_btnLoginMouseExited

    private void btnRegisterMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnRegisterMouseEntered
        btnRegister.setBackground(Color.gray);// TODO add your handling code here:
    }//GEN-LAST:event_btnRegisterMouseEntered

    private void btnRegisterMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnRegisterMouseExited
       Color colorNormal = new Color(102,0,0);
       btnRegister.setBackground(colorNormal);// // TODO add your handling code here:
    }//GEN-LAST:event_btnRegisterMouseExited

    private void txtEmailActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtEmailActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtEmailActionPerformed

  
    private void txtPasswordKeyPressed(java.awt.event.KeyEvent evt) {
        if (evt.getKeyCode() == KeyEvent.VK_ENTER) {
            btnLogin.doClick();
        }
    }
  
private void btnRegisterActionPerformed(java.awt.event.ActionEvent evt) {
   GUIcompanyRegister register = new GUIcompanyRegister(companyService);    // GUICompany Register
   register.setVisible(true);
}



    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnLogin;
    private javax.swing.JButton btnRegister;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JLabel lblUser;
    private javax.swing.JTextField txtEmail;
    private javax.swing.JTextField txtPassword;
    // End of variables declaration//GEN-END:variables
}
