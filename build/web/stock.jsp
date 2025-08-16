<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookServlet.Book"%>
<%@page import="com.booking.BookServlet"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Stock Management</title>
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
                font-weight: 500;
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

            .btn-outline-success {
                background: transparent;
                border: 2px solid var(--success-color);
                color: var(--success-color);
                transition: all 0.3s ease;
            }

            .btn-outline-success:hover {
                background: var(--success-color);
                color: var(--white);
                transform: translateY(-1px);
            }

            .btn-outline-primary {
                background: transparent;
                border: 2px solid var(--secondary-color);
                color: var(--secondary-color);
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background: var(--secondary-color);
                color: var(--white);
                transform: translateY(-1px);
            }

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
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

            .form-control[readonly] {
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.05), rgba(70, 146, 60, 0.05));
                border-color: rgba(91, 180, 80, 0.1);
                color: var(--light-text);
            }

            .input-group {
                position: relative;
                display: flex;
                flex-wrap: wrap;
                align-items: stretch;
                width: 100%;
            }

            .input-group-sm {
                width: auto;
            }

            .input-group .form-control {
                border-radius: 12px 0 0 12px;
                border-right: none;
            }

            .input-group .btn {
                border-radius: 0 12px 12px 0;
                border-left: none;
                border: 2px solid var(--border-color);
                border-left: none;
            }

            /* Modern Table Styles */
            .table-responsive {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }

            .table {
                margin-bottom: 0;
                background: var(--white);
            }

            .table thead th {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: var(--white);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
                padding: 1.25rem 1rem;
                position: relative;
            }

            .table thead th::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 2px;
                background: var(--accent-color);
            }

            .table tbody tr {
                transition: all 0.3s ease;
                border-bottom: 1px solid rgba(91, 180, 80, 0.1);
            }

            .table tbody tr:hover {
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.05), rgba(70, 146, 60, 0.05));
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(91, 180, 80, 0.1);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 1.25rem 1rem;
                vertical-align: middle;
                border: none;
                color: var(--dark-text);
                font-weight: 500;
            }

            .table tbody td:first-child {
                font-weight: 600;
                color: var(--secondary-color);
            }

            /* Badge Styles */
            .badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .bg-success {
                background: linear-gradient(135deg, var(--success-color), #20c997) !important;
                color: var(--white);
            }

            .bg-warning {
                background: linear-gradient(135deg, var(--warning-color), #fd7e14) !important;
                color: var(--dark-text);
            }

            .bg-danger {
                background: linear-gradient(135deg, var(--danger-color), #e74c3c) !important;
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

            /* Modal Styles */
            .modal-content {
                border-radius: 20px;
                border: none;
                box-shadow: var(--shadow-hover);
            }

            .modal-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: var(--white);
                border-radius: 20px 20px 0 0;
                border-bottom: none;
                padding: 1.5rem 2rem;
            }

            .modal-header .btn-close {
                filter: invert(1);
                opacity: 0.8;
            }

            .modal-body {
                padding: 2rem;
            }

            .modal-footer {
                border-top: 2px solid rgba(91, 180, 80, 0.1);
                padding: 1.5rem 2rem;
                border-radius: 0 0 20px 20px;
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

            .h3 {
                font-size: 1.75rem;
                font-weight: 700;
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

                .table-responsive {
                    font-size: 0.9rem;
                }

                .table thead th,
                .table tbody td {
                    padding: 0.75rem 0.5rem;
                }

                .input-group-sm {
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .input-group-sm .form-control,
                .input-group-sm .btn {
                    border-radius: 12px;
                    border: 2px solid var(--border-color);
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
            
            // Check role-based access - Stock management is only for ADMIN and MANAGER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators and managers can access stock management.");
                return;
            }
            
            // If no books data is loaded, load data directly
            if (request.getAttribute("books") == null) {
                // Load books directly instead of redirecting to servlet
                try {
                    BookServlet bookServlet = new BookServlet();
                    List<Book> books = bookServlet.getAllBooks();
                    request.setAttribute("books", books);
                } catch (Exception e) {
                    System.err.println("Error loading books: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "stock");
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
                        <h1 class="page-title">Stock Management</h1>
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

                <% if (request.getParameter("message") != null) { %>
                    <div class="alert alert-success">
                        <i class="bi bi-check-circle"></i> <%= request.getParameter("message") %>
                    </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle"></i> <%= request.getParameter("error") %>
                    </div>
                <% } %>

                <div class="content-card">
                    <div class="card-title">
                        <span>
                            <i class="bi bi-boxes"></i>
                            Stock Management
                        </span>
                        <a href="StockServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise"></i> Refresh
                        </a>
                    </div>
                    
                    <!-- Stock Table -->
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Current Stock</th>
                                    <th>Add Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Book> books = (List<Book>) request.getAttribute("books");
                                if (books != null && !books.isEmpty()) {
                                    for (Book book : books) {
                                %>
                                <tr>
                                    <td><%= book.getBookId() %></td>
                                    <td><strong><%= book.getTitle() %></strong></td>
                                    <td>
                                        <span class="badge <%= book.getStockQuantity() > 10 ? "bg-success" : book.getStockQuantity() > 0 ? "bg-warning" : "bg-danger" %>">
                                            <%= book.getStockQuantity() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="input-group input-group-sm">
                                            <input type="number" class="form-control add-stock-input" 
                                                   id="addStock_<%= book.getBookId() %>" 
                                                   placeholder="0" min="0" value="0">
                                            <button class="btn btn-outline-success btn-sm" 
                                                    onclick="addStock(<%= book.getBookId() %>, '<%= book.getTitle() %>', <%= book.getStockQuantity() %>)">
                                                <i class="bi bi-plus-circle"></i> Add
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <button class="btn btn-outline-primary btn-sm" 
                                                onclick="editStock(<%= book.getBookId() %>, '<%= book.getTitle() %>', <%= book.getStockQuantity() %>)">
                                            <i class="bi bi-pencil"></i> Update Stock
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">
                                        <i class="bi bi-inbox"></i> No books found
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Update Stock Modal -->
                <div class="modal fade" id="updateStockModal" tabindex="-1" aria-labelledby="updateStockModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateStockModalLabel">
                                    <i class="bi bi-pencil"></i> Set Stock Quantity
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="StockServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="bookId" id="updateBookId">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label class="form-label">Book Title</label>
                                        <input type="text" class="form-control" id="updateBookTitle" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="stockQuantity" class="form-label">Stock Quantity *</label>
                                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                               min="0" required placeholder="Enter new stock quantity">
                                        <small class="text-muted">This will replace the current stock quantity</small>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle"></i> Set Stock
                                    </button>
                                </div>
                            </form>
                        </div>
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

            // Edit stock function
            function editStock(bookId, bookTitle, currentStock) {
                document.getElementById('updateBookId').value = bookId;
                document.getElementById('updateBookTitle').value = bookTitle;
                document.getElementById('stockQuantity').value = currentStock;
                new bootstrap.Modal(document.getElementById('updateStockModal')).show();
            }
            
            // Add stock function
            function addStock(bookId, bookTitle, currentStock) {
                const addStockInput = document.getElementById('addStock_' + bookId);
                const addQuantity = parseInt(addStockInput.value) || 0;
                
                if (addQuantity <= 0) {
                    alert('Please enter a valid quantity to add.');
                    return;
                }
                
                // Create a form and submit it
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'StockServlet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'add';
                form.appendChild(actionInput);
                
                const bookIdInput = document.createElement('input');
                bookIdInput.type = 'hidden';
                bookIdInput.name = 'bookId';
                bookIdInput.value = bookId;
                form.appendChild(bookIdInput);
                
                const stockQuantityInput = document.createElement('input');
                stockQuantityInput.type = 'hidden';
                stockQuantityInput.name = 'stockQuantity';
                stockQuantityInput.value = addQuantity;
                form.appendChild(stockQuantityInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        </script>
    </body>
</html> 