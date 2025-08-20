/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.UserServlet.User;
import com.booking.UserServlet.UserRole;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.StrategyDP;
import com.booking.patterns.ObserverDP;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pruso
 */
public class LoginServlet extends HttpServlet {

    private FacadeDP facade;
    private StrategyDP.AuthenticationContext authContext;
    private ObserverDP.SystemEventManager eventManager;

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("Initializing database and patterns...");
        try {
            DatabaseUtil.initializeDatabase();
            
            // Initialize patterns
            facade = new FacadeDP();
            authContext = new StrategyDP.AuthenticationContext(new StrategyDP.DatabaseAuthenticationStrategy());
            
            // Initialize observers
            eventManager = ObserverDP.SystemEventManager.getInstance();
            eventManager.registerObserver(new ObserverDP.SystemLogger());
            eventManager.registerObserver(new ObserverDP.AuditTrail());
            
            System.out.println("Database and patterns initialization completed successfully!");
            eventManager.logEvent("System initialized successfully", "INFO");
        } catch (Exception e) {
            System.err.println("Error initializing system: " + e.getMessage());
            if (eventManager != null) {
                eventManager.logEvent("System initialization failed: " + e.getMessage(), "ERROR");
            }
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else {
            handleLogin(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleId = request.getParameter("role_id");

            // Create user object
            UserRole role = new UserRole();
            role.setRoleId(Integer.parseInt(roleId));
            
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            // Register user using facade
            boolean success = facade.registerUser(user);

            if (success) {
                eventManager.logEvent("User registered successfully: " + username, "INFO");
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            } else {
                eventManager.logEvent("User registration failed: " + username, "WARNING");
                response.sendRedirect("login.jsp?error=Registration failed. Username or email might already exist.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Registration error: " + e.getMessage(), "ERROR");
            response.sendRedirect("login.jsp?error=Registration error: " + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // First try to authenticate as a regular user (ADMIN, MANAGER, CASHIER)
            UserServlet userServlet = new UserServlet();
            User user = null;
            if (userServlet.authenticateUser(username, password)) {
                // Authentication successful, get the full user object
                user = userServlet.getUserByUsername(username);
            }

            if (user != null) {
                // Check if user has valid role (ADMIN=1, MANAGER=2, CASHIER=3)
                String roleName = user.getRole().getRoleName();
                if ("ADMIN".equals(roleName) || "MANAGER".equals(roleName) || "CASHIER".equals(roleName)) {
                    // Store user in session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("role", roleName);
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userType", "user");
                    
                    eventManager.logEvent("User logged in successfully: " + username + " (Role: " + roleName + ")", "INFO");
                    
                    // Redirect based on role
                    if ("ADMIN".equals(roleName)) {
                        response.sendRedirect("DashboardServlet");
                    } else if ("MANAGER".equals(roleName)) {
                        response.sendRedirect("pos.jsp");
                    } else if ("CASHIER".equals(roleName)) {
                        response.sendRedirect("pos.jsp");
                    } else {
                        response.sendRedirect("DashboardServlet");
                    }
                    return;
                } else {
                    // User exists but has invalid role for users table
                    eventManager.logEvent("Login failed - invalid role for user: " + username + " (Role: " + roleName + ")", "WARNING");
                    response.sendRedirect("login.jsp?error=Invalid user role. Please contact administrator.");
                    return;
                }
            }
            
            // If not a regular user, try to authenticate as a customer (CUSTOMER role only)
            System.out.println("Attempting customer authentication for username: " + username);
            com.booking.CustomerServlet.Customer customer = facade.authenticateCustomer(username, password);
            System.out.println("Customer authentication result: " + (customer != null ? "SUCCESS" : "FAILED"));
            
            if (customer != null) {
                // Check if customer has CUSTOMER role (role_id = 4)
                System.out.println("Customer found, checking role...");
                String roleName = customer.getRole() != null ? customer.getRole().getRoleName() : "NULL";
                System.out.println("Customer role: " + roleName);
                if ("CUSTOMER".equals(roleName)) {
                    // Store customer in session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", customer);
                    session.setAttribute("username", customer.getUsername());
                    session.setAttribute("role", roleName);
                    session.setAttribute("userId", customer.getCustomerId());
                    session.setAttribute("userType", "customer");
                    session.setAttribute("customerId", customer.getCustomerId());
                    session.setAttribute("customerName", customer.getName());
                    
                    eventManager.logEvent("Customer logged in successfully: " + username + " (Role: " + roleName + ")", "INFO");
                    response.sendRedirect("transaction.jsp");
                    return;
                } else {
                    // Customer exists but has invalid role for customers table
                    eventManager.logEvent("Login failed - invalid role for customer: " + username + " (Role: " + roleName + ")", "WARNING");
                    response.sendRedirect("login.jsp?error=Invalid customer role. Please contact administrator.");
                    return;
                }
            }
            
            // If neither user nor customer authentication succeeded
            eventManager.logEvent("Login failed for username: " + username, "WARNING");
            response.sendRedirect("login.jsp?error=Invalid username or password.");

        } catch (Exception e) {
            eventManager.logEvent("Login error: " + e.getMessage(), "ERROR");
            response.sendRedirect("login.jsp?error=Login error: " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
