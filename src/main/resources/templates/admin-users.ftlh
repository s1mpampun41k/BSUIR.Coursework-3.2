<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Users</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0-alpha1/css/bootstrap.min.css">
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>
<div class="container mt-5">
    <h1>Manage Users</h1>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Login</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- Перебираем всех пользователей и выводим их данные -->
        <#list users as user>
            <tr>
                <!-- Если login пользователя не null, выводим ссылку, если null - выводим "Не указан" -->
                <td>
                    <#if user.login??>
                        ${user.login}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <!-- Проверка на null для остальных данных -->
                <td>
                    <#if user.firstName??>
                        ${user.firstName}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <td>
                    <#if user.secondName??>
                        ${user.secondName}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <td>
                    <#if user.email??>
                        ${user.email}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <td>
                    <#if user.numberPhone??>
                        ${user.numberPhone}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <td>
                    <#if user.role??>
                        ${user.role}
                    <#else>
                        Не указан
                    </#if>
                </td>
                <td>
                    <#if user.active>
                        <span class="badge bg-success">Active</span>
                    <#else>
                        <span class="badge bg-danger">Inactive</span>
                    </#if>
                </td>
                <td>
                    <!-- Если пользователь активен, показываем кнопку блокировки -->
                    <#if user.active>
                        <form action="/admin/users/ban/${user.id}" method="post">
                            <button type="submit" class="btn btn-danger">Ban</button>
                        </form>
                    <#else>
                        <!-- Если пользователь не активен, показываем кнопку разблокировки -->
                        <form action="/admin/users/unban/${user.id}" method="post">
                            <button type="submit" class="btn btn-success">Unban</button>
                        </form>
                    </#if>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0-alpha1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
