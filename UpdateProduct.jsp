<%@page import="com.bean.ProductBean"%>
<%@page import="com.bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    AdminBean ab = (AdminBean) session.getAttribute("adminbean");
    ProductBean pb = (ProductBean) request.getAttribute("pbean");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Update Status</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: linear-gradient(135deg, #050816 0%, #0f172a 35%, #1e1b4b 70%, #311042 100%);
            --card: rgba(255, 255, 255, 0.08);
            --border: rgba(255, 255, 255, 0.18);
            --text: #ffffff;
            --muted: rgba(255, 255, 255, 0.74);
            --success: #34d399;
            --blue: #38bdf8;
            --shadow: 0 30px 70px rgba(0, 0, 0, 0.42);
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
        }

        body::before,
        body::after {
            content: "";
            position: fixed;
            width: 340px;
            height: 340px;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.32;
            z-index: 0;
        }

        body::before {
            background: #10b981;
            top: 8%;
            left: 10%;
        }

        body::after {
            background: #3b82f6;
            bottom: 8%;
            right: 10%;
        }

        .result-container {
            position: relative;
            z-index: 1;
            width: 860px;
            max-width: 100%;
            padding: 42px 36px 34px;
            text-align: center;
            border-radius: 30px;
            background: var(--card);
            border: 1px solid var(--border);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            box-shadow: var(--shadow);
            animation: fadeUp 0.8s ease both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(26px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .top-line {
            width: 76px;
            height: 4px;
            margin: 0 auto 22px;
            border-radius: 999px;
            background: linear-gradient(90deg, #34d399, #38bdf8, #a855f7);
        }

        .user-greeting {
            font-size: 18px;
            font-weight: 600;
            color: var(--muted);
            margin-bottom: 12px;
        }

        .user-greeting span {
            color: var(--blue);
            font-weight: 800;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 24px;
            border-radius: 18px;
            background: rgba(16, 185, 129, 0.16);
            border: 1px solid rgba(16, 185, 129, 0.34);
            color: #86efac;
            font-size: 20px;
            font-weight: 800;
            margin-bottom: 32px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.18);
        }

        .status-badge::before {
            content: "✓";
            width: 28px;
            height: 28px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.12);
            color: #bbf7d0;
            font-weight: 900;
        }

        .menu {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        .menu-card {
            position: relative;
            min-height: 168px;
            padding: 24px 18px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            color: #fff;
            border-radius: 24px;
            border: 1px solid var(--border);
            overflow: hidden;
            transition: 0.35s ease;
            box-shadow: 0 16px 30px rgba(0, 0, 0, 0.18);
        }

        .menu-card::before {
            content: "";
            position: absolute;
            inset: 0;
            opacity: 0.92;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .menu-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 24px 42px rgba(0, 0, 0, 0.35);
        }

        .menu-card:hover::before {
            opacity: 1;
        }

        .icon {
            font-size: 38px;
            margin-bottom: 10px;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
            transition: transform 0.35s ease;
        }

        .menu-card:hover .icon {
            transform: scale(1.15) rotate(-4deg);
        }

        .menu-card h2 {
            font-size: 18px;
            font-weight: 800;
            letter-spacing: -0.3px;
            margin-bottom: 6px;
        }

        .menu-card p {
            font-size: 13px;
            line-height: 1.45;
            color: rgba(255, 255, 255, 0.9);
        }

        .add-product::before {
            background: linear-gradient(135deg, rgba(6, 182, 212, 0.95), rgba(59, 130, 246, 0.95));
        }

        .view-product::before {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.95), rgba(5, 150, 105, 0.95));
        }

        .logout::before {
            background: linear-gradient(135deg, rgba(244, 63, 94, 0.95), rgba(225, 29, 72, 0.95));
        }

        .footer {
            color: rgba(255, 255, 255, 0.5);
            margin-top: 28px;
            font-size: 13px;
        }

        @media (max-width: 860px) {
            .menu {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 520px) {
            .result-container {
                padding: 32px 18px 24px;
                border-radius: 24px;
            }

            .status-badge {
                font-size: 16px;
                padding: 12px 18px;
            }

            .user-greeting {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<div class="result-container">
    <div class="top-line"></div>

    <div class="user-greeting">
        Hello <span><%= ab != null ? ab.getA_fname() : "Admin" %></span> 👋
    </div>

    <div class="status-badge">
        Product Updated Successfully
    </div>

    <div class="menu">
        <a href="AddProduct.html" class="menu-card add-product">
            <div class="icon">➕</div>
            <h2>Add Another Product</h2>
            <p>Insert more inventory items quickly.</p>
        </a>

        <a href="ViewProductServlet" class="menu-card view-product">
            <div class="icon">📦</div>
            <h2>View Products</h2>
            <p>Open the latest product list.</p>
        </a>

        <a href="LogoutServlet" class="menu-card logout">
            <div class="icon">🚪</div>
            <h2>Logout</h2>
            <p>End the current admin session safely.</p>
        </a>
    </div>

    <div class="footer">
        Admin Product Management System © 2026
    </div>
</div>

</body>
</html>