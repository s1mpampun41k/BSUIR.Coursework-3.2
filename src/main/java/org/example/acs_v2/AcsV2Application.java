package org.example.acs_v2;

import org.example.acs_v2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AcsV2Application {

    public static void main(String[] args) {
        SpringApplication.run(AcsV2Application.class, args);
    }
}
