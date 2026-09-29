<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bean.CustomerBean" %>
<%@ page import="com.bean.ProductBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Confirm Purchase</title>

    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        :root {
            --bg-main: #060814;
            --surface-glass: rgba(18, 24, 43, 0.65);
            --surface-border: rgba(255, 255, 255, 0.1);
            --border-hover: rgba(56, 189, 248, 0.3);
            
            --primary: #38bdf8;
            --primary-glow: rgba(56, 189, 248, 0.25);
            --accent-emerald: #10b981;
            --emerald-glow: rgba(16, 185, 129, 0.25);
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

        /* Ambient Glow Objects */
        .ambient-glow {
            position: fixed;
            border-radius: 50%;
            filter: blur(120px);
            z-index: 0;
            pointer-events: none;
        }
        .glow-1 {
            width: 450px;
            height: 450px;
            background: rgba(56, 189, 248, 0.12);
            top: 5%;
            left: 15%;
        }
        .glow-2 {
            width: 400px;
            height: 400px;
            background: rgba(16, 185, 129, 0.12);
            bottom: 5%;
            right: 15%;
        }

        /* Checkout Card Shell */
        .checkout-wrapper {
            position: relative;
            z-index: 1;
            width: 540px;
            max-width: 100%;
            background: var(--surface-glass);
            backdrop-filter: blur(24px);
            -webkit-backdrop-filter: blur(24px);
            border: 1px solid var(--surface-border);
            border-radius: 28px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.5),
                        inset 0 1px 0 rgba(255, 255, 255, 0.15);
            overflow: hidden;
        }

        /* Top Header Strip */
        .checkout-header {
            padding: 28px 32px 20px;
            border-bottom: 1px solid var(--surface-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-title .icon-box {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: rgba(56, 189, 248, 0.1);
            border: 1px solid rgba(56, 189, 248, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
        }

        .header-title h2 {
            font-size: 20px;
            font-weight: 800;
            letter-spacing: -0.3px;
        }

        .user-tag {
            font-size: 13px;
            color: var(--text-muted);
            background: rgba(255, 255, 255, 0.04);
            padding: 6px 14px;
            border-radius: 20px;
            border: 1px solid var(--surface-border);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .user-tag strong {
            color: var(--primary);
        }

        /* Alert Styling */
        .error-banner {
            margin: 20px 32px 0;
            background: rgba(244, 63, 94, 0.12);
            border: 1px solid rgba(244, 63, 94, 0.3);
            color: #fda4af;
            padding: 12px 16px;
            border-radius: 14px;
            font-size: 13px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Main Form Area */
        .checkout-body {
            padding: 28px 32px 32px;
        }

        /* Item Summary Box */
        .product-summary-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--surface-border);
            border-radius: 18px;
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-info-primary h3 {
            font-size: 18px;
            font-weight: 700;
            letter-spacing: -0.3px;
            margin-bottom: 4px;
        }

        .product-meta {
            font-size: 12px;
            color: var(--text-muted);
            display: flex;
            gap: 12px;
        }

        .badge-code {
            font-family: monospace;
            background: rgba(255, 255, 255, 0.08);
            padding: 2px 6px;
            border-radius: 6px;
        }

        .stock-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            color: var(--accent-emerald);
            background: rgba(16, 185, 129, 0.12);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
        }

        /* Form Controls */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            font-size: 12px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 14px;
            color: var(--text-muted);
            pointer-events: none;
        }

        .form-control {
            width: 100%;
            padding: 12px 14px 12px 42px;
            border-radius: 12px;
            border: 1px solid var(--surface-border);
            font-size: 14px;
            font-weight: 600;
            color: #ffffff;
            outline: none;
            transition: all 0.25s ease;
            background: rgba(255, 255, 255, 0.04);
        }

        .form-control[readonly] {
            color: rgba(255, 255, 255, 0.6);
            cursor: not-allowed;
            background: rgba(0, 0, 0, 0.2);
        }

        .form-control:not([readonly]):focus {
            border-color: var(--primary);
            background: rgba(56, 189, 248, 0.05);
            box-shadow: 0 0 0 3px var(--primary-glow);
        }

        /* Order Summary Output Box */
        .order-calculation-card {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.08) 0%, rgba(56, 189, 248, 0.04) 100%);
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 16px;
            padding: 16px 20px;
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .calc-label {
            font-size: 13px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .calc-value {
            font-size: 22px;
            font-weight: 800;
            color: var(--accent-emerald);
        }

        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 16px;
            margin-top: 20px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #ffffff;
            font-size: 15px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 10px 24px var(--emerald-glow);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 28px rgba(16, 185, 129, 0.4);
            background: linear-gradient(135deg, #34d399 0%, #059669 100%);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Footer Bar */
        .checkout-footer {
            padding: 18px 32px;
            border-top: 1px solid var(--surface-border);
            background: rgba(0, 0, 0, 0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-back {
            color: var(--primary);
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s ease;
        }

        .btn-back:hover {
            color: #7dd3fc;
        }

        .copyright {
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 500;
        }

        /* Not Found Fallback */
        .not-found-card {
            text-align: center;
            padding: 40px 20px;
        }

        .not-found-card i {
            color: var(--accent-rose);
            margin-bottom: 12px;
        }

        .not-found-card p {
            color: var(--text-muted);
            font-size: 15px;
            font-weight: 600;
        }

        @media (max-width: 580px) {
            .checkout-header, .checkout-body, .checkout-footer {
                padding-left: 20px;
                padding-right: 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: span 1;
            }

            .product-summary-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }
    </style>
</head>
<body>

<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<%
    CustomerBean cb = (CustomerBean) session.getAttribute("cbean");
    ProductBean pb = (ProductBean) request.getAttribute("pbean");
    String msg = (String) request.getAttribute("msg");
%>

<div class="checkout-wrapper">

    <!-- Card Header -->
    <div class="checkout-header">
        <div class="header-title">
            <div class="icon-box">
                <i data-lucide="shopping-bag" size="20"></i>
            </div>
            <h2>Confirm Purchase</h2>
        </div>

        <% if (cb != null) { %>
            <div class="user-tag">
                <i data-lucide="user" size="14"></i>
                <span>Hello, <strong><%= cb.getFname() %></strong></span>
            </div>
        <% } %>
    </div>

    <!-- Error Alert Banner -->
    <% if (msg != null) { %>
        <div class="error-banner">
            <i data-lucide="alert-circle" size="18"></i>
            <span><%= msg %></span>
        </div>
    <% } %>

    <!-- Main Content -->
    <div class="checkout-body">
        <% if (pb != null) { %>
            
            <!-- Summary Header of Selected Item -->
            <div class="product-summary-card">
                <div class="product-info-primary">
                    <h3><%= pb.getPname() %></h3>
                    <div class="product-meta">
                        <span>Code: <span class="badge-code"><%= pb.getPcode() %></span></span>
                        <span>Brand: <strong><%= pb.getPcompany() %></strong></span>
                    </div>
                </div>
                <div class="stock-badge">
                    <i data-lucide="layers" size="14"></i>
                    <span><%= pb.getPqyt() %> in stock</span>
                </div>
            </div>

            <form action="buyProduct" method="post" id="buyForm">
                
                <!-- Hidden inputs so servlet backend logic remains completely intact -->
                <input type="hidden" name="pcode" value="<%= pb.getPcode() %>">
                <input type="hidden" name="pname" value="<%= pb.getPname() %>">
                <input type="hidden" name="pcompany" value="<%= pb.getPcompany() %>">
                <input type="hidden" name="pqty" value="<%= pb.getPqyt() %>">

                <div class="form-grid">

                    <div class="form-group">
                        <label for="price">Unit Price</label>
                        <div class="input-wrapper">
                            <i data-lucide="indian-rupee" size="16"></i>
                            <input type="text" id="price" name="price" class="form-control" value="<%= pb.getPprice() %>" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reqqty" style="color: var(--accent-emerald);">Quantity Required</label>
                        <div class="input-wrapper">
                            <i data-lucide="hash" size="16"></i>
                            <input type="number" 
                                   id="reqqty" 
                                   name="reqqty" 
                                   class="form-control" 
                                   min="1" 
                                   max="<%= pb.getPqyt() %>" 
                                   placeholder="1" 
                                   required 
                                   autofocus 
                                   oninput="calculateTotal()">
                        </div>
                    </div>

                </div>

                <!-- Dynamic Total Price Preview -->
                <div class="order-calculation-card">
                    <span class="calc-label">Total Payable Amount</span>
                    <span class="calc-value" id="totalPriceDisplay">₹<%= pb.getPprice() %></span>
                </div>

                <button type="submit" class="btn-submit">
                    <i data-lucide="check-circle" size="18"></i>
                    <span>Confirm & Pay Now</span>
                </button>

            </form>

        <% } else { %>

            <div class="not-found-card">
                <i data-lucide="package-x" size="48"></i>
                <p>Product details could not be retrieved.</p>
            </div>

        <% } %>
    </div>

    <!-- Card Footer Actions -->
    <div class="checkout-footer">
        <a href="ViewCustomerProductsServlet" class="btn-back">
            <i data-lucide="arrow-left" size="16"></i>
            <span>Back to Products</span>
        </a>
        <div class="copyright">
            Checkout System © 2026
        </div>
    </div>

</div>

<script>
    
    lucide.createIcons();

    
    function calculateTotal() {
        const unitPrice = parseFloat(document.getElementById('price').value) || 0;
        const reqQtyInput = document.getElementById('reqqty');
        let qty = parseInt(reqQtyInput.value) || 1;

       
        if (qty < 1) {
            qty = 1;
        }

        const total = unitPrice * qty;
        document.getElementById('totalPriceDisplay').textContent = '₹' + total.toLocaleString('en-IN', { maximumFractionDigits: 2 });
    }

   
    document.addEventListener('DOMContentLoaded', calculateTotal);
</script>

</body>
</html>