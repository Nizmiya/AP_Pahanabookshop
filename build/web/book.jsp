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

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 2rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding: 1rem 0;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .menu-toggle {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #333;
                margin-right: 1rem;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #46923c 0%, #5bb450 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
            }

            /* Content Cards */
            .content-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 15px rgba(59, 129, 50, 0.1);
                margin-bottom: 2rem;
                border: 1px solid rgba(70, 146, 60, 0.1);
            }

            .card-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .btn-primary {
                background: linear-gradient(135deg, #46923c 0%, #5bb450 100%);
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(70, 146, 60, 0.3);
                color: white;
                background: linear-gradient(135deg, #5bb450 0%, #46923c 100%);
            }

            .btn-outline-primary {
                color: #46923c;
                border-color: #46923c;
            }

            .btn-outline-primary:hover {
                background-color: #46923c;
                border-color: #46923c;
                color: white;
            }

            .btn-outline-danger {
                color: #dc3545;
                border-color: #dc3545;
            }

            .btn-outline-danger:hover {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }

            /* Table Styles */
            .table-dark {
                background: linear-gradient(135deg, #3b8132 0%, #46923c 100%);
                color: white;
            }

            .table-striped > tbody > tr:nth-of-type(odd) > td {
                background-color: rgba(204, 231, 201, 0.1);
            }

            .table-hover > tbody > tr:hover > td {
                background-color: rgba(91, 180, 80, 0.1);
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

            /* Alert Styles */
            .alert {
                border-radius: 8px;
                border: none;
                padding: 1rem;
                margin-bottom: 1.5rem;
            }

            .alert-success {
                background-color: rgba(91, 180, 80, 0.1);
                color: #2d5a2d;
                border-left: 4px solid #5bb450;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
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

            /* Responsive Design */
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
                        <h1 class="h3 mb-0">Book Management</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
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
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                            <i class="bi bi-plus-circle me-2"></i>Add Book
                        </button>
                    </h3>
                    
                    <!-- Books Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
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
                                        <button class="btn btn-sm btn-outline-primary" 
                                                onclick="editBook(<%= book.getBookId() %>)">
                                            <i class="bi bi-pencil"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" 
                                                onclick="deleteBook(<%= book.getBookId() %>, '<%= book.getTitle() %>')">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
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
        </script>
    </body>
</html> 