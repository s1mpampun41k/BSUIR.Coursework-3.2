<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Профиль репетитора</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h2 class="text-center mb-4">Профиль репетитора</h2>
    <hr>

    <div class="card mb-4">
        <div class="card-body">
            <h3 class="card-title">Основная информация</h3>
            <p><strong>Фамилия:</strong> ${tutor.secondName! 'Не указано'}</p>
            <p><strong>Имя:</strong> ${tutor.firstName! 'Не указано'}</p>
            <p><strong>Контактная информация:</strong></p>
            <ul>
                <li><strong>Электронная почта:</strong> ${tutor.email! 'Не указана'}</li>
                <li><strong>Номер телефона:</strong> ${tutor.numberPhone! 'Не указан'}</li>
            </ul>
            <p><strong>О себе:</strong> ${tutor.description! 'Описание отсутствует'}</p>
            <p><strong>Сфера образования:</strong> ${tutor.educationSector! 'Не указана'}</p>
            <p><strong>Город:</strong> ${tutor.city! 'Не указан'}</p>
            <p><strong>Верификация:</strong> ${tutor.verificationStatus! 'Не указан'}</p>
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            <h3 class="card-title">Информация об уроке</h3>
            <p><strong>Название урока:</strong> ${tutor.lessonName! 'Не указано'}</p>
            <p><strong>Стоимость:</strong> ${tutor.price! 'Не указана'} руб.</p>
            <p><strong>Вариант проведения:</strong> ${tutor.locationStudy! 'Не указан'}</p>
            <hr>
            <div class="d-grid">
                <a href="/book-lesson/${tutor.id}" class="btn btn-success">Записаться на занятие</a>
            </div>
        </div>
    </div>

    <hr>

    <div class="card">
        <div class="card-body">
            <h3 class="card-title">Комментарии</h3>
            <#if canComment>
                <form method="post" action="/tutor/${tutor.id}/add-comment">
                    <div class="mb-3">
                        <label for="commentText" class="form-label">Ваш комментарий</label>
                        <textarea class="form-control" id="commentText" name="text" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Оставить комментарий</button>
                </form>
                <hr>
            </#if>

            <#if comments?size == 0>
                <p>Комментариев пока нет.</p>
            <#else>
                <ul class="list-group">
                    <#list comments as comment>
                        <li class="list-group-item">
                            <strong>${comment.user.firstName} ${comment.user.secondName}:</strong>
                            <p>${comment.text}</p>
                        </li>
                    </#list>
                </ul>
            </#if>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
