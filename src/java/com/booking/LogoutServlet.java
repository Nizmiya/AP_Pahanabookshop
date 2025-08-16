package com.booking;

import com.booking.patterns.ObserverDP;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling logout functionality
 */
public class LogoutServlet extends HttpServlet {

    private ObserverDP.SystemEventManager eventManager;

    @Override
    public void init() throws ServletException {
        super.init();
        eventManager = ObserverDP.SystemEventManager.getInstance();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        
        if (session != null) {
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            // Log the logout event
            if (username != null) {
                eventManager.logEvent("User logged out: " + username + " (Role: " + role + ")", "INFO");
            }
            
            // Invalidate the session
            session.invalidate();
        }
        
        // Redirect to login page
        response.sendRedirect("login.jsp?message=You have been logged out successfully.");
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
        return "Logout Servlet";
    }
} 