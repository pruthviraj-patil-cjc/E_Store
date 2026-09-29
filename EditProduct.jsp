<%@page import="com.bean.ProductBean"%>
<%@page import="com.bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Product</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --bg: linear-gradient(135deg, #050816 0%, #0f172a 35%, #1e1b4b 70%, #311042 100%);
        --card: rgba(255, 255, 255, 0.08);
        --border: rgba(255, 255, 255, 0.18);
        --text: #ffffff;
        --muted: rgba(255, 255, 255, 0.72);
        --shadow: 0 30px 70px rgba(0, 0, 0, 0.42);
        --accent: #8b5cf6;
    }

    * {
        box-sizing: border-box;
        font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
    }

    body {
        min-height: 100vh;
        margin: 0;
        color: var(--text);
        background: var(--bg);
        overflow-x: hidden;
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
    }

    body::before {
        background: #3b82f6;
        top: 8%;
        left: 8%;
    }

    body::after {
        background: #9333ea;
        bottom: 8%;
        right: 8%;
    }

    .page-wrap {
        position: relative;
        z-index: 1;
        min-height: 100vh;
    }

    .edit-card {
        width: 100%;
        max-width: 640px;
        border: 1px solid var(--border);
        border-radius: 26px;
        background: var(--card);
        backdrop-filter: blur(22px);
        -webkit-backdrop-filter: blur(22px);
        box-shadow: var(--shadow);
        overflow: hidden;
        animation: fadeUp 0.8s ease both;
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(24px) scale(0.98); }
        to { opacity: 1; transform: translateY(0) scale(1); }
    }

    .header-box {
        background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(37, 99, 235, 0.72));
        color: white;
        padding: 28px 24px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.12);
    }

    .header-box h2 {
        font-size: 28px;
        font-weight: 800;
        letter-spacing: -0.5px;
        margin-bottom: 8px;
    }

    .header-box p {
        margin: 0;
        color: rgba(255, 255, 255, 0.82);
        font-size: 15px;
        line-height: 1.6;
    }

    .form-body {
        padding: 28px 26px 26px;
    }

    .form-label {
        color: rgba(255, 255, 255, 0.88);
        font-weight: 700;
        margin-bottom: 8px;
    }

    .form-control {
        background: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.16);
        color: white;
        border-radius: 14px;
        padding: 12px 14px;
    }

    .form-control::placeholder {
        color: rgba(255, 255, 255, 0.45);
    }

    .form-control:focus {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        border-color: rgba(139, 92, 246, 0.7);
        box-shadow: 0 0 0 0.2rem rgba(139, 92, 246, 0.18);
    }

    .readonly-field {
        background: rgba(255, 255, 255, 0.05) !important;
        color: rgba(255, 255, 255, 0.9);
        cursor: not-allowed;
    }

    .btn-update {
        background: linear-gradient(135deg, #8b5cf6 0%, #6366f1 100%);
        border: none;
        color: white;
        font-weight: 800;
        border-radius: 14px;
        padding: 12px 18px;
        box-shadow: 0 12px 24px rgba(99, 102, 241, 0.28);
        transition: 0.3s ease;
    }

    .btn-update:hover {
        transform: translateY(-2px);
        color: white;
        box-shadow: 0 16px 30px rgba(99, 102, 241, 0.38);
    }

    .btn-back {
        background: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.14);
        color: rgba(255, 255, 255, 0.9);
        font-weight: 700;
        border-radius: 14px;
        padding: 12px 18px;
        transition: 0.3s ease;
    }

    .btn-back:hover {
        transform: translateY(-2px);
        color: white;
        background: rgba(255, 255, 255, 0.14);
    }

    .alert {
        border-radius: 14px;
    }

    .page-note {
        text-align: center;
        margin-top: 14px;
        color: rgba(255, 255, 255, 0.5);
        font-size: 13px;
    }

    @media (max-width: 576px) {
        .header-box h2 {
            font-size: 24px;
        }

        .form-body {
            padding: 22px 18px 20px;
        }
    }
</style>
</head>
<body>
<%
    AdminBean abean = (AdminBean) session.getAttribute("adminbean");
    ProductBean pb = (ProductBean) request.getAttribute("pbean");
%>

<div class="page-wrap d-flex justify-content-center align-items-center px-3 py-4">
    <div class="edit-card">
        <div class="header-box">
            <h2>Edit Product</h2>
            <p>
                Welcome <%= (abean != null ? abean.getA_fname() : "Admin") %>, update the selected product details below.
            </p>
        </div>

        <div class="form-body">
            <% if (pb == null) { %>
                <div class="alert alert-danger mb-0">Product data not found.</div>
            <% } else { %>
                <form action="update" method="post">
                    <div class="mb-3">
                        <label class="form-label">Product Code</label>
                        <input type="text" class="form-control readonly-field" value="<%= pb.getPcode() %>" readonly>
                        <input type="hidden" name="pcode" value="<%= pb.getPcode() %>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Product Price</label>
                        <input type="number" step="0.01" class="form-control" name="pprice" value="<%= pb.getPprice() %>" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Product Quantity</label>
                        <input type="number" class="form-control" name="pqty" value="<%= pb.getPqyt() %>" required>
                    </div>

                    <div class="d-grid gap-3">
                        <input type="submit" class="btn btn-update btn-lg" value="Update Product">
                        <a href="AdminHome.jsp" class="btn btn-back btn-lg text-decoration-none text-center">Back to Dashboard</a>
                    </div>
                </form>
            <% } %>
        </div>
    </div>
</div>

<div class="page-note">Admin Product Management System © 2026</div>
</body>
</html>