package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class UserServicesTest {

    @Mock
    private IUserRepository userRepository;

    private UserServices userServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Inicializa los mocks
        userServices = new UserServices(userRepository); // Inyecta el mock
    }

    @Test
    void testAutenticarUsuario_Success() {
        // Configuración del mock
        User user = new User(1, "test@example.com", "password", "ADMIN");
        when(userRepository.validarUsuario("test@example.com", "password")).thenReturn(user); // Simula autenticación exitosa

        // Ejecución del método
        boolean result = userServices.autenticarUsuario("test@example.com", "password");

        // Verificaciones
        assertTrue(result);
        verify(userRepository, times(1)).validarUsuario("test@example.com", "password");
    }

    @Test
    void testAutenticarUsuario_Failure() {
        // Configuración del mock
        when(userRepository.validarUsuario("test@example.com", "wrongpassword")).thenReturn(null); // Simula autenticación fallida

        // Ejecución del método
        boolean result = userServices.autenticarUsuario("test@example.com", "wrongpassword");

        // Verificaciones
        assertFalse(result);
        verify(userRepository, times(1)).validarUsuario("test@example.com", "wrongpassword");
    }

    @Test
    void testSaveUser_Success() {
        // Configuración del mock
        User user = new User(1, "test@example.com", "password", "ADMIN");
        when(userRepository.getUserIdByEmail("test@example.com")).thenReturn(-1); // No existe
        when(userRepository.saveUser(1, "test@example.com", "password", "ADMIN")).thenReturn(true); // Guardado exitoso

        // Ejecución del método
        boolean result = userServices.saveUser(user);

        // Verificaciones
        assertTrue(result);
        verify(userRepository, times(1)).getUserIdByEmail("test@example.com");
        verify(userRepository, times(1)).saveUser(1, "test@example.com", "password", "ADMIN");
    }

    @Test
    void testSaveUser_Failure_DuplicateEmail() {
        // Configuración del mock
        User user = new User(1, "test@example.com", "password", "ADMIN");
        when(userRepository.getUserIdByEmail("test@example.com")).thenReturn(1); // Ya existe

        // Ejecución del método
        boolean result = userServices.saveUser(user);

        // Verificaciones
        assertFalse(result);
        verify(userRepository, times(1)).getUserIdByEmail("test@example.com");
        verify(userRepository, never()).saveUser(anyInt(), anyString(), anyString(), anyString()); // No se debe llamar a saveUser
    }
}