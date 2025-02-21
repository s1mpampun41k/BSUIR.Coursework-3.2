<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Мой профиль</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h2 class="text-center mb-4">Мой профиль</h2>
    <hr>

    <div class="card">
        <div class="card-body">
            <h3 class="card-title">Основная информация</h3>
            <p><strong>Имя:</strong> ${user.firstName! 'Не указано'} ${user.secondName! ''}</p>
            <p><strong>Роль:</strong> ${user.role! 'Не указана'}</p>
            <p><strong>Почта:</strong> ${user.email! 'Не указана'}</p>
            <p><strong>Номер телефона:</strong> ${user.numberPhone! 'Не указан'}</p>

            <#if user.role == "ROLE_TUTOR">
                <div class="card mb-4">
                    <p><strong>Статус:</strong>
                        <#if user.verificationStatus??>
                            <#if user.verificationStatus == "PENDING">
                                Ожидает подтверждения
                            <#elseif user.verificationStatus == "VERIFIED">
                                Верифицирован
                            <#else>
                                Не верифицирован
                            </#if>
                        <#else>
                            Статус не указан
                        </#if>

                    </p>
                    <#if user.verificationStatus == 'NO_VERIFIED'>
                        <a href="/tutor/verification" class="btn btn-warning">Пройти верификацию</a>
                    </#if>
                </div>
                <p><strong>Город:</strong> ${user.city! 'Не указан'}</p>
                <p><strong>Режим обучения:</strong> ${user.locationStudy! 'Не указано'}</p>
                <p><strong>Описание:</strong> ${user.description! 'Не указано'}</p>
                <p><strong>Стоимость занятия:</strong> ${user.price +  " руб."! 'Не указано'}</p>
                <p><strong>Сектор обучения:</strong> ${user.educationSector! 'Не указан'}</p>
                <p><strong>Теги:</strong>
                <#if user.tags?has_content>
                    <ul>
                        <#list user.tags as tag>
                            <li>${tag}</li>
                        </#list>
                    </ul>
                <#else>
                    <span>Не указаны</span>
                </#if>
                </p>
            </#if>

            <hr>
            <a href="/user/edit/${user.id}" class="btn btn-primary w-100">Редактировать профиль</a>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
