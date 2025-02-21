<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Заявки на верификацию</title>
</head>
<body>
<header>
    <#include "components/navbar.ftl">
</header>

<main class="container py-5">
    <h2 class="text-center mb-4">Заявки на верификацию</h2>
    <hr>

    <#if verificationApplications?has_content>
        <div class="list-group">
            <#list verificationApplications as application>
                <div class="list-group-item">
                    <h5 class="d-flex justify-content-between align-items-center">
                        <span>${application.tutor.firstName} ${application.tutor.secondName}</span>
                        <span class="badge <#if application.verificationStatus == "PENDING">bg-warning<#elseif application.verificationStatus == "APPROVED">bg-success<#else>bg-danger</#if>">
                            <#if application.verificationStatus == "PENDING">Ожидает<#elseif application.verificationStatus == "APPROVED">Одобрено<#else>Отклонено</#if>
                        </span>
                    </h5>
                    <p><strong>Роль:</strong> ${application.tutor.role! 'Не указана'}</p>
                    <p><strong>Почта:</strong> ${application.tutor.email! 'Не указана'}</p>
                    <p><strong>Телефон:</strong> ${application.tutor.numberPhone! 'Не указан'}</p>

                    <!-- Блок для изображения документа -->
                    <#if application.verificationImage?has_content>
                        <p><strong>Документ:</strong></p>
                        <img src="${application.verificationImage}" alt="Документ верификации" class="img-fluid" style="max-width: 100%; height: auto; border: 1px solid #ccc;">
                    </#if>

                    <!-- Блок для сопроводительного письма -->
                    <#if application.verificationText?has_content>
                        <p><strong>Сопроводительное письмо:</strong></p>
                        <blockquote class="blockquote">${application.verificationText}</blockquote>
                    </#if>

                    <#if application.verificationStatus == 'PENDING'>
                        <a href="/verification/application/${application.id}/approve" class="btn btn-success btn-sm">Одобрить</a>
                        <a href="/verification/application/${application.id}/reject" class="btn btn-danger btn-sm">Отклонить</a>
                    </#if>
                </div>
            </#list>
        </div>
    <#else>
        <p>Нет заявок на верификацию.</p>
    </#if>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
