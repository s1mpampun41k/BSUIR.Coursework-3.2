package org.example.acs_v2.controllers;

import lombok.RequiredArgsConstructor;
import org.example.acs_v2.models.User;
import org.example.acs_v2.services.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/login")
    public String login(Model model, HttpServletRequest request, @RequestParam(required = false) String error) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // Добавляем CSRF-токен
//        CsrfToken csrfToken = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
//        model.addAttribute("_csrf", csrfToken);

        // Если пользователь уже аутентифицирован
        if (authentication != null && authentication.isAuthenticated()
                && !(authentication instanceof AnonymousAuthenticationToken)) {
            String role = authentication.getAuthorities().toString();
            if (role.contains("ROLE_ADMIN")) {
                return "redirect:/admin/panel";
            } else if (role.contains("ROLE_TUTOR")) {
                return "redirect:/user/profile";
            } else if (role.contains("ROLE_USER")) {
                return "redirect:/";
            }
        }

        // Обработка ошибок
        if (error != null) {
            model.addAttribute("errorMessage", "Неверный логин или пароль.");
        }

        return "login";
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(@RequestParam String login,
                             @RequestParam String password,
                             @RequestParam String firstName,
                             @RequestParam String secondName) {
        User user = new User();
        user.setLogin(login);
        user.setPassword(password);
        user.setFirstName(firstName);
        user.setSecondName(secondName);
        userService.createUser(user);
        return "redirect:/login";
    }
}
