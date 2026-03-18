<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Truy cập bị chặn | SmartHotel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #0c0c0e;
            --accent-color: #c4a47c;
            --text-color: #ffffff;
            --secondary-text: #a0a0a0;
            --glass-bg: rgba(255, 255, 255, 0.03);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .background-blobs {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: -1;
            filter: blur(80px);
        }

        .blob {
            position: absolute;
            border-radius: 50%;
            opacity: 0.15;
        }

        .blob-1 {
            width: 400px;
            height: 400px;
            background: var(--accent-color);
            top: -100px;
            left: -100px;
        }

        .blob-2 {
            width: 300px;
            height: 300px;
            background: #8e44ad;
            bottom: -50px;
            right: -50px;
        }

        .container {
            text-align: center;
            padding: 3rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .icon-wrapper {
            margin-bottom: 2rem;
            position: relative;
            display: inline-block;
        }

        .icon-bg {
            width: 100px;
            height: 100px;
            background: rgba(196, 164, 124, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
        }

        .icon {
            font-size: 3rem;
            color: var(--accent-color);
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            letter-spacing: -1px;
        }

        p {
            color: var(--secondary-text);
            margin-bottom: 2.5rem;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 1rem 2.5rem;
            background-color: var(--accent-color);
            color: #000;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px -5px rgba(196, 164, 124, 0.4);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px -5px rgba(196, 164, 124, 0.5);
            background-color: #d4b48c;
        }

        .btn:active {
            transform: translateY(-1px);
        }

        .code {
            position: absolute;
            bottom: 2rem;
            left: 0;
            right: 0;
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.1);
            letter-spacing: 5px;
        }
    </style>
</head>
<body>
    <div class="background-blobs">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
    </div>

    <div class="container">
        <div class="icon-wrapper">
            <div class="icon-bg">
                <span class="icon">✕</span>
            </div>
        </div>
        <h1>Truy cập bị chặn</h1>
        <p>Xin lỗi, cấp bậc thành viên của bạn hiện tại chưa đủ quyền hạn để truy cập vào khu vực này. Vui lòng quay lại hoặc liên hệ quản trị viên.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn">Quay lại Trang chủ</a>
    </div>

    <div class="code">ERROR CODE: 403 / ACCESS_DENIED</div>
</body>
</html>
