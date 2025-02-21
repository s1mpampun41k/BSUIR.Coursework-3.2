<!DOCTYPE html>
<html lang="ru" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация репетитора</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }
        .link-container {
            text-align: center;
            margin-top: 10px;
        }
        .link-container a {
            text-decoration: none;
            color: #4CAF50;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Регистрация репетитора</h2>

    <form action="/tutor_registration" method="post">
        <div class="form-group">
            <label for="firstName">Имя</label>
            <input type="text" class="form-control" required id="firstName" name="firstName">
        </div>
        <div class="form-group">
            <label for="secondName">Фамилия</label>
            <input type="text" class="form-control" id="secondName" required name="secondName">
        </div>
        <div class="form-group">
            <label for="description">Описание</label>
            <textarea class="form-control" id="description" name="description" required rows="4"></textarea>
        </div>
        <div class="form-group">
            <label for="price">Цена за занятие (в рублях)</label>
            <input type="number" class="form-control" id="price" required name="price">
        </div>
        <div class="form-group">
            <label for="city">Город</label>
            <input type="text" class="form-control" id="city" required name="city">
        </div>
        <div class="form-group">
            <label for="educationSector">Образование</label>
            <input type="text" class="form-control" id="educationSector" required name="educationSector">
        </div>
        <div class="form-group">
            <label for="locationStudy">Тип обучения</label>
            <select class="form-control" id="locationStudy" required name="locationStudy">
                <option value="ONLINE">Онлайн</option>
                <option value="OFFLINE">Оффлайн</option>
                <option value="NO_PREFERENCE">Не имеет значения</option>
            </select>
        </div>
        <div class="form-group">
            <label for="tags">Теги (например: математика, физика)</label>
            <input type="text" class="form-control" id="tags" name="tags">
        </div>
        <button type="submit" class="btn btn-dark">Зарегистрироваться как репетитор</button>
    </form>

    <div class="link-container">
        <p>Уже есть аккаунт? <a href="/login">Войти</a></p>
    </div>
</div>
</body>
</html>
