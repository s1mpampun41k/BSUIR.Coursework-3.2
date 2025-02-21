<div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center ms-auto">
            <#if role??>
                <#switch role>
                    <#case "ROLE_USER">
                        <a href="/" class="navbar-brand d-flex align-items-center"><strong>Repetitor.by</strong></a>
                        <a href="/my-lessons" class="btn btn-outline-light me-2">Мои занятия</a>
                        <a href="/notifications" class="btn btn-outline-light me-2">Уведомления</a>
                        <a href="/tutor_registration" class="btn btn-outline-light me-2">Стать репетитором</a>
                        <a href="/user/${userId}" class="btn btn-outline-light me-2 d-flex align-items-center profile-btn">
                            <span>Профиль</span>
                        </a>
                        <a href="/logout" class="btn btn-outline-light me-2">Logout</a>
                        <#break>
                    <#case "ROLE_TUTOR">
                        <a href="/user/${userId}" class="navbar-brand d-flex align-items-center"><strong>Repetitor.by</strong></a>
                        <a href="/my-lessons" class="btn btn-outline-light me-2">Мои занятия</a>
                        <a href="/notifications" class="btn btn-outline-light me-2">Уведомления</a>
                        <a href="/tutor/applications" class="btn btn-outline-light me-2">Заявки</a>
                        <a href="/user/${userId}" class="btn btn-outline-light me-2 d-flex align-items-center profile-btn"><span>Профиль</span></a>
                        <a href="/logout" class="btn btn-outline-light me-2">Logout</a>
                        <#break>
                    <#case "ROLE_ADMIN">
                        <a href="/admin/users" class="navbar-brand d-flex align-items-center"><strong>Repetitor.by</strong></a>
                        <a href="/admin/users" class="btn btn-outline-light me-2">Пользователи</a>
                        <a href="/verification/applications" class="btn btn-outline-light me-2">Заявки</a>
                        <a href="/logout" class="btn btn-outline-light me-2">Logout</a>
                        <#break>
                </#switch>
            <#else>
                <a class="btn btn-outline-light me-2" href="/login">Login</a>
            </#if>
        </div>
    </div>
</div>
