<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Заявки</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>
<div class="container py-5">
    <h2 class="text-center mb-4">Заявки на занятия</h2>
    <hr>

    <#if applications?has_content>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Ученик</th>
                <th>День недели</th>
                <th>Время</th>
                <th>Статус</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody>
            <#list applications as application>
                <tr>
                    <td>${application.user.firstName} ${application.user.secondName}</td>
                    <td>${application.dayWeek}</td>
                    <td>${application.timeLesson}</td>
                    <td>
                        <#if application.status == "PENDING">
                            Ожидание
                        <#elseif application.status == "CONFIRMED">
                            Подтверждено
                        <#else>
                            Отклонено
                        </#if>
                    </td>
                    <td>
                        <#if application.status == "PENDING">
                            <form action="/applications/approve" method="post" style="display:inline-block;">
                                <input type="hidden" name="applicationId" value="${application.id}">
                                <button type="submit" class="btn btn-success btn-sm">Подтвердить</button>
                            </form>
                            <form action="/applications/reject" method="post" style="display:inline-block;">
                                <input type="hidden" name="applicationId" value="${application.id}">
                                <button type="submit" class="btn btn-danger btn-sm">Отклонить</button>
                            </form>
                        <#else>
                            <!-- Если заявка не в статусе "Ожидание", скрываем кнопки -->
                            <span class="text-muted">Действия недоступны</span>
                        </#if>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <p class="text-center">Заявки отсутствуют.</p>
    </#if>
</div>
</body>
</html>
