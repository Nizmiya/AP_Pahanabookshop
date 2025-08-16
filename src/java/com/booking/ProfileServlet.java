package com.booking;

import com.booking.UserServlet.User;
import com.booking.CustomerServlet.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling Profile operations
 */
public class ProfileServlet extends HttpServlet {



    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "view";
        }

        try {
            switch (action) {
                case "update":
                    updateProfile(request, response);
                    break;
                default:
                    response.sendRedirect("profile.jsp");
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in ProfileServlet: " + e.getMessage());
            response.sendRedirect("profile.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?error=Current password is required.");
            return;
        }
        
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("profile.jsp?error=New passwords do not match.");
                return;
            }
        }

        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if ("user".equals(userType)) {
            updateUserProfile(request, response, currentPassword, newPassword);
        } else if ("customer".equals(userType)) {
            updateCustomerProfile(request, response, currentPassword, newPassword);
        } else {
            response.sendRedirect("profile.jsp?error=Invalid user type.");
        }
    }

    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response, 
                                 String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        String email = request.getParameter("email");
        
        // Verify current password
                    User user = new UserServlet().getUserByUsername(currentUser.getUsername());
        if (user == null || !user.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        // Update user
        user.setEmail(email != null ? email.trim() : user.getEmail());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            user.setPassword(newPassword.trim());
        }
        
                    boolean success = new UserServlet().updateUser(user);
        
        if (success) {
            // Update session
            session.setAttribute("user", user);
            response.sendRedirect("profile.jsp?message=Profile updated successfully.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
        }
    }

    private void updateCustomerProfile(HttpServletRequest request, HttpServletResponse response, 
                                     String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer currentCustomer = (Customer) session.getAttribute("user");
        String name = request.getParameter("name");
        
        // Verify current password
                    Customer customer = new CustomerServlet().getCustomerByUsername(currentCustomer.getUsername());
        if (customer == null || !customer.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        // Update customer
        customer.setName(name != null ? name.trim() : customer.getName());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            customer.setPassword(newPassword.trim());
        }
        
                    boolean success = new CustomerServlet().updateCustomer(customer);
        
        if (success) {
            // Update session
            session.setAttribute("user", customer);
            response.sendRedirect("profile.jsp?message=Profile updated successfully.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Profile Management Servlet";
    }
} 