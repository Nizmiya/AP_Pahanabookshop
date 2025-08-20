<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="com.booking.CustomerServlet"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Customer Management</title>
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

            .nav-link {
                position: relative;
                overflow: hidden;
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

            /* Modern Content Cards */
            .content-card {
                background: var(--white);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
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
                font-size: 1.4rem;
                font-weight: 700;
                color: var(--dark-text);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .card-title span {
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

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }

            .btn-edit {
                background: linear-gradient(135deg, var(--warning-color), #e0a800);
                color: var(--dark-text);
                box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
            }

            .btn-edit:hover {
                background: linear-gradient(135deg, #e0a800, #d39e00);
                color: var(--dark-text);
                transform: translateY(-2px);
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
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            }

            .btn-view {
                background: linear-gradient(135deg, var(--info-color), #138496);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
            }

            .btn-view:hover {
                background: linear-gradient(135deg, #138496, #117a8b);
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(23, 162, 184, 0.4);
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
                display: block;
                width: 100%;
                margin-top: 0.5rem;
                font-size: 0.875em;
                color: var(--danger-color);
                font-weight: 500;
            }

            .input-group {
                position: relative;
                display: flex;
                flex-wrap: wrap;
                align-items: stretch;
                width: 100%;
            }

            .input-group .form-control {
                position: relative;
                flex: 1 1 auto;
                width: 1%;
                min-width: 0;
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
            }

            .input-group .btn {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
                margin-left: -2px;
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
                background: #f8f9fa;
                color: #495057;
                border: none;
                padding: 0.75rem 1rem;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: none;
                letter-spacing: normal;
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

            /* Email verification styles */
            .verification-row {
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.05), rgba(70, 146, 60, 0.05));
                border: 2px solid rgba(91, 180, 80, 0.1);
                border-radius: 15px;
                padding: 1.5rem;
                margin: 1.5rem 0;
                position: relative;
                overflow: hidden;
            }

            .verification-row::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            }

            .verification-status {
                margin-top: 1rem;
            }

            .btn-verification {
                transition: all 0.3s ease;
                border-radius: 10px;
                font-weight: 600;
            }

            .btn-verification:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(70, 146, 60, 0.3);
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

            .alert-info {
                background: linear-gradient(135deg, #d1ecf1, #bee5eb);
                color: #0c5460;
                border-left: 4px solid var(--info-color);
            }

            /* Custom Popup Styles */
            .custom-popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.6);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                backdrop-filter: blur(5px);
            }

            .custom-popup {
                background: var(--white);
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                width: 90%;
                max-width: 450px;
                animation: popupFadeIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid var(--border-color);
            }

            @keyframes popupFadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.8) translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: scale(1) translateY(0);
                }
            }

            .custom-popup-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem 2rem;
                border-bottom: 2px solid var(--border-color);
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.05), rgba(70, 146, 60, 0.05));
            }

            .custom-popup-header h5 {
                margin: 0;
                color: var(--dark-text);
                font-weight: 700;
                font-size: 1.2rem;
            }

            .custom-popup-header .btn-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: var(--light-text);
                cursor: pointer;
                padding: 0;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                transition: all 0.3s ease;
            }

            .custom-popup-header .btn-close:hover {
                color: var(--danger-color);
                background: rgba(220, 53, 69, 0.1);
                transform: rotate(90deg);
            }

            .custom-popup-body {
                padding: 2rem;
            }

            .custom-popup-body p {
                margin: 0;
                color: var(--dark-text);
                font-size: 1.1rem;
                font-weight: 500;
                line-height: 1.6;
            }

            .custom-popup-footer {
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
                padding: 1.5rem 2rem;
                border-top: 2px solid var(--border-color);
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.02), rgba(70, 146, 60, 0.02));
            }

            .custom-popup-footer .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .custom-popup-footer .btn-secondary {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
            }

            .custom-popup-footer .btn-secondary:hover {
                background: linear-gradient(135deg, #5a6268, #495057);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
            }

            .custom-popup-footer .btn-danger {
                background: linear-gradient(135deg, var(--danger-color), #c82333);
                color: var(--white);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            }

            .custom-popup-footer .btn-danger:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            }

            /* Utility Classes */
            .text-muted {
                color: var(--light-text) !important;
            }

            .text-center {
                text-align: center !important;
            }

            .me-2 {
                margin-right: 0.5rem !important;
            }

            .mb-0 {
                margin-bottom: 0 !important;
            }

            .text-end {
                text-align: right !important;
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
                    align-items: flex-start;
                }

                .user-info {
                    flex-direction: column;
                    text-align: center;
                }

                .table-responsive {
                    font-size: 0.85rem;
                }

                .table thead th,
                .table tbody td {
                    padding: 0.75rem 0.5rem;
                }

                .custom-popup {
                    width: 95%;
                    margin: 1rem;
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
            
            // Check role-based access - Customer management is for ADMIN, MANAGER, CASHIER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators, managers, and cashiers can access customer management.");
                return;
            }
            
            // If no customers data is loaded, load data directly
            if (request.getAttribute("customers") == null) {
                // Load customers directly instead of redirecting to servlet
                try {
                    CustomerServlet customerServlet = new CustomerServlet();
                    List<Customer> customers = customerServlet.getAllCustomers();
                    request.setAttribute("customers", customers);
                } catch (Exception e) {
                    System.err.println("Error loading customers: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "customer");
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
                        <h1 class="page-title">Customer Management</h1>
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

                <!-- Messages -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle"></i>
                    <%= request.getParameter("message") %>
                </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle"></i>
                    <%= request.getParameter("error") %>
                </div>
                <% } %>

                <!-- Add Customer Form - Compact Style -->
                <div class="content-card" style="background: white; border: 1px solid #e9ecef; color: #2c3e50;">
                    <h3 class="card-title" style="color: #2c3e50; text-align: center; margin-bottom: 1rem;">
                        <span><i class="bi bi-person-plus-fill me-2" style="color: #46923c;"></i>Register New Customer</span>
                    </h3>
                    
                    <form action="CustomerServlet" method="post" style="max-width: 800px; margin: 0 auto;">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="email" id="hiddenEmail">
                        
                        <div class="row">
                            <!-- Personal Information Section - Left Side -->
                            <div class="col-md-6">
                                <div class="form-section" style="background: rgba(91, 180, 80, 0.1); border-radius: 12px; padding: 1rem; margin-bottom: 1rem; border: 1px solid rgba(91, 180, 80, 0.2);">
                                    <h5 style="color: #2c3e50; margin-bottom: 0.75rem; text-align: center; font-weight: 600; font-size: 1rem;">
                                        <i class="bi bi-person-badge me-2" style="color: #46923c;"></i>Personal Information
                                    </h5>
                                    
                                    <div class="form-group" style="margin-bottom: 0.75rem;">
                                        <label for="name" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Full Name</label>
                                        <input type="text" class="form-control" id="name" name="name" required 
                                               style="background: white; border: 1px solid #e9ecef; border-radius: 8px; padding: 0.5rem;">
                                    </div>
                                    
                                    <div class="form-group" style="margin-bottom: 0.75rem;">
                                        <label for="phone" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Phone Number</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" required 
                                               style="background: white; border: 1px solid #e9ecef; border-radius: 8px; padding: 0.5rem;">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="address" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Address</label>
                                        <textarea class="form-control" id="address" name="address" rows="1" required 
                                                  style="background: white; border: 1px solid #e9ecef; border-radius: 8px; padding: 0.5rem; resize: none;"></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Account Information Section - Right Side -->
                            <div class="col-md-6">
                                <div class="form-section" style="background: rgba(91, 180, 80, 0.1); border-radius: 12px; padding: 1rem; margin-bottom: 1rem; border: 1px solid rgba(91, 180, 80, 0.2);">
                                    <h5 style="color: #2c3e50; margin-bottom: 0.75rem; text-align: center; font-weight: 600; font-size: 1rem;">
                                        <i class="bi bi-shield-lock me-2" style="color: #46923c;"></i>Account Details
                                    </h5>
                                    
                                    <div class="form-group" style="margin-bottom: 0.75rem;">
                                        <label for="username" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" required 
                                               style="background: white; border: 1px solid #e9ecef; border-radius: 8px; padding: 0.5rem;">
                                    </div>
                                    
                                    <div class="form-group" style="margin-bottom: 0.75rem;">
                                        <label for="email" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Email Address</label>
                                        <div class="input-group">
                                            <input type="email" class="form-control" id="email" name="email" required 
                                                   style="background: white; border: 1px solid #e9ecef; border-radius: 8px 0 0 8px; padding: 0.5rem;">
                                            <button class="btn" type="button" id="sendVerificationBtn" onclick="sendVerificationCode()"
                                                    style="background: #28a745; border: none; border-radius: 0 8px 8px 0; color: white; padding: 0.5rem 0.75rem;">
                                                <i class="bi bi-envelope"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="password" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="password" name="password" required 
                                                   style="background: white; border: 1px solid #e9ecef; border-radius: 8px 0 0 8px; padding: 0.5rem;">
                                            <button class="btn" type="button" onclick="togglePassword('password')"
                                                    style="background: #6c757d; border: none; border-radius: 0 8px 8px 0; color: white; padding: 0.5rem 0.75rem;">
                                                <i class="bi bi-eye" id="passwordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Email Verification Section -->
                        <div class="form-section" id="verificationRow" style="display: none; background: rgba(91, 180, 80, 0.1); border-radius: 12px; padding: 1rem; margin-bottom: 1rem; border: 1px solid rgba(91, 180, 80, 0.2);">
                            <h5 style="color: #2c3e50; margin-bottom: 0.75rem; text-align: center; font-weight: 600; font-size: 1rem;">
                                <i class="bi bi-patch-check me-2" style="color: #46923c;"></i>Email Verification
                            </h5>
                            
                            <div class="form-group" style="margin-bottom: 0.75rem;">
                                <label for="verificationPin" style="color: #2c3e50; font-weight: 500; margin-bottom: 0.25rem; font-size: 0.9rem;">Verification Code</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="verificationPin" name="verificationPin" placeholder="Enter 6-digit code" maxlength="6"
                                           style="background: white; border: 1px solid #e9ecef; border-radius: 8px 0 0 8px; padding: 0.5rem;">
                                    <button class="btn" type="button" id="verifyEmailBtn" onclick="verifyEmail()"
                                            style="background: #17a2b8; border: none; border-radius: 0 8px 8px 0; color: white; padding: 0.5rem 0.75rem;">
                                        <i class="bi bi-check-circle"></i>
                                    </button>
                                </div>
                                <small style="color: #6c757d; font-size: 0.75rem;">Enter the 6-digit verification code sent to your email</small>
                            </div>
                            
                            <div class="alert" id="verificationStatus" style="display: none; background: white; border: 1px solid #e9ecef; color: #2c3e50; border-radius: 8px;">
                                <i class="bi bi-info-circle me-2" style="color: #46923c;"></i>
                                <span id="verificationMessage"></span>
                            </div>
                        </div>
                        
                        <div style="text-align: center;">
                            <button type="submit" class="btn btn-outline-success btn-sm" id="addCustomerBtn" disabled onclick="submitForm(event)"
                                    style="border: 2px solid #28a745; color: #28a745; background: transparent; padding: 0.5rem 1.5rem; border-radius: 15px; font-weight: 600; font-size: 0.9rem;">
                                <i class="bi bi-person-plus-fill me-2"></i>Create Customer Account
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Customer List -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-people me-2"></i>Customer List</span>
                        <a href="CustomerServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise me-2" style="color: white;"></i>Refresh
                        </a>
                    </h3>
                    
                    <!-- Search Bar -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" class="form-control" id="searchInput" 
                                       placeholder="Search customers by name, username, email, or account number..." 
                                       onkeyup="filterCustomers()">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                                    <i class="bi bi-x-circle"></i> Clear
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <span class="text-muted" id="customerCount">0 customers found</span>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover" id="customerTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Account Number</th>
                                    <th>Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Created By</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                                    if (customers != null && !customers.isEmpty()) {
                                        for (Customer customer : customers) {
                                %>
                                <tr>
                                    <td><%= customer.getCustomerId() %></td>
                                    <td><%= customer.getAccountNumber() %></td>
                                    <td><%= customer.getName() %></td>
                                    <td><%= customer.getUsername() != null ? customer.getUsername() : "N/A" %></td>
                                    <td><%= customer.getEmail() != null ? customer.getEmail() : "N/A" %></td>
                                    <td><%= customer.getPhone() %></td>
                                    <td><%= customer.getAddress() %></td>
                                    <td><%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %></td>
                                    <td>
                                        <div style="display: flex; gap: 5px; align-items: center;">
                                            <a href="CustomerServlet?action=view&customer_id=<%= customer.getCustomerId() %>" 
                                               class="btn btn-outline-info btn-sm" style="padding: 0.25rem 0.5rem; font-size: 0.75rem; border: 1px solid #17a2b8; color: #17a2b8; background: transparent;">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <button class="btn btn-outline-warning btn-sm" onclick="editCustomer('<%= customer.getCustomerId() %>')"
                                                    style="padding: 0.25rem 0.5rem; font-size: 0.75rem; border: 1px solid #ffc107; color: #ffc107; background: transparent;">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-outline-danger btn-sm" onclick="deleteCustomer('<%= customer.getCustomerId() %>')" 
                                                    title="Delete customer"
                                                    style="padding: 0.25rem 0.5rem; font-size: 0.75rem; border: 1px solid #dc3545; color: #dc3545; background: transparent;">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="9" class="text-center">No customers found.</td>
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

            // Customer management functions
            function editCustomer(customerId) {
                // Navigate to edit page
                window.location.href = 'customer_edit.jsp?customer_id=' + customerId;
            }

            function deleteCustomer(customerId) {
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
                            '<p>Are you sure you want to delete this customer?</p>' +
                        '</div>' +
                        '<div class="custom-popup-footer">' +
                            '<button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>' +
                            '<button type="button" class="btn btn-danger" onclick="confirmDelete(' + customerId + ')">Delete</button>' +
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

            function confirmDelete(customerId) {
                // Create AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=delete&customer_id=' + customerId, true);
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
                                showAlert('Customer deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {
                            // Show error message
                            showAlert('Failed to delete customer. Please try again.', 'error');
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
            
            // Email verification functions
            function sendVerificationCode() {
                const email = document.getElementById('email').value.trim();
                
                if (!email) {
                    showAlert('Please enter an email address first.', 'error');
                    return;
                }
                
                // Validate email format
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    showAlert('Please enter a valid email address.', 'error');
                    return;
                }
                
                // Disable the send button and show loading state
                const sendBtn = document.getElementById('sendVerificationBtn');
                const originalText = sendBtn.innerHTML;
                sendBtn.disabled = true;
                sendBtn.innerHTML = '<i class="bi bi-hourglass-split"></i>';
                
                // Send AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=sendVerificationCode', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        // Re-enable the send button
                        sendBtn.disabled = false;
                        sendBtn.innerHTML = originalText;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    showAlert(response.message, 'success');
                                    // Show verification row
                                    document.getElementById('verificationRow').style.display = 'block';
                                    // Focus on verification pin input
                                    document.getElementById('verificationPin').focus();
                                } else {
                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {
                                showAlert('Verification code sent successfully!', 'success');
                                document.getElementById('verificationRow').style.display = 'block';
                                document.getElementById('verificationPin').focus();
                            }
                        } else {
                            showAlert('Failed to send verification code. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send('email=' + encodeURIComponent(email));
            }
            
            function verifyEmail() {
                const email = document.getElementById('email').value.trim();
                const verificationPin = document.getElementById('verificationPin').value.trim();
                
                if (!verificationPin) {
                    showAlert('Please enter the verification code.', 'error');
                    return;
                }
                
                // Disable the verify button and show loading state
                const verifyBtn = document.getElementById('verifyEmailBtn');
                const originalText = verifyBtn.innerHTML;
                verifyBtn.disabled = true;
                verifyBtn.innerHTML = '<i class="bi bi-hourglass-split"></i>';
                
                // Send AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=verifyEmail', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        // Re-enable the verify button
                        verifyBtn.disabled = false;
                        verifyBtn.innerHTML = originalText;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    showAlert(response.message, 'success');
                                    // Enable the Add Customer button
                                    const addCustomerBtn = document.getElementById('addCustomerBtn');
                                    addCustomerBtn.disabled = false;
                                    console.log('Add Customer button enabled: ' + !addCustomerBtn.disabled);
                                    // Show verification status
                                    showVerificationStatus('Email verified successfully!', 'success');
                                    // Set hidden email field value before disabling
                                    const emailValue = document.getElementById('email').value;
                                    document.getElementById('hiddenEmail').value = emailValue;
                                    console.log('Hidden email field set to: ' + emailValue);
                                    // Disable email field and verification controls
                                    document.getElementById('email').disabled = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyEmailBtn').disabled = true;
                                } else {
                                    showAlert(response.message, 'error');
                                    showVerificationStatus('Verification failed. Please try again.', 'error');
                                }
                            } catch (e) {
                                console.log('JSON parse error, using fallback logic');
                                showAlert('Email verified successfully!', 'success');
                                const addCustomerBtn = document.getElementById('addCustomerBtn');
                                addCustomerBtn.disabled = false;
                                console.log('Add Customer button enabled (fallback): ' + !addCustomerBtn.disabled);
                                showVerificationStatus('Email verified successfully!', 'success');
                                // Set hidden email field value before disabling
                                const emailValue = document.getElementById('email').value;
                                document.getElementById('hiddenEmail').value = emailValue;
                                console.log('Hidden email field set to (fallback): ' + emailValue);
                                // Disable email field and verification controls
                                document.getElementById('email').disabled = true;
                                document.getElementById('sendVerificationBtn').disabled = true;
                                document.getElementById('verificationPin').disabled = true;
                                document.getElementById('verifyEmailBtn').disabled = true;
                            }
                        } else {
                            showAlert('Failed to verify email. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&verificationCode=' + encodeURIComponent(verificationPin));
            }
            
            function showVerificationStatus(message, type) {
                const statusDiv = document.getElementById('verificationStatus');
                const messageSpan = document.getElementById('verificationMessage');
                
                statusDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger');
                messageSpan.textContent = message;
                statusDiv.style.display = 'block';
                
                // Auto hide after 5 seconds
                setTimeout(() => {
                    statusDiv.style.display = 'none';
                }, 5000);
            }
            
            function submitForm(event) {
                console.log('Form submission started');
                console.log('Form data:');
                console.log('  Name:', document.getElementById('name').value);
                console.log('  Phone:', document.getElementById('phone').value);
                console.log('  Address:', document.getElementById('address').value);
                console.log('  Username:', document.getElementById('username').value);
                console.log('  Email:', document.getElementById('email').value);
                console.log('  Password:', document.getElementById('password').value);
                console.log('  Verification Pin:', document.getElementById('verificationPin').value);
                
                // Check if verification is complete
                if (document.getElementById('addCustomerBtn').disabled) {
                    console.log('ERROR: Add Customer button is still disabled');
                    event.preventDefault();
                    return false;
                }
                
                console.log('Form submission proceeding...');
                return true;
            }
            
            // Reset form when email changes
            document.getElementById('email').addEventListener('input', function() {
                // Reset verification state
                document.getElementById('verificationRow').style.display = 'none';
                document.getElementById('verificationStatus').style.display = 'none';
                document.getElementById('verificationPin').value = '';
                document.getElementById('addCustomerBtn').disabled = true;
                
                // Re-enable email field and verification controls
                document.getElementById('email').disabled = false;
                document.getElementById('sendVerificationBtn').disabled = false;
                document.getElementById('verificationPin').disabled = false;
                document.getElementById('verifyEmailBtn').disabled = false;
            });

            // Search and filter customers
            function filterCustomers() {
                const searchInput = document.getElementById('searchInput');
                const filter = searchInput.value.toLowerCase();
                const table = document.getElementById('customerTable');
                const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                let visibleCount = 0;

                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i];
                    const name = row.cells[2].textContent.toLowerCase();
                    const username = row.cells[3].textContent.toLowerCase();
                    const email = row.cells[4].textContent.toLowerCase();
                    const accountNumber = row.cells[1].textContent.toLowerCase();
                    
                    if (name.includes(filter) || username.includes(filter) || email.includes(filter) || accountNumber.includes(filter)) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                }

                // Update count
                document.getElementById('customerCount').textContent = visibleCount + ' customers found';
            }

            // Clear search
            function clearSearch() {
                document.getElementById('searchInput').value = '';
                filterCustomers();
            }

            // Initialize count on page load
            document.addEventListener('DOMContentLoaded', function() {
                const table = document.getElementById('customerTable');
                const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                let visibleCount = 0;
                
                for (let i = 0; i < rows.length; i++) {
                    if (!rows[i].cells[0].textContent.includes('No customers found')) {
                        visibleCount++;
                    }
                }
                
                document.getElementById('customerCount').textContent = visibleCount + ' customers found';
            });
        </script>
    </body>
</html> 