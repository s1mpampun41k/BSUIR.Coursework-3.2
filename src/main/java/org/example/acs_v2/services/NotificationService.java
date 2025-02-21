package org.example.acs_v2.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.acs_v2.models.Lesson;
import org.example.acs_v2.models.LessonApplication;
import org.example.acs_v2.models.Notification;
import org.example.acs_v2.models.User;
import org.example.acs_v2.repositories.LessonApplicationRepository;
import org.example.acs_v2.repositories.LessonRepository;
import org.example.acs_v2.repositories.NotificationRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public void createNotification(Notification notification) {
        notificationRepository.save(notification);
    }

    public List<Notification> getNotificationsForUser(Long userId) {
        return notificationRepository.findByUserId(userId);
    }


}