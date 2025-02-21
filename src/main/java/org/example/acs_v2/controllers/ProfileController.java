package org.example.acs_v2.controllers;

import org.example.acs_v2.models.User;
import org.example.acs_v2.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.security.Principal;

@Controller
public class ProfileController {

    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/user/{userId}")
    public String getProfilePage(@PathVariable Long userId, Principal principal, Model model) {
        // Получение ID текущего пользователя
        Long currentUserId = userService.getUserId(principal);

        // Проверка, совпадает ли ID профиля с текущим пользователем
        if (!currentUserId.equals(userId)) {
            return "error/403"; // Страница доступа запрещена
        }

        // Попытка загрузить пользователя
        User user = userService.findUserById(userId);
        if (user == null) {
            return "error/404"; // Страница не найдена
        }

        model.addAttribute("user", user);

        if (principal != null) {
            System.out.println("Principal: " + principal.getName());  // Логирование имени пользователя
            String role = userService.getUserRole(principal);

            model.addAttribute("role", role);
        } else {
            model.addAttribute("role", null);
        }
        return "profile";
    }
}
