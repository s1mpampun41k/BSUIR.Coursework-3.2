package org.example.acs_v2.models;

import lombok.Data;
import org.example.acs_v2.models.enums.Role;
import org.example.acs_v2.models.enums.Status;
import org.springframework.security.core.GrantedAuthority;


import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "workers")
@Data
public class Worker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "surname")
    private String surname;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private Status status;

    @Column(name = "number_phone")
    private String numberPhone;

    @Column(name = "hours")
    private float hours;

    @Column(name = "cardNumber")
    private float cardNumber;
    
}
