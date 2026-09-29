<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bean.CustomerBean" %>
<%@ page import="com.bean.ProductBean" %>
<%
    CustomerBean cb = (CustomerBean) session.getAttribute("cbean");
    ProductBean pb = (ProductBean) request.getAttribute("pbean");
    Integer reqQty = (Integer) request.getAttribute("reqQty");
    Float totalAmount = (Float) request.getAttribute("totalAmount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed</title>

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
            --success: #34d399;
            --blue: #38bdf8;
            --btn1: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            --btn2: linear-gradient(135deg, rgba(255,255,255,0.10) 0%, rgba(255,255,255,0.05) 100%);
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
            background: #10b981;
            top: 8%;
            left: 8%;
        }

        body::after {
            background: #3b82f6;
            bottom: 8%;
            right: 8%;
        }

        .summary-card {
            position: relative;
            z-index: 1;
            width: 620px;
            max-width: 100%;
            padding: 40px 34px 32px;
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

        .header-section {
            text-align: center;
            margin-bottom: 26px;
        }

        .success-icon {
            width: 78px;
            height: 78px;
            margin: 0 auto 14px;
            border-radius: 24px;
            display: grid;
            place-items: center;
            font-size: 38px;
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.3);
            animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes popIn {
            0% { transform: scale(0); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        .greeting-text {
            font-size: 16px;
            font-weight: 600;
            color: var(--muted);
            margin-bottom: 8px;
        }

        .greeting-text span {
            color: var(--blue);
            font-weight: 800;
        }

        .main-title {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: var(--success);
        }

        .subtitle {
            margin-top: 10px;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.6;
        }

        .section-subtitle {
            font-size: 16px;
            font-weight: 800;
            margin-bottom: 14px;
            color: rgba(255, 255, 255, 0.92);
        }

        .table-responsive {
            width: 100%;
            overflow: hidden;
            border-radius: 18px;
            border: 1px solid var(--border);
            background: rgba(0, 0, 0, 0.16);
            margin-bottom: 26px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            font-size: 14px;
        }

        th {
            width: 46%;
            text-align: left;
            color: rgba(255, 255, 255, 0.72);
            background: rgba(255, 255, 255, 0.05);
            text-transform: uppercase;
            letter-spacing: 0.6px;
            font-size: 12px;
            font-weight: 800;
        }

        td {
            color: #fff;
            font-weight: 600;
        }

        tr:last-child th,
        tr:last-child td {
            border-bottom: none;
        }

        .total-row th,
        .total-row td {
            background: rgba(16, 185, 129, 0.14);
            color: #86efac;
            font-weight: 800;
        }

        .total-row td {
            font-size: 18px;
        }

        .code-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 999px;
            font-family: monospace;
            font-size: 13px;
            color: #7dd3fc;
            background: rgba(56, 189, 248, 0.12);
            border: 1px solid rgba(56, 189, 248, 0.22);
        }

        .empty-state {
            padding: 34px 20px;
            text-align: center;
            background: rgba(0, 0, 0, 0.16);
            border-radius: 18px;
            border: 1px dashed rgba(255, 255, 255, 0.18);
            color: var(--muted);
            margin-bottom: 26px;
        }

        .action-buttons {
            display: grid;
            gap: 12px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 14px;
            border-radius: 14px;
            font-size: 15px;
            font-weight: 800;
            text-decoration: none;
            transition: 0.3s ease;
        }

        .btn-view {
            color: #fff;
            background: var(--btn1);
            box-shadow: 0 10px 20px rgba(29, 78, 216, 0.3);
        }

        .btn-view:hover {
            transform: translateY(-2px);
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            box-shadow: 0 14px 28px rgba(29, 78, 216, 0.45);
        }

        .btn-logout {
            color: rgba(255, 255, 255, 0.92);
            background: var(--btn2);
            border: 1px solid var(--border);
        }

        .btn-logout:hover {
            transform: translateY(-2px);
            background: rgba(255, 255, 255, 0.14);
        }

        .footer {
            margin-top: 26px;
            text-align: center;
            color: rgba(255, 255, 255, 0.5);
            font-size: 13px;
        }

        @media (max-width: 520px) {
            .summary-card {
                padding: 30px 18px 22px;
                border-radius: 24px;
            }

            .main-title {
                font-size: 21px;
            }

            th, td {
                padding: 12px 14px;
                font-size: 13px;
            }

            .total-row td {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<div class="summary-card">
    <div class="header-section">
        <div class="success-icon">🎉</div>
        <div class="greeting-text">
            Hello <span><%= (cb != null && cb.getFname() != null) ? cb.getFname() : "Customer" %>!</span>
        </div>
        <h2 class="main-title">Your order has been placed successfully</h2>
        <p class="subtitle">Here is your purchase summary with item and payment details.</p>
    </div>

    <div class="section-subtitle">📋 Order Summary</div>

    <% if (pb != null && totalAmount != null) { %>
        <div class="table-responsive">
            <table>
                <tr>
                    <th>Product Code</th>
                    <td><span class="code-badge"><%= pb.getPcode() %></span></td>
                </tr>
                <tr>
                    <th>Product Name</th>
                    <td><%= pb.getPname() %></td>
                </tr>
                <tr>
                    <th>Company</th>
                    <td><%= pb.getPcompany() %></td>
                </tr>
                <tr>
                    <th>Price per Unit</th>
                    <td>₹<%= pb.getPprice() %></td>
                </tr>
                <tr>
                    <th>Quantity Ordered</th>
                    <td><%= reqQty != null ? reqQty : 0 %> units</td>
                </tr>
                <tr class="total-row">
                    <th>Total Bill Amount</th>
                    <td>₹<%= totalAmount %>/-</td>
                </tr>
            </table>
        </div>
    <% } else { %>
        <div class="empty-state">
            No order details available.
        </div>
    <% } %>

    <div class="action-buttons">
        <a href="viewProducts" class="btn btn-view">🛍️ View Updated Products List</a>
        <a href="Logout.jsp" class="btn btn-logout">🚪 Logout</a>
    </div>

    <div class="footer">
        Order Summary System © 2026
    </div>
</div>

</body>
</html>