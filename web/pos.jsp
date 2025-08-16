<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookServlet.Book"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="com.booking.TransactionServlet.Transaction,com.booking.TransactionServlet.TransactionItem"%>
<%@page import="com.booking.BookCategoryServlet.BookCategory"%>
<%@page import="com.booking.BookServlet"%>
<%@page import="com.booking.CustomerServlet"%>
<%@page import="com.booking.BookCategoryServlet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Point of Sale</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #cce7c9;
                margin: 0;
                padding: 0;
            }

            .main-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: linear-gradient(135deg, #3b8132 0%, #46923c 100%);
                color: white;
                padding: 0;
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                text-align: center;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .logo:hover {
                color: #5bb450;
                text-decoration: none;
            }

            .nav-menu {
                padding: 1rem 0;
                flex-grow: 1;
            }

            .nav-item {
                margin: 0.5rem 1rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 0.75rem 1rem;
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background: rgba(255,255,255,0.2);
                color: white;
                border-left: 4px solid #5bb450;
            }

            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.1rem;
                width: 20px;
            }

            .sidebar-footer {
                padding: 1rem 1.5rem;
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
            }

            .logout-btn {
                width: 100%;
                background: #dc3545;
                border: 1px solid #dc3545;
                color: white;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                font-weight: 500;
                box-shadow: 0 2px 4px rgba(220, 53, 69, 0.2);
            }

            .logout-btn:hover {
                background: #c82333;
                border-color: #c82333;
                color: white;
                text-decoration: none;
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }

            /* Bill Modal Styles */
            .bill-container {
                max-width: 100%;
                margin: 0 auto;
                padding: 0;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #dee2e6;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }

            .bill-header h4 {
                color: #3b8132;
                margin-bottom: 10px;
                font-weight: bold;
            }

            .bill-header p {
                margin-bottom: 5px;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .bill-items {
                margin-bottom: 15px;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid #f1f3f4;
                font-size: 0.95rem;
            }

            .bill-item:last-child {
                border-bottom: none;
            }

            .bill-total {
                border-top: 2px solid #dee2e6;
                padding-top: 15px;
                font-weight: bold;
                font-size: 1.1rem;
                color: #3b8132;
            }

            /* Modal specific styles */
            #billModal .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            #billModal .modal-header {
                background: linear-gradient(135deg, #3b8132 0%, #46923c 100%);
                color: white;
                border-bottom: none;
                border-radius: 12px 12px 0 0;
            }

            #billModal .modal-title {
                color: white;
                font-weight: 600;
            }

            #billModal .btn-close-white {
                filter: invert(1);
            }

            /* Enhanced Cart Item Styles */
            .cart-item {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .cart-item-info {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 8px;
            }

            .cart-item-title {
                flex: 1;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 4px;
            }

            .cart-item-details {
                flex: 1;
                font-size: 0.85rem;
            }

            .cart-item-price {
                text-align: right;
                color: #5bb450;
                font-weight: 600;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                background: #f8f9fa;
                padding: 6px 12px;
                border-radius: 6px;
            }

            .quantity-btn {
                background: #46923c;
                color: white;
                border: none;
                border-radius: 4px;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .quantity-btn:hover {
                background: #3b8132;
            }

            .quantity-btn:active {
                transform: scale(0.95);
            }

            /* Order Summary Styles */
            #orderSummary .d-flex {
                border-bottom: 1px solid #f1f3f4;
                padding: 8px 0;
            }

            #orderSummary .d-flex:last-child {
                border-bottom: none;
            }

            #orderSummary .text-start {
                flex: 1;
            }

            #orderSummary .text-end {
                min-width: 80px;
                text-align: right;
            }

            #orderSummary strong {
                color: #2c3e50;
            }

            #orderSummary small {
                font-size: 0.8rem;
                color: #6c757d;
            }

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 0;
                background-color: #cce7c9;
            }

            .header {
                background: white;
                padding: 1rem 2rem;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .menu-toggle {
                display: none;
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #333;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
                color: #666;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                background: linear-gradient(135deg, #46923c 0%, #5bb450 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
            }

            /* POS Container Styles */
            .pos-container {
                display: flex;
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
                height: calc(100vh - 80px);
            }

            .category-section {
                background: white;
                border-radius: 12px;
                padding: 1rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 1rem;
            }

            .main-pos-content {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
                flex: 1;
            }

            .books-section, .cart-section {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
            }

            .section-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #e9ecef;
            }

            /* Category Styles */
            .category-list {
                display: flex;
                flex-direction: row;
                gap: 0.75rem;
                flex-wrap: wrap;
                justify-content: flex-start;
                padding: 0.5rem 0;
            }

            .category-item {
                padding: 0.75rem 1.25rem;
                background: #ffffff;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                color: #6c757d;
                white-space: nowrap;
                min-width: 120px;
                text-align: center;
                position: relative;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                font-size: 0.9rem;
            }

            .category-item:hover {
                background: #f8f9fa;
                border-color: #5bb450;
                color: #5bb450;
                transform: translateY(-2px);
                box-shadow: 0 4px 16px rgba(91, 180, 80, 0.15);
            }

            .category-item.active {
                background: #5bb450;
                color: white;
                border-color: #5bb450;
                transform: translateY(-2px);
                box-shadow: 0 4px 16px rgba(91, 180, 80, 0.25);
                font-weight: 600;
            }

            /* Book Table Styles */
            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
                border-radius: 12px;
                background: #ffffff;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                border: 1px solid #e9ecef;
            }

            .table {
                margin-bottom: 0;
                border: none;
            }

            .table th {
                position: sticky;
                top: 0;
                background: #f8f9fa;
                color: #495057;
                z-index: 10;
                border: none;
                border-bottom: 2px solid #dee2e6;
                padding: 12px 10px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table tbody tr {
                border-bottom: 1px solid #f1f3f4;
                transition: all 0.2s ease;
                background: #ffffff;
            }

            .table tbody tr:nth-child(even) {
                background: #f8f9fa;
            }

            .table tbody tr:hover {
                background: #e8f5e8;
                cursor: pointer;
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(91, 180, 80, 0.1);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table td {
                vertical-align: middle;
                padding: 12px 10px;
                border: none;
                font-size: 0.9rem;
            }

            .table td:nth-child(1) {
                font-weight: 600;
                color: #5bb450;
            }

            .table td:nth-child(2) {
                font-weight: 500;
                color: #2c3e50;
            }

            .table td:nth-child(3) {
                font-weight: 600;
                color: #5bb450;
            }

            .table td:nth-child(4) {
                font-weight: 500;
                color: #6c757d;
            }

            .table td:nth-child(5) {
                font-weight: 500;
                color: #495057;
            }

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.2s ease;
                border: none;
                background: #46923c;
                color: white;
            }

            .btn-sm:hover {
                background: #3b8132;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(70, 146, 60, 0.2);
            }

            /* Cart Styles */
            .cart-items {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 1rem;
                padding: 0.5rem;
            }

            .cart-item {
                background: #ffffff;
                border: 1px solid #e9ecef;
                border-radius: 12px;
                padding: 1rem;
                margin-bottom: 0.75rem;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                position: relative;
                overflow: hidden;
            }

            .cart-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(135deg, #5bb450, #46923c);
                transition: width 0.3s ease;
            }

            .cart-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(91, 180, 80, 0.15);
                border-color: #5bb450;
            }

            .cart-item:hover::before {
                width: 8px;
            }

            .cart-item:last-child {
                margin-bottom: 0;
            }

            .cart-item-info {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 0.75rem;
            }

            .cart-item-details {
                flex: 1;
            }

            .cart-item-title {
                font-weight: 600;
                color: #2c3e50;
                font-size: 0.95rem;
                margin-bottom: 0.25rem;
                line-height: 1.3;
            }

            .cart-item-subtitle {
                font-size: 0.8rem;
                color: #6c757d;
                margin-bottom: 0.5rem;
            }

            .cart-item-price {
                color: #5bb450;
                font-weight: 700;
                font-size: 1rem;
                text-align: right;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                padding: 0.5rem 0.75rem;
                border-radius: 8px;
                border: 1px solid #dee2e6;
            }

            .quantity-label {
                font-size: 0.8rem;
                color: #6c757d;
                font-weight: 500;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .quantity-btn {
                background: #46923c;
                color: white;
                border: none;
                border-radius: 6px;
                width: 28px;
                height: 28px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s ease;
                box-shadow: 0 2px 4px rgba(70, 146, 60, 0.2);
            }

            .quantity-btn:hover {
                background: #3b8132;
                transform: scale(1.1);
                box-shadow: 0 4px 8px rgba(70, 146, 60, 0.3);
            }

            .quantity-btn:active {
                transform: scale(0.95);
            }

            .quantity-display {
                font-weight: 600;
                color: #2c3e50;
                min-width: 20px;
                text-align: center;
            }

            .cart-total {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                border-radius: 12px;
                padding: 1.5rem;
                margin-top: auto;
                border: 2px solid #e9ecef;
                position: relative;
                overflow: hidden;
            }

            .cart-total::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, #5bb450, #46923c, #5bb450);
            }

            .total-label {
                font-size: 0.9rem;
                color: #6c757d;
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .total-amount {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2c3e50;
                text-align: right;
                margin-bottom: 1rem;
            }

            .checkout-btn {
                width: 50%;
                background: linear-gradient(135deg, #46923c, #5bb450);
                color: white;
                border: none;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 1rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(70, 146, 60, 0.3);
            }

            .checkout-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .checkout-btn:hover {
                background: linear-gradient(135deg, #3b8132, #46923c);
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(70, 146, 60, 0.4);
            }

            .checkout-btn:hover::before {
                left: 100%;
            }

            .checkout-btn:active {
                transform: translateY(0);
            }

            .checkout-btn:disabled {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .checkout-btn:disabled::before {
                display: none;
            }

            .clear-btn {
                width: 50%;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                border: none;
                background: linear-gradient(135deg, #dc3545, #c82333);
                color: white;
                font-weight: 600;
                transition: all 0.3s ease;
                font-size: 1rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .clear-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .clear-btn:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
            }

            .clear-btn:hover::before {
                left: 100%;
            }

            .clear-btn:active {
                transform: translateY(0);
            }

            .clear-btn:disabled {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .clear-btn:disabled::before {
                display: none;
            }

            /* Modal Styles */
            .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, #3b8132 0%, #46923c 100%);
                color: white;
                border-radius: 12px 12px 0 0;
                border: none;
            }

            .modal-body {
                padding: 2rem;
            }

            .quantity-input {
                width: 100%;
                padding: 0.75rem;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 1.1rem;
                text-align: center;
            }

            .quantity-input:focus {
                border-color: #5bb450;
                outline: none;
                box-shadow: 0 0 0 3px rgba(91, 180, 80, 0.1);
            }

            /* Customer Selection Styles */
            .customer-search {
                margin-bottom: 1rem;
            }

            .customer-list {
                max-height: 300px;
                overflow-y: auto;
            }

            .customer-item {
                padding: 0.75rem;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                margin-bottom: 0.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .customer-item:hover {
                background: #f8f9fa;
                border-color: #5bb450;
            }

            .customer-item.selected {
                background: #5bb450;
                color: white;
                border-color: #5bb450;
            }

            /* Bill Styles */
            .bill-container {
                background: white;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                max-width: 400px;
                margin: 0 auto;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 1rem;
                margin-bottom: 1rem;
            }

            .bill-items {
                margin-bottom: 1rem;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                border-bottom: 1px solid #f8f9fa;
            }

            .bill-total {
                border-top: 2px solid #e9ecef;
                padding-top: 1rem;
                font-weight: 700;
                font-size: 1.2rem;
            }

            /* Responsive Design */
            @media (max-width: 1200px) {
                .main-pos-content {
                    grid-template-columns: 1fr 1fr;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                }

                .main-pos-content {
                    grid-template-columns: 1fr;
                    grid-template-rows: auto 1fr;
                }

                .category-list {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .category-item {
                    min-width: 200px;
                }

                .menu-toggle {
                    display: block;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            // Check role-based access - POS is for ADMIN, MANAGER, CASHIER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators, managers, and cashiers can access POS.");
                return;
            }
            
            // Load categories
            BookCategoryServlet bookCategoryServlet = new BookCategoryServlet();
            List<BookCategory> categories = bookCategoryServlet.getAllBookCategories();
            request.setAttribute("categories", categories);
            
            // Load all books
            BookServlet bookServlet = new BookServlet();
            List<Book> allBooks = bookServlet.getAllBooks();
            request.setAttribute("allBooks", allBooks);
            
            // Load customers for checkout
            CustomerServlet customerServlet = new CustomerServlet();
            List<Customer> customers = customerServlet.getAllCustomers();
            request.setAttribute("customers", customers);
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "pos");
        %>

        <div class="main-container">
            <!-- Sidebar -->
            <jsp:include page="includes/sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">Point of Sale</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <!-- POS Container -->
                <div class="pos-container">
                    <!-- Book Category Section -->
                    <div class="category-section">
                        <div class="category-list" id="categoryList">
                            <div class="category-item active" onclick="selectCategory(0, 'All Categories')">
                                <i class="bi bi-collection me-2"></i>All Categories
                            </div>
                            <% for (BookCategory category : categories) { %>
                                <div class="category-item" onclick="selectCategory(<%= category.getCategoryId() %>, '<%= category.getCategoryName() %>')">
                                    <i class="bi bi-tag me-2"></i><%= category.getCategoryName() %>
                                </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Main POS Content -->
                    <div class="main-pos-content">
                        <!-- Books Section -->
                        <div class="books-section">
                            <h3 class="section-title">
                                <i class="bi bi-book me-2"></i>Books
                                <span id="categoryTitle" class="ms-2 text-muted">(All Categories)</span>
                            </h3>
                            
                            <div class="table-responsive" id="bookTable">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Price</th>
                                            <th>Stock</th>
                                            <th>Category</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="bookTableBody">
                                        <% 
                                        List<Book> booksList = (List<Book>) request.getAttribute("allBooks");
                                        if (booksList != null && !booksList.isEmpty()) {
                                            for (Book book : booksList) {
                                                // Debug: Log books with invalid data
                                                if (book.getBookId() <= 0 || book.getTitle() == null || book.getPricePerUnit() == null || 
                                                    book.getPricePerUnit().compareTo(java.math.BigDecimal.ZERO) <= 0 || book.getStockQuantity() < 0 || book.getCategory() == null) {
                                                    System.out.println("Book with invalid data found: ID=" + book.getBookId() + 
                                                        ", Title=" + book.getTitle() + 
                                                        ", Price=" + book.getPricePerUnit() + 
                                                        ", Stock=" + book.getStockQuantity() + 
                                                        ", Category=" + (book.getCategory() != null ? book.getCategory().getCategoryName() : "NULL"));
                                                }
                                        %>
                                        <tr data-category-id="<%= book.getCategory() != null ? book.getCategory().getCategoryId() : 0 %>">
                                            <td><%= book.getBookId() > 0 ? book.getBookId() : "N/A" %></td>
                                            <td><%= book.getTitle() != null ? book.getTitle() : "N/A" %></td>
                                            <td><%= book.getPricePerUnit() != null && book.getPricePerUnit().compareTo(java.math.BigDecimal.ZERO) > 0 ? book.getPricePerUnit() : "N/A" %></td>
                                            <td><%= book.getStockQuantity() >= 0 ? book.getStockQuantity() : "N/A" %></td>
                                            <td><%= book.getCategory() != null && book.getCategory().getCategoryName() != null ? book.getCategory().getCategoryName() : "N/A" %></td>
                                            <td>
                                                <% if (book.getBookId() > 0 && book.getTitle() != null && book.getPricePerUnit() != null && book.getPricePerUnit().compareTo(java.math.BigDecimal.ZERO) > 0 && book.getStockQuantity() >= 0 && book.getCategory() != null) { %>
                                                    <button class="btn btn-sm btn-primary" onclick="showQuantityModal({
                                                        id: <%= book.getBookId() %>,
                                                        title: '<%= book.getTitle().replace("'", "\\'") %>',
                                                        price: <%= book.getPricePerUnit() %>,
                                                        stock: <%= book.getStockQuantity() %>,
                                                        category: '<%= book.getCategory().getCategoryName().replace("'", "\\'") %>'
                                                    })">
                                                        Add to Cart
                                                    </button>
                                                <% } else { %>
                                                    <span class="text-muted">Invalid Data</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">
                                                <i class="bi bi-book" style="font-size: 2rem;"></i>
                                                <p>No books found</p>
                                            </td>
                                        </tr>
                                        <%
                                        }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Cart Section -->
                        <div class="cart-section">
                            <h3 class="section-title">
                                <i class="bi bi-cart me-2"></i>Shopping Cart
                            </h3>
                            
                            <div class="cart-items" id="cartItems">
                                <div class="text-center text-muted">
                                    <i class="bi bi-cart" style="font-size: 2rem;"></i>
                                    <p>Cart is empty</p>
                                </div>
                            </div>
                            
                                                    <div class="cart-total">
                            <div class="total-amount">
                                Total: <span id="cartTotal">0.00</span>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="clear-btn" id="clearBtn" disabled onclick="clearCart()">
                                    <i class="bi bi-trash me-2"></i>Clear
                                </button>
                                <button class="checkout-btn" id="checkoutBtn" disabled onclick="showCheckoutModal()">
                                    <i class="bi bi-credit-card me-2"></i>Checkout
                                </button>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quantity Modal -->
        <div class="modal fade" id="quantityModal" tabindex="-1" aria-labelledby="quantityModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="quantityModalLabel">
                            <i class="bi bi-plus-circle me-2"></i>Add to Cart
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <h6 id="bookTitle" class="mb-2"></h6>
                            <p class="text-muted mb-3">Price: <span id="bookPrice"></span></p>
                            <p class="text-muted">Available Stock: <span id="bookStock"></span></p>
                        </div>
                        <div class="mb-3">
                            <label for="quantityInput" class="form-label">Quantity:</label>
                            <input type="number" class="form-control quantity-input" id="quantityInput" min="1" value="1" max="999">
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" onclick="confirmAddToCart()">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Checkout Modal -->
        <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkoutModalLabel">
                            <i class="bi bi-credit-card me-2"></i>Checkout
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="mb-3">Select Customer</h6>
                                <div class="customer-search">
                                    <input type="text" class="form-control" id="customerSearch" placeholder="Search customers...">
                                </div>
                                <div class="customer-list" id="customerList">
                                    <% for (Customer customer : customers) { %>
                                        <div class="customer-item" onclick="selectCustomer(<%= customer.getCustomerId() %>, '<%= customer.getName().replace("'", "\\'") %>')">
                                            <strong><%= customer.getName() %></strong><br>
                                            <small class="text-muted">Account: <%= customer.getAccountNumber() %></small>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-3">Order Summary</h6>
                                <div id="orderSummary">
                                    <!-- Order summary will be populated here -->
                                </div>
                                <div class="mt-3">
                                    <strong>Total: $<span id="modalTotal">0.00</span></strong>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" id="confirmCheckoutBtn" disabled onclick="processTransaction()">
                                <i class="bi bi-check-circle me-2"></i>Confirm Transaction
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bill Modal -->
        <div class="modal fade" id="billModal" tabindex="-1" aria-labelledby="billModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="billModalLabel">
                            <i class="bi bi-receipt me-2"></i>Transaction Receipt
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="bill-container" id="billContent">
                            <!-- Bill content will be populated here -->
                        </div>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-primary me-2" onclick="printBill()">
                                <i class="bi bi-printer me-2"></i>Print Bill
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Global variables
            let cart = [];
            let selectedCategoryId = 0;
            let selectedCategoryName = 'All Categories';
            let selectedCustomer = null;
            let currentBook = null;
            let transactionId = null;

            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                        sidebar.classList.remove('show');
                    }
                }
            });

            // Select category
            function selectCategory(categoryId, categoryName) {
                selectedCategoryId = categoryId;
                selectedCategoryName = categoryName;
                
                // Update active category
                document.querySelectorAll('.category-item').forEach(item => {
                    item.classList.remove('active');
                });
                event.target.closest('.category-item').classList.add('active');
                
                // Update category title
                document.getElementById('categoryTitle').textContent = `(${categoryName})`;
                
                // Filter books by category
                filterBooksByCategory(categoryId);
            }

            // Filter books by category
            function filterBooksByCategory(categoryId) {
                const bookRows = document.querySelectorAll('#bookTableBody tr');
                
                bookRows.forEach(row => {
                    if (categoryId === 0) {
                        // Show all books
                        row.style.display = '';
                    } else {
                        // Show only books from selected category
                        const rowCategoryId = parseInt(row.getAttribute('data-category-id'));
                        row.style.display = rowCategoryId === categoryId ? '' : 'none';
                    }
                });
                
                // Check if any books are visible
                const visibleRows = document.querySelectorAll('#bookTableBody tr:not([style*="display: none"])');
                if (visibleRows.length === 0) {
                    // Show "no books" message
                    const noBooksRow = document.createElement('tr');
                    noBooksRow.innerHTML = `
                        <td colspan="6" class="text-center text-muted">
                            <i class="bi bi-book" style="font-size: 2rem;"></i>
                            <p>No books found in this category</p>
                        </td>
                    `;
                    document.getElementById('bookTableBody').appendChild(noBooksRow);
                }
            }

            // Show quantity modal
            function showQuantityModal(book) {
                console.log('showQuantityModal called with book:', book);
                console.log('Book properties:', {
                    id: book?.id,
                    title: book?.title,
                    price: book?.price,
                    stock: book?.stock,
                    category: book?.category
                });
                
                // Comprehensive validation
                if (!book) {
                    console.error('Book object is null or undefined');
                    alert('Error: Invalid book data. Please try again.');
                    return;
                }
                
                if (!book.id || book.id <= 0) {
                    console.error('Invalid book ID:', book.id);
                    alert('Error: Invalid book ID. Please try again.');
                    return;
                }
                
                if (!book.title || book.title.trim() === '') {
                    console.error('Invalid book title:', book.title);
                    alert('Error: Invalid book title. Please try again.');
                    return;
                }
                
                if (book.price === null || book.price === undefined || book.price <= 0) {
                    console.error('Invalid book price:', book.price);
                    alert('Error: Invalid book price. Please try again.');
                    return;
                }
                
                if (book.stock === null || book.stock === undefined || book.stock <= 0) {
                    console.error('Invalid book stock:', book.stock);
                    alert('Error: This book is out of stock or has invalid stock data.');
                    return;
                }
                
                // All validation passed
                currentBook = book;
                document.getElementById('bookTitle').textContent = book.title;
                document.getElementById('bookPrice').textContent = book.price.toFixed(2);
                document.getElementById('bookStock').textContent = book.stock;
                document.getElementById('quantityInput').value = 1;
                document.getElementById('quantityInput').max = book.stock;
                
                const modal = new bootstrap.Modal(document.getElementById('quantityModal'));
                modal.show();
            }

            // Confirm add to cart
            function confirmAddToCart() {
                // Validate currentBook
                if (!currentBook || !currentBook.stock) {
                    console.error('Invalid currentBook:', currentBook);
                    alert('Error: Invalid book data. Please try again.');
                    return;
                }
                
                const quantity = parseInt(document.getElementById('quantityInput').value);
                const stock = currentBook.stock;
                
                if (quantity < 1) {
                    alert('Quantity must be at least 1');
                    return;
                }
                
                if (quantity > stock) {
                    alert('Quantity cannot exceed available stock');
                    return;
                }
                
                const existingItem = cart.find(item => item.id === currentBook.id);
                
                if (existingItem) {
                    const newTotal = existingItem.quantity + quantity;
                    if (newTotal > stock) {
                        alert('Total quantity cannot exceed available stock');
                        return;
                    }
                    existingItem.quantity += quantity;
                } else {
                    cart.push({
                        id: currentBook.id,
                        title: currentBook.title,
                        price: currentBook.price,
                        quantity: quantity,
                        stock: currentBook.stock
                    });
                }
                
                updateCartDisplay();
                
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('quantityModal'));
                modal.hide();
                
                // Show success message
                showToast('Item added to cart successfully!', 'success');
            }

            // Update cart display
            function updateCartDisplay() {
                const cartItems = document.getElementById('cartItems');
                const cartTotal = document.getElementById('cartTotal');
                const checkoutBtn = document.getElementById('checkoutBtn');
                const clearBtn = document.getElementById('clearBtn');
                
                if (cart.length === 0) {
                    cartItems.innerHTML = `
                        <div class="text-center text-muted">
                            <i class="bi bi-cart" style="font-size: 2rem;"></i>
                            <p>Cart is empty</p>
                        </div>
                    `;
                    checkoutBtn.disabled = true;
                    clearBtn.disabled = true;
                } else {
                    cartItems.innerHTML = '';
                    let total = 0;
                    
                                            cart.forEach(item => {
                            const itemTotal = item.price * item.quantity;
                            total += itemTotal;
                            
                            const cartItem = document.createElement('div');
                            cartItem.className = 'cart-item';
                            cartItem.innerHTML = '<div class="cart-item-info">' +
                                '<div class="cart-item-details">' +
                                '<div class="cart-item-title">' + item.title + '</div>' +
                                '<div class="cart-item-subtitle">ID: ' + item.id + ' • Price: $' + item.price.toFixed(2) + '</div>' +
                                '</div>' +
                                '<div class="cart-item-price">$' + itemTotal.toFixed(2) + '</div>' +
                                '</div>' +
                                '<div class="cart-item-quantity">' +
                                '<div class="quantity-label">Quantity:</div>' +
                                '<div class="quantity-controls">' +
                                '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', -1)">−</button>' +
                                '<span class="quantity-display">' + item.quantity + '</span>' +
                                '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', 1)">+</button>' +
                                '</div>' +
                                '</div>';
                            
                            cartItems.appendChild(cartItem);
                        });
                    
                    cartTotal.textContent = total.toFixed(2);
                    checkoutBtn.disabled = false;
                    clearBtn.disabled = false;
                }
            }

            // Update quantity
            function updateQuantity(productId, change) {
                const item = cart.find(item => item.id === productId);
                
                if (item) {
                    const newQuantity = item.quantity + change;
                    
                    if (newQuantity <= 0) {
                        cart = cart.filter(item => item.id !== productId);
                    } else if (newQuantity > item.stock) {
                        alert('Quantity cannot exceed available stock');
                        return;
                    } else {
                        item.quantity = newQuantity;
                    }
                    
                    updateCartDisplay();
                }
            }

            // Clear cart
            function clearCart() {
                if (cart.length === 0) {
                    showToast('Cart is already empty!', 'warning');
                    return;
                }
                
                // Clear the cart array immediately
                cart = [];
                
                // Update the cart display
                updateCartDisplay();
                
                // Show success message
                showToast('Cart cleared successfully!', 'success');
                
                // Reset total to 0.00
                document.getElementById('cartTotal').textContent = '0.00';
            }

            // Reset checkout modal state
            function resetCheckoutModal() {
                selectedCustomer = null;
                document.getElementById('confirmCheckoutBtn').disabled = true;
                document.getElementById('modalTotal').textContent = '0.00';
                document.getElementById('orderSummary').innerHTML = '';
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
            }

            // Show checkout modal
            function showCheckoutModal() {
                if (cart.length === 0) {
                    alert('Cart is empty!');
                    return;
                }
                
                // Reset checkout modal state
                resetCheckoutModal();
                
                // Update order summary
                updateOrderSummary();
                
                const modal = new bootstrap.Modal(document.getElementById('checkoutModal'));
                modal.show();
            }

            // Select customer
            function selectCustomer(customerId, customerName) {
                selectedCustomer = { id: customerId, name: customerName };
                
                // Update UI
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
                event.target.closest('.customer-item').classList.add('selected');
                
                document.getElementById('confirmCheckoutBtn').disabled = false;
            }

            // Update order summary
            function updateOrderSummary() {
                const orderSummary = document.getElementById('orderSummary');
                const modalTotal = document.getElementById('modalTotal');
                let total = 0;
                
                let summaryHTML = '';
                cart.forEach(item => {
                    const itemTotal = item.price * item.quantity;
                    total += itemTotal;
                    
                    summaryHTML += '<div class="d-flex justify-content-between mb-2">' +
                        '<div class="text-start">' +
                        '<div><strong>' + item.title + '</strong></div>' +
                        '<small class="text-muted">ID: ' + item.id + ' | Price: ' + item.price.toFixed(2) + ' x ' + item.quantity + '</small>' +
                        '</div>' +
                        '<div class="text-end">' +
                        '<strong>' + itemTotal.toFixed(2) + '</strong>' +
                        '</div>' +
                        '</div>';
                });
                
                orderSummary.innerHTML = summaryHTML;
                modalTotal.textContent = total.toFixed(2);
            }

            // Process transaction
            function processTransaction() {
                if (!selectedCustomer) {
                    alert('Please select a customer');
                    return;
                }
                
                if (cart.length === 0) {
                    alert('Cart is empty');
                    return;
                }
                
                // Calculate total amount from cart
                let totalAmount = 0;
                cart.forEach(item => {
                    totalAmount += item.price * item.quantity;
                });
                
                // Prepare transaction data
                const transactionData = {
                    customerId: selectedCustomer.id,
                    items: cart.map(item => ({
                        bookId: item.id,
                        quantity: item.quantity,
                        price: item.price
                    })),
                    totalAmount: totalAmount
                };
                
                // Debug: Log the transaction data
                console.log('Transaction data:', transactionData);
                console.log('JSON string:', JSON.stringify(transactionData));
                
                // Send transaction to server
                fetch('TransactionServlet?action=create', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(transactionData)
                })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);
                    if (data.success) {
                        transactionId = data.transactionId;
                        showBill(data.transaction);
                        
                        // Clear cart
                        cart = [];
                        updateCartDisplay();
                        
                        // Reset modal total and clear order summary
                        document.getElementById('modalTotal').textContent = '0.00';
                        document.getElementById('orderSummary').innerHTML = '';
                        
                        // Close checkout modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('checkoutModal'));
                        modal.hide();
                        
                        // Reset checkout modal state
                        resetCheckoutModal();
                        
                        showToast('Transaction completed successfully!', 'success');
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    console.error('Error details:', error.message);
                    alert('An error occurred while processing the transaction');
                });
            }

            // Show bill
            function showBill(transaction) {
                console.log('showBill called with transaction:', transaction);
                const billContent = document.getElementById('billContent');
                const billModal = document.getElementById('billModal');
                
                console.log('billContent element:', billContent);
                console.log('billModal element:', billModal);
                
                const currentDate = new Date().toLocaleDateString();
                const currentTime = new Date().toLocaleTimeString();
                
                let itemsHTML = '';
                let total = 0;
                
                // Check if transaction and items exist
                if (!transaction) {
                    console.error('Transaction is null or undefined');
                    return;
                }
                
                if (!transaction.items || !Array.isArray(transaction.items)) {
                    console.error('Transaction items is null, undefined, or not an array:', transaction.items);
                    return;
                }
                
                console.log('Transaction items:', transaction.items);
                
                transaction.items.forEach(item => {
                    console.log('Processing item:', item);
                    if (!item || !item.title || !item.quantity || !item.price) {
                        console.error('Invalid item data:', item);
                        return;
                    }
                    const itemTotal = item.price * item.quantity;
                    total += itemTotal;
                    
                    itemsHTML += '<div class="bill-item">' +
                                            '<span>' + item.title + ' x' + item.quantity + '</span>' +
                    '<span>' + itemTotal.toFixed(2) + '</span>' +
                        '</div>';
                });
                
                const billHTML = '<div class="bill-header">' +
                    '<h4>Pahana Edu Bookshop</h4>' +
                    '<p class="mb-1">Transaction Receipt</p>' +
                    '<p class="mb-1">Date: ' + currentDate + '</p>' +
                    '<p class="mb-1">Time: ' + currentTime + '</p>' +
                    '<p class="mb-1">Transaction ID: ' + (transaction.transactionId || 'N/A') + '</p>' +
                    '<p class="mb-1">Customer: ' + (transaction.customerName || 'N/A') + '</p>' +
                    '</div>' +
                    '<div class="bill-items">' +
                    (itemsHTML || '<div class="text-center text-muted">No items to display</div>') +
                    '</div>' +
                    '<div class="bill-total d-flex justify-content-between">' +
                    '<span>Total:</span>' +
                    '<span>' + total.toFixed(2) + '</span>' +
                    '</div>' +
                    '<div class="text-center mt-3">' +
                    '<p class="text-muted">Thank you for your purchase!</p>' +
                    '</div>';
                
                console.log('Generated bill HTML:', billHTML);
                billContent.innerHTML = billHTML;
                
                const modal = new bootstrap.Modal(document.getElementById('billModal'));
                console.log('Showing bill modal');
                modal.show();
                console.log('Bill modal should be visible now');
            }

            // Print bill
            function printBill() {
                const billContent = document.getElementById('billContent').innerHTML;
                const printWindow = window.open('', '_blank');
                printWindow.document.write(
                    '<html>' +
                    '<head>' +
                    '<title>Transaction Receipt</title>' +
                    '<style>' +
                    'body { font-family: Arial, sans-serif; margin: 20px; }' +
                    '.bill-container { max-width: 400px; margin: 0 auto; }' +
                    '.bill-header { text-align: center; border-bottom: 2px solid #ccc; padding-bottom: 10px; margin-bottom: 10px; }' +
                    '.bill-item { display: flex; justify-content: space-between; padding: 5px 0; border-bottom: 1px solid #eee; }' +
                    '.bill-total { border-top: 2px solid #ccc; padding-top: 10px; font-weight: bold; font-size: 1.2em; }' +
                    '@media print { body { margin: 0; } }' +
                    '</style>' +
                    '</head>' +
                    '<body>' +
                    '<div class="bill-container">' +
                    billContent +
                    '</div>' +
                    '</body>' +
                    '</html>'
                );
                printWindow.document.close();
                printWindow.print();
            }

            // Show toast notification
            function showToast(message, type = 'info') {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
                toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                toast.innerHTML = message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                
                document.body.appendChild(toast);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 3000);
            }

            // Customer search functionality
            document.getElementById('customerSearch').addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const customerItems = document.querySelectorAll('.customer-item');
                
                customerItems.forEach(item => {
                    const customerName = item.querySelector('strong').textContent.toLowerCase();
                    const accountNumber = item.querySelector('small').textContent.toLowerCase();
                    
                    if (customerName.includes(searchTerm) || accountNumber.includes(searchTerm)) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });

            // Initialize POS
            document.addEventListener('DOMContentLoaded', function() {
                console.log('POS initialized with enhanced functionality');
                
                // Debug: Check loaded data
                const bookRows = document.querySelectorAll('#bookTableBody tr');
                console.log('Total book rows found:', bookRows.length);
                
                bookRows.forEach((row, index) => {
                    const categoryId = row.getAttribute('data-category-id');
                    const title = row.querySelector('td:nth-child(2)')?.textContent;
                    const price = row.querySelector('td:nth-child(3)')?.textContent;
                    const stock = row.querySelector('td:nth-child(4)')?.textContent;
                    const category = row.querySelector('td:nth-child(5)')?.textContent;
                    
                    console.log(`Row ${index + 1}:`, {
                        categoryId,
                        title,
                        price,
                        stock,
                        category
                    });
                });
            });
        </script>
    </body>
</html> 