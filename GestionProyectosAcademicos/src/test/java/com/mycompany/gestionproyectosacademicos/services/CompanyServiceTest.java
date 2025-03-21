package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.access.ICompanyRepository;
import com.mycompany.gestionproyectosacademicos.access.IUserRepository;
import com.mycompany.gestionproyectosacademicos.entities.Company;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class CompanyServiceTest {

    @Mock
    private ICompanyRepository companyRepository;

    @Mock
    private IUserRepository userRepository;

    private CompanyService companyService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Inicializa los mocks
        companyService = new CompanyService(companyRepository, userRepository); // Inyecta los mocks
    }

    @Test
    void testRegisterCompany_Success() {
        // Configuración del mock
        Company company = new Company("Empresa A", "123456", "info@empresa.com", "TECHNOLOGY", 
                                     "John", "Doe", "555-1234", "CEO");

        when(companyRepository.existsCompany("123456", "info@empresa.com")).thenReturn(false); // No existe
        when(companyRepository.save(company)).thenReturn(true); // Guardado exitoso

        // Ejecución del método
        boolean result = companyService.registerCompany(company);

        // Verificaciones
        assertTrue(result);
        verify(companyRepository, times(1)).existsCompany("123456", "info@empresa.com");
        verify(companyRepository, times(1)).save(company);
    }

    @Test
    void testRegisterCompany_Failure_DuplicateCompany() {
        // Configuración del mock
        Company company = new Company("Empresa A", "123456", "info@empresa.com", "TECHNOLOGY", 
                                     "John", "Doe", "555-1234", "CEO");

        when(companyRepository.existsCompany("123456", "info@empresa.com")).thenReturn(true); // Ya existe

        // Ejecución del método
        boolean result = companyService.registerCompany(company);

        // Verificaciones
        assertFalse(result);
        verify(companyRepository, times(1)).existsCompany("123456", "info@empresa.com");
        verify(companyRepository, never()).save(company); // No se debe llamar a save
    }

    @Test
    void testRegisterCompany_Failure_SaveError() {
        // Configuración del mock
        Company company = new Company("Empresa A", "123456", "info@empresa.com", "TECHNOLOGY", 
                                     "John", "Doe", "555-1234", "CEO");

        when(companyRepository.existsCompany("123456", "info@empresa.com")).thenReturn(false); // No existe
        when(companyRepository.save(company)).thenReturn(false); // Error al guardar

        // Ejecución del método
        boolean result = companyService.registerCompany(company);

        // Verificaciones
        assertFalse(result);
        verify(companyRepository, times(1)).existsCompany("123456", "info@empresa.com");
        verify(companyRepository, times(1)).save(company);
    }
}