<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Security | Session Terminated</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
   
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        :root {
            --bg-deep: #030712;
            --surface-card: rgba(15, 23, 42, 0.75);
            --surface-border: rgba(255, 255, 255, 0.08);

            --accent-emerald: #10b981;
            --accent-emerald-glow: rgba(16, 185, 129, 0.25);
            --accent-cyan: #06b6d4;
            --accent-indigo: #6366f1;

            --text-heading: #f8fafc;
            --text-body: #cbd5e1;
            --text-muted: #64748b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
        }

        body {
            min-height: 100vh;
            background-color: var(--bg-deep);
            color: var(--text-body);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 24px;
            overflow: hidden;
            position: relative;
        }

        
        .grid-bg {
            position: fixed;
            inset: 0;
            background-image: 
                linear-gradient(to right, rgba(255, 255, 255, 0.02) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(255, 255, 255, 0.02) 1px, transparent 1px);
            background-size: 36px 36px;
            z-index: 0;
            pointer-events: none;
        }

       
        .ambient-glow {
            position: fixed;
            border-radius: 50%;
            filter: blur(130px);
            z-index: 0;
            pointer-events: none;
        }
        .glow-1 {
            width: 450px;
            height: 450px;
            background: rgba(16, 185, 129, 0.12);
            top: -100px;
            left: -100px;
        }
        .glow-2 {
            width: 450px;
            height: 450px;
            background: rgba(99, 102, 241, 0.12);
            bottom: -100px;
            right: -100px;
        }

        /* Card Container */
        .card {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 460px;
            background: var(--surface-card);
            backdrop-filter: blur(28px);
            -webkit-backdrop-filter: blur(28px);
            border: 1px solid var(--surface-border);
            border-radius: 24px;
            box-shadow: 0 32px 80px rgba(0, 0, 0, 0.6),
                        inset 0 1px 0 rgba(255, 255, 255, 0.12);
            padding: 40px 36px 32px;
            text-align: center;
            animation: cardEntrance 0.7s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        @keyframes cardEntrance {
            from { opacity: 0; transform: translateY(24px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* Icon Badge Header */
        .shield-icon-wrapper {
            width: 72px;
            height: 72px;
            margin: 0 auto 20px;
            border-radius: 20px;
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.2), rgba(6, 182, 212, 0.1));
            border: 1px solid rgba(16, 185, 129, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-emerald);
            box-shadow: 0 12px 28px var(--accent-emerald-glow);
            animation: pulseGlow 3s ease-in-out infinite alternate;
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 12px 28px rgba(16, 185, 129, 0.2); }
            100% { box-shadow: 0 16px 36px rgba(16, 185, 129, 0.4); }
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--accent-emerald);
            font-size: 11.5px;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 20px;
        }

        .status-badge::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--accent-emerald);
            box-shadow: 0 0 8px var(--accent-emerald);
        }

        h1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 24px;
            font-weight: 700;
            color: var(--text-heading);
            margin-bottom: 10px;
            letter-spacing: -0.3px;
        }

        .desc {
            font-size: 13.5px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 28px;
        }

        /* Action Buttons */
        .actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 13px 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.25s ease;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--accent-indigo) 0%, #4f46e5 100%);
            color: #ffffff;
            box-shadow: 0 8px 22px rgba(99, 102, 241, 0.35);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(99, 102, 241, 0.45);
            background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.04);
            color: var(--text-heading);
            border: 1px solid var(--surface-border);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.08);
            transform: translateY(-2px);
            border-color: rgba(255, 255, 255, 0.2);
        }

        
        .audit-panel {
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid var(--surface-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 11.5px;
            color: var(--text-muted);
        }

        .redirect-counter {
            font-weight: 600;
            color: var(--accent-cyan);
        }

        @media (max-width: 480px) {
            .card {
                padding: 32px 24px 24px;
            }
        }
    </style>
</head>
<body>

<div class="grid-bg"></div>
<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<div class="card">

    <div class="shield-icon-wrapper">
        <i data-lucide="shield-check" size="32"></i>
    </div>

    <div class="status-badge">Session Safely Cleared</div>

    <h1>Logged Out Successfully</h1>

    <p class="desc">
        Your security credentials have been flushed and active server tokens were invalidated.
    </p>

    <div class="actions">
        <a href="AdminLogin.html" class="btn btn-primary">
            <i data-lucide="log-in" size="18"></i>
            <span>Re-authenticate Login</span>
        </a>
        <a href="Index.html" class="btn btn-secondary">
            <i data-lucide="home" size="18"></i>
            <span>Return to Main Portal</span>
        </a>
    </div>

    <div class="audit-panel">
        <span>Aegis Security Engine &copy; 2026</span>
        <span class="redirect-counter">Auto redirect in <span id="timer">10</span>s</span>
    </div>

</div>

<script>
    lucide.createIcons();

    
    let seconds = 10;
    const timerElement = document.getElementById("timer");

    const countdown = setInterval(() => {
        seconds--;
        if (timerElement) {
            timerElement.textContent = seconds;
        }
        if (seconds <= 0) {
            clearInterval(countdown);
            window.location.href = "AdminLogin.html";
        }
    }, 1000);
</script>

</body>
</html>