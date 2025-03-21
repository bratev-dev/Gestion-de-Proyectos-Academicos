package com.mycompany.gestionproyectosacademicos.presentation;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GUICoordinatorButtonEditor extends DefaultCellEditor {
    private JPanel panel;
    private JButton btnSeeDetails;
    private JButton btnComment;
    private int currentRow;
    private GUICoordinator guiCoordinator;

    public GUICoordinatorButtonEditor(JCheckBox checkBox, CommentListener commentListener) {
        super(checkBox);
        this.guiCoordinator = guiCoordinator;
        panel = new JPanel(new FlowLayout(FlowLayout.CENTER, 5, 0));
        panel.setOpaque(true);
        
        btnSeeDetails = new JButton("Ver más");
        customizeButton(btnSeeDetails);
        
        btnComment = new JButton("Comentar");
        customizeButton(btnComment);

        btnSeeDetails.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Lógica para el botón "Ver más"
                if (guiCoordinator != null) {
                    guiCoordinator.openSeeDetails(currentRow); // Llamar a un método en GUICoordinator
                }
                fireEditingStopped();
            }
        });

        btnComment.addActionListener(e -> {
            // Obtener el proyecto de la fila seleccionada
            int row = tblRequests.convertRowIndexToModel(tblRequests.getEditingRow());
            List<Project> projects = guiCoordinator.getProjects(); // Método para obtener la lista de proyectos
            if (row >= 0 && row < projects.size()) {
                project = projects.get(row);
                guiCoordinator.comment(project); // Pasar el proyecto seleccionado
            }
        });

        panel.add(btnSeeDetails);
        panel.add(btnComment);
    }

    private void customizeButton(JButton button) {
        button.setOpaque(true);
        button.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9
        button.setBorder(BorderFactory.createEmptyBorder()); // Sin bordes
        button.setFont(new Font("Tahoma", Font.BOLD, 20)); // Fuente Tahoma, Bold, tamaño 20
        button.setFocusPainted(false); // Eliminar el borde de enfoque
    }
    
    @Override
    public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {
        currentRow = row;
        panel.setBackground(table.getSelectionBackground());
        return panel;

    }

    @Override
    public Object getCellEditorValue() {
        return "";
    }
}