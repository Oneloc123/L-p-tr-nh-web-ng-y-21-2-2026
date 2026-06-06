<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 8:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/header.jsp" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Sản phẩm - LUXCAR</title>

<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<!-- Font luxury -->
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Inter:wght@300;400;500;600&display=swap"
      rel="stylesheet">

<!-- noUiSlider for price range -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.css" rel="stylesheet">

<style>
    /* ================= GLOBAL ================= */
    :root {
        --black: #1a1a1a;
        --gold: #C5A028;
        --white: #FFFFFF;
        --light-gold: #e9d6b0;
        --dark-gold: #9e7e2c;
        --gray-light: #f5f5f5;
        --gray-border: #e0e0e0;
        --text-primary: #2c2c2c;
        --text-secondary: #666666;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    html, body {
        height: 100%;
        font-family: 'Inter', sans-serif;
        background-color: var(--gray-light);
        color: var(--text-primary);
    }

    h1, h2, h3, h4, h5 {
        font-family: 'Cormorant Garamond', serif;
        font-weight: 600;
        letter-spacing: 0.5px;
    }

    .container-fluid {
        height: 100vh;
    }

    .row {
        height: 100%;
        margin: 0;
    }

    /* ================= SIDEBAR ================= */
    .sidebar {
        background: #fff;
        padding: 0;
        border-right: 1px solid var(--gray-border);
        height: 100%;
        overflow-y: auto;
        box-shadow: 2px 0 25px rgba(0, 0, 0, 0.04);
        display: flex;
        flex-direction: column;
    }

    .sidebar::-webkit-scrollbar {
        width: 4px;
    }
    .sidebar::-webkit-scrollbar-track {
        background: transparent;
    }
    .sidebar::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 4px;
    }

    /* ================= FILTER HEADER ================= */
    .filter-header {
        padding: 20px 20px 16px;
        border-bottom: 1px solid var(--gray-border);
        flex-shrink: 0;
    }
    .filter-header h5 {
        font-family: 'Cormorant Garamond', serif;
        font-size: 20px;
        font-weight: 700;
        color: var(--black);
        margin: 0;
        letter-spacing: 0.5px;
    }
    .filter-header h5 i {
        color: var(--gold);
        margin-right: 8px;
    }
    .filter-header .active-filters-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        background: var(--gold);
        color: #fff;
        font-size: 11px;
        font-weight: 600;
        padding: 2px 10px;
        border-radius: 20px;
        margin-left: 8px;
    }

    /* ================= SEARCH ================= */
    .filter-search {
        padding: 14px 20px;
        border-bottom: 1px solid #f0f0f0;
        flex-shrink: 0;
    }
    .filter-search .search-wrap {
        position: relative;
    }
    .filter-search .search-wrap i {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #aaa;
        font-size: 14px;
        transition: color 0.2s;
    }
    .filter-search .search-wrap input {
        width: 100%;
        padding: 9px 14px 9px 38px;
        border: 1.5px solid #eee;
        border-radius: 30px;
        font-size: 13px;
        background: #fafafa;
        transition: all 0.25s;
        color: var(--text-primary);
    }
    .filter-search .search-wrap input:focus {
        outline: none;
        border-color: var(--gold);
        background: #fff;
        box-shadow: 0 0 0 3px rgba(197, 160, 40, 0.08);
    }
    .filter-search .search-wrap input:focus + i,
    .filter-search .search-wrap input:focus ~ i {
        color: var(--gold);
    }

    /* ================= FILTER BODY ================= */
    .filter-body {
        flex: 1;
        overflow-y: auto;
        padding: 6px 0;
    }
    .filter-body::-webkit-scrollbar {
        width: 3px;
    }
    .filter-body::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 3px;
    }

    /* ================= FILTER SECTION ================= */
    .filter-section {
        border-bottom: 1px solid #f0f0f0;
        transition: background 0.2s;
    }
    .filter-section:last-child {
        border-bottom: none;
    }

    .filter-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 14px 20px;
        cursor: pointer;
        transition: all 0.2s;
        user-select: none;
        gap: 12px;
    }
    .filter-title:hover {
        background: #fcf9f0;
    }
    .filter-title .title-left {
        display: flex;
        align-items: center;
        gap: 10px;
        min-width: 0;
    }
    .filter-title .title-left i {
        color: var(--gold);
        font-size: 15px;
        width: 20px;
        text-align: center;
        flex-shrink: 0;
    }
    .filter-title .title-left span {
        font-weight: 600;
        font-size: 13px;
        color: var(--text-primary);
        letter-spacing: 0.3px;
        text-transform: uppercase;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .filter-title .title-left .count-label {
        font-size: 11px;
        color: #999;
        font-weight: 400;
        text-transform: none;
        margin-left: 2px;
    }
    .filter-title .title-right {
        display: flex;
        align-items: center;
        gap: 6px;
        flex-shrink: 0;
    }
    .filter-title .title-right .filter-active-dot {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: var(--gold);
        display: none;
    }
    .filter-title .title-right .filter-active-dot.show {
        display: block;
        animation: popDot 0.3s ease;
    }
    .filter-title .title-right i.chevron {
        color: #bbb;
        font-size: 12px;
        transition: transform 0.3s ease;
    }
    .filter-title.active .title-right i.chevron {
        transform: rotate(180deg);
    }

    @keyframes popDot {
        0% { transform: scale(0); }
        50% { transform: scale(1.4); }
        100% { transform: scale(1); }
    }

    /* ================= FILTER CONTENT (collapsible) ================= */
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
    .filter-content.open::-webkit-scrollbar {
        width: 3px;
    }
    .filter-content.open::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 3px;
    }

    /* ================= CHECKBOXES ================= */
    .filter-checkbox {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 6px 8px;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.15s;
        margin-bottom: 2px;
    }
    .filter-checkbox:hover {
        background: #faf8f2;
    }
    .filter-checkbox input[type="checkbox"] {
        appearance: none;
        -webkit-appearance: none;
        width: 17px;
        height: 17px;
        border: 2px solid #d0d0d0;
        border-radius: 4px;
        cursor: pointer;
        flex-shrink: 0;
        position: relative;
        transition: all 0.2s;
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
        border: solid #fff;
        border-width: 0 2px 2px 0;
        transform: rotate(45deg);
    }
    .filter-checkbox input[type="checkbox"]:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(197, 160, 40, 0.12);
    }
    .filter-checkbox label {
        font-size: 13px;
        color: var(--text-secondary);
        cursor: pointer;
        flex: 1;
        min-width: 0;
        transition: color 0.15s;
    }
    .filter-checkbox:hover label {
        color: var(--text-primary);
    }
    .filter-checkbox input[type="checkbox"]:checked ~ label {
        color: var(--black);
        font-weight: 500;
    }

    /* ================= PRICE RANGE ================= */
    .price-range-wrap {
        padding: 8px 4px 4px;
    }
    #price-range {
        margin: 10px 0 18px;
        height: 4px;
    }
    .noUi-connect {
        background: var(--gold);
    }
    .noUi-handle {
        border: 2.5px solid var(--gold);
        border-radius: 50%;
        background: #fff;
        cursor: pointer;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.12);
        width: 20px !important;
        height: 20px !important;
        right: -10px !important;
        top: -8px !important;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .noUi-handle:before,
    .noUi-handle:after {
        display: none;
    }
    .noUi-handle:hover {
        transform: scale(1.15);
        box-shadow: 0 3px 10px rgba(197, 160, 40, 0.25);
    }
    .noUi-handle.noUi-active {
        transform: scale(1.2);
        box-shadow: 0 4px 14px rgba(197, 160, 40, 0.3);
    }
    .noUi-target {
        background: #e8e8e8;
        border-radius: 3px;
        border: none;
        box-shadow: none;
    }

    .price-display {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
        background: #f9f9f9;
        border-radius: 10px;
        padding: 10px 14px;
        border: 1px solid #eee;
    }
    .price-display .price-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2px;
    }
    .price-display .price-item .price-label {
        font-size: 10px;
        color: #999;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 500;
    }
    .price-display .price-item .price-value {
        font-size: 14px;
        font-weight: 600;
        color: var(--black);
        font-family: 'Cormorant Garamond', serif;
    }
    .price-display .price-sep {
        color: #ddd;
        font-size: 12px;
    }

    /* ================= SIDEBAR FOOTER ================= */
    .sidebar-footer {
        flex-shrink: 0;
        padding: 16px 20px;
        border-top: 1px solid var(--gray-border);
        background: #fff;
    }
    .sidebar-footer .btn-apply {
        flex: 1;
        background: var(--black);
        color: #fff;
        border: none;
        padding: 11px 20px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.25s;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }
    .sidebar-footer .btn-apply:hover {
        background: #333;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
    }
    .sidebar-footer .btn-apply:active {
        transform: translateY(0);
    }
    .sidebar-footer .btn-reset-filter {
        width: 44px;
        height: 44px;
        border: 1.5px solid #ddd;
        border-radius: 50%;
        background: #fff;
        color: var(--text-secondary);
        cursor: pointer;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .sidebar-footer .btn-reset-filter:hover {
        border-color: var(--gold);
        color: var(--gold);
        background: #fcf9f0;
        transform: rotate(-30deg);
    }

    /* ================= VOUCHER ================= */
    .voucher-mini {
        padding: 12px 20px;
        border-top: 1px solid #f0f0f0;
        flex-shrink: 0;
    }
    .voucher-toggle {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        padding: 10px 14px;
        background: linear-gradient(135deg, #fcf9f0, #fff);
        border: 1px dashed var(--gold);
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.2s;
        font-size: 12px;
        font-weight: 500;
        color: var(--text-primary);
    }
    .voucher-toggle:hover {
        background: linear-gradient(135deg, #f8f0d8, #fff);
    }
    .voucher-toggle i {
        color: var(--gold);
        font-size: 16px;
    }
    .voucher-toggle .v-badge {
        background: var(--gold);
        color: #fff;
        font-size: 10px;
        font-weight: 700;
        padding: 2px 8px;
        border-radius: 20px;
    }
    .voucher-content {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease, padding 0.3s ease;
    }
    .voucher-content.open {
        max-height: 400px;
        padding-top: 10px;
    }
    .voucher-item {
        background: #fff;
        border-radius: 8px;
        padding: 10px 12px;
        margin-bottom: 6px;
        border-left: 3px solid var(--gold);
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .voucher-code {
        font-weight: 600;
        color: var(--text-primary);
        font-size: 12px;
    }
    .voucher-discount {
        color: var(--gold);
        font-weight: 500;
        font-size: 11px;
    }
    .voucher-empty {
        text-align: center;
        color: #bbb;
        font-size: 12px;
        padding: 10px;
    }

    /* ================= SORT BAR ================= */
    .sort-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding: 12px 20px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.03);
    }
    .sort-buttons {
        display: flex;
        gap: 6px;
        flex-wrap: wrap;
    }
    .sort-btn {
        padding: 6px 16px;
        border: 1.5px solid #eee;
        background: #fff;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 500;
        transition: all 0.2s;
        cursor: pointer;
        color: var(--text-secondary);
        white-space: nowrap;
    }
    .sort-btn:hover {
        border-color: var(--gold);
        color: var(--gold);
    }
    .sort-btn.active {
        background: var(--black);
        border-color: var(--black);
        color: #fff;
    }
    .result-count {
        color: var(--text-secondary);
        font-size: 18px;
        font-weight: 400;
        white-space: nowrap;
    }
    .result-count span {
        color: var(--gold);
        font-weight: 700;
        font-size: 22px;
    }

    /* ================= PRODUCT WRAPPER ================= */
    .product-wrapper {
        height: 100%;
        overflow-y: auto;
        padding: 2rem 2rem 0;
        display: flex;
        flex-direction: column;
    }
    .product-wrapper::-webkit-scrollbar {
        width: 8px;
    }
    .product-wrapper::-webkit-scrollbar-track {
        background: #f1f1f1;
    }
    .product-wrapper::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 4px;
    }
    .product-content {
        flex: 1 0 auto;
    }
    .product-grid {
        margin-bottom: 30px;
    }

    /* ================= PRODUCT CARD ================= */
    .product-card {
        border: none;
        border-radius: 14px;
        overflow: hidden;
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        height: 100%;
        display: flex;
        flex-direction: column;
        background: #fff;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
        position: relative;
    }
    .product-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.08);
    }
    .product-image-wrapper {
        height: 200px;
        overflow: hidden;
        position: relative;
    }
    .product-image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    .product-card:hover .product-image-wrapper img {
        transform: scale(1.08);
    }
    .product-image-wrapper::after {
        content: '';
        position: absolute;
        inset: 0;
        background: linear-gradient(to bottom, transparent 60%, rgba(0,0,0,0.03));
        pointer-events: none;
        z-index: 1;
    }
    .product-badge {
        position: absolute;
        top: 10px;
        left: 10px;
        background: var(--gold);
        color: #fff;
        padding: 3px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        z-index: 2;
        letter-spacing: 0.3px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .product-badge.discount {
        background: linear-gradient(135deg, #d32f2f, #b71c1c);
    }
    .card-body {
        padding: 14px 16px 16px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    .product-category {
        font-size: 10px;
        color: var(--gold);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 4px;
        font-weight: 600;
    }
    .product-name {
        font-weight: 700;
        margin-bottom: 4px;
        font-size: 18px;
        color: var(--text-primary);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-family: 'Cormorant Garamond', serif;
        line-height: 1.3;
        transition: color 0.25s ease;
        letter-spacing: 0.3px;
    }
    .product-card:hover .product-name {
        color: var(--gold);
    }
    .product-model {
        font-size: 12px;
        color: var(--text-secondary);
        margin-bottom: 6px;
        font-weight: 400;
    }
    .product-model i {
        color: var(--gold);
        margin-right: 3px;
        font-size: 11px;
    }
    .product-price-section {
        margin: 6px 0;
    }
    .product-price-row {
        display: flex;
        align-items: baseline;
        flex-wrap: wrap;
        gap: 4px;
    }
    .product-price-old {
        font-size: 13px;
        text-decoration: line-through;
        color: #ccc;
        font-weight: 400;
    }
    .product-price-current {
        font-size: 24px;
        font-weight: 800;
        color: var(--gold);
        font-family: 'Cormorant Garamond', serif;
        line-height: 1.2;
        text-shadow: 0 1px 2px rgba(212, 175, 55, 0.08);
        transition: transform 0.2s ease;
    }
    .product-card:hover .product-price-current {
        transform: scale(1.03);
    }
    .product-actions {
        display: flex;
        gap: 6px;
        margin-top: auto;
        border-top: 1px solid #f0f0f0;
        padding-top: 12px;
        opacity: 0.85;
        transition: opacity 0.3s, transform 0.3s;
    }
    .product-card:hover .product-actions {
        opacity: 1;
    }
    .btn-buy {
        flex: 2;
        background: var(--black);
        color: #fff;
        border: none;
        padding: 8px 0;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 500;
        transition: 0.2s;
    }
    .btn-buy:hover {
        background: var(--gold);
    }
    .btn-action {
        flex: 1;
        background: #f8f8f8;
        color: var(--text-secondary);
        border: none;
        padding: 8px 0;
        border-radius: 30px;
        transition: 0.2s;
    }
    .btn-action:hover {
        background: var(--gold);
        color: #fff;
    }

    /* ================= RATING ================= */
    .rating {
        display: flex;
        align-items: center;
        gap: 3px;
        font-size: 12px;
        color: var(--gold);
        margin: 8px 0;
    }
    .rating span {
        color: var(--text-secondary);
        margin-right: 4px;
        font-weight: 500;
        font-size: 12px;
    }

    /* ================= EMPTY STATE ================= */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: #fff;
        border-radius: 12px;
    }
    .empty-state i {
        font-size: 60px;
        color: var(--gold);
        opacity: 0.3;
        margin-bottom: 15px;
    }
    .empty-state h4 {
        font-size: 22px;
        margin-bottom: 8px;
        color: var(--text-primary);
    }
    .empty-state p {
        color: var(--text-secondary);
        margin-bottom: 20px;
        font-size: 14px;
    }
    .btn-reset {
        background: var(--gold);
        color: #fff;
        border: none;
        padding: 10px 30px;
        border-radius: 30px;
        font-weight: 500;
        transition: 0.2s;
    }
    .btn-reset:hover {
        background: var(--dark-gold);
    }

    /* ================= PAGINATION ================= */
    .pagination-container {
        margin-top: auto;
        padding: 30px 0 40px;
        width: 100%;
        border-top: 2px solid var(--gray-border);
        background: transparent;
    }
    .pagination {
        display: flex;
        justify-content: center;
        gap: 8px;
        margin: 0;
        padding: 0;
        list-style: none;
        flex-wrap: wrap;
    }
    .pagination .page-item {
        margin: 0;
    }
    .pagination .page-link {
        color: var(--text-secondary);
        border: 1px solid var(--gray-border);
        border-radius: 8px;
        transition: all 0.25s ease;
        width: 42px;
        height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
        font-weight: 500;
        padding: 0;
        text-decoration: none;
        background: #fff;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.03);
    }
    .pagination .page-link:hover {
        background: var(--gold);
        color: #fff;
        border-color: var(--gold);
        transform: translateY(-3px);
        box-shadow: 0 5px 12px rgba(197, 160, 40, 0.2);
    }
    .pagination .page-item.active .page-link {
        background: var(--gold);
        border-color: var(--gold);
        color: #fff;
        font-weight: 600;
        box-shadow: 0 4px 10px rgba(197, 160, 40, 0.25);
    }
    .pagination .page-item.disabled .page-link {
        background: #f8f8f8;
        color: #ccc;
        border-color: #eee;
        pointer-events: none;
        box-shadow: none;
        transform: none;
    }

    /* ================= RESPONSIVE ================= */
    @media (max-width: 991px) {
        .sidebar {
            border-right: none;
            border-bottom: 1px solid var(--gray-border);
            height: auto;
            max-height: 400px;
        }
        .filter-body {
            max-height: 250px;
        }
        .product-wrapper {
            padding: 1.5rem 1rem 0;
        }
        .sort-bar {
            flex-direction: column;
            gap: 12px;
            align-items: stretch;
        }
        .sort-buttons {
            justify-content: center;
        }
        .result-count {
            text-align: center;
        }
    }
    @media (max-width: 767px) {
        .sidebar {
            max-height: 350px;
        }
    }
</style>

<body>

<!-- Alert Container -->
<%--<div id="alertContainer" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>--%>

<div class="container-fluid">
    <div class="row align-items-start">

        <!-- ================= SIDEBAR FILTER ================= -->
        <div class="col-lg-3 col-md-4 sidebar p-0">
            <form id="filterForm" action="products" method="get"
                  style="height: 100%; display: flex; flex-direction: column;">

                <!-- Header -->
                <div class="filter-header">
                    <h5>
                        <i class="bi bi-funnel"></i>Bộ lọc
                        <span class="active-filters-badge" id="activeFilterCount" style="display:none;">0</span>
                    </h5>
                </div>

                <!-- Search -->
                <div class="filter-search">
                    <div class="search-wrap">
                        <i class="bi bi-search"></i>
                        <input name="keyword" value="${find}" type="text"
                               placeholder="Tìm sản phẩm..."
                               autocomplete="off">
                    </div>
                </div>

                <!-- Sort (hidden inputs) -->
                <input type="hidden" name="sort" id="sortInput" value="${param.sort != null ? param.sort : ''}">
                <input type="hidden" name="minPrice" id="minPriceInput" value="${param.minPrice}">
                <input type="hidden" name="maxPrice" id="maxPriceInput" value="${param.maxPrice}">

                <!-- Filter Body -->
                <div class="filter-body">

                    <!-- Tỉ lệ mô hình -->
                    <div class="filter-section">
                        <div class="filter-title active" onclick="toggleFilter(this)" role="button" aria-expanded="true" aria-controls="content-scale">
                            <div class="title-left">
                                <i class="bi bi-grid-3x3-gap"></i>
                                <span>Tỉ lệ <span class="count-label">(${totalScale})</span></span>
                            </div>
                            <div class="title-right">
                                <span class="filter-active-dot" id="dot-scale"></span>
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content open" id="content-scale">
                            <c:forEach items="${scaleName}" var="scale">
                                <c:set var="checked" value="false"/>
                                <c:forEach items="${paramValues.scale}" var="s">
                                    <c:if test="${s == scale}">
                                        <c:set var="checked" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <div class="filter-checkbox">
                                    <input name="scale" value="${scale}" type="checkbox" ${checked ? 'checked' : ''} id="scale-${fn:replace(scale, ' ', '-')}">
                                    <label for="scale-${fn:replace(scale, ' ', '-')}">Tỉ lệ ${scale}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Thương hiệu -->
                    <div class="filter-section">
                        <div class="filter-title" onclick="toggleFilter(this)" role="button" aria-expanded="false" aria-controls="content-brand">
                            <div class="title-left">
                                <i class="bi bi-tags"></i>
                                <span>Thương hiệu <span class="count-label">(${totalBrand})</span></span>
                            </div>
                            <div class="title-right">
                                <span class="filter-active-dot" id="dot-brand"></span>
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content" id="content-brand">
                            <c:forEach var="bn" items="${brandName}">
                                <c:set var="checked" value="false"/>
                                <c:forEach items="${paramValues.brand}" var="b">
                                    <c:if test="${b == bn}">
                                        <c:set var="checked" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <div class="filter-checkbox">
                                    <input name="brand" value="${bn}" type="checkbox" ${checked ? 'checked' : ''} id="brand-${fn:replace(bn, ' ', '-')}">
                                    <label for="brand-${fn:replace(bn, ' ', '-')}">${bn}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Danh mục -->
                    <div class="filter-section">
                        <div class="filter-title" onclick="toggleFilter(this)" role="button" aria-expanded="false" aria-controls="content-category">
                            <div class="title-left">
                                <i class="bi bi-collection"></i>
                                <span>Danh mục <span class="count-label">(${totalCategory})</span></span>
                            </div>
                            <div class="title-right">
                                <span class="filter-active-dot" id="dot-category"></span>
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content" id="content-category">
                            <c:forEach var="cn" items="${categoryName}">
                                <c:set var="checked" value="false"/>
                                <c:forEach items="${paramValues.category}" var="c">
                                    <c:if test="${c == cn}">
                                        <c:set var="checked" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <div class="filter-checkbox">
                                    <input name="category" value="${cn}" type="checkbox" ${checked ? 'checked' : ''} id="category-${fn:replace(cn, ' ', '-')}">
                                    <label for="category-${fn:replace(cn, ' ', '-')}">${cn}</label>
                                </div>
                            </c:forEach>
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
                                <span class="filter-active-dot" id="dot-price"></span>
                                <i class="bi bi-chevron-down chevron"></i>
                            </div>
                        </div>
                        <div class="filter-content open" id="content-price">
                            <div class="price-range-wrap">
                                <div id="price-range"></div>
                                <div class="price-display">
                                    <div class="price-item">
                                        <span class="price-label">Từ</span>
                                        <span class="price-value" id="display-min-price">
                                            <fmt:formatNumber value="${param.minPrice != null ? param.minPrice : 0}" type="number" groupingUsed="true"/> ₫
                                        </span>
                                    </div>
                                    <span class="price-sep">—</span>
                                    <div class="price-item">
                                        <span class="price-label">Đến</span>
                                        <span class="price-value" id="display-max-price">
                                            <fmt:formatNumber value="${param.maxPrice != null ? param.maxPrice : requestScope.maxPrice}" type="number" groupingUsed="true"/> ₫
                                        </span>
                                    </div>
                                </div>
                                <input type="hidden" id="min-price" value="${param.minPrice != null ? param.minPrice : 0}">
                                <input type="hidden" id="max-price" value="${param.maxPrice != null ? param.maxPrice : requestScope.maxPrice}">
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
                        <button type="button" class="btn-reset-filter" onclick="resetFilters()" title="Đặt lại">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </button>
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
                            <span class="voucher-discount">-${v.maxDiscount}</span>
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
                    <span>${totalProduct}</span> sản phẩm
                </div>
            </div>

            <!-- Product Grid -->
            <div class="product-content">
                <div class="row g-3">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="card product-card">
                                        <div class="product-image-wrapper">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                                <img src="${pageContext.request.contextPath}/uploads/${p.image}"
                                                     class="card-img-top" alt="${p.name}">
                                            </a>
                                            <c:if test="${p.discountPercent > 0}">
                                                <span class="product-badge discount">-${p.discountPercent}%</span>
                                            </c:if>
                                        </div>
                                        <div class="card-body">
                                            <div class="product-category">${p.categoryName}</div>
                                            <h6 class="product-name">${p.name}</h6>
                                            <div class="product-model">
                                                <i class="bi bi-cpu"></i> Tỉ lệ ${p.ratio}
                                            </div>
                                            <div class="rating mb-2">
                                                <fmt:formatNumber
                                                        value="${p.avgRating}"
                                                        maxFractionDigits="1"/>
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:choose>
                                                        <c:when test="${i le p.avgRating}">
                                                            <i class="bi bi-star-fill"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="bi bi-star"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            <div class="product-price-section">
                                                <div class="product-price-row">
                                                    <c:if test="${p.discountPercent > 0}">
                                                        <span class="product-price-old">
                                                        <fmt:formatNumber value="${p.price}" type="number"
                                                                          groupingUsed="true"/> ₫
                                                    </span>
                                                    </c:if>
                                                    <div class="product-price-current">
                                                        <fmt:formatNumber value="${p.finalPrice}" type="number"
                                                                          groupingUsed="true"/> ₫
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="product-actions">


                                                    <button type="button" class="btn-buy"
                                                            onclick="addToCartAjax(event,'${p.id}', '${fn:replace(p.name, "'", "\\'")}', true)">
                                                        <i class="bi bi-lightning-charge me-1"></i>Mua
                                                    </button>





                                                    <!--sua type act thanh btt -->
                                                    <button type="button" class="btn-action"
                                                            onclick="addToCartAjax(event,'${p.id}', '${fn:replace(p.name, "'", "\\'")}', false)">
                                                        <i class="bi bi-cart-plus"></i>
                                                    </button>




                                                <form method="post" action="/favorites" style="display: contents;">
                                                    <button class="btn-action" name="productid" value="${p.id}">
                                                        <i class="bi bi-star"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="empty-state">
                                    <i class="bi bi-search"></i>
                                    <h4>Không tìm thấy sản phẩm</h4>
                                    <p>Không có sản phẩm nào phù hợp với bộ lọc của bạn.</p>
                                    <button class="btn-reset" onclick="resetFilters()">
                                        <i class="bi bi-arrow-counterclockwise me-2"></i>Đặt lại bộ lọc
                                    </button>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- Pagination -->
            <c:if test="${totalPage > 1}">
                <div class="pagination-container">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage - 1})"
                                   aria-label="Previous">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>

                            <c:forEach begin="1" end="${totalPage}" var="i">
                                <c:if test="${i == 1 || i == totalPage || (i >= currentPage-2 && i <= currentPage+2)}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="javascript:void(0)"
                                           onclick="changePage(${i})">${i}</a>
                                    </li>
                                </c:if>
                                <c:if test="${i == currentPage-3 && i > 2}">
                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                                <c:if test="${i == currentPage+3 && i < totalPage-1}">
                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage + 1})"
                                   aria-label="Next">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</div>
