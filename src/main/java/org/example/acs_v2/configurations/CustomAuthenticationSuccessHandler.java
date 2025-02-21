package org.example.acs_v2.configurations;

import org.example.acs_v2.services.CustomUserDetailsService;
import org.example.acs_v2.models.User;  // Если у вас есть сущность User с ID
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String redirectUrl = "/";

        // Получаем роль пользователя
        if (authentication.getAuthorities().stream().anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"))) {
            redirectUrl = "/verification/applications";
        }
        if (authentication.getAuthorities().stream().anyMatch(authority -> authority.getAuthority().equals("ROLE_TUTOR"))) {
            redirectUrl = "/my-lessons";
        }
        response.sendRedirect(redirectUrl);
    }
}
