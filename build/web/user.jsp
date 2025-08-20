<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.UserServlet.User,com.booking.UserServlet.UserRole"%>
<%@page import="com.booking.UserServlet"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - User Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #3b8132;
                --secondary-color: #46923c;
                --accent-color: #5bb450;
                --light-bg: #cce7c9;
                --white: #ffffff;
                --dark-text: #2c3e50;
                --light-text: #7f8c8d;
                --border-color: #e9ecef;
                --shadow: 0 8px 32px rgba(59, 129, 50, 0.1);
                --shadow-hover: 0 12px 40px rgba(59, 129, 50, 0.15);
                --success-color: #28a745;
                --info-color: #17a2b8;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, var(--light-bg) 0%, #e8f5e8 100%);
                color: var(--dark-text);
                line-height: 1.6;
                overflow-x: hidden;
            }

            .main-container {
                display: flex;
                min-height: 100vh;
                position: relative;
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

            .nav-link::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
                transition: left 0.5s;
            }

            .nav-link:hover::before {
                left: 100%;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.15);
                color: var(--white);
                text-decoration: none;
                transform: translateX(5px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            }

            .nav-link.active {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                color: var(--white);
                box-shadow: 0 4px 15px rgba(91, 180, 80, 0.4);
                transform: translateX(5px);
            }

            .nav-link i {
                margin-right: 1rem;
                font-size: 1.2rem;
                width: 24px;
                text-align: center;
            }

            /* Sidebar Footer Styles */
            .sidebar-footer {
                padding: 1.5rem;
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
                background: rgba(0,0,0,0.1);
            }

            .logout-btn {
                width: 100%;
                background: linear-gradient(135deg, #dc3545, #c82333);
                border: none;
                color: var(--white);
                padding: 1rem 1.25rem;
                border-radius: 12px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .logout-btn:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
                color: var(--white);
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            }

            /* Main Content Area */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 2rem;
                position: relative;
            }

            .header {
                background: var(--white);
                border-radius: 20px;
                padding: 1.5rem 2rem;
                margin-bottom: 2rem;
                box-shadow: var(--shadow);
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                overflow: hidden;
            }

            .header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-color));
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .menu-toggle {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                border: none;
                color: var(--white);
                padding: 0.75rem;
                border-radius: 12px;
                font-size: 1.2rem;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(70, 146, 60, 0.3);
            }

            .menu-toggle:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(70, 146, 60, 0.4);
            }

            .page-title {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--dark-text);
                margin: 0;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
                background: linear-gradient(135deg, var(--light-bg), #e8f5e8);
                padding: 0.75rem 1.5rem;
                border-radius: 15px;
                border: 2px solid rgba(91, 180, 80, 0.2);
            }

            .user-avatar {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--white);
                font-weight: 600;
                font-size: 1.2rem;
                box-shadow: 0 4px 15px rgba(91, 180, 80, 0.3);
            }

            .user-details {
                display: flex;
                flex-direction: column;
            }

            .user-name {
                font-weight: 600;
                color: var(--dark-text);
                font-size: 0.95rem;
            }

            .user-role {
                font-size: 0.85rem;
                color: var(--light-text);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Modern Content Card Styles */
            .content-card {
                background: var(--white);
                border-radius: 20px;
                box-shadow: var(--shadow);
                padding: 2rem;
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            .content-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            }

            .content-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-hover);
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid rgba(91, 180, 80, 0.1);
                color: var(--dark-text);
                flex-wrap: wrap;
                gap: 1rem;
            }

            .card-title span {
                font-size: 1.5rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .card-title i {
                color: var(--secondary-color);
                font-size: 1.6rem;
            }

            /* Modern Button Styles */
            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: none;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                color: var(--white);
                box-shadow: 0 4px 15px rgba(70, 146, 60, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(70, 146, 60, 0.4);
                text-decoration: none;
            }

            .btn-secondary {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
            }

            .btn-secondary:hover {
                background: linear-gradient(135deg, #5a6268, #495057);
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
                text-decoration: none;
            }

            .btn-danger {
                background: linear-gradient(135deg, var(--danger-color), #c82333);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
                text-decoration: none;
            }

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }

            .btn-edit {
                background: linear-gradient(135deg, var(--warning-color), #fd7e14);
                color: var(--dark-text);
                box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
            }

            .btn-edit:hover {
                background: linear-gradient(135deg, #fd7e14, #e55a00);
                color: var(--white);
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(255, 193, 7, 0.4);
            }

            .btn-delete {
                background: linear-gradient(135deg, var(--danger-color), #c82333);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .btn-delete:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
                color: var(--white);
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            }

            /* Modern Form Styles */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: var(--dark-text);
                margin-bottom: 0.75rem;
                display: block;
                font-size: 0.95rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-control {
                border: 2px solid var(--border-color);
                border-radius: 12px;
                padding: 1rem 1.25rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: var(--white);
                color: var(--dark-text);
            }

            .form-control:focus {
                border-color: var(--secondary-color);
                box-shadow: 0 0 0 0.2rem rgba(70, 146, 60, 0.25);
                outline: none;
                transform: translateY(-1px);
            }

            .form-control.is-invalid {
                border-color: var(--danger-color);
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            }

            .invalid-feedback {
                color: var(--danger-color);
                font-size: 0.875rem;
                margin-top: 0.5rem;
                font-weight: 500;
            }

            /* Simple Table Styles */
            .table-responsive {
                border-radius: 8px;
                overflow: hidden;
                border: 1px solid #e0e0e0;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            .table {
                margin-bottom: 0;
                background: var(--white);
            }

            .table thead th {
                background: #e9ecef;
                color: #2c3e50;
                border: none;
                padding: 0.75rem 1rem;
                font-weight: 700;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-bottom: 2px solid #dee2e6;
            }

            .table tbody tr {
                border-bottom: 1px solid #f1f3f4;
                transition: background-color 0.2s ease;
                background: var(--white);
            }

            .table tbody tr:nth-child(even) {
                background: #f8f9fa;
            }

            .table tbody tr:hover {
                background: #e9ecef;
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 0.75rem 1rem;
                border: none;
                vertical-align: middle;
                font-size: 0.9rem;
                color: #495057;
            }

            .table tbody td:first-child {
                font-weight: 600;
                color: #007bff;
                font-size: 0.9rem;
            }

            /* Role Badge Styles */
            .role-badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .role-admin {
                background: linear-gradient(135deg, var(--danger-color), #c82333);
                color: var(--white);
            }

            .role-manager {
                background: linear-gradient(135deg, var(--warning-color), #fd7e14);
                color: var(--dark-text);
            }

            .role-cashier {
                background: linear-gradient(135deg, var(--info-color), #20c997);
                color: var(--white);
            }

            .role-customer {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                color: var(--white);
            }

            /* Modern Alert Styles */
            .alert {
                border-radius: 15px;
                border: none;
                padding: 1.25rem 1.5rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
                border-left: 4px solid var(--success-color);
            }

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                color: #721c24;
                border-left: 4px solid var(--danger-color);
            }

            /* Custom Popup Styles */
            .custom-popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                backdrop-filter: blur(5px);
            }

            .custom-popup {
                background: var(--white);
                border-radius: 20px;
                box-shadow: var(--shadow-hover);
                width: 90%;
                max-width: 400px;
                animation: popupFadeIn 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .custom-popup::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            }

            @keyframes popupFadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.8);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            .custom-popup-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem 2rem;
                border-bottom: 2px solid rgba(91, 180, 80, 0.1);
            }

            .custom-popup-header h5 {
                margin: 0;
                color: var(--dark-text);
                font-weight: 700;
                font-size: 1.2rem;
            }

            .custom-popup-header .btn-close {
                background: linear-gradient(135deg, var(--danger-color), #c82333);
                border: none;
                color: var(--white);
                padding: 0.5rem;
                border-radius: 50%;
                cursor: pointer;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                transition: all 0.3s ease;
            }

            .custom-popup-header .btn-close:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .custom-popup-body {
                padding: 2rem;
            }

            .custom-popup-body p {
                margin: 0;
                color: var(--light-text);
                font-size: 1rem;
                line-height: 1.6;
            }

            .custom-popup-footer {
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
                padding: 1.5rem 2rem;
                border-top: 2px solid rgba(91, 180, 80, 0.1);
            }

            .custom-popup-footer .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            /* Utility Classes */
            .text-muted {
                color: var(--light-text) !important;
            }

            .text-center {
                text-align: center !important;
            }

            .text-end {
                text-align: right !important;
            }

            .me-2 {
                margin-right: 0.5rem !important;
            }

            .mb-0 {
                margin-bottom: 0 !important;
            }

            .h3 {
                font-size: 1.75rem;
                font-weight: 700;
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                margin-right: -0.75rem;
                margin-left: -0.75rem;
            }

            .col-md-6 {
                flex: 0 0 50%;
                max-width: 50%;
                padding-right: 0.75rem;
                padding-left: 0.75rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                    padding: 1rem;
                }

                .header {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }

                .card-title {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }

                .user-info {
                    flex-direction: column;
                    text-align: center;
                }

                .col-md-6 {
                    flex: 0 0 100%;
                    max-width: 100%;
                }

                .custom-popup {
                    width: 95%;
                    margin: 1rem;
                }

                .custom-popup-footer {
                    flex-direction: column;
                }
            }

            /* Loading Animation */
            .loading {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 3px solid rgba(91, 180, 80, 0.3);
                border-radius: 50%;
                border-top-color: var(--accent-color);
                animation: spin 1s ease-in-out infinite;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            /* Scrollbar Styling */
            ::-webkit-scrollbar {
                width: 8px;
            }

            ::-webkit-scrollbar-track {
                background: rgba(0,0,0,0.1);
                border-radius: 4px;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                border-radius: 4px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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
            
            // Check role-based access - User management is for ADMIN, MANAGER, CASHIER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators, managers, and cashiers can access user management.");
                return;
            }
        %>

        <%
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "user");
        %>

        <div class="main-container">
            <!-- Sidebar -->
            <jsp:include page="includes/sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="page-title">User Management</h1>
                    </div>
                    <div class="user-info">
                        <div class="user-details">
                            <span class="user-name"><%= username %></span>
                            <span class="user-role"><%= role %></span>
                        </div>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <% 
                    String message = (String) request.getAttribute("message");
                    if (message == null) {
                        message = request.getParameter("message");
                    }
                    String error = (String) request.getAttribute("error");
                    if (error == null) {
                        error = request.getParameter("error");
                    }
                %>
                
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success">
                        <i class="bi bi-check-circle"></i> <%= message %>
                    </div>
                <% } %>
                
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle"></i> <%= error %>
                    </div>
                <% } %>

                <!-- Add User Form -->
                <% if (!"CASHIER".equals(role)) { %>
                <div class="content-card" style="background: white; border: 1px solid #e9ecef; color: #2c3e50;">
                    <div class="card-title" style="color: #2c3e50; text-align: center; margin-bottom: 2rem;">
                        <span><i class="bi bi-person-plus-fill me-2" style="color: #46923c;"></i>Create New User Account</span>
                    </div>
                    
                    <form action="UserServlet" method="post" style="max-width: 900px; margin: 0 auto;">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <!-- Account Information Section - Left Side -->
                            <div class="col-md-6">
                                <div class="form-section" style="background: rgba(91, 180, 80, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 1.5rem; border: 1px solid rgba(91, 180, 80, 0.2);">
                                    <h5 style="color: #2c3e50; margin-bottom: 1rem; text-align: center; font-weight: 600;">
                                        <i class="bi bi-shield-lock me-2" style="color: #46923c;"></i>Account Details
                                    </h5>
                                    
                                    <div class="form-group" style="margin-bottom: 1rem;">
                                        <label for="username" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.5rem;">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" required 
                                               style="background: white; border: 1px solid #e9ecef; border-radius: 10px; padding: 0.75rem;">
                                    </div>
                                    
                                    <div class="form-group" style="margin-bottom: 1rem;">
                                        <label for="email" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.5rem;">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email" required 
                                               style="background: white; border: 1px solid #e9ecef; border-radius: 10px; padding: 0.75rem;">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="password" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.5rem;">Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="password" name="password" required 
                                                   style="background: white; border: 1px solid #e9ecef; border-radius: 10px 0 0 10px; padding: 0.75rem;">
                                            <button class="btn" type="button" onclick="togglePassword('password')"
                                                    style="background: #6c757d; border: none; border-radius: 0 10px 10px 0; color: white; padding: 0.75rem 1rem;">
                                                <i class="bi bi-eye" id="passwordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Role Assignment Section - Right Side -->
                            <div class="col-md-6">
                                <div class="form-section" style="background: rgba(91, 180, 80, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 1.5rem; border: 1px solid rgba(91, 180, 80, 0.2);">
                                    <h5 style="color: #2c3e50; margin-bottom: 1rem; text-align: center; font-weight: 600;">
                                        <i class="bi bi-person-badge me-2" style="color: #46923c;"></i>Role Assignment
                                    </h5>
                                    
                                    <div class="form-group">
                                        <label for="role_id" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.5rem;">User Role</label>
                                        <select class="form-control" id="role_id" name="role_id" required 
                                                style="background: white; border: 1px solid #e9ecef; border-radius: 10px; padding: 0.75rem;">
                                            <option value="">Select Role</option>
                                            <!-- Note: ADMIN can only create system users (ADMIN, MANAGER, CASHIER). CUSTOMER accounts are created through customer registration. -->
                                            <%
                                                List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                                if (userRoles != null) {
                                                    for (UserRole userRole : userRoles) {
                                                        // Role-based filtering - ADMIN can only create system users (ADMIN, MANAGER, CASHIER)
                                                        boolean canCreate = false;
                                                        if ("ADMIN".equals(role)) {
                                                            // Admin can only create ADMIN, MANAGER, CASHIER (system users)
                                                            canCreate = !"CUSTOMER".equals(userRole.getRoleName());
                                                        } else if ("MANAGER".equals(role)) {
                                                            canCreate = "CASHIER".equals(userRole.getRoleName());
                                                        } else if ("CASHIER".equals(role)) {
                                                            canCreate = "CUSTOMER".equals(userRole.getRoleName());
                                                        }
                                                        
                                                        if (canCreate) {
                                            %>
                                            <option value="<%= userRole.getRoleId() %>"><%= userRole.getRoleName() %></option>
                                            <%
                                                        }
                                                    }
                                                }
                                            %>
                                        </select>
                                        <small style="color: #6c757d; font-size: 0.8rem; margin-top: 0.5rem; display: block;">
                                            <i class="bi bi-info-circle me-1" style="color: #46923c;"></i>
                                            Select the appropriate role for this user account
                                        </small>
                                    </div>
                                    
                                    <!-- Role Information Display -->
                                    <div class="role-info" style="background: white; border-radius: 10px; padding: 1rem; margin-top: 1rem; border: 1px solid #e9ecef;">
                                        <h6 style="color: #2c3e50; font-weight: 600; margin-bottom: 0.5rem;">
                                            <i class="bi bi-lightbulb me-2" style="color: #46923c;"></i>Role Permissions
                                        </h6>
                                        <div style="color: #2c3e50; font-size: 0.85rem;">
                                            <div style="margin-bottom: 0.5rem;">
                                                <strong style="color: #dc3545;">ADMIN:</strong> Full system access and user management
                                            </div>
                                            <div style="margin-bottom: 0.5rem;">
                                                <strong style="color: #ffc107;">MANAGER:</strong> Book and stock management, reports
                                            </div>
                                            <div style="margin-bottom: 0.5rem;">
                                                <strong style="color: #17a2b8;">CASHIER:</strong> Sales transactions and customer service
                                            </div>
                                            <div>
                                                <strong style="color: #6c757d;">CUSTOMER:</strong> Book browsing and purchasing
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div style="text-align: center;">
                            <button type="submit" class="btn btn-outline-success btn-sm" 
                                    style="border: 2px solid #28a745; color: #28a745; background: transparent; padding: 0.5rem 1.5rem; border-radius: 15px; font-weight: 600; font-size: 0.9rem;">
                                <i class="bi bi-person-plus-fill me-2"></i>Create User Account
                            </button>
                        </div>
                    </form>
                </div>
                <% } %>

                <!-- User List -->
                <div class="content-card">
                    <div class="card-title">
                        <span>
                            <i class="bi bi-people"></i>
                            User List
                        </span>
                        <div>
                            <a href="UserServlet?action=list" class="btn btn-primary">
                                <i class="bi bi-arrow-clockwise" style="color: white;"></i> Refresh
                            </a>
                        </div>
                    </div>
                    
                    <%
                        // Auto-load user data if not already loaded
                        if (request.getAttribute("users") == null) {
                            // Load users directly instead of redirecting to servlet
                            try {
                                UserServlet userServlet = new UserServlet();
                                
                                // Test database connection first
                                boolean connectionOk = userServlet.testDatabaseConnection();
                                System.out.println("Database connection test: " + (connectionOk ? "PASSED" : "FAILED"));
                                
                                if (connectionOk) {
                                    List<User> users = userServlet.getAllUsers();
                                    System.out.println("Loaded " + (users != null ? users.size() : 0) + " users");
                                    if (users != null && !users.isEmpty()) {
                                        for (User user : users) {
                                            System.out.println("User: " + user.getUsername() + ", Role: " + 
                                                (user.getRole() != null ? user.getRole().getRoleName() : "NULL"));
                                        }
                                    }
                                    request.setAttribute("users", users);
                                } else {
                                    System.err.println("Cannot load users - database connection failed");
                                }
                            } catch (Exception e) {
                                System.err.println("Error loading users: " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                    %>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Created At</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<User> users = (List<User>) request.getAttribute("users");
                                    if (users != null && !users.isEmpty()) {
                                        for (User user : users) {
                                            String roleClass = "";
                                            switch (user.getRole().getRoleName()) {
                                                case "ADMIN":
                                                    roleClass = "role-admin";
                                                    break;
                                                case "MANAGER":
                                                    roleClass = "role-manager";
                                                    break;
                                                case "CASHIER":
                                                    roleClass = "role-cashier";
                                                    break;
                                                case "CUSTOMER":
                                                    roleClass = "role-customer";
                                                    break;
                                            }
                                %>
                                <tr>
                                    <td><%= user.getUserId() %></td>
                                    <td><%= user.getUsername() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><span class="role-badge <%= roleClass %>"><%= user.getRole().getRoleName() %></span></td>
                                    <td><%= user.getCreatedAt() != null ? user.getCreatedAt().toString() : "N/A" %></td>
                                    <td>
                                        <% if (!"CASHIER".equals(user.getRole().getRoleName())) { %>
                                        <button class="btn btn-edit btn-sm" data-user-id="<%= user.getUserId() %>" data-action="edit">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-delete btn-sm" data-user-id="<%= user.getUserId() %>" data-action="delete">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center">No users found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
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

            // User management functions
            function editUser(userId) {
                // Navigate to edit page
                window.location.href = 'UserServlet?action=view&user_id=' + userId;
            }

            function deleteUser(userId) {
                // Create custom popup
                const popup = document.createElement('div');
                popup.className = 'custom-popup-overlay';
                popup.innerHTML = 
                    '<div class="custom-popup">' +
                        '<div class="custom-popup-header">' +
                            '<h5>Confirm Delete</h5>' +
                            '<button type="button" class="btn-close" onclick="closePopup()">&times;</button>' +
                        '</div>' +
                        '<div class="custom-popup-body">' +
                            '<p>Are you sure you want to delete this user?</p>' +
                        '</div>' +
                        '<div class="custom-popup-footer">' +
                            '<button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>' +
                            '<button type="button" class="btn btn-danger" onclick="confirmDelete(' + userId + ')">Delete</button>' +
                        '</div>' +
                    '</div>';
                document.body.appendChild(popup);
            }

            function closePopup() {
                const popup = document.querySelector('.custom-popup-overlay');
                if (popup) {
                    popup.remove();
                }
            }

            function confirmDelete(userId) {
                // Create AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=delete&user_id=' + userId, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        closePopup();
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    // Show success message
                                    showAlert(response.message, 'success');
                                    // Reload the page after a short delay
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                } else {
                                    // Show error message
                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {
                                // Fallback for non-JSON responses
                                showAlert('User deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {
                            // Show error message
                            showAlert('Failed to delete user. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send();
            }

            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' alert-dismissible fade show';
                alertDiv.style.position = 'fixed';
                alertDiv.style.top = '20px';
                alertDiv.style.right = '20px';
                alertDiv.style.zIndex = '9999';
                alertDiv.style.minWidth = '300px';
                alertDiv.innerHTML = 
                    message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(alertDiv);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }

            // Toggle password visibility
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const icon = document.getElementById(inputId + 'Icon');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }

            // Event delegation for user management buttons
            document.addEventListener('DOMContentLoaded', function() {
                document.addEventListener('click', function(event) {
                    const target = event.target.closest('[data-action]');
                    if (target) {
                        const action = target.getAttribute('data-action');
                        const userId = target.getAttribute('data-user-id');
                        
                        if (action === 'edit' && userId) {
                            editUser(userId);
                        } else if (action === 'delete' && userId) {
                            deleteUser(userId);
                        }
                    }
                });
            });
        </script>
    </body>
</html> 