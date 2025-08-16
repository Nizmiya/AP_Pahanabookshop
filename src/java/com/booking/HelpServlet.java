package com.booking;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import com.booking.patterns.SingletonDP;

/**
 * Servlet for handling Help operations
 */
public class HelpServlet extends HttpServlet {

    // HelpSection Model Class
    public static class HelpSection {
        private int helpId;
        private String title;
        private String content;
        
        public HelpSection() {}
        
        public HelpSection(int helpId, String title, String content) {
            this.helpId = helpId;
            this.title = title;
            this.content = content;
        }
        
        // Getters and Setters
        public int getHelpId() {
            return helpId;
        }
        
        public void setHelpId(int helpId) {
            this.helpId = helpId;
        }
        
        public String getTitle() {
            return title;
        }
        
        public void setTitle(String title) {
            this.title = title;
        }
        
        public String getContent() {
            return content;
        }
        
        public void setContent(String content) {
            this.content = content;
        }
        
        @Override
        public String toString() {
            return "HelpSection{" + "helpId=" + helpId + ", title=" + title + '}';
        }
    }

    // HelpSection DAO Methods
    public boolean createHelpSection(HelpSection helpSection) {
        String sql = "INSERT INTO help_sections (title, content) VALUES (?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating help section: " + e.getMessage());
            return false;
        }
    }
    
    public List<HelpSection> getAllHelpSections() {
        List<HelpSection> helpSections = new ArrayList<>();
        String sql = "SELECT * FROM help_sections ORDER BY help_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                HelpSection helpSection = new HelpSection();
                helpSection.setHelpId(rs.getInt("help_id"));
                helpSection.setTitle(rs.getString("title"));
                helpSection.setContent(rs.getString("content"));
                
                helpSections.add(helpSection);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all help sections: " + e.getMessage());
        }
        return helpSections;
    }
    
    public HelpSection getHelpSectionById(int helpId) {
        String sql = "SELECT * FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    HelpSection helpSection = new HelpSection();
                    helpSection.setHelpId(rs.getInt("help_id"));
                    helpSection.setTitle(rs.getString("title"));
                    helpSection.setContent(rs.getString("content"));
                    
                    return helpSection;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help section by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateHelpSection(HelpSection helpSection) {
        String sql = "UPDATE help_sections SET title = ?, content = ? WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            pstmt.setInt(3, helpSection.getHelpId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating help section: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteHelpSection(int helpId) {
        String sql = "DELETE FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting help section: " + e.getMessage());
            return false;
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can manage help content (create, update, delete, view, list)
            return "create".equals(action) || "update".equals(action) || 
                   "delete".equals(action) || "view".equals(action) || "list".equals(action);
        } else if ("CASHIER".equals(currentUserRole) || "CUSTOMER".equals(currentUserRole)) {
            // Cashier and Customer can only view help content
            return "view".equals(action) || "list".equals(action);
        }
        return false;
    }

    private void handleCreateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Title and content are required.");
                return;
            }

            HelpSection helpSection = new HelpSection();
            helpSection.setTitle(title.trim());
            helpSection.setContent(content.trim());

            boolean success = createHelpSection(helpSection);

            if (success) {
                // eventManager.logEvent("Help section created successfully: " + title, "INFO"); // Removed
                response.sendRedirect("help.jsp?message=Help section created successfully.");
            } else {
                // eventManager.logEvent("Help section creation failed: " + title, "ERROR"); // Removed
                response.sendRedirect("help.jsp?error=Failed to create help section.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section creation error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error creating help section: " + e.getMessage());
        }
    }

    private void handleUpdateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Title and content are required.");
                return;
            }

            HelpSection helpSection = new HelpSection();
            helpSection.setHelpId(helpId);
            helpSection.setTitle(title.trim());
            helpSection.setContent(content.trim());

            boolean success = updateHelpSection(helpSection);

            if (success) {
                // eventManager.logEvent("Help section updated successfully: " + title, "INFO"); // Removed
                response.sendRedirect("help.jsp?message=Help section updated successfully.");
            } else {
                // eventManager.logEvent("Help section update failed: " + title, "ERROR"); // Removed
                response.sendRedirect("help.jsp?error=Failed to update help section.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section update error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error updating help section: " + e.getMessage());
        }
    }

    private void handleDeleteHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));

            boolean success = deleteHelpSection(helpId);

            if (success) {
                // eventManager.logEvent("Help section deleted successfully: ID " + helpId, "INFO"); // Removed
                response.sendRedirect("help.jsp?message=Help section deleted successfully.");
            } else {
                // eventManager.logEvent("Help section deletion failed: ID " + helpId, "ERROR"); // Removed
                response.sendRedirect("help.jsp?error=Failed to delete help section.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section deletion error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error deleting help section: " + e.getMessage());
        }
    }

    private void handleViewHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));
            HelpSection helpSection = getHelpSectionById(helpId);
            
            if (helpSection != null) {
                request.setAttribute("helpSection", helpSection);
                request.getRequestDispatcher("help_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("help.jsp?error=Help section not found.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section view error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error viewing help section: " + e.getMessage());
        }
    }

    private void handleListHelpSections(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<HelpSection> helpSections = getAllHelpSections();
            request.setAttribute("helpSections", helpSections);
            request.getRequestDispatcher("help.jsp").forward(request, response);

        } catch (Exception e) {
            // eventManager.logEvent("Help section list error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error loading help sections: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET requests directly
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        // Get session
        HttpSession session = request.getSession(false);
        
        try {
            switch (action) {
                case "create":
                    handleCreateHelpSection(request, response, session);
                    break;
                case "update":
                    handleUpdateHelpSection(request, response, session);
                    break;
                case "delete":
                    handleDeleteHelpSection(request, response, session);
                    break;
                case "view":
                    handleViewHelpSection(request, response, session);
                    break;
                case "list":
                default:
                    handleListHelpSections(request, response, session);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in HelpServlet: " + e.getMessage());
            response.sendRedirect("help.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests directly
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Help Content Management Servlet";
    }
} 