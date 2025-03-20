package com.mycompany.gestionproyectosacademicos.presentation;

import com.mycompany.gestionproyectosacademicos.entities.Project;

public interface CommentListener {
    void onCommentButtonClicked(Project project); // Método para manejar el clic en el botón "Comentar"
}
