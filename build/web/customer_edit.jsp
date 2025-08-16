<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="com.booking.CustomerServlet"%>

<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Edit Customer</title>
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
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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

            .form-control[readonly] {
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.05), rgba(70, 146, 60, 0.05));
                color: var(--light-text);
                cursor: not-allowed;
                border-color: rgba(91, 180, 80, 0.2);
            }

            .invalid-feedback {
                display: block;
                width: 100%;
                margin-top: 0.5rem;
                font-size: 0.875em;
                color: var(--danger-color);
                font-weight: 500;
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

            .col-12 {
                flex: 0 0 100%;
                max-width: 100%;
                padding-right: 0.75rem;
                padding-left: 0.75rem;
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

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                color: #721c24;
                border-left: 4px solid var(--danger-color);
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
                border-left: 4px solid var(--success-color);
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

            .ms-2 {
                margin-left: 0.5rem !important;
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
            
            // Check role-based access - Customer edit is for ADMIN, MANAGER, CASHIER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators, managers, and cashiers can edit customers.");
                return;
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "customer");
            
            CustomerServlet customerServlet = new CustomerServlet();
            Customer customer = null;
            String errorMessage = "";
            String successMessage = "";
            
            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    int customerId = Integer.parseInt(request.getParameter("customerId"));
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String customerUsername = request.getParameter("username");
                    String email = request.getParameter("email");
                    
                    // Validation
                    if (name == null || name.trim().isEmpty()) {
                        errorMessage = "Customer name is required";
                    } else if (phone == null || phone.trim().isEmpty()) {
                        errorMessage = "Phone number is required";
                    } else {
                        // Get existing customer
                        customer = customerServlet.getCustomerById(customerId);
                        if (customer != null) {
                            // Update customer details
                            customer.setName(name.trim());
                            customer.setPhone(phone.trim());
                            customer.setAddress(address != null ? address.trim() : "");
                            customer.setUsername(customerUsername != null ? customerUsername.trim() : "");
                            customer.setEmail(email != null ? email.trim() : "");
                            
                            if (customerServlet.updateCustomer(customer)) {
                                successMessage = "Customer updated successfully!";
                            } else {
                                errorMessage = "Failed to update customer";
                            }
                        } else {
                            errorMessage = "Customer not found";
                        }
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID";
                } catch (Exception e) {
                    errorMessage = "Error updating customer: " + e.getMessage();
                }
            }
            
            // Load customer data for editing
            if (customer == null) {
                try {
                    String customerIdParam = request.getParameter("customer_id");
                    if (customerIdParam == null) {
                        customerIdParam = request.getParameter("id");
                    }
                    
                    if (customerIdParam != null) {
                        int customerId = Integer.parseInt(customerIdParam);
                        customer = customerServlet.getCustomerById(customerId);
                        
                        if (customer == null) {
                            errorMessage = "Customer not found with ID: " + customerId;
                        }
                    } else {
                        errorMessage = "No customer ID provided";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID provided";
                } catch (Exception e) {
                    errorMessage = "Error retrieving customer: " + e.getMessage();
                }
            }
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
                        <h1 class="page-title">Edit Customer</h1>
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

                <div class="content-card">
                    <div class="card-title">
                        <span>
                            <i class="bi bi-pencil-square"></i>
                            Edit Customer Details
                        </span>
                        <div>
                            <a href="customer.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Back to List
                            </a>
                        </div>
                    </div>

                    <% if (!errorMessage.isEmpty()) { %>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle"></i> <%= errorMessage %>
                        </div>
                    <% } %>

                    <% if (!successMessage.isEmpty()) { %>
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle"></i> <%= successMessage %>
                        </div>
                    <% } %>

                    <% if (customer != null) { %>
                        <form method="POST" action="customer_edit.jsp">
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Customer ID</label>
                                        <input type="text" class="form-control" value="<%= customer.getCustomerId() %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Account Number</label>
                                        <input type="text" class="form-control" value="<%= customer.getAccountNumber() != null ? customer.getAccountNumber() : "" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Customer Name *</label>
                                        <input type="text" class="form-control" name="name" value="<%= customer.getName() != null ? customer.getName() : "" %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Phone Number *</label>
                                        <input type="text" class="form-control" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username" value="<%= customer.getUsername() != null ? customer.getUsername() : "" %>">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" name="email" value="<%= customer.getEmail() != null ? customer.getEmail() : "" %>">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Address</label>
                                        <textarea class="form-control" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Role</label>
                                        <input type="text" class="form-control" value="<%= customer.getRole() != null ? customer.getRole().getRoleName() : "N/A" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Created By</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Created At</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Updated At</label>
                                        <input type="text" class="form-control" value="<%= customer.getUpdatedAt() != null ? customer.getUpdatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle"></i> Update Customer
                                        </button>
                                        <a href="customer_view.jsp?customer_id=<%= customer.getCustomerId() %>" class="btn btn-secondary ms-2">
                                            <i class="bi bi-eye"></i> View Customer
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    <% } %>
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

            // Form validation
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        const name = document.querySelector('input[name="name"]').value.trim();
                        const phone = document.querySelector('input[name="phone"]').value.trim();
                        
                        if (!name) {
                            e.preventDefault();
                            alert('Customer name is required');
                            return false;
                        }
                        
                        if (!phone) {
                            e.preventDefault();
                            alert('Phone number is required');
                            return false;
                        }
                    });
                }
            });
        </script>
    </body>
</html> 