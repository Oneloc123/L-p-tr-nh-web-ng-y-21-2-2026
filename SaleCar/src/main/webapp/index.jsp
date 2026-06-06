<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/common/header.jsp" %>

<title>LUXCAR - Mô Hình Xe Sang Trọng</title>

<style>
    /* ==================== GLOBAL STYLES ==================== */
    :root {
        --black: #000000;
        --gold: #D4AF37;
        --white: #FFFFFF;
        --light-gold: #f5e7b2;
        --dark-gold: #b8960f;
        --gray-bg: #f8f9fa;
    }

    body {
        font-family: 'Inter', sans-serif;
        background: var(--gray-bg);
    }

    .section-title {
        text-align: center;
        margin-bottom: 50px;
        position: relative;
        font-weight: 700;
        font-size: 32px;
        color: var(--black);
    }

    .section-title:after {
        content: '';
        position: absolute;
        bottom: -15px;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: var(--gold);
    }

    /* ==================== HERO BANNER SLIDER ==================== */
    .hero-slider {
        position: relative;
        width: 100%;
        height: 600px;
        overflow: hidden;
        background: var(--black);
    }

    .slider-container {
        position: relative;
        width: 100%;
        height: 100%;
    }

    .slide {
        position: absolute;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 0.8s ease-in-out;
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }

    .slide.active {
        opacity: 1;
        z-index: 1;
    }

    .slide::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.4) 100%);
        z-index: 1;
    }

    .slide-content {
        position: absolute;
        bottom: 30%;
        left: 10%;
        right: 10%;
        z-index: 2;
        color: var(--white);
        max-width: 600px;
        animation: slideUp 0.8s ease;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .slide-content h1 {
        font-size: 48px;
        font-weight: 700;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .slide-content p {
        font-size: 18px;
        margin-bottom: 30px;
        line-height: 1.6;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .slide-btn {
        display: inline-block;
        padding: 12px 35px;
        background: var(--gold);
        color: var(--black);
        text-decoration: none;
        font-weight: 600;
        border-radius: 30px;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }

    .slide-btn:hover {
        background: transparent;
        border-color: var(--gold);
        color: var(--gold);
        transform: translateY(-2px);
    }

    /* Slider Navigation */
    .slider-nav {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        width: 100%;
        display: flex;
        justify-content: space-between;
        padding: 0 20px;
        z-index: 10;
        pointer-events: none;
    }

    .slider-nav button {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: rgba(212, 175, 55, 0.8);
        border: none;
        color: var(--black);
        font-size: 24px;
        cursor: pointer;
        transition: all 0.3s ease;
        pointer-events: auto;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .slider-nav button:hover {
        background: var(--gold);
        transform: scale(1.1);
    }

    /* Slider Indicators */
    .slider-indicators {
        position: absolute;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 12px;
        z-index: 10;
    }

    .indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.5);
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .indicator.active {
        background: var(--gold);
        width: 30px;
        border-radius: 6px;
    }

    /* ==================== VOUCHER CAROUSEL (DARK + GOLD) ==================== */
    .voucher-section {
        padding: 60px 0 70px;
        background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
        position: relative;
        overflow: hidden;
    }

    .voucher-section::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -30%;
        width: 600px;
        height: 600px;
        background: radial-gradient(circle, rgba(212, 175, 55, 0.04) 0%, transparent 60%);
        border-radius: 50%;
        pointer-events: none;
    }

    .voucher-section::after {
        content: '';
        position: absolute;
        bottom: -40%;
        right: -20%;
        width: 500px;
        height: 500px;
        background: radial-gradient(circle, rgba(212, 175, 55, 0.03) 0%, transparent 60%);
        border-radius: 50%;
        pointer-events: none;
    }

    .voucher-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 40px;
        position: relative;
        z-index: 2;
    }

    .voucher-header-left {
        flex: 1;
    }

    .voucher-title {
        font-size: 28px;
        font-weight: 700;
        color: var(--white);
        margin: 0 0 8px 0;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .voucher-title i {
        color: var(--gold);
        font-size: 30px;
    }

    .voucher-subtitle {
        color: rgba(255, 255, 255, 0.5);
        font-size: 14px;
        margin: 0;
    }

    .voucher-view-all {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: var(--gold);
        font-weight: 600;
        font-size: 14px;
        text-decoration: none;
        padding: 10px 20px;
        border: 2px solid rgba(212, 175, 55, 0.2);
        border-radius: 30px;
        transition: all 0.3s ease;
        white-space: nowrap;
    }

    .voucher-view-all:hover {
        background: var(--gold);
        color: var(--black);
        border-color: var(--gold);
        gap: 12px;
    }

    .voucher-view-all i {
        font-size: 12px;
        transition: transform 0.3s ease;
    }

    .voucher-view-all:hover i {
        transform: translateX(4px);
    }

    /* ─── Carousel Wrapper ─── */
    .voucher-carousel-wrapper {
        position: relative;
        z-index: 2;
    }

    .voucher-carousel {
        display: flex;
        gap: 20px;
        overflow-x: auto;
        scroll-snap-type: x mandatory;
        scroll-behavior: smooth;
        -webkit-overflow-scrolling: touch;
        padding: 8px 4px 12px;
        scrollbar-width: none;
    }

    .voucher-carousel::-webkit-scrollbar {
        display: none;
    }

    .voucher-scroll-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        width: 44px;
        height: 44px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.06);
        border: 1px solid rgba(212, 175, 55, 0.2);
        color: var(--gold);
        font-size: 18px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        z-index: 10;
        opacity: 0;
        backdrop-filter: blur(10px);
    }

    .voucher-carousel-wrapper:hover .voucher-scroll-btn {
        opacity: 1;
    }

    .voucher-scroll-btn:hover {
        background: var(--gold);
        border-color: var(--gold);
        color: var(--black);
        transform: translateY(-50%) scale(1.1);
        box-shadow: 0 6px 25px rgba(212, 175, 55, 0.3);
    }

    .voucher-scroll-left {
        left: -18px;
    }

    .voucher-scroll-right {
        right: -18px;
    }

    /* ─── Voucher Card ─── */
    .voucher-card {
        flex: 0 0 320px;
        scroll-snap-align: start;
        background: #1a1a1a;
        border-radius: 20px;
        position: relative;
        overflow: hidden;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
        border: 1px solid rgba(212, 175, 55, 0.12);
    }

    .voucher-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 50px rgba(212, 175, 55, 0.1);
        border-color: rgba(212, 175, 55, 0.25);
    }

    /* Gold top-border accent on card */
    .voucher-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 2px;
        background: linear-gradient(90deg, transparent, var(--gold), transparent);
        opacity: 0.5;
        z-index: 3;
        transition: opacity 0.4s ease;
    }

    .voucher-card:hover::before {
        opacity: 1;
    }

    /* Decorative pattern overlay */
    .voucher-card-bg {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 130px;
        background: linear-gradient(135deg, rgba(212, 175, 55, 0.06) 0%, transparent 60%);
        border-radius: 20px 20px 0 0;
        pointer-events: none;
    }

    .voucher-card-bg::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: repeating-linear-gradient(
            45deg,
            transparent,
            transparent 20px,
            rgba(212, 175, 55, 0.02) 20px,
            rgba(212, 175, 55, 0.02) 40px
        );
        border-radius: 20px 20px 0 0;
    }

    .voucher-card-bg::after {
        content: '';
        position: absolute;
        bottom: -20px;
        right: -10px;
        width: 80px;
        height: 80px;
        border: 2px solid rgba(212, 175, 55, 0.06);
        border-radius: 50%;
        pointer-events: none;
    }

    .voucher-card-content {
        position: relative;
        z-index: 2;
        padding: 0;
    }

    /* Type Badge */
    .voucher-type-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(212, 175, 55, 0.12);
        color: var(--gold);
        font-size: 11px;
        font-weight: 700;
        padding: 5px 14px;
        border-radius: 20px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin: 18px 0 0 18px;
        border: 1px solid rgba(212, 175, 55, 0.1);
    }

    .voucher-type-badge i {
        font-size: 13px;
    }

    /* Value Display */
    .voucher-value-display {
        display: flex;
        align-items: baseline;
        gap: 2px;
        margin: 14px 0 0 18px;
        line-height: 1;
    }

    .voucher-value-number {
        font-size: 40px;
        font-weight: 800;
        letter-spacing: -1px;
        color: var(--gold);
        text-shadow: 0 2px 15px rgba(212, 175, 55, 0.2);
    }

    .voucher-value-unit {
        font-size: 20px;
        font-weight: 700;
        color: rgba(212, 175, 55, 0.7);
        margin-left: 2px;
    }

    /* Details Section */
    .voucher-details {
        padding: 14px 18px 0;
        border-radius: 0;
    }

    .voucher-detail-row {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        color: rgba(255, 255, 255, 0.5);
        padding: 4px 0;
    }

    .voucher-detail-row i {
        color: var(--gold);
        font-size: 14px;
        width: 18px;
        flex-shrink: 0;
    }

    .voucher-detail-row span {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* Code + Copy Button */
    .voucher-code-area {
        padding: 16px 18px;
        display: flex;
        align-items: center;
        gap: 10px;
        border-top: 1px solid rgba(212, 175, 55, 0.08);
        margin-top: 12px;
    }

    .voucher-code {
        flex: 1;
        background: rgba(212, 175, 55, 0.06);
        border: 1.5px dashed rgba(212, 175, 55, 0.2);
        border-radius: 10px;
        padding: 10px 14px;
        text-align: center;
        position: relative;
        transition: all 0.3s ease;
    }

    .voucher-card:hover .voucher-code {
        border-color: rgba(212, 175, 55, 0.4);
        background: rgba(212, 175, 55, 0.08);
    }

    .voucher-code-text {
        font-family: 'Courier New', monospace;
        font-size: 16px;
        font-weight: 800;
        letter-spacing: 2px;
        color: var(--white);
    }

    .voucher-copy-btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: var(--gold);
        color: var(--black);
        border: none;
        padding: 10px 18px;
        border-radius: 10px;
        font-weight: 700;
        font-size: 13px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        white-space: nowrap;
    }

    .voucher-copy-btn:hover {
        background: var(--dark-gold);
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
    }

    .voucher-copy-btn:active {
        transform: scale(0.95);
    }

    .voucher-copy-btn.copied {
        background: #2ed573;
        color: white;
        pointer-events: none;
    }

    .voucher-copy-btn.copied i {
        animation: copySuccess 0.5s ease;
    }

    @keyframes copySuccess {
        0% { transform: scale(1); }
        50% { transform: scale(1.3); }
        100% { transform: scale(1); }
    }

    /* ─── Responsive ─── */
    @media (max-width: 991px) {
        .voucher-section {
            padding: 45px 0 55px;
        }
        .voucher-title {
            font-size: 24px;
        }
        .voucher-title i {
            font-size: 26px;
        }
        .voucher-card {
            flex: 0 0 290px;
        }
        .voucher-value-number {
            font-size: 34px;
        }
    }

    @media (max-width: 768px) {
        .voucher-section {
            padding: 35px 0 40px;
        }
        .voucher-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 25px;
        }
        .voucher-title {
            font-size: 20px;
        }
        .voucher-title i {
            font-size: 22px;
        }
        .voucher-card {
            flex: 0 0 270px;
        }
        .voucher-value-number {
            font-size: 30px;
        }
        .voucher-scroll-btn {
            display: none;
        }
        .voucher-code-text {
            font-size: 14px;
            letter-spacing: 1px;
        }
        .voucher-copy-btn {
            padding: 8px 14px;
            font-size: 12px;
        }
    }

    /* ==================== BRAND LOGOS ==================== */
    .brands-section {
        padding: 80px 0;
        background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
        position: relative;
        overflow: hidden;
    }

    .brands-section::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle at 30% 50%, rgba(212, 175, 55, 0.03) 0%, transparent 50%);
        pointer-events: none;
    }

    .brands-section .section-title {
        color: var(--white);
    }

    .brands-section .section-title:after {
        background: var(--gold);
    }

    .brands-subtitle {
        text-align: center;
        color: rgba(255, 255, 255, 0.6);
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
        letter-spacing: 0.5px;
    }

    .brands-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        gap: 30px;
        position: relative;
        z-index: 1;
    }

    .brand-item {
        text-align: center;
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        cursor: pointer;
        padding: 30px 35px 40px;
        background: rgba(255, 255, 255, 0.03);
        border-radius: 16px;
        border: 1px solid rgba(255, 255, 255, 0.06);
        min-width: 160px;
        position: relative;
    }

    .brand-item::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%) scaleX(0);
        width: 60%;
        height: 2px;
        background: var(--gold);
        border-radius: 2px;
        transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .brand-item:hover {
        transform: translateY(-8px);
        background: rgba(255, 255, 255, 0.06);
        border-color: rgba(212, 175, 55, 0.3);
        box-shadow: 0 20px 60px rgba(212, 175, 55, 0.1);
    }

    .brand-item:hover::after {
        transform: translateX(-50%) scaleX(1);
    }

    .brand-logo {
        width: 90px;
        height: 90px;
        object-fit: contain;
        filter: grayscale(100%) brightness(0.8);
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .brand-item:hover .brand-logo {
        filter: grayscale(0%) brightness(1);
        transform: scale(1.1);
    }

    .brand-name {
        margin-top: 14px;
        font-size: 13px;
        font-weight: 600;
        color: rgba(255, 255, 255, 0.7);
        letter-spacing: 1px;
        text-transform: uppercase;
        transition: color 0.3s ease;
    }

    .brand-item:hover .brand-name {
        color: var(--gold);
    }

    .brand-item .brand-hover-hint {
        position: absolute;
        bottom: 14px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 11px;
        color: var(--gold);
        opacity: 0;
        transition: all 0.3s ease;
        white-space: nowrap;
        font-weight: 500;
        letter-spacing: 0.5px;
    }

    .brand-item:hover .brand-hover-hint {
        opacity: 1;
    }

    /* ==================== CATEGORY SECTION (MODERN GLASS) ==================== */
    .category-section {
        padding: 80px 0;
        background: linear-gradient(135deg, #f8f9fa 0%, #f0f2f5 100%);
        position: relative;
        overflow: hidden;
    }

    .category-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 500px;
        height: 500px;
        background: radial-gradient(circle, rgba(212, 175, 55, 0.06) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    .category-section::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(212, 175, 55, 0.04) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    .category-section .section-subtitle {
        text-align: center;
        color: #888;
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
    }

    .category-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        position: relative;
        z-index: 1;
    }

    .category-card {
        position: relative;
        background: rgba(255, 255, 255, 0.65);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.4);
        border-radius: 24px;
        text-decoration: none;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.06);
        min-height: 280px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 40px 30px 35px;
        text-align: center;
        overflow: hidden;
    }

    .category-card::before {
        content: '';
        position: absolute;
        inset: 0;
        border-radius: 24px;
        padding: 2px;
        background: linear-gradient(135deg, rgba(212, 175, 55, 0.2), transparent 40%, transparent 60%, rgba(212, 175, 55, 0.2));
        -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        opacity: 0;
        transition: opacity 0.5s ease;
        pointer-events: none;
    }

    .category-card:hover::before {
        opacity: 1;
    }

    .category-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 50px rgba(212, 175, 55, 0.12);
        border-color: rgba(212, 175, 55, 0.3);
        background: rgba(255, 255, 255, 0.85);
    }

    /* Icon Circle */
    .category-icon-wrapper {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(212, 175, 55, 0.12), rgba(212, 175, 55, 0.05));
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        border: 1px solid rgba(212, 175, 55, 0.15);
        flex-shrink: 0;
    }

    .category-card:hover .category-icon-wrapper {
        background: linear-gradient(135deg, rgba(212, 175, 55, 0.2), rgba(212, 175, 55, 0.08));
        border-color: rgba(212, 175, 55, 0.35);
        transform: scale(1.08);
        box-shadow: 0 8px 25px rgba(212, 175, 55, 0.15);
    }

    .category-icon {
        font-size: 36px;
        color: var(--gold);
        transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .category-card:hover .category-icon {
        transform: scale(1.15) rotate(-8deg);
    }

    /* Category Name */
    .category-name {
        font-size: 20px;
        font-weight: 700;
        color: var(--black);
        margin: 0 0 10px 0;
        transition: color 0.3s ease;
        letter-spacing: 0.3px;
    }

    .category-card:hover .category-name {
        color: var(--gold);
    }

    /* Description */
    .category-desc {
        font-size: 13px;
        color: #999;
        margin: 0 0 18px 0;
        line-height: 1.6;
        max-width: 220px;
        transition: color 0.3s ease;
    }

    /* Product Count Badge */
    .category-count-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(212, 175, 55, 0.08);
        color: var(--gold);
        font-size: 12px;
        font-weight: 600;
        padding: 6px 14px;
        border-radius: 20px;
        border: 1px solid rgba(212, 175, 55, 0.15);
        margin-bottom: 16px;
        transition: all 0.4s ease;
    }

    .category-card:hover .category-count-badge {
        background: rgba(212, 175, 55, 0.15);
        border-color: rgba(212, 175, 55, 0.3);
    }

    .category-count-badge i {
        font-size: 13px;
    }

    /* Separator Line */
    .category-separator {
        width: 40px;
        height: 1.5px;
        background: linear-gradient(90deg, transparent, var(--gold), transparent);
        margin: 0 auto 16px;
        opacity: 0.3;
        transition: all 0.5s ease;
    }

    .category-card:hover .category-separator {
        opacity: 0.8;
        width: 60px;
    }

    /* CTA */
    .category-cta {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        font-weight: 600;
        color: var(--gold);
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        opacity: 0;
        transform: translateY(8px);
    }

    .category-cta i {
        transition: transform 0.3s ease;
        font-size: 14px;
    }

    .category-card:hover .category-cta {
        opacity: 1;
        transform: translateY(0);
    }

    .category-card:hover .category-cta i {
        animation: ctaBounce 1s ease infinite;
    }

    @keyframes ctaBounce {
        0%, 100% { transform: translateX(0); }
        50% { transform: translateX(5px); }
    }

    /* Glass Shimmer Effect */
    .category-card::after {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 60%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.8s ease;
        pointer-events: none;
    }

    .category-card:hover::after {
        left: 150%;
    }

    /* ==================== PRODUCT CARD ==================== */
    .product-section {
        padding: 80px 0;
    }

    .product-section.bg-white {
        background: var(--white);
    }

    .product-section .section-subtitle {
        text-align: center;
        color: #888;
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
    }

    .product-card {
        background: var(--white);
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        position: relative;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        border: 1px solid rgba(0, 0, 0, 0.04);
    }

    .product-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--gold), var(--light-gold), var(--gold));
        transform: scaleX(0);
        transform-origin: left;
        transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        z-index: 5;
    }

    .product-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 50px rgba(212, 175, 55, 0.12);
        border-color: rgba(212, 175, 55, 0.15);
    }

    .product-card:hover::before {
        transform: scaleX(1);
    }

    /* ─── Badges ─── */
    .product-badge {
        position: absolute;
        top: 14px;
        left: 14px;
        z-index: 3;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .badge-custom {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        animation: badgePulse 2s ease-in-out infinite;
    }

    @keyframes badgePulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }

    .badge-hot {
        background: linear-gradient(135deg, #ff4757, #ff6b81);
        color: #fff;
    }

    .badge-new {
        background: linear-gradient(135deg, #2ed573, #7bed9f);
        color: #fff;
    }

    .badge-sale {
        background: linear-gradient(135deg, #e74c3c, #ff7675);
        color: #fff;
    }

    .badge-custom i {
        font-size: 12px;
    }

    /* ─── Image ─── */
    .product-img-wrapper {
        position: relative;
        overflow: hidden;
        cursor: pointer;
        background: #f5f5f5;
    }

    .product-img {
        width: 100%;
        height: 280px;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .product-card:hover .product-img {
        transform: scale(1.12);
    }

    .product-img-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.5) 0%, transparent 50%);
        opacity: 0;
        transition: opacity 0.4s ease;
        z-index: 1;
    }

    .product-card:hover .product-img-overlay {
        opacity: 1;
    }

    /* ─── Discount Badge ─── */
    .product-discount-badge {
        position: absolute;
        top: 14px;
        right: 14px;
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: #fff;
        font-size: 13px;
        font-weight: 800;
        padding: 6px 10px;
        border-radius: 8px;
        z-index: 3;
        box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
        transform: rotate(3deg);
        transition: transform 0.3s ease;
        line-height: 1;
    }

    .product-card:hover .product-discount-badge {
        transform: rotate(0deg) scale(1.1);
    }

    /* ─── Action Buttons ─── */
    .product-actions {
        position: absolute;
        top: 14px;
        right: 14px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        z-index: 3;
    }

    .action-btn {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.95);
        border: none;
        color: var(--black);
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        opacity: 0;
        transform: translateX(10px);
    }

    .product-card:hover .action-btn {
        opacity: 1;
        transform: translateX(0);
    }

    .product-card .action-btn:nth-child(2) {
        transition-delay: 0.05s;
    }

    .product-card:hover .action-btn:hover {
        background: var(--gold);
        color: var(--black);
        transform: scale(1.1);
        box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
    }

    .action-btn i {
        pointer-events: none;
    }

    /* ─── Info Section ─── */
    .product-info {
        padding: 20px 22px 22px;
        position: relative;
    }

    .product-info-top {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
    }

    .product-brand {
        font-size: 11px;
        color: var(--gold);
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .product-scale {
        font-size: 11px;
        color: #999;
        background: #f5f5f5;
        padding: 3px 8px;
        border-radius: 4px;
        font-weight: 500;
    }

    .product-name {
        font-size: 17px;
        font-weight: 700;
        color: var(--black);
        margin-bottom: 10px;
        text-decoration: none;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        line-height: 1.4;
        min-height: 44px;
        transition: color 0.3s ease;
        letter-spacing: 0.3px;
    }

    .product-name:hover {
        color: var(--gold);
    }

    .product-rating {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 12px;
    }

    .stars {
        color: #f39c12;
        font-size: 12px;
        display: flex;
        gap: 1px;
    }

    .review-count {
        font-size: 11px;
        color: #aaa;
    }

    .product-price {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 16px;
        flex-wrap: wrap;
    }

    .current-price {
        font-size: 22px;
        font-weight: 800;
        color: var(--gold);
        text-shadow: 0 1px 3px rgba(212, 175, 55, 0.1);
        transition: transform 0.2s ease;
    }

    .product-card:hover .current-price {
        transform: scale(1.04);
    }

    .old-price {
        font-size: 14px;
        color: #ccc;
        text-decoration: line-through;
        font-weight: 400;
    }

    /* ─── View Detail CTA ─── */
    .product-card .product-view-detail {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        width: 100%;
        padding: 10px 16px;
        background: transparent;
        color: var(--black);
        border: 2px solid #eee;
        border-radius: 10px;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
        text-decoration: none;
        box-sizing: border-box;
    }

    .product-card:hover .product-view-detail {
        border-color: var(--gold);
        background: var(--gold);
        color: var(--black);
        gap: 12px;
    }

    .product-view-detail i {
        font-size: 12px;
        transition: transform 0.3s ease;
    }

    .product-card:hover .product-view-detail i {
        transform: translateX(4px);
    }

    /* Wishlist Toast Notification */
    .toast-notification {
        position: fixed;
        bottom: 30px;
        right: 30px;
        background: var(--black);
        color: var(--gold);
        padding: 15px 25px;
        border-radius: 8px;
        border-left: 4px solid var(--gold);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        z-index: 9999;
        transform: translateX(400px);
        transition: transform 0.3s ease;
        font-weight: 500;
    }

    .toast-notification.show {
        transform: translateX(0);
    }

    /* Responsive */
    @media (max-width: 991px) {
        .hero-slider {
            height: 500px;
        }

        .slide-content h1 {
            font-size: 32px;
        }

        .slide-content p {
            font-size: 14px;
        }
    }

    @media (max-width: 991px) {
        .category-grid {
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        }
        .category-card {
            padding: 32px 22px 28px;
            min-height: 240px;
        }
        .category-icon-wrapper {
            width: 68px;
            height: 68px;
        }
        .category-icon {
            font-size: 30px;
        }
        .brand-item {
            min-width: 130px;
            padding: 20px 24px 34px;
        }
        .brand-logo {
            width: 70px;
            height: 70px;
        }
    }

    @media (max-width: 768px) {
        .hero-slider {
            height: 400px;
        }

        .section-title {
            font-size: 24px;
        }

        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .category-grid {
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }

        .category-card {
            padding: 28px 18px 24px;
            min-height: 210px;
        }

        .category-icon-wrapper {
            width: 60px;
            height: 60px;
            margin-bottom: 14px;
        }

        .category-icon {
            font-size: 26px;
        }

        .category-name {
            font-size: 17px;
        }

        .brands-wrapper {
            gap: 16px;
        }

        .brand-item {
            min-width: 110px;
            padding: 16px 18px 30px;
        }

        .brand-logo {
            width: 60px;
            height: 60px;
        }

        .brands-section {
            padding: 50px 0;
        }

        .category-section {
            padding: 50px 0;
        }
    }
</style>

<c:if test="${not empty banners}">
<!-- ==================== HERO BANNER SLIDER ==================== -->
<section class="hero-slider">
    <div class="slider-container">
        <c:forEach var="banner" items="${banners}" varStatus="status">
            <div class="slide" data-link="${not empty banner.redirectUrl ? banner.redirectUrl : '#'}" data-slide="${status.index}"
                 style="background-image: url('${pageContext.request.contextPath}${banner.imageUrl}');">
                <div class="slide-content">
                    <h1>${banner.title}</h1>
                    <c:if test="${not empty banner.description}">
                        <p>${banner.description}</p>
                    </c:if>
                    <c:if test="${not empty banner.redirectUrl}">
                        <a href="${banner.redirectUrl}" class="slide-btn">Khám phá ngay</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="slider-nav">
        <button class="prev-slide"><i class="bi bi-chevron-left"></i></button>
        <button class="next-slide"><i class="bi bi-chevron-right"></i></button>
    </div>

    <div class="slider-indicators">
        <c:forEach var="banner" items="${banners}" varStatus="status">
            <div class="indicator" data-slide="${status.index}"></div>
        </c:forEach>
    </div>
</section>
</c:if>

<c:if test="${not empty vouchers}">
<!-- ==================== VOUCHER CAROUSEL SECTION ==================== -->
<section class="voucher-section">
    <div class="container">
        <div class="voucher-header">
            <div class="voucher-header-left">
                <h2 class="voucher-title">
                    <i class="bi bi-ticket-perforated"></i>
                    Mã Giảm Giá Hot
                </h2>
                <p class="voucher-subtitle">Sao chép mã và áp dụng ngay khi thanh toán</p>
            </div>
            <a href="/products" class="voucher-view-all">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="voucher-carousel-wrapper">
            <button class="voucher-scroll-btn voucher-scroll-left" aria-label="Cuộn trái">
                <i class="bi bi-chevron-left"></i>
            </button>

            <div class="voucher-carousel" id="voucherCarousel">
                <c:forEach var="v" items="${vouchers}">
                    <div class="voucher-card">
                        <div class="voucher-card-bg"></div>
                        <div class="voucher-card-content">
                            <div class="voucher-type-badge">
                                <c:choose>
                                    <c:when test="${v.valueType == 'PERCENT'}">
                                        <i class="bi bi-percent"></i> Giảm %
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-cash-stack"></i> Giảm tiền
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="voucher-value-display">
                                <c:choose>
                                    <c:when test="${v.valueType == 'PERCENT'}">
                                        <span class="voucher-value-number"><fmt:formatNumber value="${v.value}" type="number" groupingUsed="true"/></span>
                                        <span class="voucher-value-unit">%</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="voucher-value-number"><fmt:formatNumber value="${v.value}" type="number" groupingUsed="true"/></span>
                                        <span class="voucher-value-unit">₫</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="voucher-details">
                                <c:if test="${v.minOrderValue ne null && v.minOrderValue > 0}">
                                    <div class="voucher-detail-row">
                                        <i class="bi bi-cart"></i>
                                        <span>Đơn tối thiểu <fmt:formatNumber value="${v.minOrderValue}" type="number" groupingUsed="true"/>₫</span>
                                    </div>
                                </c:if>
                                <c:if test="${v.maxDiscount ne null && v.maxDiscount > 0}">
                                    <div class="voucher-detail-row">
                                        <i class="bi bi-credit-card"></i>
                                        <span>Giảm tối đa <fmt:formatNumber value="${v.maxDiscount}" type="number" groupingUsed="true"/>₫</span>
                                    </div>
                                </c:if>
                                <c:if test="${v.endAt ne null}">
                                    <div class="voucher-detail-row">
                                        <i class="bi bi-clock"></i>
                                        <span>HSD: <fmt:formatDate value="${v.endAtDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                </c:if>
                            </div>

                            <div class="voucher-code-area">
                                <div class="voucher-code" data-code="${v.code}">
                                    <span class="voucher-code-text">${v.code}</span>
                                </div>
                                <button class="voucher-copy-btn" data-code="${v.code}" title="Sao chép mã">
                                    <i class="bi bi-copy"></i>
                                    <span>Sao chép</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <button class="voucher-scroll-btn voucher-scroll-right" aria-label="Cuộn phải">
                <i class="bi bi-chevron-right"></i>
            </button>
        </div>
    </div>
</section>
</c:if>

<!-- ==================== BRAND LOGOS SECTION ==================== -->
<section class="brands-section">
    <div class="container">
        <h2 class="section-title">Thương Hiệu Đối Tác</h2>
        <p class="brands-subtitle">Những thương hiệu xe hơi danh tiếng hợp tác cùng chúng tôi</p>
        <div class="brands-wrapper">
            <c:forEach var="br" items="${brands}">
                <div class="brand-item" onclick="location.href='/products?brand=${br.name}'">
                    <img src="${pageContext.request.contextPath}${br.logo}"
                         alt="${br.name}" class="brand-logo">
                    <p class="brand-name">${br.name}</p>
                    <span class="brand-hover-hint">Khám phá →</span>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== CATEGORY SECTION (GLASS DESIGN) ==================== -->
<section class="category-section">
    <div class="container">
        <h2 class="section-title">Danh Mục Mô Hình Xe</h2>
        <p class="section-subtitle">Lựa chọn theo dòng xe yêu thích của bạn</p>
        <div class="category-grid">
            <c:forEach var="ca" items="${categories}">
                <a href="/products?category=${ca.name}" class="category-card">
                    <div class="category-icon-wrapper">
                        <i class="bi ${ca.icon} category-icon"></i>
                    </div>
                    <h3 class="category-name">${ca.name}</h3>
                    <p class="category-desc">Bộ sưu tập mô hình xe ${ca.name} cao cấp</p>
                    <c:if test="${ca.productCount gt 0}">
                        <span class="category-count-badge">
                            <i class="bi bi-box-seam"></i> ${ca.productCount} mô hình
                        </span>
                    </c:if>
                    <div class="category-separator"></div>
                    <span class="category-cta">Khám phá <i class="bi bi-arrow-right"></i></span>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM BÁN CHẠY ==================== -->
<section class="product-section bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Bán Chạy</h2>
        <p class="section-subtitle">Những mẫu xe được yêu thích nhất hiện nay</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productHot}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-hot"><i class="bi bi-fire"></i> Bán chạy</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? pageContext.request.contextPath.concat('/uploads/').concat(product.image) : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-half"></i>
                            </div>
                            <span class="review-count">(${product.reviewCount ne null ? product.reviewCount : 12} đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${product.price ne null && product.price gt product.finalPrice}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM MỚI ==================== -->
<section class="product-section">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Mới</h2>
        <p class="section-subtitle">Những mẫu xe vừa ra mắt tại LUXCAR</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productNew}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-new"><i class="bi bi-stars"></i> Mới</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? pageContext.request.contextPath.concat('/uploads/').concat(product.image) : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star"></i>
                            </div>
                            <span class="review-count">(0 đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${product.finalPrice ne null && product.finalPrice gt product.price}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<c:if test="${not empty productSale}">
<!-- ==================== SẢN PHẨM KHUYẾN MÃI ==================== -->
<section class="product-section bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Khuyến Mãi</h2>
        <p class="section-subtitle">Cơ hội sở hữu mô hình xe với giá ưu đãi</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productSale}">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-sale"><i class="bi bi-tag"></i> Giảm ${product.discountPercent}%</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? pageContext.request.contextPath.concat('/uploads/').concat(product.image) : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                            </div>
                            <span class="review-count">(${product.reviewCount} đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${product.price > 0}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
</c:if>

<!-- Toast Notification Container -->
<%--<div id="toastNotification" class="toast-notification"></div>--%>

<script>
    // ==================== SLIDER FUNCTIONALITY ====================
    document.addEventListener('DOMContentLoaded', function () {
        const slides = document.querySelectorAll('.slide');

        slides.forEach((slide) => {
            slide.style.backgroundSize = 'cover';
            slide.style.backgroundPosition = 'center';
        });

        let currentSlide = 0;
        const totalSlides = slides.length;
        let autoSlideInterval;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.remove('active');
                document.querySelectorAll('.indicator')[i].classList.remove('active');
            });

            currentSlide = (index + totalSlides) % totalSlides;
            slides[currentSlide].classList.add('active');
            document.querySelectorAll('.indicator')[currentSlide].classList.add('active');
        }

        function nextSlide() {
            showSlide(currentSlide + 1);
        }

        function prevSlide() {
            showSlide(currentSlide - 1);
        }

        function startAutoSlide() {
            autoSlideInterval = setInterval(nextSlide, 5000);
        }

        function stopAutoSlide() {
            clearInterval(autoSlideInterval);
        }

        // Event listeners
        document.querySelector('.next-slide').addEventListener('click', () => {
            stopAutoSlide();
            nextSlide();
            startAutoSlide();
        });

        document.querySelector('.prev-slide').addEventListener('click', () => {
            stopAutoSlide();
            prevSlide();
            startAutoSlide();
        });

        document.querySelectorAll('.indicator').forEach((indicator, i) => {
            indicator.addEventListener('click', () => {
                stopAutoSlide();
                showSlide(i);
                startAutoSlide();
            });
        });

        // Click on slide to navigate
        slides.forEach(slide => {
            slide.addEventListener('click', (e) => {
                if (e.target.tagName !== 'A' && !e.target.closest('.slide-btn')) {
                    const link = slide.getAttribute('data-link');
                    if (link) {
                        window.location.href = link;
                    }
                }
            });
        });

        // Start auto slide
        showSlide(0);
        startAutoSlide();

        // ==================== WISHLIST FUNCTIONALITY ====================
        const wishlistButtons = document.querySelectorAll('.add-to-wishlist');
        // const toast = document.getElementById('toastNotification');

        // function showToast(message, isSuccess = true) {
        //     toast.textContent = message;
        //     toast.style.background = isSuccess ? 'var(--black)' : '#dc3545';
        //     toast.style.color = isSuccess ? 'var(--gold)' : 'white';
        //     toast.classList.add('show');
        //
        //     setTimeout(() => {
        //         toast.classList.remove('show');
        //     }, 3000);
        // }

        wishlistButtons.forEach(button => {
            button.addEventListener('click', async function (e) {
                e.stopPropagation();
                const productId = this.getAttribute('data-product-id');

                <c:choose>
                <c:when test="${sessionScope.user != null}">
                // User logged in - add to wishlist via AJAX
                try {
                    const response = await fetch('${pageContext.request.contextPath}/api/wishlist/add', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `productId=${productId}`
                    });

                    if (response.ok) {
                        const result = await response.json();
                        showAlert('Đã thêm vào yêu thích!', 'success');
                        // Change heart icon style
                        this.querySelector('i').classList.remove('bi-heart');
                        this.querySelector('i').classList.add('bi-heart-fill');
                    } else {
                        showToast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showAlert('Có lỗi xảy ra!', 'error');
                }
                </c:when>
                <c:otherwise>
                // Not logged in - redirect to login
                showAlert('Vui lòng đăng nhập để thêm vào yêu thích!', 'warning');
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }, 1500);
                </c:otherwise>
                </c:choose>
            });
        });

        // ==================== QUICK VIEW FUNCTIONALITY ====================
        const quickViewButtons = document.querySelectorAll('.quick-view');

        quickViewButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.stopPropagation();
                const productId = this.getAttribute('data-product-id');
                // Implement quick view modal here
                window.location.href = `/product-detail?id=${productId}`;
            });
        });

        // ==================== PRODUCT CARD CLICK ====================
        const productCards = document.querySelectorAll('.product-card');
        productCards.forEach(card => {
            card.addEventListener('click', function (e) {
                if (!e.target.closest('.action-btn') && !e.target.closest('.product-view-detail')) {
                    const productLink = this.querySelector('.product-name');
                    if (productLink) {
                        window.location.href = productLink.getAttribute('href');
                    }
                }
            });
        });

        // ==================== VOUCHER CAROUSEL SCROLL ====================
        const voucherCarousel = document.getElementById('voucherCarousel');
        if (voucherCarousel) {
            const scrollLeftBtn = document.querySelector('.voucher-scroll-left');
            const scrollRightBtn = document.querySelector('.voucher-scroll-right');

            const scrollAmount = 340;

            scrollLeftBtn.addEventListener('click', () => {
                voucherCarousel.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
            });

            scrollRightBtn.addEventListener('click', () => {
                voucherCarousel.scrollBy({ left: scrollAmount, behavior: 'smooth' });
            });
        }

        // ==================== VOUCHER COPY TO CLIPBOARD ====================
        const copyButtons = document.querySelectorAll('.voucher-copy-btn');

        copyButtons.forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.stopPropagation();

                const code = this.getAttribute('data-code');

                // Copy to clipboard
                navigator.clipboard.writeText(code).then(() => {
                    // Visual feedback
                    const originalHtml = this.innerHTML;
                    this.classList.add('copied');
                    this.innerHTML = '<i class="bi bi-check-lg"></i> <span>Đã sao chép!</span>';

                    // Reset after 2s
                    setTimeout(() => {
                        this.classList.remove('copied');
                        this.innerHTML = originalHtml;
                    }, 2000);

                    // Show toast notification
                    showAlert('Đã sao chép mã <strong>' + code + '</strong>!', 'success');
                }).catch(err => {
                    // Fallback for older browsers
                    const textarea = document.createElement('textarea');
                    textarea.value = code;
                    textarea.style.position = 'fixed';
                    textarea.style.opacity = '0';
                    document.body.appendChild(textarea);
                    textarea.select();
                    document.execCommand('copy');
                    document.body.removeChild(textarea);

                    this.classList.add('copied');
                    const originalHtml = this.innerHTML;
                    this.innerHTML = '<i class="bi bi-check-lg"></i> <span>Đã sao chép!</span>';
                    setTimeout(() => {
                        this.classList.remove('copied');
                        this.innerHTML = originalHtml;
                    }, 2000);

                    showAlert('Đã sao chép mã <strong>' + code + '</strong>!', 'success');
                });
            });
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>