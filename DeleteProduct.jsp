<%@page import="com.bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    AdminBean abean = (AdminBean) session.getAttribute("adminbean");
    String data = (String) request.getAttribute("data");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Operation Status</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: linear-gradient(135deg, #050816 0%, #0f172a 35%, #1e1b4b 70%, #311042 100%);
            --card: rgba(255, 255, 255, 0.08);
            --border: rgba(255, 255, 255, 0.18);
            --hover-border: rgba(255, 255, 255, 0.4);
            --text: #ffffff;
            --muted: rgba(255, 255, 255, 0.72);
            --shadow: 0 30px 70px rgba(0, 0, 0, 0.42);
            --add: linear-gradient(135deg, rgba(6, 182, 212, 0.92) 0%, rgba(59, 130, 246, 0.92) 100%);
            --view: linear-gradient(135deg, rgba(16, 185, 129, 0.92) 0%, rgba(5, 150, 105, 0.92) 100%);
            --logout: linear-gradient(135deg, rgba(244, 63, 94, 0.92) 0%, rgba(225, 29, 72, 0.92) 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
            color: var(--text);
            overflow-x: hidden;
            background: var(--bg);
            background-size: 300% 300%;
            animation: gradientShift 16s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        body::before,
        body::after {
            content: "";
            position: fixed;
            width: 340px;
            height: 340px;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.3;
            z-index: 0;
            pointer-events: none;
        }

        body::before {
            background: #f43f5e;
            top: 8%;
            left: 10%;
        }

        body::after {
            background: #9333ea;
            bottom: 8%;
            right: 10%;
        }

        .result-container {
            position: relative;
            z-index: 1;
            width: 840px;
            max-width: 100%;
            padding: 42px 34px 34px;
            text-align: center;
            border-radius: 32px;
            background: var(--card);
            border: 1px solid var(--border);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            box-shadow: var(--shadow);
            animation: fadeUp 0.8s ease both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .user-greeting {
            font-size: 18px;
            font-weight: 600;
            color: var(--muted);
            margin-bottom: 12px;
        }

        .user-greeting span {
            color: #38bdf8;
            font-weight: 800;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 24px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.22);
            font-size: 18px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 34px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
        }

        .menu {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        .menu-card {
            position: relative;
            min-height: 160px;
            padding: 24px 16px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 24px;
            text-decoration: none;
            color: #fff;
            border: 1px solid var(--border);
            transition: 0.35s ease;
            overflow: hidden;
        }

        .menu-card::before {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 24px;
            opacity: 0.9;
            z-index: -1;
            transition: opacity 0.3s ease;
        }

        .menu-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--hover-border);
            box-shadow: 0 20px 35px rgba(0, 0, 0, 0.35);
        }

        .menu-card:hover::before {
            opacity: 1;
        }

        .menu-card .icon {
            font-size: 36px;
            margin-bottom: 10px;
            transition: transform 0.35s ease;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
        }

        .menu-card:hover .icon {
            transform: scale(1.15) rotate(-5deg);
        }

        .menu-card h2 {
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 5px;
            letter-spacing: -0.3px;
        }

        .menu-card p {
            font-size: 12px;
            line-height: 1.4;
            opacity: 0.9;
        }

        .add-product::before { background: var(--add); }
        .view-product::before { background: var(--view); }
        .logout::before { background: var(--logout); }

        .footer {
            color: rgba(255, 255, 255, 0.5);
            margin-top: 34px;
            font-size: 13px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .result-container {
                padding: 32px 20px 24px;
            }

            .menu {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .status-badge {
                font-size: 16px;
                padding: 12px 20px;
            }

            .menu-card {
                min-height: 120px;
            }
        }
    </style>
</head>
<body>

<div class="result-container">
    <div class="user-greeting">
        Hello <span><%= abean != null ? abean.getA_fname() : "Admin" %></span> 👋
    </div>

    <div class="status-badge">
        🔔 <%= data != null ? data : "Operation Processed" %>
    </div>

    <div class="menu">
        <a href="AddProduct.html" class="menu-card add-product">
            <div class="icon">➕</div>
            <h2>Add Another Product</h2>
            <p>Insert more inventory items.</p>
        </a>

        <a href="ViewProductServlet" class="menu-card view-product">
            <div class="icon">📦</div>
            <h2>View Products</h2>
            <p>Check the updated product list.</p>
        </a>

        <a href="LogoutServlet" class="menu-card logout">
            <div class="icon">🚪</div>
            <h2>Logout</h2>
            <p>Exit the current admin session.</p>
        </a>
    </div>

    <div class="footer">
        Admin Product Management System © 2026
    </div>
</div>

</body>
</html>