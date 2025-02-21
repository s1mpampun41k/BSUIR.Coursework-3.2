<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мои занятия</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
        }

        .card {
            margin-bottom: 30px;
        }

        .card-body {
            padding: 20px;
        }

        table th, table td {
            text-align: center;
            vertical-align: middle;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .table-dark th {
            background-color: #343a40;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .text-center {
            text-align: center !important;
        }
    </style>
</head>
<body>

<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h2 class="text-center mb-4">Мои занятия</h2>
    <hr>

    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center">Список занятий</h3>
            <hr>
            <#if lessons?size == 0>
                <p class="text-center text-muted">У вас пока нет запланированных занятий.</p>
            <#else>
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>День недели</th>
                        <th>Стоимость</th>
                        <th>Вариант обучения</th>
                        <#if role == "ROLE_TUTOR">
                            <th>Ученик</th>
                        <#else>
                            <th>Репетитор</th>
                        </#if>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list lessons as lesson>
                        <tr>
                            <td>${lesson.dayWeek}</td>
                            <td>${lesson.price} руб.</td>
                            <td>
                                <#if lesson.locationStudy?has_content>
                                    <p>${lesson.locationStudy! "Не указано"}</p>
                                </#if>
                            </td>
                            <td>
                                <#if role == "ROLE_TUTOR">
                                    <#if lesson.user?has_content>
                                        ${lesson.user.firstName} ${lesson.user.secondName}
                                    <#else>
                                        <span class="text-muted">Не назначен</span>
                                    </#if>
                                </#if>
                                <#if role == "ROLE_USER">
                                    <#if lesson.tutor?has_content>
                                        ${lesson.tutor.firstName} ${lesson.tutor.secondName}
                                    <#else>
                                        <span class="text-muted">Не назначен</span>
                                    </#if>
                                </#if>
                            </td>
                            <td>
                                <#-- Добавляем форму для удаления занятия -->
                                <form action="/delete-lesson/${lesson.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger">Удалить</button>
                                </form>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </#if>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
