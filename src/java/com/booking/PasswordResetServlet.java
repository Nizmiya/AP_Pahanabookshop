package com.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import com.booking.patterns.SingletonDP;

@WebServlet("/PasswordResetServlet")
public class PasswordResetServlet extends HttpServlet {
    
    private EmailService emailService;
    private Map<String, String> resetCodes = new HashMap<>();
    
    @Override
    public void init() throws ServletException {
        try {
            emailService = new EmailService();
            System.out.println("✓ PasswordResetServlet initialized with EmailService");
        } catch (Exception e) {
            System.err.println("⚠ Failed to initialize EmailService: " + e.getMessage());
            emailService = null;
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
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("login.jsp?error=Invalid request");
            return;
        }
        
        switch (action) {
            case "sendResetCode":
                handleSendResetCode(request, response);
                break;
            case "verifyResetCode":
                handleVerifyResetCode(request, response);
                break;
            case "resetPassword":
                handleResetPassword(request, response);
                break;
            default:
                response.sendRedirect("login.jsp?error=Invalid action");
        }
    }
    
    /**
     * Handle sending reset code to email
     */
    private void handleSendResetCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            
            if (email == null || email.trim().isEmpty()) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email is required.\"}");
                return;
            }
            
            // Check if email exists in users table
            if (!emailExists(email.trim())) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email not found in our system.\"}");
                return;
            }
            
            // Check if email service is available
            if (emailService == null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email service not available. Please try again later.\"}");
                return;
            }
            
            // Generate reset code
            String resetCode = emailService.generateVerificationCode();
            
            // Store the code
            resetCodes.put(email.trim(), resetCode);
            
            // Debug logging
            System.out.println("✓ Reset code generated for " + email.trim() + ": " + resetCode);
            System.out.println("✓ Total codes in memory: " + resetCodes.size());
            
            // Send reset email
            boolean emailSent = emailService.sendPasswordResetEmail(email.trim(), resetCode);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (emailSent) {
                response.getWriter().write("{\"success\": true, \"message\": \"Password reset code sent to your email.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to send reset code. Please try again.\"}");
            }
            
        } catch (Exception e) {
            System.err.println("Error in handleSendResetCode: " + e.getMessage());
            e.printStackTrace();
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }
    }
    
    /**
     * Handle verifying reset code
     */
    private void handleVerifyResetCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String resetCode = request.getParameter("resetCode");
            
            if (email == null || email.trim().isEmpty() || 
                resetCode == null || resetCode.trim().isEmpty()) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email and reset code are required.\"}");
                return;
            }
            
            String storedCode = resetCodes.get(email.trim());
            
            // Debug logging
            System.out.println("🔍 Verifying code for " + email.trim());
            System.out.println("🔍 Entered code: " + resetCode.trim());
            System.out.println("🔍 Stored code: " + (storedCode != null ? storedCode : "NULL"));
            System.out.println("🔍 Total codes in memory: " + resetCodes.size());
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (storedCode != null && storedCode.equals(resetCode.trim())) {
                System.out.println("✅ Code verification successful!");
                response.getWriter().write("{\"success\": true, \"message\": \"Reset code verified successfully.\"}");
            } else {
                System.out.println("❌ Code verification failed!");
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid reset code.\"}");
            }
            
        } catch (Exception e) {
            System.err.println("Error in handleVerifyResetCode: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
    
    /**
     * Handle password reset
     */
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String resetCode = request.getParameter("resetCode");
            String newPassword = request.getParameter("newPassword");
            
            if (email == null || email.trim().isEmpty() || 
                resetCode == null || resetCode.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty()) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"All fields are required.\"}");
                return;
            }
            
            // Verify reset code
            String storedCode = resetCodes.get(email.trim());
            if (storedCode == null || !storedCode.equals(resetCode.trim())) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid reset code.\"}");
                return;
            }
            
            // Update password in database
            boolean passwordUpdated = updatePassword(email.trim(), newPassword.trim());
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (passwordUpdated) {
                // Remove the used code
                resetCodes.remove(email.trim());
                response.getWriter().write("{\"success\": true, \"message\": \"Password reset successfully. You can now login with your new password.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to reset password. Please try again.\"}");
            }
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
    
    /**
     * Check if email exists in users table
     */
    private boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Update password in database
     */
    private boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newPassword);
            pstmt.setString(2, email);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
        }
        return false;
    }
}
