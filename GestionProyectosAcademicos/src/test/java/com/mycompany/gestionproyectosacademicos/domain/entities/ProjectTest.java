package com.mycompany.gestionproyectosacademicos.domain.entities;

import com.mycompany.gestionproyectosacademicos.entities.Company;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

public class ProjectTest {

    @Test
    void testProjectConstructorAndGetters() {
        Company company = new Company("Tech Corp", "123456789", "info@techcorp.com", "TECHNOLOGY", 
                                      "John", "Doe", "555-1234", "CEO");

        Project project = new Project(1, "Project Alpha", "Summary of Project Alpha", "Goals of Project Alpha", 
                                      "Description of Project Alpha", "12", "100000", "2023-10-01", "ACTIVE", company);

        assertThat(project.getId()).isEqualTo(1);
        assertThat(project.getName()).isEqualTo("Project Alpha");
        assertThat(project.getSummary()).isEqualTo("Summary of Project Alpha");
        assertThat(project.getGoals()).isEqualTo("Goals of Project Alpha");
        assertThat(project.getDescription()).isEqualTo("Description of Project Alpha");
        assertThat(project.getMaxTimeInMonths()).isEqualTo("12");
        assertThat(project.getBudget()).isEqualTo("100000");
        assertThat(project.getDate()).isEqualTo("2023-10-01");
        assertThat(project.getState()).isEqualTo("ACTIVE");
        assertThat(project.getCompany()).isEqualTo(company);
    }

    @Test
    void testSetters() {
        Company company = new Company("Tech Corp", "123456789", "info@techcorp.com", "TECHNOLOGY", 
                                      "John", "Doe", "555-1234", "CEO");

        Project project = new Project(0, "", "", "", "", "", "", "", "", null);

        project.setId(2);
        project.setName("Project Beta");
        project.setSummary("Summary of Project Beta");
        project.setGoals("Goals of Project Beta");
        project.setDescription("Description of Project Beta");
        project.setMaxTimeInMonths("24");
        project.setBudget("200000");
        project.setDate("2024-01-01");
        project.setState("PENDING");
        project.setCompany(company);

        assertThat(project.getId()).isEqualTo(2);
        assertThat(project.getName()).isEqualTo("Project Beta");
        assertThat(project.getSummary()).isEqualTo("Summary of Project Beta");
        assertThat(project.getGoals()).isEqualTo("Goals of Project Beta");
        assertThat(project.getDescription()).isEqualTo("Description of Project Beta");
        assertThat(project.getMaxTimeInMonths()).isEqualTo("24");
        assertThat(project.getBudget()).isEqualTo("200000");
        assertThat(project.getDate()).isEqualTo("2024-01-01");
        assertThat(project.getState()).isEqualTo("PENDING");
        assertThat(project.getCompany()).isEqualTo(company);
    }
}