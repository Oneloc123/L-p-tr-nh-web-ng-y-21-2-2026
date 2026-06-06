<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/common/header.jsp" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Sản phẩm yêu thích - LUXCAR</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap"
      rel="stylesheet">

<style>
    /* =============================================
       DARK LUXURY AUTOMOTIVE THEME
       SaleCar — LUXCAR Favorites
       ============================================= */

    :root {
        --black: #0a0a0a;
        --bg-primary: #101010;
        --bg-surface: #181818;
        --bg-elevated: #1f1f1f;
        --bg-elevated-hover: #252525;
        --gold: #D4AF37;
        --gold-dark: #b8960f;
        --gold-light: #e9d6b0;
        --text-primary: #f0f0f0;
        --text-secondary: #9f9f9f;
        --text-muted: #666666;
        --border-subtle: rgba(255, 255, 255, 0.06);
        --border-gold: rgba(212, 175, 55, 0.15);
        --border-gold-strong: rgba(212, 175, 55, 0.25);
        --shadow-card: 0 8px 32px rgba(0, 0, 0, 0.3);
        --radius-sm: 8px;
        --radius-md: 14px;
        --radius-lg: 20px;
        --transition-fast: 0.2s ease;
        --transition-base: 0.3s ease;
        --transition-slow: 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    html, body {
        height: 100%;
        font-family: 'Inter', sans-serif;
        background: var(--bg-primary);
        color: var(--text-primary);
    }

    h1, h2, h3, h4, h5, h6 {
        font-family: 'Playfair Display', serif;
        font-weight: 600;
        letter-spacing: 0.3px;
    }

    .container-fluid { height: 100vh; }
    .row { height: 100%; margin: 0; }

    /* ================= SIDEBAR ================= */
    .sidebar {
        background: var(--bg-surface);
        padding: 0;
        border-right: 1px solid var(--border-subtle);
        height: 100%;
        overflow-y: auto;
        box-shadow: 4px 0 30px rgba(0, 0, 0, 0.2);
        display: flex;
        flex-direction: column;
    }
    .sidebar::-webkit-scrollbar { width: 4px; }
    .sidebar::-webkit-scrollbar-track { background: transparent; }
    .sidebar::-webkit-scrollbar-thumb { background: rgba(212, 175, 55, 0.25); border-radius: 4px; }

    /* ================= FILTER HEADER ================= */
    .filter-header {
        padding: 22px 22px 16px;
        border-bottom: 1px solid var(--border-subtle);
        flex-shrink: 0;
    }
    .filter-header h5 {
        font-family: 'Playfair Display', serif;
        font-size: 20px;
        font-weight: 700;
        color: var(--text-primary);
        margin: 0;
        letter-spacing: 0.5px;
    }
    .filter-header h5 i { color: var(--gold); margin-right: 8px; }

    /* ================= SEARCH ================= */
    .filter-search {
        padding: 14px 22px;
        border-bottom: 1px solid var(--border-subtle);
        flex-shrink: 0;
    }
    .filter-search .search-wrap { position: relative; }
    .filter-search .search-wrap i {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
        font-size: 14px;
        transition: color var(--transition-fast);
    }
    .filter-search .search-wrap:focus-within i { color: var(--gold); }
    .filter-search .search-wrap input {
        width: 100%;
        padding: 10px 14px 10px 40px;
        border: 1.5px solid var(--border-subtle);
        border-radius: 30px;
        font-size: 13px;
        background: var(--bg-elevated);
        transition: all var(--transition-base);
        color: var(--text-primary);
    }
    .filter-search .search-wrap input::placeholder { color: var(--text-muted); }
    .filter-search .search-wrap input:focus {
        outline: none;
        border-color: var(--border-gold-strong);
        background: var(--bg-elevated-hover);
        box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.06);
    }

    /* ================= FILTER SECTION ================= */
    .filter-section {
        border-bottom: 1px solid var(--border-subtle);
    }
    .filter-section:last-child { border-bottom: none; }

    .filter-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 14px 20px;
        cursor: pointer;
        transition: all var(--transition-fast);
        user-select: none;
        gap: 12px;
    }
    .filter-title:hover { background: rgba(212, 175, 55, 0.04); }
    .filter-title .title-left {
        display: flex;
        align-items: center;
        gap: 10px;
        min-width: 0;
    }
    .filter-title .title-left i {
        color: var(--gold);
        font-size: 14px;
        width: 22px;
        text-align: center;
        flex-shrink: 0;
        opacity: 0.8;
    }
    .filter-title .title-left span {
        font-weight: 500;
        font-size: 13px;
        color: var(--text-primary);
        letter-spacing: 0.5px;
        text-transform: uppercase;
    }
    .filter-title .title-left .count-label {
        font-size: 11px;
        color: var(--text-muted);
        font-weight: 400;
        text-transform: none;
    }
    .filter-title .title-right {
        display: flex;
        align-items: center;
        gap: 6px;
        flex-shrink: 0;
    }
    .filter-title .title-right i.chevron {
        color: var(--text-muted);
        font-size: 11px;
        transition: transform var(--transition-base);
    }
    .filter-title.active .title-right i.chevron { transform: rotate(180deg); }

    .filter-content {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.35s ease, padding 0.35s ease;
        padding: 0 20px;
    }
    .filter-content.open {
        max-height: 280px;
        padding: 0 20px 14px;
        overflow-y: auto;
    }

    /* ================= DARK SELECT ================= */
    .filter-select {
        width: 100%;
        padding: 10px 14px;
        background: var(--bg-elevated);
        border: 1.5px solid var(--border-subtle);
        border-radius: var(--radius-sm);
        color: var(--text-primary);
        font-size: 13px;
        cursor: pointer;
        transition: all var(--transition-base);
        appearance: none;
        -webkit-appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%239f9f9f' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 12px center;
        padding-right: 36px;
    }
    .filter-select:focus {
        outline: none;
        border-color: var(--border-gold-strong);
        box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.06);
    }
    .filter-select option { background: var(--bg-elevated); color: var(--text-primary); }

    /* ================= DARK CHECKBOX ================= */
    .filter-checkbox {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 6px 0;
        cursor: pointer;
        transition: all var(--transition-fast);
    }
    .filter-checkbox:hover label { color: var(--text-primary); }
    .filter-checkbox input[type="checkbox"] {
        appearance: none;
        -webkit-appearance: none;
        width: 16px;
        height: 16px;
        border: 2px solid rgba(255, 255, 255, 0.15);
        border-radius: 4px;
        cursor: pointer;
        flex-shrink: 0;
        position: relative;
        transition: all var(--transition-fast);
        background: transparent;
    }
    .filter-checkbox input[type="checkbox"]:checked {
        background: var(--gold);
        border-color: var(--gold);
    }
    .filter-checkbox input[type="checkbox"]:checked::after {
        content: '';
        position: absolute;
        left: 4px;
        top: 1px;
        width: 5px;
        height: 9px;
        border: solid #101010;
        border-width: 0 2px 2px 0;
        transform: rotate(45deg);
    }
    .filter-checkbox label {
        font-size: 13px;
        color: var(--text-secondary);
        cursor: pointer;
        flex: 1;
        transition: color var(--transition-fast);
    }

    /* ================= SIDEBAR FOOTER ================= */
    .sidebar-footer {
        flex-shrink: 0;
        padding: 16px 22px;
        border-top: 1px solid var(--border-subtle);
        background: var(--bg-surface);
    }
    .sidebar-footer .btn-apply {
        flex: 1;
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        border: none;
        padding: 11px 20px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 700;
        transition: all var(--transition-base);
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        letter-spacing: 0.3px;
    }
    .sidebar-footer .btn-apply:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(212, 175, 55, 0.25);
    }
    .sidebar-footer .btn-reset-filter {
        width: 44px;
        height: 44px;
        border: 1.5px solid var(--border-subtle);
        border-radius: 50%;
        background: var(--bg-elevated);
        color: var(--text-muted);
        cursor: pointer;
        transition: all var(--transition-base);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .sidebar-footer .btn-reset-filter:hover {
        border-color: var(--gold);
        color: var(--gold);
        background: rgba(212, 175, 55, 0.08);
        transform: rotate(-30deg);
        box-shadow: 0 4px 15px rgba(212, 175, 55, 0.12);
    }

    /* ================= VOUCHER MINI ================= */
    .voucher-mini {
        padding: 14px 22px;
        border-top: 1px solid var(--border-subtle);
        flex-shrink: 0;
    }
    .voucher-toggle {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        padding: 12px 16px;
        background: var(--bg-elevated);
        border: 1px dashed var(--border-gold-strong);
        border-radius: var(--radius-md);
        cursor: pointer;
        transition: all var(--transition-base);
        font-size: 12px;
        font-weight: 500;
        color: var(--text-primary);
    }
    .voucher-toggle:hover {
        background: var(--bg-elevated-hover);
        border-color: rgba(212, 175, 55, 0.35);
        transform: translateY(-1px);
    }
    .voucher-toggle i { color: var(--gold); font-size: 14px; }
    .voucher-toggle .v-badge {
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        font-size: 10px;
        font-weight: 700;
        padding: 3px 10px;
        border-radius: 20px;
    }
    .voucher-content {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease, padding 0.3s ease;
    }
    .voucher-content.open { max-height: 400px; padding-top: 10px; }
    .voucher-item {
        background: var(--bg-elevated);
        border-radius: var(--radius-sm);
        padding: 10px 12px;
        margin-bottom: 6px;
        border-left: 3px solid var(--gold);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .voucher-code { font-weight: 600; color: var(--text-primary); font-size: 12px; }
    .voucher-discount { color: var(--gold); font-weight: 500; font-size: 11px; }
    .voucher-empty { text-align: center; color: var(--text-muted); font-size: 12px; padding: 10px; }

    /* ================= PRODUCT WRAPPER ================= */
    .product-wrapper {
        height: 100%;
        overflow-y: auto;
        padding: 2rem 2rem 0;
        display: flex;
        flex-direction: column;
        background: var(--bg-primary);
    }
    .product-wrapper::-webkit-scrollbar { width: 6px; }
    .product-wrapper::-webkit-scrollbar-track { background: transparent; }
    .product-wrapper::-webkit-scrollbar-thumb { background: rgba(212, 175, 55, 0.15); border-radius: 3px; }
    .product-content { flex: 1 0 auto; }

    /* ================= SORT BAR ================= */
    .sort-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding: 10px 24px;
        background: var(--bg-surface);
        border-radius: 50px;
        box-shadow: var(--shadow-card);
        border: 1px solid var(--border-subtle);
        min-height: 60px;
    }
    .sort-buttons { display: flex; gap: 6px; flex-wrap: wrap; }
    .sort-btn {
        padding: 8px 20px;
        border: none;
        background: var(--bg-elevated);
        border-radius: 50px;
        font-size: 12px;
        font-weight: 500;
        transition: all var(--transition-base);
        cursor: pointer;
        color: var(--text-secondary);
        white-space: nowrap;
    }
    .sort-btn:hover {
        background: var(--bg-elevated-hover);
        color: var(--gold);
        transform: translateY(-1px);
    }
    .sort-btn.active {
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        font-weight: 600;
        box-shadow: 0 4px 14px rgba(212, 175, 55, 0.2);
    }
    .result-count { color: var(--text-muted); font-size: 16px; font-weight: 400; white-space: nowrap; }
    .result-count span {
        color: var(--gold);
        font-weight: 700;
        font-size: 20px;
        font-family: 'Playfair Display', serif;
    }

    /* ================= PRODUCT CARD (DARK LUXURY) ================= */
    .product-card {
        border: 1px solid var(--border-subtle);
        border-radius: var(--radius-lg);
        overflow: hidden;
        transition: all var(--transition-slow);
        height: auto;
        display: flex;
        flex-direction: column;
        background: var(--bg-elevated);
        box-shadow: var(--shadow-card);
        position: relative;
    }
    .product-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 1px;
        background: linear-gradient(90deg, transparent, var(--gold), transparent);
        opacity: 0.3;
        z-index: 5;
        transition: opacity 0.5s ease;
    }
    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.55), 0 0 50px rgba(212, 175, 55, 0.06);
        border-color: rgba(212, 175, 55, 0.3);
        background: var(--bg-elevated-hover);
    }
    .product-card:hover::before { opacity: 1; }

    /* ================= IMAGE AREA ================= */
    .product-image-wrapper {
        height: 220px;
        overflow: hidden;
        position: relative;
        z-index: 1;
        background: linear-gradient(135deg, #141414 0%, #0d0d0d 50%, #161616 100%);
    }
    .product-image-wrapper::before {
        content: '';
        position: absolute;
        inset: 0;
        background: radial-gradient(ellipse at center, rgba(212, 175, 55, 0.04) 0%, transparent 70%);
        pointer-events: none;
        z-index: 1;
    }
    .product-image-wrapper::after {
        content: '';
        position: absolute;
        inset: 0;
        box-shadow: inset 0 0 50px 15px rgba(0, 0, 0, 0.45);
        pointer-events: none;
        z-index: 3;
    }
    .product-image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        position: relative;
        z-index: 2;
    }
    .product-card:hover .product-image-wrapper img { transform: scale(1.08); }

    /* ================= BADGE ================= */
    .product-badge {
        position: absolute;
        top: 12px;
        right: 12px;
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 10px;
        font-weight: 700;
        z-index: 4;
        letter-spacing: 0.3px;
        box-shadow: 0 3px 10px rgba(212, 175, 55, 0.2);
    }
    .product-badge.discount {
        background: linear-gradient(135deg, #d32f2f, #b71c1c);
        color: #fff;
        box-shadow: 0 3px 10px rgba(211, 47, 47, 0.25);
    }
    .product-badge.unavailable {
        background: rgba(255, 255, 255, 0.1);
        color: var(--text-muted);
        backdrop-filter: blur(4px);
        box-shadow: none;
    }

    /* ================= CARD BODY ================= */
    .card-body {
        padding: 16px 18px 18px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        position: relative;
        z-index: 2;
        background: transparent;
    }

    .product-category {
        font-size: 10px;
        color: var(--gold);
        text-transform: uppercase;
        letter-spacing: 1.2px;
        margin-bottom: 4px;
        font-weight: 600;
        opacity: 0.7;
    }
    .product-name {
        font-weight: 700;
        margin-bottom: 4px;
        font-size: 17px;
        color: var(--text-primary);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-family: 'Playfair Display', serif;
        line-height: 1.3;
        transition: color var(--transition-base);
        letter-spacing: 0.2px;
    }
    .product-card:hover .product-name {
        color: var(--gold);
        text-shadow: 0 0 20px rgba(212, 175, 55, 0.08);
    }
    .product-model {
        font-size: 12px;
        color: var(--text-muted);
        margin-bottom: 6px;
        font-weight: 400;
    }
    .product-model i { color: var(--gold); margin-right: 3px; font-size: 11px; opacity: 0.7; }

    .product-price-section {
        margin: 8px 0 4px;
        padding: 10px 0 0;
        border-top: 1px solid var(--border-subtle);
    }
    .product-price-row { display: flex; align-items: baseline; flex-wrap: wrap; gap: 6px; }
    .product-price-old {
        font-size: 13px;
        text-decoration: line-through;
        color: var(--text-muted);
        font-weight: 400;
        opacity: 0.5;
    }
    .product-price-current {
        font-size: 24px;
        font-weight: 800;
        color: var(--gold);
        font-family: 'Playfair Display', serif;
        line-height: 1.2;
        text-shadow: 0 2px 12px rgba(212, 175, 55, 0.1);
        transition: all var(--transition-base);
        letter-spacing: -0.3px;
    }
    .product-card:hover .product-price-current {
        text-shadow: 0 0 30px rgba(212, 175, 55, 0.2), 0 3px 12px rgba(212, 175, 55, 0.1);
        transform: scale(1.03);
    }

    /* ================= PRODUCT ACTIONS ================= */
    .product-actions {
        display: flex;
        gap: 6px;
        margin-top: auto;
        padding-top: 12px;
        border-top: 1px solid var(--border-subtle);
        flex-wrap: nowrap;
    }
    .btn-add-cart {
        flex: 2;
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        border: none;
        padding: 9px 0;
        border-radius: 30px;
        font-size: 11px;
        font-weight: 700;
        transition: all var(--transition-base);
        cursor: pointer;
        letter-spacing: 0.3px;
        text-decoration: none;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 4px;
    }
    .btn-add-cart:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(212, 175, 55, 0.3);
        color: #101010;
    }
    .btn-action {
        flex: 1;
        background: rgba(255, 255, 255, 0.05);
        color: var(--text-secondary);
        border: 1px solid var(--border-subtle);
        padding: 8px 0;
        border-radius: 30px;
        transition: all var(--transition-base);
        cursor: pointer;
        font-size: 11px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 4px;
    }
    .btn-action:hover {
        background: rgba(212, 175, 55, 0.1);
        color: var(--gold);
        border-color: rgba(212, 175, 55, 0.3);
        transform: translateY(-1px);
    }
    .btn-action-remove {
        flex: 1;
        background: rgba(255, 255, 255, 0.03);
        color: rgba(255, 255, 255, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.06);
        padding: 8px 0;
        border-radius: 30px;
        transition: all var(--transition-base);
        cursor: pointer;
        font-size: 11px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 4px;
    }
    .btn-action-remove:hover {
        background: rgba(244, 67, 54, 0.1);
        color: #f44336;
        border-color: rgba(244, 67, 54, 0.3);
        transform: translateY(-1px);
    }

    /* ================= RATING ================= */
    .rating {
        display: flex;
        align-items: center;
        gap: 2px;
        font-size: 12px;
        color: var(--gold);
        margin: 6px 0 10px;
    }
    .rating span { color: var(--text-muted); margin-right: 6px; font-weight: 500; font-size: 12px; }
    .rating i { color: #f0c040; font-size: 13px; }

    /* ================= EMPTY STATE ================= */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        background: var(--bg-elevated);
        border-radius: var(--radius-lg);
        border: 1px solid var(--border-subtle);
    }
    .empty-state i { font-size: 64px; color: var(--gold); opacity: 0.12; margin-bottom: 16px; }
    .empty-state h4 { font-size: 22px; margin-bottom: 8px; color: var(--text-primary); }
    .empty-state p { color: var(--text-muted); margin-bottom: 20px; font-size: 14px; }
    .btn-explore {
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #101010;
        border: none;
        padding: 10px 30px;
        border-radius: 30px;
        font-weight: 700;
        transition: all var(--transition-base);
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .btn-explore:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(212, 175, 55, 0.25);
        color: #101010;
    }

    /* ================= UNAVAILABLE ================= */
    .opacity-50 { opacity: 0.5; }
    .unavailable-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        background: rgba(255, 255, 255, 0.06);
        color: var(--text-muted);
        font-size: 11px;
        font-weight: 600;
        padding: 4px 10px;
        border-radius: 20px;
        margin: 6px 0;
    }

    /* ================= RESPONSIVE ================= */
    @media (max-width: 1200px) {
        .product-image-wrapper { height: 200px; }
    }
    @media (max-width: 991px) {
        .sidebar {
            border-right: none;
            border-bottom: 1px solid var(--border-subtle);
            height: auto;
            max-height: 400px;
        }
        .product-wrapper { padding: 1.5rem 1rem 0; }
        .sort-bar {
            flex-direction: column;
            gap: 12px;
            align-items: stretch;
            border-radius: var(--radius-md);
            padding: 14px 18px;
        }
        .sort-buttons { justify-content: center; }
        .result-count { text-align: center; }
        .product-price-current { font-size: 22px; }
        .product-image-wrapper { height: 190px; }
    }
    @media (max-width: 767px) {
        .sidebar { max-height: 350px; }
        .product-card { border-radius: 16px; }
        .product-image-wrapper { height: 180px; }
        .product-price-current { font-size: 20px; }
        .card-body { padding: 14px; }
        .sort-bar { border-radius: var(--radius-md); padding: 12px 14px; }
        .sort-btn { font-size: 11px; padding: 6px 14px; }
    }
