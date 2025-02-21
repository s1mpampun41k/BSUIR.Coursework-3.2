package org.example.acs_v2.controllers;

import lombok.RequiredArgsConstructor;
import org.example.acs_v2.models.Notification;
import org.example.acs_v2.models.User;
import org.example.acs_v2.services.NotificationService;
import org.example.acs_v2.services.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private final UserService userService;

    @GetMapping("/notifications")
    public String viewNotifications(Model model, Principal principal) {
        String username = principal.getName();

        Long userId = userService.getUserId(principal);
        String role = userService.getUserRole(principal);
        User user = userService.findByLogin(username);

        model.addAttribute("userId", userId != null ? userId.toString() : null);
        model.addAttribute("role", role);
        model.addAttribute("user", user != null ? user : new User());

        // Получаем список уведомлений для пользователя
        List<Notification> notifications = notificationService.getNotificationsForUser(userId);

        // Добавляем список уведомлений в модель
        model.addAttribute("notifications", notifications);

        return "notifications"; // Возвращаем имя представления (HTML страницы)
    }
}
