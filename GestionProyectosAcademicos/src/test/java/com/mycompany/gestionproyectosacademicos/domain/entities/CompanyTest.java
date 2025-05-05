package com.mycompany.gestionproyectosacademicos.domain.entities;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

public class CompanyTest {

    @Test
    void testCompanyConstructorAndGetters() {
        Company company = new Company("Tech Corp", Long.valueOf(123456789), "info@techcorp.com", "TECHNOLOGY", 
                                      "John", "Doe", "555-1234", "CEO","1234");

        assertThat(company.getName()).isEqualTo("Tech Corp");
        assertThat(company.getNit()).isEqualTo("123456789");
        assertThat(company.getEmail()).isEqualTo("info@techcorp.com");
        assertThat(company.getSector()).isEqualTo("TECHNOLOGY");
        assertThat(company.getContactNames()).isEqualTo("John");
        assertThat(company.getContactLastNames()).isEqualTo("Doe");
        assertThat(company.getContactPhoneNumber()).isEqualTo("555-1234");
        assertThat(company.getContactPosition()).isEqualTo("CEO");
    }

    @Test
    void testSetters() {
        Company company = new Company("", Long.valueOf(""), "", "", "", "", "", "","");

        company.setName("Health Corp");
        company.setNit(Long.valueOf(987654321));
        company.setEmail("info@healthcorp.com");
        company.setSector("HEALTH");
        company.setContactNames("Jane");
        company.setContactLastNames("Smith");
        company.setContactPhoneNumber("555-5678");
        company.setContactPosition("CTO");

        assertThat(company.getName()).isEqualTo("Health Corp");
        assertThat(company.getNit()).isEqualTo("987654321");
        assertThat(company.getEmail()).isEqualTo("info@healthcorp.com");
        assertThat(company.getSector()).isEqualTo("HEALTH");
        assertThat(company.getContactNames()).isEqualTo("Jane");
        assertThat(company.getContactLastNames()).isEqualTo("Smith");
        assertThat(company.getContactPhoneNumber()).isEqualTo("555-5678");
        assertThat(company.getContactPosition()).isEqualTo("CTO");
    }
}