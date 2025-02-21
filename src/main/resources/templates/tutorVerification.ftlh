<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Верификация репетитора</title>
</head>
<body>
<div class="container py-5">
    <h2 class="text-center mb-4">Верификация репетитора</h2>
    <form method="POST" enctype="multipart/form-data" action="/tutor/verification">
        <div class="mb-3">
            <label for="verificationImage" class="form-label">Загрузите фотографию</label>
            <input type="file" class="form-control" id="verificationImage" name="verificationImage" required>
        </div>
        <div class="mb-3">
            <label for="verificationText" class="form-label">Сопроводительное письмо</label>
            <textarea class="form-control" id="verificationText" name="verificationText" rows="4" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Пройти верификацию</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