<div id="customToast"
     style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
    <i class="fas fa-check-circle"></i> <span id="toastMessage"> Đã thêm vào giỏ!</span>
</div>

<!-- thong bao dang nhap -->
<div class="modal fade" id="requireLoginModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
            <div class="modal-header" style="border-bottom: 1px solid #eee;">
                <h5 class="modal-title" style="color: var(--gold); font-weight: 600;">
                    <i class="bi bi-shield-lock me-2"></i>Yêu cầu đăng nhập
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body text-center" style="padding: 30px 20px;">
                <i class="bi bi-person-circle"
                   style="font-size: 50px; color: #ddd; margin-bottom: 15px; display: block;"></i>
                <h6 style="font-size: 16px; color: #333; line-height: 1.5;">Vui lòng đăng nhập để thêm mặt hàng này vào
                    giỏ!</h6>
            </div>

            <div class="modal-footer justify-content-center" style="border-top: none; padding-bottom: 25px;">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"
                        style="border-radius: 30px; padding: 8px 24px; font-weight: 500;">
                    Tiếp tục lướt
                </button>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark"
                   style="border-radius: 30px; padding: 8px 24px; background-color: var(--black); font-weight: 500;">
                    Đi đến đăng nhập
                </a>
            </div>
        </div>
    </div>
