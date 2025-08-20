<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.UserServlet.UserRole"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - User Role Management</title>
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

            /* Badge Styles */
            .badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .bg-primary {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color)) !important;
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

            .alert-info {
                background: linear-gradient(135deg, #d1ecf1, #bee5eb);
                color: #0c5460;
                border-left: 4px solid var(--info-color);
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

            .small {
                font-size: 0.875rem;
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
            
            // Check role-based access - only ADMIN can access user roles
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators can manage user roles.");
                return;
            }
        %>

        <%
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "userrole");
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
                        <h1 class="page-title">User Role Management</h1>
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

                <!-- Add User Role Form -->
                <div class="content-card" style="background: linear-gradient(135deg, #adb5bd 0%, #6c757d 100%); border: none; color: white;">
                    <div class="card-title" style="color: white; text-align: center; margin-bottom: 2rem;">
                        <span><i class="bi bi-shield-plus-fill me-2" style="color: white;"></i>Create New User Role</span>
                    </div>
                    
                    <form action="UserRoleServlet" method="post" style="max-width: 600px; margin: 0 auto;">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="form-section" style="background: rgba(255,255,255,0.1); border-radius: 15px; padding: 2rem; margin-bottom: 1.5rem; backdrop-filter: blur(10px);">
                            <h5 style="color: white; margin-bottom: 1.5rem; text-align: center; font-weight: 600;">
                                <i class="bi bi-shield-lock me-2"></i>Role Information
                            </h5>
                            
                            <div class="form-group" style="margin-bottom: 1.5rem;">
                                <label for="role_name" style="color: white; font-weight: 500; margin-bottom: 0.75rem; display: block;">Role Name</label>
                                <input type="text" class="form-control" id="role_name" name="role_name" 
                                       placeholder="Enter role name (e.g., EDITOR, MODERATOR)" required
                                       style="background: rgba(255,255,255,0.9); border: none; border-radius: 10px; padding: 0.75rem; font-size: 1rem;">
                                <small style="color: rgba(255,255,255,0.8); font-size: 0.85rem; margin-top: 0.5rem; display: block;">
                                    <i class="bi bi-info-circle me-1"></i>
                                    Use uppercase letters for role names (e.g., EDITOR, MODERATOR, ANALYST)
                                </small>
                            </div>
                            
                            <!-- Role Guidelines -->
                            <div class="role-guidelines" style="background: rgba(255,255,255,0.1); border-radius: 10px; padding: 1.5rem; margin-top: 1.5rem;">
                                <h6 style="color: white; font-weight: 600; margin-bottom: 1rem;">
                                    <i class="bi bi-lightbulb me-2"></i>Role Creation Guidelines
                                </h6>
                                <div style="color: rgba(255,255,255,0.9); font-size: 0.9rem;">
                                    <div style="margin-bottom: 0.75rem;">
                                        <strong>✓</strong> Use descriptive, clear role names
                                    </div>
                                    <div style="margin-bottom: 0.75rem;">
                                        <strong>✓</strong> Follow naming conventions (UPPERCASE)
                                    </div>
                                    <div style="margin-bottom: 0.75rem;">
                                        <strong>✓</strong> Consider permissions and access levels
                                    </div>
                                    <div>
                                        <strong>✓</strong> Avoid duplicate or conflicting roles
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div style="text-align: center;">
                            <button type="submit" class="btn" 
                                    style="background: linear-gradient(135deg, #28a745, #20c997); border: none; color: white; padding: 1rem 2rem; border-radius: 25px; font-weight: 600; font-size: 1.1rem; box-shadow: 0 4px 15px rgba(40,167,69,0.3);">
                                <i class="bi bi-shield-plus-fill me-2" style="color: white;"></i>Create User Role
                            </button>
                        </div>
                    </form>
                </div>

                <!-- User Role List -->
                <div class="content-card">
                    <div class="card-title">
                        <span>
                            <i class="bi bi-shield-check"></i>
                            User Role List
                        </span>
                        <a href="UserRoleServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise" style="color: white;"></i> Refresh
                        </a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Role Name</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Load user roles directly if not already loaded
                                    List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                    if (userRoles == null) {
                                        try {
                                            // Load user roles directly using UserRoleServlet
                                            com.booking.UserRoleServlet userRoleServlet = new com.booking.UserRoleServlet();
                                            userRoles = userRoleServlet.getAllUserRoles();
                                            System.out.println("Loaded " + (userRoles != null ? userRoles.size() : 0) + " user roles");
                                        } catch (Exception e) {
                                            System.err.println("Error loading user roles: " + e.getMessage());
                                            e.printStackTrace();
                                            userRoles = new ArrayList<>();
                                        }
                                    }
                                    
                                    if (userRoles != null && !userRoles.isEmpty()) {
                                        for (UserRole userRole : userRoles) {
                                %>
                                <tr>
                                    <td><%= userRole.getRoleId() %></td>
                                    <td><span class="badge bg-primary"><%= userRole.getRoleName() %></span></td>
                                    <td>
                                        <button class="btn btn-edit btn-sm edit-role-btn" 
                                                data-role-id="<%= userRole.getRoleId() %>" 
                                                data-role-name="<%= userRole.getRoleName() %>">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <% if (userRole.getRoleId() > 4) { %>
                                        <button class="btn btn-delete btn-sm delete-role-btn" 
                                                data-role-id="<%= userRole.getRoleId() %>">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                        <% } else { %>
                                        <span class="text-muted small">Core Role</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center">No user roles found.</td>
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

            // User role management functions
            function editRole(roleId, roleName) {
                const newRoleName = prompt('Enter new role name:', roleName);
                if (newRoleName && newRoleName.trim() !== '') {
                    // Create a form and submit it
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'UserRoleServlet';
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'update';
                    form.appendChild(actionInput);
                    
                    const roleIdInput = document.createElement('input');
                    roleIdInput.type = 'hidden';
                    roleIdInput.name = 'role_id';
                    roleIdInput.value = roleId;
                    form.appendChild(roleIdInput);
                    
                    const roleNameInput = document.createElement('input');
                    roleNameInput.type = 'hidden';
                    roleNameInput.name = 'role_name';
                    roleNameInput.value = newRoleName.trim();
                    form.appendChild(roleNameInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function deleteRole(roleId) {
                if (confirm('Are you sure you want to delete this role?')) {
                    window.location.href = 'UserRoleServlet?action=delete&role_id=' + roleId;
                }
            }

            // Add event listeners for edit and delete buttons
            document.addEventListener('DOMContentLoaded', function() {
                // Edit role buttons
                document.querySelectorAll('.edit-role-btn').forEach(function(button) {
                    button.addEventListener('click', function() {
                        const roleId = this.getAttribute('data-role-id');
                        const roleName = this.getAttribute('data-role-name');
                        editRole(roleId, roleName);
                    });
                });

                // Delete role buttons
                document.querySelectorAll('.delete-role-btn').forEach(function(button) {
                    button.addEventListener('click', function() {
                        const roleId = this.getAttribute('data-role-id');
                        deleteRole(roleId);
                    });
                });
            });
        </script>
    </body>
</html> 