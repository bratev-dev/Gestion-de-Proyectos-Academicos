package com.mycompany.gestionproyectosacademicos.presentation;

import javax.swing.*;
import javax.swing.table.TableCellRenderer;
import java.awt.*;

public class GUICoordinatorButtonRenderer extends JPanel implements TableCellRenderer {
    private JButton btnSeeDetails;
    private JButton btnComment;

    public GUICoordinatorButtonRenderer() {
        setLayout(new FlowLayout(FlowLayout.CENTER, 5, 0));
        setOpaque(true);
        setBackground(new Color(232, 232, 232));

        btnSeeDetails = new JButton("Ver más");
        customizeButton(btnSeeDetails);
        
        btnComment = new JButton("Comentar");
        customizeButton(btnComment);

        add(btnSeeDetails);
        add(btnComment);
    }

    private void customizeButton(JButton button) {
        button.setOpaque(true);
        button.setBackground(new Color(217, 217, 217)); // Color de fondo #D9D9D9
        button.setBorder(BorderFactory.createEmptyBorder()); // Sin bordes
        button.setFont(new Font("Tahoma", Font.BOLD, 20)); // Fuente Tahoma, Bold, tamaño 20
        button.setFocusPainted(false); // Eliminar el borde de enfoque
    }

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        // Mantener consistencia visual con la tabla
        if (isSelected) {
            setBackground(table.getSelectionBackground());
        } else {
            setBackground(table.getBackground());
        }
        return this;
    }
}