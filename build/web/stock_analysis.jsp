<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock Analysis - Pahana Edu BookShop</title>
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

            /* Stock Analysis Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                border-radius: 15px;
                padding: 1.5rem 1rem;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
                border: none;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                overflow: hidden;
                min-height: 120px;
                backdrop-filter: blur(10px);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
                z-index: 1;
            }

            .stat-card:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
            }

            .stat-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1rem;
                position: relative;
                z-index: 2;
            }

            .stat-title {
                font-size: 0.85rem;
                color: #6c757d;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                margin-bottom: 0.5rem;
            }

            .stat-icon {
                width: 40px;
                height: 40px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.1rem;
                color: var(--white);
                box-shadow: 0 6px 20px rgba(0,0,0,0.15);
                position: relative;
                z-index: 2;
                transition: all 0.3s ease;
            }

            .stat-card:hover .stat-icon {
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 12px 35px rgba(0,0,0,0.25);
            }

            .stat-card.success .stat-icon {
                background: linear-gradient(135deg, #28a745, #20c997);
            }

            .stat-card.info .stat-icon {
                background: linear-gradient(135deg, #17a2b8, #6f42c1);
            }

            .stat-card.warning .stat-icon {
                background: linear-gradient(135deg, #ffc107, #fd7e14);
            }

            .stat-card.danger .stat-icon {
                background: linear-gradient(135deg, #dc3545, #e83e8c);
            }

            .stat-value {
                font-size: 1.8rem;
                font-weight: 900;
                background: linear-gradient(135deg, #2c3e50, #34495e);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.5rem;
                line-height: 1;
                position: relative;
                z-index: 2;
            }

            .stat-change {
                display: flex;
                align-items: center;
                font-size: 0.7rem;
                font-weight: 700;
                padding: 0.4rem 0.8rem;
                border-radius: 10px;
                background: linear-gradient(135deg, rgba(91, 180, 80, 0.1), rgba(70, 146, 60, 0.1));
                color: var(--secondary-color);
                width: fit-content;
                position: relative;
                z-index: 2;
                transition: all 0.3s ease;
                border: 1px solid rgba(91, 180, 80, 0.2);
            }

            /* Charts Section */
            .charts-section {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .chart-card {
                background: var(--white);
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
                position: relative;
                overflow: hidden;
            }

            .chart-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-color));
            }

            .chart-title {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--dark-text);
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .chart-title i {
                color: var(--secondary-color);
                font-size: 1.6rem;
            }

            .chart-container {
                position: relative;
                margin: 1rem 0;
                border-radius: 15px;
                overflow: hidden;
                height: 300px;
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

                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 0.75rem;
                }
                
                .stat-card {
                    padding: 1rem;
                    min-height: 120px;
                }
                
                .stat-value {
                    font-size: 1.5rem;
                }
                
                .stat-icon {
                    width: 35px;
                    height: 35px;
                    font-size: 1rem;
                }

                .charts-section {
                    grid-template-columns: 1fr;
                    gap: 1rem;
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
            
            // Check role-based access - only MANAGER can access stock analysis
            if (!"MANAGER".equals(role)) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only managers can access stock analysis.");
                return;
            }
        %>

        <%
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "stockanalysis");
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
                        <h1 class="page-title">Stock Analysis</h1>
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

                <!-- Message Display -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success" id="successMessage" style="margin: 20px; padding: 15px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 5px; color: #155724;">
                    <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message") %>
                    <button type="button" class="btn-close" onclick="closeMessage('successMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                </div>
                <% } %>
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger" id="errorMessage" style="margin: 20px; padding: 15px; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 5px; color: #721c24;">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                    <button type="button" class="btn-close" onclick="closeMessage('errorMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                </div>
                <% } %>

                <!-- Stock Statistics Cards -->
                <div class="stats-grid">
                    <div class="stat-card success">
                        <div class="stat-header">
                            <span class="stat-title">Total Books</span>
                            <div class="stat-icon">
                                <i class="bi bi-collection"></i>
                            </div>
                        </div>
                        <div class="stat-value" id="totalBooks">0</div>
                        <div class="stat-change">
                            <i class="bi bi-arrow-up me-2"></i>
                            Books in inventory
                        </div>
                    </div>

                    <div class="stat-card info">
                        <div class="stat-header">
                            <span class="stat-title">Low Stock Items</span>
                            <div class="stat-icon">
                                <i class="bi bi-exclamation-triangle"></i>
                            </div>
                        </div>
                        <div class="stat-value" id="lowStockItems">0</div>
                        <div class="stat-change">
                            <i class="bi bi-arrow-down me-2"></i>
                            Need restocking
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-header">
                            <span class="stat-title">Out of Stock</span>
                            <div class="stat-icon">
                                <i class="bi bi-x-circle"></i>
                            </div>
                        </div>
                        <div class="stat-value" id="outOfStock">0</div>
                        <div class="stat-change">
                            <i class="bi bi-arrow-down me-2"></i>
                            Zero stock items
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-header">
                            <span class="stat-title">Total Value</span>
                            <div class="stat-icon">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                        </div>
                        <div class="stat-value" id="totalValue">Rs 0</div>
                        <div class="stat-change">
                            <i class="bi bi-arrow-up me-2"></i>
                            Inventory value
                        </div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <!-- Stock by Category Chart -->
                    <div class="chart-card">
                        <h3 class="chart-title">
                            <i class="bi bi-pie-chart"></i>
                            Stock Distribution by Category
                        </h3>
                        <div class="chart-container">
                            <canvas id="categoryChart"></canvas>
                        </div>
                    </div>

                    <!-- Stock Level Chart -->
                    <div class="chart-card">
                        <h3 class="chart-title">
                            <i class="bi bi-bar-chart"></i>
                            Stock Levels Overview
                        </h3>
                        <div class="chart-container">
                            <canvas id="stockLevelChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Additional Charts -->
                <div class="charts-section">
                    <!-- Stock Movement -->
                    <div class="chart-card">
                        <h3 class="chart-title">
                            <i class="bi bi-arrow-left-right"></i>
                            Stock Movement Trends
                        </h3>
                        <div class="chart-container">
                            <canvas id="stockMovementChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            // Load stock analysis data
            function loadStockAnalysis() {
                // Load statistics
                fetch('ChartServlet?action=stockStats')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            document.getElementById('totalBooks').textContent = data.totalBooks;
                            document.getElementById('lowStockItems').textContent = data.lowStockItems;
                            document.getElementById('outOfStock').textContent = data.outOfStock;
                            document.getElementById('totalValue').textContent = 'Rs ' + data.totalValue.toLocaleString();
                        }
                    })
                    .catch(error => {
                        console.error('Error loading stock stats:', error);
                    });

                // Load category chart
                loadCategoryChart();
                
                // Load stock level chart
                loadStockLevelChart();
                
                // Load stock movement chart
                loadStockMovementChart();
            }

            // Category Distribution Chart
            function loadCategoryChart() {
                fetch('ChartServlet?action=stockByCategory')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            createCategoryChart(data.labels, data.data);
                        }
                    })
                    .catch(error => {
                        console.error('Error loading category chart:', error);
                    });
            }

            function createCategoryChart(labels, data) {
                const ctx = document.getElementById('categoryChart').getContext('2d');
                
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: [
                                '#46923c',
                                '#5bb450',
                                '#28a745',
                                '#20c997',
                                '#17a2b8',
                                '#6f42c1',
                                '#fd7e14',
                                '#dc3545'
                            ],
                            borderWidth: 2,
                            borderColor: '#ffffff'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20,
                                    font: {
                                        size: 12,
                                        weight: '600'
                                    }
                                }
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.label + ': ' + context.parsed + ' books';
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // Stock Level Chart
            function loadStockLevelChart() {
                fetch('ChartServlet?action=stockLevels')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            createStockLevelChart(data.labels, data.data);
                        }
                    })
                    .catch(error => {
                        console.error('Error loading stock level chart:', error);
                    });
            }

            function createStockLevelChart(labels, data) {
                const ctx = document.getElementById('stockLevelChart').getContext('2d');
                
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Stock Quantity',
                            data: data,
                            backgroundColor: 'rgba(91, 180, 80, 0.8)',
                            borderColor: '#46923c',
                            borderWidth: 2,
                            borderRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return 'Stock: ' + context.parsed.y + ' units';
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(91, 180, 80, 0.1)'
                                }
                            },
                            x: {
                                grid: {
                                    display: false
                                }
                            }
                        }
                    }
                });
            }



            // Stock Movement Chart
            function loadStockMovementChart() {
                fetch('ChartServlet?action=stockMovement')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            createStockMovementChart(data.labels, data.inStock, data.outStock);
                        }
                    })
                    .catch(error => {
                        console.error('Error loading stock movement chart:', error);
                    });
            }

            function createStockMovementChart(labels, inStock, outStock) {
                const ctx = document.getElementById('stockMovementChart').getContext('2d');
                
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Stock In',
                            data: inStock,
                            borderColor: '#28a745',
                            backgroundColor: 'rgba(40, 167, 69, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4
                        }, {
                            label: 'Stock Out',
                            data: outStock,
                            borderColor: '#dc3545',
                            backgroundColor: 'rgba(220, 53, 69, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'top',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(91, 180, 80, 0.1)'
                                }
                            },
                            x: {
                                grid: {
                                    color: 'rgba(91, 180, 80, 0.1)'
                                }
                            }
                        }
                    }
                });
            }

            // Load data when page loads
            document.addEventListener('DOMContentLoaded', function() {
                loadStockAnalysis();
                
                // Refresh data every 5 minutes
                setInterval(loadStockAnalysis, 300000);
            });

            // Function to close message alerts
            function closeMessage(messageId) {
                const messageElement = document.getElementById(messageId);
                if (messageElement) {
                    messageElement.style.display = 'none';
                }
            }

            // Auto-hide success messages after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const successMessage = document.getElementById('successMessage');
                if (successMessage) {
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 5000);
                }
            });
        </script>
    </body>
</html>
