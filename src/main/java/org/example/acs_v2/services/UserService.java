package org.example.acs_v2.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.acs_v2.models.User;
import org.example.acs_v2.models.enums.LocationStudy;
import org.example.acs_v2.models.enums.Role;
import org.example.acs_v2.repositories.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public String createUser(User user) {
        if (userRepository.findByLogin(user.getLogin()) != null) {
            return "User already exists";
        }
        user.setActive(true); // Устанавливаем активность пользователя при создании
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.ROLE_USER); // Устанавливаем роль по умолчанию
        userRepository.save(user);
        log.info("Created new user with login: {}", user.getLogin());
        return "User created successfully";
    }

    public void createAdminIfNotExist() {
        // Пропускаем проверку на существование, создаем администратора всегда
        User admin = new User();
        admin.setLogin("admin");
        admin.setPassword(passwordEncoder.encode("admin"));
        admin.setRole(Role.ROLE_ADMIN);  // Убедитесь, что у вас есть Role.ADMIN

        userRepository.save(admin);  // Сохраняем администратора в базе данных
    }

    public User save(User user) {
        return userRepository.save(user);  // Вызов метода save() у репозитория
    }

    public User findByLogin(String login) {
        return userRepository.findByLogin(login); // Метод поиска пользователя по логину
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(!user.isActive()); // Переключаем активность пользователя
            String action = user.isActive() ? "Unban" : "Ban";
            log.info("{} user with id = {}; login: {}", action, user.getId(), user.getLogin());
            userRepository.save(user);
        }
    }

    public void changeUserStatus(Long id, boolean active) {
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.setActive(active);  // Меняем статус пользователя
        userRepository.save(user);  // Сохраняем изменения в базе данных
    }

    public void changeUserRole(User user, Map<String, String> form) {
        String newRole = form.get("role");
        if (!user.getRole().name().equals(newRole)) {
            user.setRole(Role.valueOf(newRole));
            userRepository.save(user);
        }
    }
    // Метод для поиска пользователя по ID
    public User findUserById(Long id) {
        return userRepository.findById(id).orElse(null);  // Возвращаем null, если пользователь не найден
    }


    public String getUserRole(Principal principal) {
        if (principal == null) {
            log.warn("Principal is null, user is not authenticated");
            return null;
        }

        try {
            String login = principal.getName();
            User user = userRepository.findByLogin(login);

            if (user == null) {
                log.warn("User not found with login: {}", login);
                return null;
            }

            String role = user.getRole().name();
            log.info("User with login: {} has role: {}", login, role);
            return role;
        } catch (Exception e) {
            log.error("Error occurred while fetching user role for principal: {}", principal.getName(), e);
            return null;
        }
    }

    public Long getUserId(Principal principal) {
        if (principal == null) {
            log.warn("Principal is null, user is not authenticated");
            return null;
        }

        try {
            String login = principal.getName();
            User user = userRepository.findByLogin(login);

            if (user == null) {
                log.warn("User not found with login: {}", login);
                return null;
            }

            Long userId = user.getId();
            log.info("User with login: {} has ID: {}", login, userId);
            return userId;
        } catch (Exception e) {
            log.error("Error occurred while fetching user ID for principal: {}", principal.getName(), e);
            return null;
        }
    }


    public void updateUserProfile(Long userId, String firstName, String secondName, String email, String numberPhone,
                                  String city, LocationStudy locationStudy, String description, Double price,
                                  String educationSector, Set<String> tags) {
        // Логика обновления профиля пользователя

        // Например, найти пользователя по ID
        User user = findUserById(userId);

        // Обновить поля пользователя
        user.setFirstName(firstName);
        user.setSecondName(secondName);
        user.setEmail(email);
        user.setNumberPhone(numberPhone);
        user.setCity(city);
        user.setLocationStudy(locationStudy);
        user.setDescription(description);
        user.setPrice(price);
        user.setEducationSector(educationSector);
        user.setTags(tags);

        // Сохранить обновленного пользователя
        saveUser(user);
    }

    public void saveUser(User user) {
        // Проверяем, если пользователь еще не сохранен (новый пользователь) или обновляем существующего
        if (user.getId() == null) {
            // Новый пользователь, сохраняем его в базу данных
            userRepository.save(user);
            log.info("User with login: {} saved successfully.", user.getLogin());
        } else {
            // Обновляем уже существующего пользователя
            userRepository.save(user);
            log.info("User with id: {} updated successfully.", user.getId());
        }
    }



    private Set<String> parseTags(String tagsStr) {
        // Преобразуем строку в Set<String> (например, через разделитель запятой)
        Set<String> tagsSet = new HashSet<>();
        String[] tags = tagsStr.split(",");
        for (String tag : tags) {
            tagsSet.add(tag.trim());
        }
        return tagsSet;
    }
}
