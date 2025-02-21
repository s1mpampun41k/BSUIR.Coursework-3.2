package org.example.acs_v2.repositories;

import org.example.acs_v2.models.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    // Метод для получения всех уведомлений для конкретного ученика
    List<Notification> findByUserId(Long userId);

    // Метод для получения всех уведомлений для репетитора
    List<Notification> findByTutorId(Long tutorId);
}
