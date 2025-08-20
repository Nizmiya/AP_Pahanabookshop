<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookServlet.Book"%>
<%@page import="com.booking.BookCategoryServlet.BookCategory"%>
<%@page import="com.booking.BookServlet"%>
<%@page import="com.booking.BookCategoryServlet"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Book Management</title>
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

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }

            .btn-outline-primary {
                color: var(--secondary-color);
                border: 2px solid var(--secondary-color);
                background: transparent;
            }

            .btn-outline-primary:hover {
                background: var(--secondary-color);
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(70, 146, 60, 0.3);
            }

            .btn-outline-danger {
                color: var(--danger-color);
                border: 2px solid var(--danger-color);
                background: transparent;
            }

            .btn-outline-danger:hover {
                background: var(--danger-color);
                color: var(--white);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
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
            .badge.bg-success {
                background-color: #5bb450 !important;
            }

            .badge.bg-warning {
                background-color: #ffc107 !important;
                color: #212529 !important;
            }

            .badge.bg-danger {
                background-color: #dc3545 !important;
            }

            .badge.bg-secondary {
                background-color: #6c757d !important;
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
            .modal-header {
                background: linear-gradient(135deg, #3b8132 0%, #46923c 100%);
                color: white;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .modal-title {
                color: white;
            }

            .btn-close {
                filter: invert(1);
            }

            /* Form Controls */
            .form-control:focus {
                border-color: #5bb450;
                box-shadow: 0 0 0 0.2rem rgba(91, 180, 80, 0.25);
            }

            .form-select:focus {
                border-color: #5bb450;
                box-shadow: 0 0 0 0.2rem rgba(91, 180, 80, 0.25);
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
            
            // Check role-based access - Book management is for ADMIN, MANAGER, CASHIER
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators, managers, and cashiers can access book management.");
                return;
            }
            
            // If no books data is loaded, load data directly
            if (request.getAttribute("books") == null) {
                // Load books and categories directly instead of redirecting to servlet
                try {
                    BookServlet bookServlet = new BookServlet();
                    List<Book> books = bookServlet.getAllBooks();
                    request.setAttribute("books", books);
                    
                    BookCategoryServlet bookCategoryServlet = new BookCategoryServlet();
                    List<BookCategory> categories = bookCategoryServlet.getAllBookCategories();
                    request.setAttribute("categories", categories);
                } catch (Exception e) {
                    System.err.println("Error loading books: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "book");
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
                        <h1 class="page-title">Book Management</h1>
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
                    <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message") %>
                </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                </div>
                <% } %>

                <!-- Book Management Content -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-book me-2"></i>Book Management</span>
                        <% if (!"CASHIER".equals(role)) { %>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                            <i class="bi bi-plus-circle me-2" style="color: white;"></i>Add Book
                        </button>
                        <% } %>
                    </h3>
                    
                    <!-- Search Bar -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" class="form-control" id="searchInput" 
                                       placeholder="Search books by title, category, or description..." 
                                       onkeyup="filterBooks()">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                                    <i class="bi bi-x-circle"></i> Clear
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <span class="text-muted">
                                <i class="bi bi-info-circle me-1"></i>
                                <span id="bookCount">0</span> books found
                            </span>
                        </div>
                    </div>
                    
                    <!-- Books Table -->
                    <div class="table-responsive">
                        <table class="table table-hover" id="booksTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Created By</th>
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
                                    <td>
                                        <strong><%= book.getTitle() %></strong>
                                        <% if (book.getDescription() != null && !book.getDescription().isEmpty()) { %>
                                        <br><small class="text-muted"><%= book.getDescription() %></small>
                                        <% } %>
                                    </td>
                                    <td><span class="badge bg-secondary"><%= book.getCategory().getCategoryName() %></span></td>
                                    <td><%= book.getPricePerUnit() %></td>
                                    <td>
                                        <span class="badge <%= book.getStockQuantity() > 10 ? "bg-success" : book.getStockQuantity() > 0 ? "bg-warning" : "bg-danger" %>">
                                            <%= book.getStockQuantity() %>
                                        </span>
                                    </td>
                                    <td><%= book.getCreatedBy().getUsername() %></td>
                                    <td>
                                        <% if (!"CASHIER".equals(role)) { %>
                                        <button class="btn btn-sm btn-outline-primary" 
                                                onclick="editBook(<%= book.getBookId() %>)">
                                            <i class="bi bi-pencil"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" 
                                                onclick="deleteBook(<%= book.getBookId() %>, '<%= book.getTitle() %>')">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                        <% } else { %>
                                        <span class="text-muted">View Only</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No books found
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Add Book Modal -->
                <div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBookModalLabel">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Book
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookServlet" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="title" class="form-label">Book Title *</label>
                                                <input type="text" class="form-control" id="title" name="title" 
                                                       required placeholder="Enter book title">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="categoryId" class="form-label">Category *</label>
                                                <select class="form-select" id="categoryId" name="categoryId" required>
                                                    <option value="">Select Category</option>
                                                    <% 
                                                    List<BookCategory> categories = (List<BookCategory>) request.getAttribute("categories");
                                                    if (categories == null) {
                                                        // If categories not loaded, we'll need to load them
                                                        // For now, this will be handled by the servlet
                                                    } else {
                                                        for (BookCategory category : categories) {
                                                    %>
                                                    <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                                                    <%
                                                        }
                                                    }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Price *</label>
                                                <input type="number" class="form-control" id="price" name="price" 
                                                       step="0.01" min="0" required placeholder="0.00">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="stock" class="form-label">Stock Quantity *</label>
                                                <input type="number" class="form-control" id="stock" name="stock" 
                                                       min="0" required placeholder="0">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="3" placeholder="Enter book description (optional)"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Add Book
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteBookModal" tabindex="-1" aria-labelledby="deleteBookModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteBookModalLabel">
                                    <i class="bi bi-exclamation-triangle me-2"></i>Confirm Delete
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete the book "<span id="deleteBookTitle"></span>"?</p>
                                <p class="text-danger"><small>This action cannot be undone.</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="#" id="confirmDeleteBookBtn" class="btn btn-danger">
                                    <i class="bi bi-trash me-2"></i>Delete Book
                                </a>
                            </div>
                        </div>
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

            // Edit book function
            function editBook(bookId) {
                window.location.href = 'BookServlet?action=edit&id=' + bookId;
            }

            // Delete book function
            function deleteBook(bookId, bookTitle) {
                document.getElementById('deleteBookTitle').textContent = bookTitle;
                document.getElementById('confirmDeleteBookBtn').href = 'BookServlet?action=delete&id=' + bookId;
                new bootstrap.Modal(document.getElementById('deleteBookModal')).show();
            }

            // Search and filter books
            function filterBooks() {
                const searchInput = document.getElementById('searchInput');
                const searchTerm = searchInput.value.toLowerCase();
                const table = document.getElementById('booksTable');
                const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                let visibleCount = 0;

                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i];
                    const title = row.cells[1] ? row.cells[1].textContent.toLowerCase() : '';
                    const category = row.cells[2] ? row.cells[2].textContent.toLowerCase() : '';
                    const description = row.cells[1] ? row.cells[1].getElementsByTagName('small')[0]?.textContent.toLowerCase() || '' : '';
                    
                    // Check if any of the search terms match
                    const matches = title.includes(searchTerm) || 
                                  category.includes(searchTerm) || 
                                  description.includes(searchTerm);
                    
                    if (matches) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                }

                // Update book count
                document.getElementById('bookCount').textContent = visibleCount;
            }

            // Clear search
            function clearSearch() {
                document.getElementById('searchInput').value = '';
                filterBooks();
            }

            // Initialize book count on page load
            document.addEventListener('DOMContentLoaded', function() {
                filterBooks();
            });
        </script>
    </body>
</html> 