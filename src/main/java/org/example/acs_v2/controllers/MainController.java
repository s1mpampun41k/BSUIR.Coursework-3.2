package org.example.acs_v2.controllers;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.acs_v2.models.User;
import org.example.acs_v2.services.TutorSearchService;
import org.example.acs_v2.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final UserService userService;
    private final TutorSearchService tutorSearchService;

    @GetMapping("/")
    public String product(Principal principal, Model model) {
        if (principal != null) {
            String username = principal.getName();
            log.info("Authenticated user: {}", username);

            Long userId = userService.getUserId(principal);
            String role = userService.getUserRole(principal);
            User user = userService.findByLogin(username);

            model.addAttribute("userId", userId != null ? userId.toString() : null);
            model.addAttribute("role", role);
            model.addAttribute("user", user != null ? user : new User());
        } else {
            log.info("No authenticated user.");
            model.addAttribute("userId", null);
            model.addAttribute("role", null);
            model.addAttribute("user", new User());
        }

        // Передаем данные для фильтрации
        List<String> cities = tutorSearchService.getCities();
        List<String> educationSectors = tutorSearchService.getEducationSectors();

        model.addAttribute("cities", cities);
        model.addAttribute("educationSectors", educationSectors);

        model.addAttribute("selectedCity", "Город не выбран");
        model.addAttribute("selectedEducationSector", "Сфера не выбрана");
        model.addAttribute("query", "");
        model.addAttribute("minPrice", 0);
        model.addAttribute("maxPrice", 1000);
        model.addAttribute("locationStudy", "NO_PREFERENCE");

        model.addAttribute("city", "Город не выбран");
        model.addAttribute("sector", "Сектор не выбран");

//        userService.createAdminIfNotExist();

        return "index";
    }
}
