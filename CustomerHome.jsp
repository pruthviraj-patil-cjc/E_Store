<%@page import="com.bean.CustomerBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Workspace</title>


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>

<style>
:root {
	--bg-main: #060814;
	--surface-glass: rgba(18, 24, 43, 0.55);
	--surface-border: rgba(255, 255, 255, 0.08);
	--border-hover: rgba(56, 189, 248, 0.3);
	--primary: #38bdf8;
	--primary-glow: rgba(56, 189, 248, 0.25);
	--accent-purple: #a855f7;
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
	background: rgba(56, 189, 248, 0.12);
	top: -100px;
	left: -100px;
}

.glow-2 {
	width: 450px;
	height: 450px;
	background: rgba(168, 85, 247, 0.12);
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
	border-color: rgba(56, 189, 248, 0.2);
}

.nav-link.logout {
	color: var(--accent-rose);
}

.nav-link.logout:hover {
	background: rgba(244, 63, 94, 0.1);
	border-color: rgba(244, 63, 94, 0.2);
}

/* Main Workspace */
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
	background: linear-gradient(135deg, var(--primary), var(--accent-purple));
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

.metrics-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
}

.metric-card {
	background: var(--surface-glass);
	border: 1px solid var(--surface-border);
	padding: 20px;
	border-radius: 20px;
	backdrop-filter: blur(12px);
	display: flex;
	align-items: center;
	gap: 16px;
}

.metric-icon {
	width: 48px;
	height: 48px;
	border-radius: 14px;
	background: rgba(255, 255, 255, 0.04);
	display: flex;
	align-items: center;
	justify-content: center;
	color: var(--primary);
	border: 1px solid var(--surface-border);
}

.metric-info label {
	font-size: 12px;
	color: var(--text-muted);
	font-weight: 500;
	display: block;
	margin-bottom: 2px;
}

.metric-info span {
	font-size: 18px;
	font-weight: 700;
}

.hero-banner {
	position: relative;
	background: linear-gradient(135deg, rgba(56, 189, 248, 0.1) 0%,
		rgba(168, 85, 247, 0.05) 100%);
	border: 1px solid var(--surface-border);
	border-radius: 28px;
	padding: 40px;
	overflow: hidden;
	display: flex;
	justify-content: space-between;
	align-items: center;
	backdrop-filter: blur(16px);
}

.hero-banner::before {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	width: 300px;
	height: 100%;
	background: radial-gradient(circle, var(--primary-glow) 0%, transparent
		70%);
	pointer-events: none;
}

.hero-text {
	max-width: 420px;
	z-index: 1;
}

.hero-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 6px 12px;
	border-radius: 20px;
	background: rgba(56, 189, 248, 0.15);
	color: var(--primary);
	font-size: 12px;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin-bottom: 16px;
}

.hero-title {
	font-size: 28px;
	font-weight: 800;
	line-height: 1.25;
	margin-bottom: 12px;
	letter-spacing: -0.5px;
}

.hero-description {
	color: var(--text-muted);
	font-size: 14px;
	line-height: 1.6;
	margin-bottom: 24px;
}

.btn-primary {
	display: inline-flex;
	align-items: center;
	gap: 10px;
	background: var(--primary);
	color: #060814;
	padding: 14px 28px;
	border-radius: 14px;
	font-weight: 700;
	font-size: 14px;
	text-decoration: none;
	transition: all 0.3s ease;
	box-shadow: 0 8px 20px rgba(56, 189, 248, 0.25);
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 28px rgba(56, 189, 248, 0.4);
	background: #7dd3fc;
}

.hero-visual {
	z-index: 1;
	width: 140px;
	height: 140px;
	background: rgba(255, 255, 255, 0.03);
	border: 1px solid var(--surface-border);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;
}

.hero-visual i {
	color: var(--primary);
	filter: drop-shadow(0 0 12px var(--primary));
}

.workspace-footer {
	margin-top: auto;
	padding-top: 24px;
	border-top: 1px solid var(--surface-border);
	display: flex;
	justify-content: space-between;
	color: var(--text-muted);
	font-size: 13px;
}

@media ( max-width : 900px) {
	.app-layout {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		border-right: none;
		border-bottom: 1px solid var(--surface-border);
	}
	.metrics-grid {
		grid-template-columns: 1fr;
	}
	.hero-banner {
		flex-direction: column;
		text-align: center;
		gap: 24px;
	}
	.hero-text {
		max-width: 100%;
	}
	.hero-badge {
		margin: 0 auto 16px;
	}
}
</style>
</head>
<body>

	<div class="ambient-glow glow-1"></div>
	<div class="ambient-glow glow-2"></div>

	<%
    CustomerBean cb = (CustomerBean) session.getAttribute("cbean");
    String firstName = (cb != null && cb.getFname() != null) ? cb.getFname() : "User";
    String firstInitial = firstName.substring(0, 1).toUpperCase();
%>

	<div class="app-layout">

		<!-- Sidebar Navigation -->
		<aside class="sidebar">
			<div class="brand-logo">
				<i data-lucide="shield-check"></i> Portal
			</div>

			<ul class="nav-list">
				<li><a href="#" class="nav-link active"> <i
						data-lucide="layout-dashboard"></i> Dashboard
				</a></li>
				<li><a href="viewProducts" class="nav-link"> <i
						data-lucide="shopping-bag"></i> Browse Products
				</a></li>
				<li style="margin-top: auto;"><a href="Logout.jsp"
					class="nav-link logout"> <i data-lucide="log-out"></i> Sign Out
				</a></li>
			</ul>
		</aside>

		<!-- Main Workspace -->
		<main class="main-workspace">

			<!-- Top Navigation / Header -->
			<header class="top-header">
				<div class="user-greeting">
					<h1>
						Welcome back,
						<%= firstName %>
						👋
					</h1>
					<p>Manage your orders and explore our product selection.</p>
				</div>

				<div class="user-avatar-badge">
					<div class="avatar"><%= firstInitial %></div>
					<span class="avatar-name"><%= firstName %></span>
				</div>
			</header>

			<!-- Quick Status Cards -->
			<section class="metrics-grid">
				<div class="metric-card">
					<div class="metric-icon">
						<i data-lucide="package"></i>
					</div>
					<div class="metric-info">
						<label>Catalog Access</label> <span>Full Access</span>
					</div>
				</div>

				<div class="metric-card">
					<div class="metric-icon">
						<i data-lucide="user-check"></i>
					</div>
					<div class="metric-info">
						<label>Account Status</label> <span style="color: #4ade80;">Active</span>
					</div>
				</div>

				<div class="metric-card">
					<div class="metric-icon">
						<i data-lucide="clock"></i>
					</div>
					<div class="metric-info">
						<label>Current Year</label> <span>2026 Edition</span>
					</div>
				</div>
			</section>


			<section class="hero-banner">
				<div class="hero-text">
					<div class="hero-badge">
						<i data-lucide="sparkles" size="14"></i> Updated Catalog
					</div>
					<h2 class="hero-title">Explore Our Latest Products</h2>
					<p class="hero-description">Discover new additions and browse
						the entire inventory available in your account.</p>
					<a href="viewProducts" class="btn-primary"> View Catalog <i
						data-lucide="arrow-right" size="18"></i>
					</a>
				</div>

				<div class="hero-visual">
					<i data-lucide="shopping-bag" size="56"></i>
				</div>
			</section>


			<footer class="workspace-footer">
				<span>Customer Portal System</span> <span>© 2026 All rights
					reserved</span>
			</footer>

		</main>

	</div>

	<script>
    
    lucide.createIcons();
</script>

</body>
</html>