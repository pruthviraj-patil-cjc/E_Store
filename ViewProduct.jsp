<%@page import="com.bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bean.ProductBean" %>
<%
    HttpSession sess = request.getSession(false);
    AdminBean ab = (AdminBean) session.getAttribute("adminbean");
    ArrayList<ProductBean> al = (ArrayList<ProductBean>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Products</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: linear-gradient(135deg, #050816 0%, #0f172a 40%, #1e1b4b 100%);
            --card: rgba(255, 255, 255, 0.08);
            --card-strong: rgba(255, 255, 255, 0.12);
            --border: rgba(255, 255, 255, 0.16);
            --text: #ffffff;
            --muted: rgba(255, 255, 255, 0.72);
            --accent: #38bdf8;
            --success: #34d399;
            --danger: #f87171;
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
            background: var(--bg);
            color: var(--text);
            overflow-x: hidden;
            padding: 28px 18px;
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
            top: 6%;
            right: 8%;
        }

        body::after {
            background: #9333ea;
            bottom: 6%;
            left: 8%;
        }

        .container {
            position: relative;
            z-index: 1;
            width: 1100px;
            max-width: 100%;
            margin: 0 auto;
            padding: 34px;
            border-radius: 28px;
            background: var(--card);
            border: 1px solid var(--border);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            box-shadow: var(--shadow);
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 26px;
            flex-wrap: wrap;
        }

        .header-title h1 {
            font-size: 30px;
            font-weight: 800;
            letter-spacing: -0.6px;
            margin-bottom: 6px;
        }

        .header-title p {
            color: var(--muted);
            font-size: 15px;
            line-height: 1.6;
        }

        .header-title span {
            color: var(--accent);
            font-weight: 700;
        }

        .top-nav-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-nav {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 11px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            transition: 0.25s ease;
            border: 1px solid transparent;
            white-space: nowrap;
        }

        .btn-dashboard {
            color: #fff;
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(255, 255, 255, 0.14);
        }

        .btn-dashboard:hover {
            transform: translateY(-2px);
            background: rgba(255, 255, 255, 0.14);
        }

        .btn-logout-nav {
            color: #fecaca;
            background: rgba(239, 68, 68, 0.16);
            border-color: rgba(239, 68, 68, 0.32);
        }

        .btn-logout-nav:hover {
            transform: translateY(-2px);
            color: #fff;
            background: rgba(239, 68, 68, 0.28);
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 18px;
            border: 1px solid var(--border);
            background: rgba(0, 0, 0, 0.14);
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 820px;
        }

        .product-table thead th {
            text-align: left;
            padding: 16px 18px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: rgba(255, 255, 255, 0.82);
            background: rgba(255, 255, 255, 0.08);
            border-bottom: 1px solid var(--border);
        }

        .product-table tbody td {
            padding: 16px 18px;
            font-size: 15px;
            color: rgba(255, 255, 255, 0.95);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .product-table tbody tr {
            transition: background 0.2s ease, transform 0.2s ease;
        }

        .product-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.06);
        }

        .code-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 999px;
            font-family: monospace;
            font-size: 13px;
            font-weight: 700;
            color: #7dd3fc;
            background: rgba(56, 189, 248, 0.12);
            border: 1px solid rgba(56, 189, 248, 0.22);
        }

        .price-tag {
            color: var(--success);
            font-weight: 800;
        }

        .qty-tag {
            display: inline-flex;
            align-items: center;
            padding: 5px 10px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            font-size: 13px;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.9);
        }

        .actions-cell {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: 0.25s ease;
            border: 1px solid transparent;
        }

        .btn-edit {
            color: #bfdbfe;
            background: rgba(59, 130, 246, 0.16);
            border-color: rgba(59, 130, 246, 0.3);
        }

        .btn-edit:hover {
            transform: translateY(-1px);
            color: #fff;
            background: rgba(59, 130, 246, 0.3);
        }

        .btn-delete {
            color: #fecaca;
            background: rgba(248, 113, 113, 0.14);
            border-color: rgba(248, 113, 113, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-1px);
            color: #fff;
            background: rgba(248, 113, 113, 0.28);
        }

        .empty-state {
            text-align: center;
            padding: 56px 22px;
            border-radius: 18px;
            background: rgba(0, 0, 0, 0.12);
            border: 1px dashed rgba(255, 255, 255, 0.18);
        }

        .empty-state .icon {
            font-size: 52px;
            margin-bottom: 14px;
        }

        .empty-state p {
            color: var(--muted);
            font-size: 16px;
        }

        .footer {
            margin-top: 24px;
            text-align: center;
            color: rgba(255, 255, 255, 0.5);
            font-size: 13px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 22px 16px;
                border-radius: 22px;
            }

            .header-section {
                align-items: flex-start;
                flex-direction: column;
            }

            .top-nav-actions {
                width: 100%;
            }

            .btn-nav {
                flex: 1;
            }

            .header-title h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <div class="header-title">
            <h1>📦 Inventory Management</h1>
            <p>Welcome <span><%= ab != null ? ab.getA_fname() : "Admin" %></span>, here are your product details.</p>
        </div>

        <div class="top-nav-actions">
            <a href="AdminHome.jsp" class="btn-nav btn-dashboard">🏠 Dashboard</a>
            <a href="LogoutServlet" class="btn-nav btn-logout-nav">🚪 Logout</a>
        </div>
    </div>

    <%
        if (al != null && !al.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="product-table">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Product Name</th>
                    <th>Company</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (ProductBean pb : al) { %>
                <tr>
                    <td><span class="code-badge"><%= pb.getPcode() %></span></td>
                    <td><strong><%= pb.getPname() %></strong></td>
                    <td><%= pb.getPcompany() %></td>
                    <td><span class="price-tag">₹<%= pb.getPprice() %></span></td>
                    <td><span class="qty-tag"><%= pb.getPqyt() %> units</span></td>
                    <td>
                        <div class="actions-cell">
                            <a href="EditProductServlet?pcode=<%= pb.getPcode() %>" class="btn-action btn-edit">✏️ Edit</a>
                            <a href="DeleteProductServlet?pcode=<%= pb.getPcode() %>" class="btn-action btn-delete">🗑️ Delete</a>
                        </div>
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
        <div class="icon">📭</div>
        <p>No products available in the database.</p>
    </div>
    <%
        }
    %>

    <div class="footer">
        Admin Product Management System © 2026
    </div>
</div>

</body>
</html>