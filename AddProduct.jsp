<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Operation Status | Admin Portal</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        :root {
            --bg-main: #060814;
            --surface-glass: rgba(18, 24, 43, 0.65);
            --surface-border: rgba(255, 255, 255, 0.1);
            --border-hover: rgba(168, 85, 247, 0.4);
            
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
            justify-content: center;
            align-items: center;
            padding: 24px 16px;
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
            width: 480px;
            height: 480px;
            background: rgba(16, 185, 129, 0.12);
            top: -100px;
            left: -100px;
        }
        .glow-2 {
            width: 420px;
            height: 420px;
            background: rgba(168, 85, 247, 0.12);
            bottom: -50px;
            right: -50px;
        }

        .result-card {
            position: relative;
            z-index: 1;
            width: 720px;
            max-width: 100%;
            background: var(--surface-glass);
            backdrop-filter: blur(24px);
            -webkit-backdrop-filter: blur(24px);
            border: 1px solid var(--surface-border);
            border-radius: 28px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.5),
                        inset 0 1px 0 rgba(255, 255, 255, 0.15);
            padding: 44px 36px 36px;
            text-align: center;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            padding: 14px 24px;
            border-radius: 999px;
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.25);
            color: #34d399;
            font-size: 15px;
            font-weight: 700;
            margin-bottom: 36px;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.15);
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .action-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--surface-border);
            border-radius: 20px;
            padding: 24px 16px;
            text-decoration: none;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .action-card:hover {
            transform: translateY(-6px);
            border-color: var(--border-hover);
            background: rgba(255, 255, 255, 0.06);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.3);
        }

        .card-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--surface-border);
            transition: transform 0.3s ease;
        }

        .action-card:hover .card-icon {
            transform: scale(1.1);
        }

        .icon-add {
            background: rgba(168, 85, 247, 0.12);
            color: var(--primary);
            border-color: rgba(168, 85, 247, 0.25);
        }

        .icon-view {
            background: rgba(16, 185, 129, 0.12);
            color: var(--accent-emerald);
            border-color: rgba(16, 185, 129, 0.25);
        }

        .icon-logout {
            background: rgba(244, 63, 94, 0.12);
            color: var(--accent-rose);
            border-color: rgba(244, 63, 94, 0.25);
        }

        .action-card h2 {
            font-size: 16px;
            font-weight: 700;
            letter-spacing: -0.2px;
        }

        .action-card p {
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.4;
        }

        .footer {
            margin-top: 36px;
            padding-top: 20px;
            border-top: 1px solid var(--surface-border);
            text-align: center;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 500;
        }

        @media (max-width: 680px) {
            .result-card {
                padding: 32px 20px;
            }

            .action-grid {
                grid-template-columns: 1fr;
            }

            .status-badge {
                font-size: 14px;
                padding: 12px 18px;
            }
        }
    </style>
</head>
<body>

<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<div class="result-card">

    <div class="status-badge">
        <i data-lucide="bell" size="18"></i>
        <span><%
            String msg = (String) request.getAttribute("msg");
            out.print(msg != null ? msg : "Operation Completed Successfully");
        %></span>
    </div>

    <div class="action-grid">

        <a href="AddProduct.html" class="action-card">
            <div class="card-icon icon-add">
                <i data-lucide="plus" size="22"></i>
            </div>
            <h2>Add Product</h2>
            <p>Insert another product entry</p>
        </a>

        <a href="ViewProductServlet" class="action-card">
            <div class="card-icon icon-view">
                <i data-lucide="boxes" size="22"></i>
            </div>
            <h2>View Catalog</h2>
            <p>Inspect active inventory list</p>
        </a>

        <a href="Logout" class="action-card">
            <div class="card-icon icon-logout">
                <i data-lucide="log-out" size="22"></i>
            </div>
            <h2>Logout</h2>
            <p>Terminate current session</p>
        </a>

    </div>

    <div class="footer">
        Admin Product Management System © 2026
    </div>

</div>

<script>
    lucide.createIcons();
</script>

</body>
</html>