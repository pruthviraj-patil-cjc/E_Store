<%@page import="com.bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Workspace</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        :root {
            --bg-main: #060814;
            --surface-glass: rgba(18, 24, 43, 0.55);
            --surface-border: rgba(255, 255, 255, 0.08);
            --border-hover: rgba(168, 85, 247, 0.3);
            
            --primary: #a855f7;
            --primary-glow: rgba(168, 85, 247, 0.25);
            --secondary-indigo: #6366f1;
            --accent-emerald: #10b981;
            --accent-rose: #f43f5e;
            
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
        }

        body {
            min-height: 100vh;
            background-color: var(--bg-main);
            color: var(--text-main);
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        .ambient-glow {
            position: fixed;
            border-radius: 50%;
            filter: blur(120px);
            z-index: 0;
            pointer-events: none;
        }
        .glow-1 {
            width: 500px;
            height: 500px;
            background: rgba(168, 85, 247, 0.12);
            top: -100px;
            left: -100px;
        }
        .glow-2 {
            width: 450px;
            height: 450px;
            background: rgba(99, 102, 241, 0.12);
            bottom: -50px;
            right: -50px;
        }

        .app-layout {
            display: flex;
            width: 100%;
            max-width: 1400px;
            min-height: 100vh;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .sidebar {
            width: 260px;
            padding: 32px 20px;
            display: flex;
            flex-direction: column;
            border-right: 1px solid var(--surface-border);
            background: rgba(10, 14, 26, 0.4);
            backdrop-filter: blur(20px);
        }

        .brand-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 20px;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 40px;
            color: #fff;
        }

        .brand-logo i {
            color: var(--primary);
        }

        .nav-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex-grow: 1;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 16px;
            border-radius: 14px;
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.25s ease;
        }

        .nav-link:hover, .nav-link.active {
            color: #fff;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--surface-border);
        }

        .nav-link.active {
            background: var(--primary-glow);
            color: var(--primary);
            border-color: rgba(168, 85, 247, 0.2);
        }

        .nav-link.logout {
            color: var(--accent-rose);
        }

        .nav-link.logout:hover {
            background: rgba(244, 63, 94, 0.1);
            border-color: rgba(244, 63, 94, 0.2);
        }

        .main-workspace {
            flex: 1;
            padding: 40px 48px;
            display: flex;
            flex-direction: column;
            gap: 32px;
            overflow-y: auto;
        }

        .top-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-greeting h1 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .user-greeting p {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 4px;
        }

        .user-avatar-badge {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--surface-glass);
            border: 1px solid var(--surface-border);
            padding: 8px 16px 8px 8px;
            border-radius: 40px;
            backdrop-filter: blur(12px);
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary-indigo));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #fff;
            font-size: 14px;
        }

        .avatar-name {
            font-size: 14px;
            font-weight: 600;
        }

        .action-cards-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .action-card {
            background: var(--surface-glass);
            border: 1px solid var(--surface-border);
            border-radius: 24px;
            padding: 32px;
            backdrop-filter: blur(16px);
            text-decoration: none;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            gap: 20px;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }

        .action-card:hover {
            transform: translateY(-6px);
            border-color: var(--border-hover);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }

        .action-icon-box {
            width: 56px;
            height: 56px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--surface-border);
            transition: transform 0.3s ease;
        }

        .action-card:hover .action-icon-box {
            transform: scale(1.1);
        }

        .add-box {
            background: rgba(168, 85, 247, 0.12);
            color: var(--primary);
            border-color: rgba(168, 85, 247, 0.25);
        }

        .view-box {
            background: rgba(16, 185, 129, 0.12);
            color: var(--accent-emerald);
            border-color: rgba(16, 185, 129, 0.25);
        }

        .action-details h2 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: -0.3px;
        }

        .action-details p {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .action-footer {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 700;
            margin-top: auto;
        }

        .add-footer { color: var(--primary); }
        .view-footer { color: var(--accent-emerald); }

        .workspace-footer {
            margin-top: auto;
            padding-top: 24px;
            border-top: 1px solid var(--surface-border);
            display: flex;
            justify-content: space-between;
            color: var(--text-muted);
            font-size: 13px;
        }

        @media (max-width: 900px) {
            .app-layout {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                border-right: none;
                border-bottom: 1px solid var(--surface-border);
            }
            .action-cards-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<%
    AdminBean ab = (AdminBean) session.getAttribute("adminbean");
    String firstName = (ab != null && ab.getA_fname() != null) ? ab.getA_fname() : "Admin";
    String firstInitial = firstName.substring(0, 1).toUpperCase();
%>

<div class="app-layout">

    <aside class="sidebar">
        <div class="brand-logo">
            <i data-lucide="shield-check"></i> Control Center
        </div>

        <ul class="nav-list">
            <li>
                <a href="#" class="nav-link active">
                    <i data-lucide="layout-dashboard"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="AddProduct.html" class="nav-link">
                    <i data-lucide="plus-circle"></i> Add Product
                </a>
            </li>
            <li>
                <a href="ViewProductServlet" class="nav-link">
                    <i data-lucide="package"></i> Inventory Catalog
                </a>
            </li>
            <li style="margin-top: auto;">
                <a href="Logout.jsp" class="nav-link logout">
                    <i data-lucide="log-out"></i> Sign Out
                </a>
            </li>
        </ul>
    </aside>

    <main class="main-workspace">

        <header class="top-header">
            <div class="user-greeting">
                <h1>Welcome back, <%= firstName %> 👋</h1>
                <p>Manage product operations and inventory records.</p>
            </div>

            <div class="user-avatar-badge">
                <div class="avatar"><%= firstInitial %></div>
                <span class="avatar-name"><%= firstName %></span>
            </div>
        </header>

        <section class="action-cards-grid">
            <a href="AddProduct.html" class="action-card">
                <div class="action-icon-box add-box">
                    <i data-lucide="plus" size="28"></i>
                </div>
                <div class="action-details">
                    <h2>Add Product</h2>
                    <p>Insert new product items, establish base pricing, and set starting inventory quantities.</p>
                </div>
                <div class="action-footer add-footer">
                    <span>Create New Entry</span>
                    <i data-lucide="arrow-right" size="16"></i>
                </div>
            </a>

            <a href="ViewProductServlet" class="action-card">
                <div class="action-icon-box view-box">
                    <i data-lucide="boxes" size="28"></i>
                </div>
                <div class="action-details">
                    <h2>View Inventory</h2>
                    <p>Browse active inventory, edit existing product information, or adjust system stocks.</p>
                </div>
                <div class="action-footer view-footer">
                    <span>Manage Catalog</span>
                    <i data-lucide="arrow-right" size="16"></i>
                </div>
            </a>
        </section>

        <footer class="workspace-footer">
            <span>Admin Control Panel System</span>
            <span>© 2026 All rights reserved</span>
        </footer>

    </main>

</div>

<script>
    lucide.createIcons();
</script>

</body>
</html>