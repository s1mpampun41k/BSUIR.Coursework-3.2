<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Редактирование профиля</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h1>Редактировать профиль</h1>
    <form action="/user/${user.id}/update" method="post">
    <div class="form-group">
            <label for="firstName">Имя</label>
            <input type="text" id="firstName" name="firstName" class="form-control" value="${user.firstName!''}" required>
        </div>

        <div class="form-group">
            <label for="secondName">Фамилия</label>
            <input type="text" id="secondName" name="secondName" class="form-control" value="${user.secondName!''}" required>
        </div>

        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" id="email" name="email" class="form-control" value="${user.email!''}">
        </div>

        <div class="form-group">
            <label for="numberPhone">Телефон</label>
            <input type="tel" id="numberPhone" name="numberPhone" class="form-control" value="${user.numberPhone!''}">
        </div>

        <#if user.role == "ROLE_TUTOR">
            <div class="form-group">
                <label for="city">Город</label>
                <input type="text" id="city" name="city" class="form-control" value="${user.city!''}">
            </div>

            <!-- Местоположение для обучения -->
            <div class="form-group">
                <label for="locationStudy">Местоположение для обучения</label>
                <select name="locationStudy" id="locationStudy" class="form-control">
                    <#-- Перебираем locationStudyList, который был передан с сервера -->
                    <#list locationStudyList as location>
                        <#if user.locationStudy?is_sequence>
                        <#-- Если locationStudy - это коллекция (список), проверяем наличие элемента в коллекции -->
                            <option value="${location}"
                                    <#if user.locationStudy?seq_contains(location)>selected</#if>>
                                ${location}
                            </option>
                        <#else>
                        <#-- Если locationStudy - это одиночное значение, просто сравниваем -->
                            <option value="${location}"
                                    <#if user.locationStudy == location>selected</#if>>
                                ${location}
                            </option>
                        </#if>
                    </#list>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Описание</label>
                <textarea id="description" name="description" class="form-control">${user.description!''}</textarea>
            </div>

            <div class="form-group">
                <label for="price">Цена</label>
                <input type="number" id="price" name="price" class="form-control" value="${user.price!''}">
            </div>

            <div class="form-group">
                <label for="educationSector">Сектор образования</label>
                <input type="text" id="educationSector" name="educationSector" class="form-control" value="${user.educationSector!''}">
            </div>

            <div class="form-group">
                <label for="tags">Теги</label>
                <input type="text" id="tags" name="tags" class="form-control" value="${user.tags?join(',')!''}">
            </div>
        </#if>

        <button type="submit" class="btn btn-primary">Обновить</button>
    </form>
</main>

</body>
</html>
