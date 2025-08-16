<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bookshop_Dashboard</title>
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

            .dashboard-container {
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

            /* Modern Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: var(--white);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            }

            .stat-card:hover {
                transform: translateY(-8px);
                box-shadow: var(--shadow-hover);
            }

            .stat-card.success::before {
                background: linear-gradient(90deg, #28a745, #20c997);
            }

            .stat-card.info::before {
                background: linear-gradient(90deg, #17a2b8, #6f42c1);
            }

            .stat-card.warning::before {
                background: linear-gradient(90deg, #ffc107, #fd7e14);
            }

            .stat-card.danger::before {
                background: linear-gradient(90deg, #dc3545, #e83e8c);
            }

            .stat-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .stat-title {
                font-size: 0.9rem;
                color: var(--light-text);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.4rem;
                color: var(--white);
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
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
                font-size: 2.5rem;
                font-weight: 800;
                color: var(--dark-text);
                margin-bottom: 0.75rem;
                line-height: 1;
            }

            .stat-change {
                display: flex;
                align-items: center;
                font-size: 0.9rem;
                font-weight: 600;
                padding: 0.5rem 1rem;
                border-radius: 10px;
                background: rgba(91, 180, 80, 0.1);
                color: var(--secondary-color);
                width: fit-content;
            }

            .stat-change.positive {
                background: rgba(40, 167, 69, 0.1);
                color: #28a745;
            }

            .stat-change.negative {
                background: rgba(220, 53, 69, 0.1);
                color: #dc3545;
            }

            /* Modern Chart Section */
            .charts-section {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .chart-card {
                background: var(--white);
                border-radius: 20px;
                padding: 2rem;
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
                font-size: 1.4rem;
                font-weight: 700;
                color: var(--dark-text);
                margin-bottom: 1.5rem;
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
                    grid-template-columns: 1fr;
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
            // Get user role from session
            String role = (String) session.getAttribute("role");
            String username = (String) session.getAttribute("username");
            
            if (role == null || username == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            // Check role-based access - Dashboard is only for ADMIN
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators can access the dashboard.");
                return;
            }
            
            // Load dashboard statistics if not already loaded
            if (request.getAttribute("dashboardStats") == null) {
                // Redirect to DashboardServlet to load real data
                response.sendRedirect("DashboardServlet");
                return;
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "dashboard");
        %>

        <div class="dashboard-container">
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
                        <h1 class="page-title">Dashboard Overview</h1>
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

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <%
                        com.booking.patterns.FacadeDP.DashboardStats stats = (com.booking.patterns.FacadeDP.DashboardStats) request.getAttribute("dashboardStats");
                        if (stats == null) {
                            stats = new com.booking.patterns.FacadeDP.DashboardStats();
                        }
                    %>
                    <div class="stat-card success">
                        <div class="stat-header">
                            <span class="stat-title">Total Books</span>
                            <div class="stat-icon">
                                <i class="bi bi-book"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalBooks() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-2"></i>
                            Books in stock
                        </div>
                    </div>

                    <div class="stat-card info">
                        <div class="stat-header">
                            <span class="stat-title">Total Sales</span>
                            <div class="stat-icon">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalTransactions() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-2"></i>
                            Transactions completed
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-header">
                            <span class="stat-title">Total Customers</span>
                            <div class="stat-icon">
                                <i class="bi bi-people"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalCustomers() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-2"></i>
                            Registered customers
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-header">
                            <span class="stat-title">Total Users</span>
                            <div class="stat-icon">
                                <i class="bi bi-person-gear"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalUsers() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-2"></i>
                            System users
                        </div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <div class="chart-card">
                        <h3 class="chart-title">
                            <i class="bi bi-graph-up"></i>
                            Transaction Sales (Last 30 Days)
                        </h3>
                        <div class="chart-container" style="position: relative; height: 350px;">
                            <canvas id="salesChart"></canvas>
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

            // Load and display sales chart with new color scheme
            let salesChart;
            
            function loadSalesChart() {
                fetch('ChartServlet?action=transactionSales')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            createSalesChart(data.labels, data.data);
                        } else {
                            console.error('Error loading chart data:', data.error);
                            // Show fallback chart with sample data
                            createSalesChart(['No Data'], [0]);
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching chart data:', error);
                        // Show fallback chart with sample data
                        createSalesChart(['No Data'], [0]);
                    });
            }
            
            function createSalesChart(labels, data) {
                const ctx = document.getElementById('salesChart').getContext('2d');
                
                if (salesChart) {
                    salesChart.destroy();
                }
                
                salesChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Daily Sales',
                            data: data,
                            borderColor: '#46923c',
                            backgroundColor: 'rgba(91, 180, 80, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4,
                            pointBackgroundColor: '#46923c',
                            pointBorderColor: '#ffffff',
                            pointBorderWidth: 3,
                            pointRadius: 6,
                            pointHoverRadius: 10,
                            pointHoverBackgroundColor: '#5bb450',
                            pointHoverBorderColor: '#ffffff'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20,
                                    font: {
                                        size: 14,
                                        weight: '600'
                                    },
                                    color: '#2c3e50'
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                backgroundColor: 'rgba(59, 129, 50, 0.9)',
                                titleColor: '#ffffff',
                                bodyColor: '#ffffff',
                                borderColor: '#46923c',
                                borderWidth: 1,
                                cornerRadius: 10,
                                displayColors: false,
                                callbacks: {
                                    label: function(context) {
                                        return 'Sales: ' + context.parsed.y.toLocaleString();
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(91, 180, 80, 0.1)',
                                    drawBorder: false
                                },
                                ticks: {
                                    callback: function(value) {
                                        return value.toLocaleString();
                                    },
                                    color: '#7f8c8d',
                                    font: {
                                        size: 12,
                                        weight: '500'
                                    }
                                }
                            },
                            x: {
                                grid: {
                                    color: 'rgba(91, 180, 80, 0.1)',
                                    drawBorder: false
                                },
                                ticks: {
                                    color: '#7f8c8d',
                                    font: {
                                        size: 12,
                                        weight: '500'
                                    }
                                }
                            }
                        },
                        interaction: {
                            mode: 'nearest',
                            axis: 'x',
                            intersect: false
                        },
                        elements: {
                            point: {
                                hoverRadius: 10
                            }
                        }
                    }
                });
            }
            
            // Load chart when page loads
            document.addEventListener('DOMContentLoaded', function() {
                loadSalesChart();
                
                // Refresh chart every 5 minutes for real-time updates
                setInterval(loadSalesChart, 300000);
            });
        </script>
    </body>
</html> 