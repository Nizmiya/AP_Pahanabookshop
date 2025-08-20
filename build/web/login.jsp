<%-- 
    Document   : login
    Created on : Jul 20, 2025, 11:56:48 PM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>BookClub - Login (v2)</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: #cce7c9 !important;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
                padding: 20px;
            }

            .login-container {
                background: white !important;
                border-radius: 20px !important;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important;
                overflow: hidden;
                max-width: 900px;
                width: 100%;
                display: flex !important;
                min-height: 600px;
            }

            .welcome-section {
                flex: 1;
                background: linear-gradient(135deg, #5bb450 0%, #4a9a3f 50%, #3b8132 100%) !important;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: 40px;
                position: relative;
                overflow: hidden;
                box-shadow: inset 0 0 100px rgba(0,0,0,0.1);
            }

            .welcome-section::before {
                content: '';
                position: absolute;
                bottom: -50%;
                right: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
                border-radius: 50%;
                transform: rotate(-45deg);
                animation: float 6s ease-in-out infinite;
            }

            .welcome-section::after {
                content: '';
                position: absolute;
                top: -30%;
                left: -30%;
                width: 160%;
                height: 160%;
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0.03) 100%);
                border-radius: 50%;
                transform: rotate(45deg);
                animation: float 8s ease-in-out infinite reverse;
            }

            @keyframes float {
                0%, 100% { transform: rotate(-45deg) translateY(0px); }
                50% { transform: rotate(-45deg) translateY(-20px); }
            }

            .brand-section {
                position: relative;
                z-index: 2;
                text-align: center;
                margin-bottom: 40px;
            }

            .brand-icon {
                width: 80px;
                height: 80px;
                background: white !important;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.3);
                transition: all 0.3s ease;
                animation: pulse 2s ease-in-out infinite;
            }

            .brand-icon:hover {
                transform: scale(1.1);
                box-shadow: 0 12px 35px rgba(0,0,0,0.4);
            }

            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.05); }
            }

            .brand-icon i {
                font-size: 32px;
                color: #3b8132;
                animation: bounce 2s ease-in-out infinite;
            }

            @keyframes bounce {
                0%, 100% { transform: translateY(0); }
                50% { transform: translateY(-5px); }
            }

            .brand-name {
                color: white !important;
                font-size: 20px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
                margin-bottom: 10px;
            }

            .welcome-content {
                position: relative;
                z-index: 2;
                text-align: center;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                padding-top: 20px;
            }

            .welcome-title {
                color: white !important;
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 10px;
                text-transform: uppercase;
                text-shadow: 0 4px 8px rgba(0,0,0,0.3);
                letter-spacing: 2px;
            }

            .shop-description {
                color: rgba(255,255,255,0.9) !important;
                font-size: 1rem;
                font-weight: 500;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-shadow: 0 1px 2px rgba(0,0,0,0.2);
            }

            .welcome-subtitle {
                color: rgba(255,255,255,0.9) !important;
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .signin-button {
                background: transparent !important;
                border: 2px solid white !important;
                color: white !important;
                padding: 12px 30px;
                border-radius: 25px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                cursor: pointer;
                transition: all 0.3s ease;
                margin: 0 auto;
                display: block;
                text-decoration: none;
            }

            .signin-button:hover {
                background: white !important;
                color: #3b8132 !important;
                transform: translateY(-2px);
                text-decoration: none;
            }

            .footer-text {
                position: relative;
                z-index: 2;
                color: rgba(255,255,255,0.7) !important;
                font-size: 12px;
                text-align: center;
                text-transform: uppercase;
            }

            .form-section {
                flex: 1;
                background: white !important;
                padding: 50px 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                position: relative;
                overflow: hidden;
            }

            .form-section::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(135deg, rgba(114, 191, 106, 0.1) 0%, rgba(101, 168, 94, 0.1) 100%);
                border-radius: 50%;
                transform: rotate(45deg);
            }

            .form-content {
                position: relative;
                z-index: 2;
            }

            .form-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: #3b8132 !important;
                margin-bottom: 8px;
                text-transform: lowercase;
            }

            .form-subtitle {
                color: #666;
                font-size: 1rem;
                margin-bottom: 30px;
                line-height: 1.5;
            }

            /* Registration form specific styles */
            #registerForm .form-title {
                font-size: 2rem;
                margin-bottom: 6px;
            }

            #registerForm .form-subtitle {
                font-size: 0.9rem;
                margin-bottom: 20px;
                line-height: 1.4;
            }

            #registerForm .form-group {
                margin-bottom: 15px;
            }

            #registerForm .form-control {
                padding: 12px 15px;
                font-size: 14px;
            }

            #registerForm .btn-login {
                padding: 12px 20px;
                font-size: 14px;
            }

            #registerForm .alert {
                font-size: 0.8rem;
                margin-bottom: 15px;
                padding: 10px 15px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #3b8132;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-control {
                width: 100%;
                padding: 15px 20px;
                border: 2px solid #e0e0e0;
                border-radius: 12px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #f8f9fa;
                box-sizing: border-box;
            }

            .form-control:focus {
                outline: none;
                border-color: #3b8132;
                background: white;
                box-shadow: 0 0 0 4px rgba(59, 129, 50, 0.1);
            }

            .form-control::placeholder {
                color: #a0a0a0;
                font-style: italic;
            }

            .password-container {
                position: relative;
                display: flex;
                align-items: center;
            }

            .password-container .form-control {
                padding-right: 50px;
            }

            .password-toggle {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #666;
                cursor: pointer;
                font-size: 18px;
                padding: 5px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .password-toggle:hover {
                color: #3b8132;
                background: rgba(59, 129, 50, 0.1);
            }

            .forgot-password {
                text-align: right;
                margin-bottom: 25px;
            }

            .forgot-password a {
                color: #3b8132;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .forgot-password a:hover {
                color: #2d6b25;
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, #3b8132 0%, #2d6b25 100%);
                color: white;
                border: none;
                padding: 15px 20px;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(59, 129, 50, 0.3);
            }

            .register-link {
                text-align: center;
                margin-top: 25px;
                color: #666;
                font-size: 14px;
            }

            .register-link a {
                color: #3b8132;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .register-link a:hover {
                color: #2d6b25;
            }

            .alert {
                border-radius: 12px;
                border: none;
                padding: 15px 20px;
                margin-bottom: 25px;
                font-size: 14px;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border-left: 4px solid #28a745;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            .form-toggle {
                text-align: center;
                margin-top: 25px;
            }

            .form-toggle a {
                color: #3b8132;
                text-decoration: none;
                font-weight: 600;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .form-toggle a:hover {
                color: #2d6b25;
            }

            .hidden {
                display: none;
            }

            @media (max-width: 768px) {
                .login-container {
                    flex-direction: column;
                    min-height: auto;
                }
                
                .welcome-section {
                    order: -1;
                    padding: 30px 20px;
                    min-height: 300px;
                }
                
                .form-section {
                    padding: 40px 30px;
                }
                
                .welcome-title {
                    font-size: 2rem;
                }
                
                .form-title {
                    font-size: 2rem;
                }

                #registerForm .form-title {
                    font-size: 1.8rem;
                }

                #registerForm .form-group {
                    margin-bottom: 15px;
                }

                #registerForm .form-control {
                    padding: 12px 15px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="welcome-section">
                <div class="brand-section">
                    <div class="brand-icon">
                        <i class="bi bi-book"></i>
                    </div>
                    <div class="brand-name">Pahana Edu BookShop</div>
                </div>
                <div class="welcome-content">
                    <h1 class="welcome-title">Welcome Back!</h1>
                    <p class="shop-description">Sri Lanka, Colombo - Best Book Shop</p>
                    <p class="welcome-subtitle">To stay connected with us please login with your personal info</p>
                </div>
                <div class="footer-text">
                    CREATOR HERE | DIRECTOR HERE
                </div>
            </div>

            <div class="form-section">
                <div class="form-content">
                    <!-- Login Form -->
                    <div id="loginForm">
                        <!-- Message Display -->
                        <% if (request.getParameter("message") != null) {%>
                        <div class="alert alert-success" id="successMessage">
                            <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message")%>
                            <button type="button" class="btn-close" onclick="closeMessage('successMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                        </div>
                        <% } %>
                        <% if (request.getParameter("error") != null) {%>
                        <div class="alert alert-danger" id="errorMessage">
                            <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error")%>
                            <button type="button" class="btn-close" onclick="closeMessage('errorMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                        </div>
                        <% }%>

                        <h1 class="form-title">Login</h1>
                        <p class="form-subtitle">Login in to your account to continue</p>

                        <form action="LoginServlet" method="post">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-group">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" required>
                            </div>

                            <div class="form-group">
                                <label for="password" class="form-label">Password</label>
                                <div class="password-container">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('password')">
                                        <i class="bi bi-eye-slash" id="password-toggle-icon"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="forgot-password">
                                <a href="#">Forgot your password?</a>
                            </div>

                            <button type="submit" class="btn-login">Log In</button>
                        </form>

                        <div class="register-link">
                            Don't have an account? <a href="#" onclick="showRegisterForm()">sign up</a>
                        </div>
                    </div>

                    <!-- Registration Form -->
                    <div id="registerForm" class="hidden">
                        <h1 class="form-title">Create Account</h1>
                        <p class="form-subtitle">Join our community today</p>

                        <form action="CustomerServlet" method="post">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="regName" name="name" placeholder="Full Name..........." required>
                            </div>

                            <div class="form-group">
                                <input type="tel" class="form-control" id="regPhone" name="phone" placeholder="Phone Number..........." required>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" id="regAddress" name="address" rows="2" placeholder="Address..........." required></textarea>
                            </div>

                            <div class="form-group">
                                <input type="text" class="form-control" id="regUsername" name="username" placeholder="Username..........." required>
                            </div>

                            <div class="form-group">
                                <input type="email" class="form-control" id="regEmail" name="email" placeholder="Email Address..........." required>
                            </div>

                            <div class="form-group">
                                <div class="password-container">
                                    <input type="password" class="form-control" id="regPassword" name="password" placeholder="Password..........." required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('regPassword')">
                                        <i class="bi bi-eye-slash" id="reg-password-toggle-icon"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="alert alert-info" style="font-size: 0.8rem; margin-bottom: 15px; padding: 10px 15px;">
                                <i class="bi bi-info-circle me-2"></i>
                                <strong>Note:</strong> Account number will be automatically generated when you register.
                            </div>

                            <button type="submit" class="btn-login">Create Account</button>
                        </form>

                        <div class="form-toggle">
                            <a href="#" onclick="showLoginForm()">Already have an account? Log in</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            // Force reload to clear cache
            if (performance.navigation.type === 1) {
                // Page was refreshed
                console.log('Page was refreshed');
            } else {
                // Page was loaded normally
                console.log('Page loaded normally');
            }

            function showLoginForm() {
                document.getElementById('loginForm').classList.remove('hidden');
                document.getElementById('registerForm').classList.add('hidden');
            }

            function showRegisterForm() {
                document.getElementById('loginForm').classList.add('hidden');
                document.getElementById('registerForm').classList.remove('hidden');
            }

            function togglePasswordVisibility(inputId) {
                const input = document.getElementById(inputId);
                let icon;
                
                if (inputId === 'regPassword') {
                    icon = document.getElementById('reg-password-toggle-icon');
                } else {
                    icon = document.getElementById(inputId + '-toggle-icon');
                }
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
            }

            function closeMessage(messageId) {
                document.getElementById(messageId).style.display = 'none';
            }

            // Auto-close success message after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const successMessage = document.getElementById('successMessage');
                if (successMessage) {
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 5000); // 5 seconds
                }
            });
        </script>
    </body>
</html>
