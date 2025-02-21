<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Уведомления</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h2 class="text-center mb-4">Ваши уведомления</h2>
    <hr>

    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center">Список уведомлений</h3>
            <hr>
            <#if notifications?size == 0>
                <p class="text-center text-muted">У вас пока нет уведомлений.</p>
            <#else>
                <ul class="list-group">
                    <#list notifications as notification>
                        <li class="list-group-item">
                            <p class="mb-0">${notification.notificationText}</p>
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