</div>
</body>


<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/wnumb/1.2.0/wNumb.min.js"></script>

<script>
    function addToCartAjax(event, productId, productName, isBuyNow) {
        event.preventDefault();

        let quantityInput = document.querySelector('input[name="quantity"]');
        let quantity;

        if (quantityInput != null) {
            quantity = quantityInput.value
        } else {
            quantity = 1;
        }

        let apiUrl;
                if (isBuyNow == true) {
                    apiUrl = 'buy-now';
                } else {
                    apiUrl = 'cart-add';
                }

                fetch(apiUrl + '?productId=' + productId + '&quantity=' + quantity + '&ajax=true')
                    .then(function (response) {
                        return response.text();
                    })
                    .then(function (data) {
                        if (data.trim() === 'success') {

                            if (isBuyNow === true) {
                                window.location.href = "checkout?type=buynow";
                            } else {
                        // hien thi thong bao(TOAST)
                        // let toast = document.getElementById("customToast");
                        // document.getElementById("toastMessage").innerText = "Đã thêm " + quantity + " chiếc [" + productName + "] vào giỏ!";


                        // toast.style.visibility = "visible";
                        // toast.style.opacity = "1";
                        //
                        // setTimeout(function () {
                        //     toast.style.opacity = "0";
                        //
                        //     setTimeout(function () {
                        //         toast.style.visibility = "hidden";
                        //     }, 500);
                        // }, 3000);

                        let mess = "Đã thêm " + quantity + " chiếc [" + productName + "] vào giỏ!";
                        showAlert(mess, "success");

                        // CỘNG SỐ GIỎ HÀNG
                        let count = document.getElementById("cart-count");
                        if (count != null) {
                            let crrNumber = parseInt(count.innerText);

                            if (isNaN(crrNumber)) {
                                crrNumber = 0;
                            }
                            count.innerText = crrNumber + parseInt(quantity);
                        }
                    }


                } else if (data.trim() === 'need_login') {
                    let loginModal = new bootstrap.Modal(document.getElementById("requireLoginModal"));
                    loginModal.show();
                }
            })
            .catch(function (error) {
                console.error("Lỗi khi thêm giỏ hàng:", error);
                alert("có lỗi xãy ra, vui lòng thử lại!");
            });
    }


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

    /* ================= ACTIVE FILTER COUNT ================= */
    function updateActiveFilterCount() {
        const checkboxes = document.querySelectorAll('.filter-checkbox input[type="checkbox"]:checked');
        const badge = document.getElementById('activeFilterCount');

        // Check price filter - only count if different from defaults
        const minVal = document.getElementById('minPriceInput').value;
        const maxVal = document.getElementById('maxPriceInput').value;
        const hasPrice = (minVal && minVal !== '0') || (maxVal && maxVal !== String(${maxPrice}));

        // Check keyword
        const kw = document.querySelector('input[name="keyword"]').value;
        const hasKeyword = kw && kw.trim().length > 0;

        let totalActive = checkboxes.length;
        if (hasPrice) totalActive++;
        if (hasKeyword) totalActive++;

        if (totalActive > 0) {
            badge.textContent = totalActive;
            badge.style.display = 'inline-flex';
            badge.style.animation = 'none';
            setTimeout(function() { badge.style.animation = 'popDot 0.3s ease'; }, 10);
        } else {
            badge.style.display = 'none';
        }
    }

    /* ================= ACTIVE DOTS ================= */
    function updateActiveDots() {
        const sections = [
            { checkboxes: 'input[name="scale"]', dotId: 'dot-scale' },
            { checkboxes: 'input[name="brand"]', dotId: 'dot-brand' },
            { checkboxes: 'input[name="category"]', dotId: 'dot-category' }
        ];
        sections.forEach(function(s) {
            const checked = document.querySelectorAll(s.checkboxes + ':checked').length;
            const dot = document.getElementById(s.dotId);
            if (checked > 0) {
                dot.classList.add('show');
            } else {
                dot.classList.remove('show');
            }
        });
        // Price dot
        const minVal = document.getElementById('minPriceInput').value;
        const maxVal = document.getElementById('maxPriceInput').value;
        const priceDot = document.getElementById('dot-price');
        if (minVal || maxVal) {
            priceDot.classList.add('show');
        } else {
            priceDot.classList.remove('show');
        }
    }

    /* ================= PRICE RANGE SLIDER ================= */
    const priceSlider = document.getElementById('price-range');
    const minPriceHidden = document.getElementById('minPriceInput');
    const maxPriceHidden = document.getElementById('maxPriceInput');
    const displayMin = document.getElementById('display-min-price');
    const displayMax = document.getElementById('display-max-price');

    const urlParams = new URLSearchParams(window.location.search);
    const minPrice = urlParams.get('minPrice') ? parseInt(urlParams.get('minPrice')) : 0;
    const maxPrice = urlParams.get('maxPrice') ? parseInt(urlParams.get('maxPrice')) : ${maxPrice};

    noUiSlider.create(priceSlider, {
        start: [minPrice, maxPrice],
        connect: true,
        step: 100000,
        range: {
            'min': 0,
            'max': ${maxPrice}
        },
        format: wNumb({
            decimals: 0,
            thousand: '.',
            suffix: ' ₫'
        })
    });

    priceSlider.noUiSlider.on('update', function (values, handle) {
        const value = values[handle].replace(/[^0-9]/g, '');
        if (handle) {
            displayMax.textContent = values[handle];
            maxPriceHidden.value = value;
        } else {
            displayMin.textContent = values[handle];
            minPriceHidden.value = value;
        }
        updateActiveDots();
        updateActiveFilterCount();
    });

    function setSort(sortValue) {
        document.getElementById('sortInput').value = sortValue;
        document.getElementById('filterForm').submit();
    }

    function resetFilters() {
        window.location.href = 'products';
    }

    function changePage(page) {
        const form = document.getElementById('filterForm');
        const pageInput = document.createElement('input');
        pageInput.type = 'hidden';
        pageInput.name = 'page';
        pageInput.value = page;
        form.appendChild(pageInput);
        form.submit();
    }

    /* ================= INIT ================= */
    document.addEventListener('DOMContentLoaded', function() {
        // Update active dot and count on checkbox change
        document.querySelectorAll('.filter-checkbox input[type="checkbox"]').forEach(function(cb) {
            cb.addEventListener('change', function() {
                updateActiveDots();
                updateActiveFilterCount();
            });
        });
        // Initial update
        updateActiveDots();
        updateActiveFilterCount();
    });


    // function showAlert(message, type) {
    //     const alertDiv = document.createElement('div');
    //     alertDiv.className = 'alert-custom';
    //     if (type === 'success') {
    //         alertDiv.classList.add('success');
    //     }
    //
    //     // Chọn icon phù hợp
    //     let icon = 'bi-check-circle-fill';
    //     if (type === 'warning') {
    //         icon = 'bi-exclamation-triangle-fill';
    //     } else if (type === 'success') {
    //         icon = 'bi-check-circle-fill';
    //     }
    //
    //     alertDiv.innerHTML = `
    //         <div class="d-flex align-items-center">
    //             <i class="bi ` + icon + ` me-3" style="font-size: 24px;"></i>
    //             <div>
    //                 <strong>LUXCAR</strong><br>
    //                 <span style="font-size: 14px;">` + message + `</span>
    //             </div>
    //         </div>
    //         <div style="position: absolute; bottom: 0; left: 0; height: 3px; width: 100%; background: linear-gradient(90deg, var(--gold), var(--light-gold)); transform-origin: left; animation: progress 3s linear;"></div>
    //     `;
    //     document.getElementById('alertContainer').appendChild(alertDiv);
    //
    //     // Thêm animation progress bar
    //     const style = document.createElement('style');
    //     style.innerHTML = `
    //         @keyframes progress {
    //             0% { transform: scaleX(1); }
    //             100% { transform: scaleX(0); }
    //         }
    //     `;
    //     document.head.appendChild(style);
    //
    //     setTimeout(() => {
    //         alertDiv.style.animation = 'slideOutRight 0.3s ease';
    //         setTimeout(() => alertDiv.remove(), 300);
    //     }, 3000);
    // }


    <!-- Thêm phần này để kiểm tra URL parameter -->
    document.addEventListener('DOMContentLoaded', function () {
        <c:if test="${empty products}">
        showAlert('Không có sản phẩm nào phù hợp với bộ lọc của bạn', 'warning');
        </c:if>
    });
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy parameters từ URL
        const urlParams = new URLSearchParams(window.location.search);
        const cartSuccess = urlParams.get('cartSuccess');
        const productName = urlParams.get('productName');

        if (cartSuccess === 'true' && productName) {
            showAlert('Đã thêm ' + decodeURIComponent(productName) + ' vào giỏ hàng thành công!', 'success');

            // Xóa parameters khỏi URL (tùy chọn)
            const newUrl = window.location.pathname + window.location.search.replace(/[?&]cartSuccess=true&productName=[^&]*/g, '');
            window.history.replaceState({}, document.title, newUrl);
        }
    });
</script>
<%--<c:if test="${not empty toastMessage}">--%>
<%--    <script>--%>
<%--        showAlert("${toastMessage}", "${toastType}");--%>
<%--    </script>--%>
<%--</c:if>--%>
<%@ include file="/common/footer.jsp" %>