</style>

<body>

<div class="container-fluid">
    <div class="row align-items-start">

        <!-- ================= SIDEBAR FILTER ================= -->
        <div class="col-lg-3 col-md-4 sidebar p-0">
            <form id="filterForm" method="get" action="${pageContext.request.contextPath}/favorites"
                  style="height: 100%; display: flex; flex-direction: column;">

                <!-- Header -->
                <div class="filter-header">
                    <h5><i class="bi bi-funnel"></i>Bộ lọc yêu thích</h5>
                </div>

                <!-- Search -->
                <div class="filter-search">
                    <div class="search-wrap">
                        <i class="bi bi-search"></i>
                        <input name="keyword" value="${param.keyword}" type="text"
                               placeholder="Tìm kiếm yêu thích..."
                               autocomplete="off">
                    </div>
                </div>

                <!-- Filter Body -->
                <div class="filter-body" style="flex: 1; overflow-y: auto; padding: 6px 0;">
                    <!-- Danh mục -->
                    <div class="filter-section">
                        <div class="filter-title active" onclick="toggleFilter(this)" role="button" aria-expanded="true" aria-controls="content-category">
                            <div class="title-left">
                                <i class="bi bi-collection"></i>
                                <span>Danh mục <span class="count-label">(${fn:length(category)})</span></span>
                            </div>
                            <div class="title-right">
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content open" id="content-category">
                            <select name="category" class="filter-select">
                                <option value="all">Tất cả</option>
                                <c:forEach var="c" items="${category}">
                                    <option value="${c}" ${param.category == c ? 'selected' : ''}>${c}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Thương hiệu -->
                    <div class="filter-section">
                        <div class="filter-title" onclick="toggleFilter(this)" role="button" aria-expanded="false" aria-controls="content-brand">
                            <div class="title-left">
                                <i class="bi bi-tags"></i>
                                <span>Thương hiệu <span class="count-label">(${fn:length(brand)})</span></span>
                            </div>
                            <div class="title-right">
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content" id="content-brand">
                            <select name="brand" class="filter-select">
                                <option value="all">Tất cả</option>
                                <c:forEach var="b" items="${brand}">
                                    <option value="${b}" ${param.brand == b ? 'selected' : ''}>${b}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Khoảng giá -->
                    <div class="filter-section">
                        <div class="filter-title active" onclick="toggleFilter(this)" role="button" aria-expanded="true" aria-controls="content-price">
                            <div class="title-left">
                                <i class="bi bi-currency-dollar"></i>
                                <span>Khoảng giá</span>
                            </div>
                            <div class="title-right">
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content open" id="content-price">
                            <select name="price" class="filter-select">
                                <option value="-1">Tất cả</option>
                                <option value="10000000" ${param.price == '10000000' ? 'selected' : ''}>Dưới 10.000.000</option>
                                <option value="50000000" ${param.price == '50000000' ? 'selected' : ''}>Dưới 50.000.000</option>
                                <option value="100000000" ${param.price == '100000000' ? 'selected' : ''}>Dưới 100.000.000</option>
                                <option value="500000000" ${param.price == '500000000' ? 'selected' : ''}>Dưới 500.000.000</option>
                            </select>
                        </div>
                    </div>

                    <!-- Tùy chọn khác -->
                    <div class="filter-section">
                        <div class="filter-title" onclick="toggleFilter(this)" role="button" aria-expanded="false" aria-controls="content-options">
                            <div class="title-left">
                                <i class="bi bi-sliders"></i>
                                <span>Tùy chọn</span>
                            </div>
                            <div class="title-right">
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content" id="content-options">
                            <div class="filter-checkbox">
                                <input class="form-check-input" type="checkbox" name="discount" ${not empty param.discount ? 'checked' : ''} id="chk-discount">
                                <label for="chk-discount">Đang giảm giá</label>
                            </div>
                            <div class="filter-checkbox">
                                <input class="form-check-input" type="checkbox" name="newest" ${not empty param.newest ? 'checked' : ''} id="chk-newest">
                                <label for="chk-newest">Giảm giá mới nhất</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer buttons -->
                <div class="sidebar-footer">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn-apply">
                            <i class="bi bi-funnel"></i>Áp dụng
                        </button>
                        <c:if test="${not empty param.keyword or (not empty param.category and param.category != 'all') or (not empty param.brand and param.brand != 'all') or (not empty param.price and param.price != '-1') or not empty param.discount or not empty param.newest}">
                            <a href="${pageContext.request.contextPath}/favorites" class="btn-reset-filter" title="Xóa bộ lọc">
                                <i class="bi bi-x-lg"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
            </form>

            <!-- Voucher Mini -->
            <div class="voucher-mini">
                <div class="voucher-toggle" onclick="toggleVoucher()">
                    <span><i class="bi bi-ticket-perforated me-2"></i>Voucher khuyến mãi</span>
                    <span class="v-badge">${fn:length(vouchers)}</span>
                </div>
                <div class="voucher-content" id="voucherContent">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="voucher-item">
                            <span class="voucher-code">${v.code}</span>
                            <span class="voucher-discount">-<fmt:formatNumber value="${v.maxDiscount}" type="number"/> ₫</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty vouchers}">
                        <div class="voucher-empty">Bạn chưa có voucher nào</div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- ================= PRODUCT LIST ================= -->
        <div class="col-lg-9 col-md-8 product-wrapper">
            <!-- Sort Bar -->
            <div class="sort-bar">
                <div class="sort-buttons">
                    <button type="button" class="sort-btn ${param.sort == 'price_asc' ? 'active' : ''}"
                            onclick="setSort('price_asc')">
                        <i class="bi bi-arrow-up me-1"></i>Giá tăng dần
                    </button>
                    <button type="button" class="sort-btn ${param.sort == 'price_desc' ? 'active' : ''}"
                            onclick="setSort('price_desc')">
                        <i class="bi bi-arrow-down me-1"></i>Giá giảm dần
                    </button>
                    <button type="button" class="sort-btn ${param.sort == 'newest' ? 'active' : ''}"
                            onclick="setSort('newest')">
                        <i class="bi bi-clock me-1"></i>Mới nhất
                    </button>
                </div>
                <div class="result-count">
                    <span>${fn:length(favorites)}</span> sản phẩm yêu thích
                </div>
            </div>

            <!-- Product Grid -->
            <div class="product-content">
                <div class="row g-3">
                    <c:choose>
                        <c:when test="${not empty favorites}">
                            <c:forEach var="p" items="${favorites}">
                                <c:set var="productStatus" value="${p.status}" />
                                <c:set var="isUnavailable" value="${productStatus == null || productStatus.code == 0 || productStatus.code == 2}" />

                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="card product-card ${isUnavailable ? 'opacity-50' : ''}">
                                        <!-- Image -->
                                        <a href="${isUnavailable ? '#' : pageContext.request.contextPath.concat('/product-detail?id=').concat(p.productId)}">
                                            <div class="product-image-wrapper">
                                                <c:choose>
                                                    <c:when test="${not empty p.images and fn:length(p.images) > 0}">
                                                        <img src="${pageContext.request.contextPath}/uploads/${p.images[0]}"
                                                             alt="${p.productName}"
                                                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=No+Image';">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/400x300?text=LUXCAR" alt="${p.productName}">
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not isUnavailable and p.discountPercent > 0}">
                                                    <span class="product-badge discount">-<fmt:formatNumber value="${p.discountPercent}" maxFractionDigits="0"/>%</span>
                                                </c:if>
                                                <c:if test="${isUnavailable}">
                                                    <span class="product-badge unavailable">Không khả dụng</span>
                                                </c:if>
                                            </div>
                                        </a>

                                        <!-- Card Body -->
                                        <div class="card-body">
                                            <div class="product-category">${p.category.name}</div>
                                            <h6 class="product-name">${p.productName}</h6>
                                            <div class="product-model">
                                                <i class="bi bi-cpu"></i> Tỉ lệ ${p.ratio}
                                            </div>

                                            <c:choose>
                                                <c:when test="${isUnavailable}">
                                                    <span class="unavailable-badge">
                                                        <i class="bi bi-exclamation-triangle"></i> Sản phẩm không còn khả dụng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="rating">
                                                        <fmt:formatNumber value="${p.averageRating}" maxFractionDigits="1"/>
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${i le p.averageRating}"><i class="bi bi-star-fill"></i></c:when>
                                                                <c:otherwise><i class="bi bi-star"></i></c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span class="text-muted ms-1">(${p.totalReviews})</span>
                                                    </div>

                                                    <div class="product-price-section">
                                                        <div class="product-price-row">
                                                            <c:if test="${p.price > 0 and p.discountPercent > 0}">
                                                                <span class="product-price-old">
                                                                    <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> ₫
                                                                </span>
                                                            </c:if>
                                                            <div class="product-price-current">
                                                                <fmt:formatNumber value="${p.finalPrice}" type="number" groupingUsed="true"/> ₫
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Actions -->
                                            <div class="product-actions">
                                                <c:choose>
                                                    <c:when test="${isUnavailable}">
                                                        <form action="${pageContext.request.contextPath}/favorites" method="post" style="display: contents;">
                                                            <button name="remove" value="${p.productId}" class="btn-action-remove w-100">
                                                                <i class="bi bi-trash"></i> Xóa
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.productId}" class="btn-add-cart">
                                                            <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/favorites" method="post" style="display: contents;">
                                                            <button name="remove" value="${p.productId}" class="btn-action">
                                                                <i class="bi bi-heartbreak"></i>
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <div class="col-12">
                                <div class="empty-state">
                                    <i class="bi bi-heart"></i>
                                    <h4>Bạn chưa có sản phẩm yêu thích nào</h4>
                                    <p>Hãy khám phá các sản phẩm và thêm vào danh sách yêu thích nhé!</p>
                                    <a href="${pageContext.request.contextPath}/products" class="btn-explore">
                                        <i class="bi bi-search"></i> Khám phá xe ngay
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    /* ================= FILTER TOGGLE ================= */
    function toggleFilter(header) {
        const isActive = header.classList.toggle('active');
        const content = header.nextElementSibling;
        if (content && content.classList.contains('filter-content')) {
            content.classList.toggle('open');
            header.setAttribute('aria-expanded', isActive);
        }
    }

    /* ================= VOUCHER TOGGLE ================= */
    function toggleVoucher() {
        const content = document.getElementById('voucherContent');
        content.classList.toggle('open');
    }

    /* ================= SORT ================= */
    function setSort(sortValue) {
        const form = document.getElementById('filterForm');
        const sortInput = document.createElement('input');
        sortInput.type = 'hidden';
        sortInput.name = 'sort';
        sortInput.value = sortValue;
        form.appendChild(sortInput);
        form.submit();
    }

    /* ================= INIT ================= */
    document.addEventListener('DOMContentLoaded', function() {
        // Open sections that have selected values
        const selects = document.querySelectorAll('.filter-select');
        selects.forEach(function(sel) {
            if (sel.value && sel.value !== 'all' && sel.value !== '-1') {
                const section = sel.closest('.filter-section');
                if (section) {
                    const title = section.querySelector('.filter-title');
                    const content = section.querySelector('.filter-content');
                    if (title && !title.classList.contains('active')) {
                        title.classList.add('active');
                        if (content) content.classList.add('open');
                    }
                }
            }
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>
