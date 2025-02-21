<!doctype html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Yaroslav Shepelevsky">
    <title>Поиск репетитора</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="../static.css.filter.css" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin-top: 40px;
        }

        h1 {
            color: #d32f2f;
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar input {
            flex-grow: 1;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #e2e2e2;
            border-radius: 30px;
            background-color: #f9f9f9;
        }

        .search-bar button {
            padding: 12px 20px;
            background-color: #d32f2f;
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 14px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #c62828;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: -320px;
            width: 300px;
            height: 100%;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: left 0.3s ease;
            padding: 20px;
            border-radius: 10px;
            z-index: 999;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar h2 {
            color: #d32f2f;
            margin-bottom: 20px;
        }

        .sidebar label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
        }

        .sidebar input,
        .sidebar select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-bottom: 15px;
            border: 1px solid #e2e2e2;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .search-button-container {
            text-align: center;
        }

        .search-button-container button {
            padding: 12px 25px;
            background-color: #d32f2f;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }

        .search-button-container button:hover {
            background-color: #c62828;
        }

        .card {
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body>

<header>
    <!-- Здесь подключаем navbar -->
    <#include "components/navbar.ftl">
</header>

<main>
    <section class="text-center container">
        <h1>Поиск репетитора</h1>

        <form method="get" action="/search">
            <div class="search-bar">
                <input type="text" id="searchQuery" name="query" placeholder="Введите запрос..." class="form-control" value="${query}">
                <button type="button" class="btn btn-secondary" id="toggleSidebar">Открыть фильтры</button>
                <button type="submit" class="btn btn-primary">Поиск</button>
            </div>

            <div class="sort-options">
                <label for="sort">Сортировка по цене:</label>
                <select name="sort" id="sort" class="form-control">
                    <<option value="asc" <#if sort?? && sort == 'asc'>selected</#if>>По возрастанию</option>
                    <option value="desc" <#if sort?? && sort == 'desc'>selected</#if>>По убыванию</option>

                </select>
            </div>
        </form>
    </section>

    <section id="tutorsList" class="container mt-4">
        <div class="row">
            <#if tutors?has_content>
                <#list tutors as tutor>
                    <a href="/tutor/${tutor.id}" class="text-decoration-none">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">${tutor.firstName} ${tutor.secondName}</h5>
                                    <p class="card-text">Занятие: ${tutor.lessonName?default("Не указано")}</p>
                                    <p class="card-text">Цена: ${tutor.price?string["0.00"]} руб.</p>
                                    <p class="card-text">Город: ${tutor.city}</p>
                                    <p class="card-text">Сфера образования: ${tutor.educationSector}</p>
                                    <p class="card-text">Способ обучения: ${tutor.locationStudy}</p>
                                </div>
                            </div>
                        </div>
                    </a>
                </#list>
            <#else>
                <p class="text-muted">Репетиторы не найдены по заданным параметрам.</p>
            </#if>
        </div>
    </section>
</main>

<div class="sidebar" id="sidebar">
    <h2>Фильтры</h2>
    <form method="get" action="/search">
        <div class="price-range">
            <input type="number" id="minPrice" name="minPrice" placeholder="Мин. цена" class="form-control" value="${minPrice}">
            <input type="number" id="maxPrice" name="maxPrice" placeholder="Макс. цена" class="form-control" value="${maxPrice}">
        </div>
        <select id="city" name="city" class="form-control">
            <option value="">Все города</option>
            <#list cities as city>
                <option value="${city}" <#if city == selectedCity>selected</#if>>${city}</option>
            </#list>
        </select>
        <select id="educationSector" name="educationSector" class="form-control">
            <option value="">Все сферы</option>
            <#list educationSectors as sector>
                <option value="${sector}" <#if sector == selectedEducationSector>selected</#if>>${sector}</option>
            </#list>
        </select>
        <select id="locationStudy" name="locationStudy" class="form-control">
            <option value="NO_PREFERENCE" <#if locationStudy == 'NO_PREFERENCE'>selected</#if>>Не имеет значения</option>
            <option value="ONLINE" <#if locationStudy == 'ONLINE'>selected</#if>>Онлайн</option>
            <option value="OFFLINE" <#if locationStudy == 'OFFLINE'>selected</#if>>Оффлайн</option>
        </select>
        <button type="submit" class="btn btn-primary mt-3">Применить фильтры</button>
    </form>
</div>

<script>
    const toggleButton = document.getElementById('toggleSidebar');
    const sidebar = document.getElementById('sidebar');

    toggleButton.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        toggleButton.textContent = sidebar.classList.contains('active') ? 'Скрыть фильтры' : 'Открыть фильтры';
    });
</script>

</body>
</html>
