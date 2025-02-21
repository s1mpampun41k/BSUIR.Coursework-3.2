package org.example.acs_v2.controllers;

import org.example.acs_v2.models.User;
import org.example.acs_v2.models.enums.LocationStudy;
import org.example.acs_v2.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ProfileEditController {

    private final UserService userService;
    private static final Logger logger = LoggerFactory.getLogger(ProfileEditController.class);

    public ProfileEditController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/user/edit/{userId}")
    public String showEditProfilePage(@PathVariable Long userId, Principal principal, Model model) {
        Long currentUserId = userService.getUserId(principal);

        if (principal != null) {
            System.out.println("Principal: " + principal.getName());  // Логирование имени пользователя
            String role = userService.getUserRole(principal);

            model.addAttribute("role", role);
        } else {
            model.addAttribute("role", null);
        }

        // Загружаем данные пользователя для редактирования
        User user = userService.findUserById(userId);

        // Преобразуем значения LocationStudy для отображения в HTML
        List<String> locationStudyList = Arrays.stream(LocationStudy.values())
                .map(Enum::name)
                .collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("locationStudyList", locationStudyList);

        return "edit-profile";
    }

    @PostMapping("/user/{userId}/update")
    public String updateProfile(@PathVariable Long userId,
                                @RequestParam String firstName,
                                @RequestParam String secondName,
                                @RequestParam String email,
                                @RequestParam String numberPhone,
                                @RequestParam(required = false) String city,
                                @RequestParam(required = false) String locationStudy,
                                @RequestParam(required = false) String description,
                                @RequestParam(required = false) String price,
                                @RequestParam(required = false) String educationSector,
                                @RequestParam(required = false) String tags, // Теги
                                Principal principal, Model model) {
        Long currentUserId = userService.getUserId(principal);

        if (!userId.equals(currentUserId)) {
            logger.error("Access denied for userId: {}", userId);
            throw new SecurityException("Access denied: You can only edit your profile");
        }

        try {
            // Преобразуем строку locationStudy в Enum
            LocationStudy locationStudyEnum = locationStudy != null ? LocationStudy.valueOf(locationStudy) : LocationStudy.NO_PREFERENCE;

            // Преобразуем строку тегов в Set<String>
            Set<String> tagSet = tags != null ? new HashSet<>(Arrays.asList(tags.split("\\s*,\\s*"))) : new HashSet<>();

            userService.updateUserProfile(userId, firstName, secondName, email, numberPhone, city,
                    locationStudyEnum, description, price != null ? Double.valueOf(price) : null,
                    educationSector, tagSet); // Передаем теги в метод сервиса

            model.addAttribute("message", "Profile updated successfully!");
            return "redirect:/user/{userId}"; // Перенаправляем обратно на страницу редактирования
        } catch (IllegalArgumentException e) {
            logger.error("Error updating profile for userId: {}", userId, e);
            model.addAttribute("error", e.getMessage());
            return "profile";
        }
    }

    // Утилита для преобразования строки в число (цена)
    private Double parsePrice(String price) {
        if (price == null || price.trim().isEmpty()) {
            return null;
        }
        try {
            return Double.parseDouble(price);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Price must be a valid number.");
        }
    }

    // Утилита для обработки списка тегов
    private List<String> parseTags(String tags) {
        if (tags == null || tags.trim().isEmpty()) {
            return List.of();
        }
        return Arrays.stream(tags.split(","))
                .map(String::trim)
                .collect(Collectors.toList());
    }
}
