<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Запись на занятие</title>
</head>
<body>
<main class="container py-5">
    <h2 class="text-center mb-4">Запись на занятие</h2>
    <hr>
    <p>Вы записываетесь на занятие к репетитору:</p>
    <ul>
        <li><strong>Имя:</strong> ${tutor.firstName} ${tutor.secondName}</li>
        <li><strong>Название урока:</strong> ${tutor.lessonName}</li>
        <li><strong>Стоимость:</strong> ${tutor.price} руб.</li>
    </ul>
    <form action="/confirm-booking" method="post">
        <input type="hidden" name="tutorId" value="${tutor.id}">

        <!-- Ввод дня недели -->
        <div class="mb-3">
            <label for="dayOfWeek" class="form-label"><strong>Выберите день недели:</strong></label>
            <select class="form-select" id="dayOfWeek" name="dayOfWeek" required>
                <option value="" disabled selected>Выберите день...</option>
                <option value="Понедельник">Понедельник</option>
                <option value="Вторник">Вторник</option>
                <option value="Среда">Среда</option>
                <option value="Четверг">Четверг</option>
                <option value="Пятница">Пятница</option>
                <option value="Суббота">Суббота</option>
                <option value="Воскресенье">Воскресенье</option>
            </select>
        </div>

        <!-- Ввод времени занятия -->
        <div class="mb-3">
            <label for="time" class="form-label"><strong>Выберите время занятия:</strong></label>
            <input type="time" class="form-control" id="time" name="time" required>
        </div>

        <!-- Кнопки подтверждения и отмены -->
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-success">Подтвердить запись</button>
            <a href="/tutor/${tutor.id}" class="btn btn-secondary">Отмена</a>
        </div>
    </form>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
