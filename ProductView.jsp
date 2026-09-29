<%@page import="com.bean.CustomerBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bean.ProductBean" %>
<%
    CustomerBean cb = (CustomerBean) session.getAttribute("cbean");
    ArrayList<ProductBean> al = (ArrayList<ProductBean>) request.getAttribute("productList");
    if (al == null) {
        al = (ArrayList<ProductBean>) session.getAttribute("productList");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Catalog</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: linear-gradient(135deg, #050816 0%, #0f172a 35%, #1e1b4b 70%, #311042 100%);
            --card: rgba(255, 255, 255, 0.08);
            --border: rgba(255, 255, 255, 0.18);
            --text: #ffffff;
            --muted: rgba(255, 255, 255, 0.72);
            --accent: #38bdf8;
            --success: #4ade80;
            --buy1: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --buy2: linear-gradient(135deg, #059669 0%, #047857 100%);
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
            padding: 28px 18px;
            color: var(--text);
            overflow-x: hidden;
            background: var(--bg);
        }

        body::before,
        body::after {
            content: "";
            position: fixed;
            width: 360px;
            height: 360px;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.3;
            z-index: 0;
        }

        body::before {
            background: #3b82f6;
            top: 5%;
            left: 8%;
        }

        body::after {
            background: #9333ea;
            bottom: 5%;
            right: 8%;
        }

        .container {
            position: relative;
            z-index: 1;
            width: 980px;
            max-width: 100%;
            padding: 36px 32px 28px;
            border-radius: 30px;
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

        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.12);
            flex-wrap: wrap;
        }

        .header-title h2 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 6px;
        }

        .header-title p {
            color: var(--muted);
            font-size: 15px;
            line-height: 1.6;
        }

        .header-title span {
            color: var(--accent);
            font-weight: 800;
        }

        .user-badge {
            padding: 9px 18px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 999px;
            font-size: 14px;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.92);
            white-space: nowrap;
        }

        .user-badge span {
            color: var(--accent);
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 18px;
            border: 1px solid var(--border);
            background: rgba(0, 0, 0, 0.14);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px;
            text-align: left;
        }

        th {
            background: rgba(255, 255, 255, 0.08);
            padding: 16px 18px;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.7px;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 16px 18px;
            font-size: 14px;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.92);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            vertical-align: middle;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.06);
        }

        tr:last-child td {
            border-bottom: none;
        }

        .code-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 999px;
            font-family: monospace;
            font-size: 13px;
            letter-spacing: 0.4px;
            color: #7dd3fc;
            background: rgba(56, 189, 248, 0.12);
            border: 1px solid rgba(56, 189, 248, 0.22);
        }

        .price-text {
            color: var(--success);
            font-weight: 800;
        }

        .qty-tag {
            display: inline-flex;
            align-items: center;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.92);
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
        }

        .actions-cell {
            text-align: center;
        }

        .btn-buy {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-width: 92px;
            padding: 9px 18px;
            background: var(--buy1);
            color: #fff;
            text-decoration: none;
            font-size: 13px;
            font-weight: 800;
            border-radius: 12px;
            transition: 0.3s ease;
            box-shadow: 0 8px 18px rgba(16, 185, 129, 0.28);
        }

        .btn-buy:hover {
            transform: translateY(-2px);
            background: var(--buy2);
            box-shadow: 0 12px 22px rgba(16, 185, 129, 0.4);
        }

        .empty-state {
            padding: 58px 20px;
            text-align: center;
            background: rgba(0, 0, 0, 0.14);
            border-radius: 20px;
            border: 1px dashed rgba(255, 255, 255, 0.18);
        }

        .empty-state .icon {
            font-size: 50px;
            margin-bottom: 12px;
        }

        .empty-state p {
            font-size: 16px;
            color: var(--muted);
        }

        .nav-actions {
            margin-top: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-back {
            color: #7dd3fc;
            text-decoration: none;
            font-size: 14px;
            font-weight: 800;
        }

        .btn-back:hover {
            text-decoration: underline;
        }

        .footer {
            color: rgba(255, 255, 255, 0.5);
            font-size: 13px;
        }

        @media (max-width: 640px) {
            .container {
                padding: 26px 16px 20px;
                border-radius: 24px;
            }

            .header-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-title h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-bar">
        <div class="header-title">
            <h2>🛍️ Product Catalog</h2>
            <p>Browse available products and tap <span>Buy</span> to place your order.</p>
        </div>
        <div class="user-badge">
            Welcome, <span><%= cb != null ? cb.getFname() : "Customer" %></span>
        </div>
    </div>

    <%
        if (al != null && !al.isEmpty()) {
    %>
    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Product Name</th>
                    <th>Company</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th style="text-align:center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (ProductBean pb : al) { %>
                <tr>
                    <td><span class="code-badge"><%= pb.getPcode() %></span></td>
                    <td><strong><%= pb.getPname() %></strong></td>
                    <td><%= pb.getPcompany() %></td>
                    <td class="price-text">₹<%= pb.getPprice() %></td>
                    <td><span class="qty-tag"><%= pb.getPqyt() %> units</span></td>
                    <td class="actions-cell">
                        <a href="BuyProductServlet?pcode=<%= pb.getPcode() %>" class="btn-buy">🛒 Buy</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <%
        } else {
    %>
    <div class="empty-state">
        <div class="icon">📦</div>
        <p>No products available in the database.</p>
    </div>
    <%
        }
    %>

    <div class="nav-actions">
        <a href="CustomerHome.jsp" class="btn-back">← Back to Dashboard</a>
        <div class="footer">Product Catalog System © 2026</div>
    </div>
</div>

</body>
</html>