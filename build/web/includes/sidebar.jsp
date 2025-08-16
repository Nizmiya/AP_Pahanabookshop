<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) {
        currentPage = "";
    }
%>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <i class="bi bi-book"></i> BookShop
        </div>
    </div>

    <nav class="nav-menu">
        <!-- Dashboard - Only for ADMIN -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <a href="DashboardServlet" class="nav-link <%= "dashboard".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>
        </div>
        <% } %>
        
        <!-- POS - For ADMIN, MANAGER, CASHIER -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="pos.jsp" class="nav-link <%= "pos".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-cart-check"></i>
                POS
            </a>
        </div>
        <% } %>
        
        <!-- Transactions - For all roles -->
        <div class="nav-item">
            <a href="transaction.jsp" class="nav-link <%= "transaction".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-receipt"></i>
                Transaction
            </a>
        </div>
        
        <!-- Customer - For ADMIN, MANAGER, CASHIER -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="CustomerServlet?action=list" class="nav-link <%= "customer".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-people"></i>
                Customer
            </a>
        </div>
        <% } %>
        
        <!-- Book Categories - Only for ADMIN -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <a href="BookCategoryServlet?action=list" class="nav-link <%= "bookcategory".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-tags"></i>
                Book Categories
            </a>
        </div>
        <% } %>
        
        <!-- Books - For ADMIN, MANAGER, CASHIER -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="BookServlet?action=list" class="nav-link <%= "book".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-book"></i>
                Book
            </a>
        </div>
        <% } %>
        
        <!-- Stock - For ADMIN, MANAGER -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
        <div class="nav-item">
            <a href="StockServlet?action=list" class="nav-link <%= "stock".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-boxes"></i>
                Stock
            </a>
        </div>
        <% } %>
        
        <!-- Users - For ADMIN, MANAGER, CASHIER -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="UserServlet?action=list" class="nav-link <%= "user".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-person-gear"></i>
                User
            </a>
        </div>
        <% } %>
        
        <!-- User Roles - Only for ADMIN -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <a href="UserRoleServlet?action=list" class="nav-link <%= "userrole".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-shield-check"></i>
                UserRole
            </a>
        </div>
        <% } %>
        
        <!-- Profile - For all roles -->
        <div class="nav-item">
            <a href="profile.jsp" class="nav-link <%= "profile".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-person-circle"></i>
                Profile
            </a>
        </div>
        
        <!-- Help - For all roles -->
        <div class="nav-item">
            <a href="help.jsp" class="nav-link <%= "help".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-question-circle"></i>
                Help
            </a>
        </div>
    </nav>

    <div class="sidebar-footer">
        <a href="LogoutServlet" class="logout-btn">
            <i class="bi bi-box-arrow-right me-2"></i>
            Logout
        </a>
    </div>
</div> 