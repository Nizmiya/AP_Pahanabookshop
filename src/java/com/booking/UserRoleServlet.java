package com.booking;

import com.booking.UserServlet.UserRole;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.booking.patterns.SingletonDP;

/**
 * Servlet for handling user role management operations (Admin only)
 */
public class UserRoleServlet extends HttpServlet {

    private FacadeDP facade;
    private ObserverDP.SystemEventManager eventManager;

    @Override
    public void init() throws ServletException {
        super.init();
        facade = new FacadeDP();
        eventManager = ObserverDP.SystemEventManager.getInstance();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        // Check if user is admin (only admin can manage user roles)
        String currentUserRole = (String) session.getAttribute("role");
        if (!"ADMIN".equals(currentUserRole)) {
            response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators can manage user roles.");
            return;
        }

        // If no action specified, default to list (load the page with data)
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "create":
                handleCreateUserRole(request, response, session);
                break;
            case "update":
                handleUpdateUserRole(request, response, session);
                break;
            case "delete":
                handleDeleteUserRole(request, response, session);
                break;
            case "view":
                handleViewUserRole(request, response, session);
                break;
            case "list":
                handleListUserRoles(request, response, session);
                break;
            default:
                response.sendRedirect("user_role.jsp?error=Invalid action.");
        }
    }

    private void handleCreateUserRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String roleName = request.getParameter("role_name");

            if (roleName == null || roleName.trim().isEmpty()) {
                response.sendRedirect("user_role.jsp?error=Role name is required.");
                return;
            }

            // Check if role already exists
            List<UserRole> existingRoles = this.getAllUserRoles();
            if (existingRoles.stream().anyMatch(role -> role.getRoleName().equalsIgnoreCase(roleName.trim()))) {
                response.sendRedirect("user_role.jsp?error=Role name already exists.");
                return;
            }

            UserRole userRole = new UserRole();
            userRole.setRoleName(roleName.trim().toUpperCase());

            boolean success = this.createUserRole(userRole);

            if (success) {
                eventManager.logEvent("User role created successfully: " + roleName, "INFO");
                response.sendRedirect("user_role.jsp?message=User role created successfully.");
            } else {
                eventManager.logEvent("User role creation failed: " + roleName, "ERROR");
                response.sendRedirect("user_role.jsp?error=Failed to create user role.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User role creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user_role.jsp?error=Error creating user role: " + e.getMessage());
        }
    }

    private void handleUpdateUserRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int roleId = Integer.parseInt(request.getParameter("role_id"));
            String roleName = request.getParameter("role_name");

            if (roleName == null || roleName.trim().isEmpty()) {
                response.sendRedirect("user_role.jsp?error=Role name is required.");
                return;
            }

            // Check if role already exists (excluding current role)
            List<UserRole> existingRoles = facade.getAllUserRoles();
            if (existingRoles.stream().anyMatch(role -> 
                role.getRoleId() != roleId && role.getRoleName().equalsIgnoreCase(roleName.trim()))) {
                response.sendRedirect("user_role.jsp?error=Role name already exists.");
                return;
            }

            UserRole userRole = new UserRole();
            userRole.setRoleId(roleId);
            userRole.setRoleName(roleName.trim().toUpperCase());

            boolean success = this.updateUserRole(userRole);

            if (success) {
                eventManager.logEvent("User role updated successfully: " + roleName, "INFO");
                response.sendRedirect("user_role.jsp?message=User role updated successfully.");
            } else {
                eventManager.logEvent("User role update failed: " + roleName, "ERROR");
                response.sendRedirect("user_role.jsp?error=Failed to update user role.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User role update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user_role.jsp?error=Error updating user role: " + e.getMessage());
        }
    }

    private void handleDeleteUserRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            // Check if role is being used by any users
            // This is a basic check - in a real system, you'd want more sophisticated validation
            if (roleId <= 4) { // Prevent deletion of core roles (ADMIN, MANAGER, CASHIER, CUSTOMER)
                response.sendRedirect("user_role.jsp?error=Cannot delete core system roles.");
                return;
            }

            boolean success = this.deleteUserRole(roleId);

            if (success) {
                eventManager.logEvent("User role deleted successfully: ID " + roleId, "INFO");
                response.sendRedirect("user_role.jsp?message=User role deleted successfully.");
            } else {
                eventManager.logEvent("User role deletion failed: ID " + roleId, "ERROR");
                response.sendRedirect("user_role.jsp?error=Failed to delete user role.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User role deletion error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user_role.jsp?error=Error deleting user role: " + e.getMessage());
        }
    }

    private void handleViewUserRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int roleId = Integer.parseInt(request.getParameter("role_id"));
            UserRole userRole = this.getUserRoleById(roleId);
            
            if (userRole != null) {
                request.setAttribute("userRole", userRole);
                request.getRequestDispatcher("user_role_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("user_role.jsp?error=User role not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User role view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user_role.jsp?error=Error viewing user role: " + e.getMessage());
        }
    }

    private void handleListUserRoles(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<UserRole> userRoles = this.getAllUserRoles();
            request.setAttribute("userRoles", userRoles);
            request.getRequestDispatcher("user_role.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("User role list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user_role.jsp?error=Error loading user roles: " + e.getMessage());
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

    // UserRole DAO Methods
    public List<UserRole> getAllUserRoles() {
        List<UserRole> userRoles = new ArrayList<>();
        String sql = "SELECT * FROM user_roles ORDER BY role_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                UserRole userRole = new UserRole();
                userRole.setRoleId(rs.getInt("role_id"));
                userRole.setRoleName(rs.getString("role_name"));
                userRoles.add(userRole);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all user roles: " + e.getMessage());
            e.printStackTrace();
        }
        return userRoles;
    }
    
    public boolean createUserRole(UserRole userRole) {
        String sql = "INSERT INTO user_roles (role_name) VALUES (?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userRole.getRoleName());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user role: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateUserRole(UserRole userRole) {
        String sql = "UPDATE user_roles SET role_name = ? WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userRole.getRoleName());
            pstmt.setInt(2, userRole.getRoleId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user role: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUserRole(int roleId) {
        String sql = "DELETE FROM user_roles WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user role: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public UserRole getUserRoleById(int roleId) {
        String sql = "SELECT * FROM user_roles WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    UserRole userRole = new UserRole();
                    userRole.setRoleId(rs.getInt("role_id"));
                    userRole.setRoleName(rs.getString("role_name"));
                    return userRole;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user role by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public String getServletInfo() {
        return "User Role Management Servlet";
    }
} 