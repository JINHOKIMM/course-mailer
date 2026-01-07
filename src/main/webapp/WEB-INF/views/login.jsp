<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign in</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="page">
    <div class="card">
        <div class="brand">
            <!-- 로고 이미지 파일을 넣을 거면 아래 img로 바꾸면 됨 -->
            <div class="logo-badge" aria-hidden="true" style="background-color: #1C5631;">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="logo">
            </div>
            <div class="brand-title">Welcome</div>
            <div class="brand-sub">Sign in to continue</div>
        </div>

        <!-- Google 로그인 -->
        <a class="btn btn-google" href="${pageContext.request.contextPath}/oauth2/authorization/google">
            <span class="google-icon" aria-hidden="true">
                <svg width="18" height="18" viewBox="0 0 48 48">
                    <path fill="#EA4335" d="M24 9.5c3.54 0 6.73 1.22 9.25 3.62l6.9-6.9C36.05 2.55 30.4 0 24 0 14.64 0 6.55 5.38 2.64 13.22l8.02 6.23C12.3 13.02 17.67 9.5 24 9.5z"/>
                    <path fill="#4285F4" d="M46.5 24.5c0-1.57-.14-3.08-.4-4.5H24v8.52h12.64c-.55 2.96-2.2 5.46-4.7 7.14l7.2 5.58C43.34 37.4 46.5 31.46 46.5 24.5z"/>
                    <path fill="#FBBC05" d="M10.66 28.45A14.5 14.5 0 0 1 9.9 24c0-1.55.27-3.05.76-4.45l-8.02-6.23A23.93 23.93 0 0 0 0 24c0 3.87.93 7.53 2.64 10.78l8.02-6.33z"/>
                    <path fill="#34A853" d="M24 48c6.4 0 12.05-2.12 16.06-5.76l-7.2-5.58c-2 1.35-4.56 2.14-8.86 2.14-6.33 0-11.7-3.52-13.34-8.95l-8.02 6.33C6.55 42.62 14.64 48 24 48z"/>
                    <path fill="none" d="M0 0h48v48H0z"/>
                </svg>
            </span>
            <span class="btn-text">Continue with Google</span>
        </a>
    </div>
</div>
</body>
</html>
