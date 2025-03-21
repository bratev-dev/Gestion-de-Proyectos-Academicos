package com.mycompany.gestionproyectosacademicos.domain.entities;

import com.mycompany.gestionproyectosacademicos.entities.User;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

public class UserTest {

    @Test
    void testUserConstructorAndGetters() {
        User user = new User(1, "user@example.com", "password123", "ADMIN");

        assertThat(user.getId()).isEqualTo(1);
        assertThat(user.getEmail()).isEqualTo("user@example.com");
        assertThat(user.getPassword()).isEqualTo("password123");
        assertThat(user.getRole()).isEqualTo("ADMIN");
    }

    @Test
    void testSetters() {
        User user = new User(0, "", "", "");

        user.setId(2);
        user.setEmail("newuser@example.com");
        user.setPassword("newpassword");
        user.setRole("COORDINADOR");

        assertThat(user.getId()).isEqualTo(2);
        assertThat(user.getEmail()).isEqualTo("newuser@example.com");
        assertThat(user.getPassword()).isEqualTo("newpassword");
        assertThat(user.getRole()).isEqualTo("COORDINADOR");
    }
}