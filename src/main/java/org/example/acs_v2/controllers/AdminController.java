package org.example.acs_v2.controllers;

import org.example.acs_v2.models.User;
import org.example.acs_v2.repositories.UserRepository;
import org.example.acs_v2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.List;

@Controller
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final UserService userService;
    private final UserRepository userRepository;

    @Autowired
    public AdminController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    // Страница со списком пользователей
    @GetMapping("/admin/users")
    public String getUsers(Model model, Principal principal) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        String userLogin = principal.getName();

        Long userId = userService.getUserId(principal);
        String role = userService.getUserRole(principal);
        User user = userService.findByLogin(userLogin);

        model.addAttribute("userId", userId != null ? userId.toString() : null);
        model.addAttribute("role", role);
        model.addAttribute("user", user != null ? user : new User());
        return "admin-users";
    }

    // Блокировка пользователя
    @PostMapping("/admin/users/ban/{id}")
    public String banUser(@PathVariable Long id) {
        userService.changeUserStatus(id, false); // Блокируем пользователя
        return "redirect:/admin/users"; // После изменения перенаправляем обратно на страницу
    }

    // Разблокировка пользователя
    @PostMapping("/admin/users/unban/{id}")
    public String unbanUser(@PathVariable Long id) {
        userService.changeUserStatus(id, true); // Разблокируем пользователя
        return "redirect:/admin/users"; // После изменения перенаправляем обратно на страницу
    }
}
