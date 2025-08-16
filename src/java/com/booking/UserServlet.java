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
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;

/**
 * Servlet for handling User operations
 */
public class UserServlet extends HttpServlet {

    private FacadeDP facade;
    private ObserverDP.SystemEventManager eventManager;

    // User Model Class
    public static class User {
        private int userId;
        private String username;
        private String password;
        private String email;
        private UserRole role;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public User() {}
        
        public User(int userId, String username, String password, String email, UserRole role) {
            this.userId = userId;
            this.username = username;
            this.password = password;
            this.email = email;
            this.role = role;
        }
        
        // Getters and Setters
        public int getUserId() {
            return userId;
        }
        
        public void setUserId(int userId) {
            this.userId = userId;
        }
        
        public String getUsername() {
            return username;
        }
        
        public void setUsername(String username) {
            this.username = username;
        }
        
        public String getPassword() {
            return password;
        }
        
        public void setPassword(String password) {
            this.password = password;
        }
        
        public String getEmail() {
            return email;
        }
        
        public void setEmail(String email) {
            this.email = email;
        }
        
        public UserRole getRole() {
            return role;
        }
        
        public void setRole(UserRole role) {
            this.role = role;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public Timestamp getUpdatedAt() {
            return updatedAt;
        }
        
        public void setUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
        
        @Override
        public String toString() {
            return "User{" + "userId=" + userId + ", username=" + username + ", email=" + email + ", role=" + role + '}';
        }
    }

    // UserRole Model Class
    public static class UserRole {
        private int roleId;
        private String roleName;
        
        public UserRole() {}
        
        public UserRole(int roleId, String roleName) {
            this.roleId = roleId;
            this.roleName = roleName;
        }
        
        // Getters and Setters
        public int getRoleId() {
            return roleId;
        }
        
        public void setRoleId(int roleId) {
            this.roleId = roleId;
        }
        
        public String getRoleName() {
            return roleName;
        }
        
        public void setRoleName(String roleName) {
            this.roleName = roleName;
        }
        
        @Override
        public String toString() {
            return "UserRole{" + "roleId=" + roleId + ", roleName=" + roleName + '}';
        }
    }

    // User DAO Methods
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (username, password, email, role_id) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setInt(4, user.getRole().getRoleId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean testDatabaseConnection() {
        try (Connection conn = SingletonDP.getInstance().getConnection()) {
            System.out.println("Test connection successful: " + (conn != null ? "YES" : "NO"));
            if (conn != null) {
                System.out.println("Database: " + conn.getMetaData().getDatabaseProductName());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Test connection failed: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM users u " +
                    "LEFT JOIN user_roles r ON u.role_id = r.role_id " +
                    "ORDER BY u.user_id";
        
        System.out.println("Executing SQL: " + sql);
        
        try (Connection conn = SingletonDP.getInstance().getConnection()) {
            System.out.println("Database connection established: " + (conn != null ? "SUCCESS" : "FAILED"));
            if (conn != null) {
                System.out.println("Database: " + conn.getMetaData().getDatabaseProductName() + 
                    " " + conn.getMetaData().getDatabaseProductVersion());
            }
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Set role
                UserRole role = new UserRole();
                int roleId = rs.getInt("role_id");
                String roleName = rs.getString("role_name");
                role.setRoleId(roleId);
                role.setRoleName(roleName);
                user.setRole(role);
                
                System.out.println("Retrieved user: " + user.getUsername() + 
                    ", role_id: " + roleId + ", role_name: " + roleName);
                
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Total users retrieved: " + users.size());
        return users;
    }
    
    public User getUserById(int userId) {
        String sql = "SELECT u.*, r.role_name FROM users u " +
                    "LEFT JOIN user_roles r ON u.role_id = r.role_id " +
                    "WHERE u.user_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    UserRole role = new UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    user.setRole(role);
                    
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
        }
        return null;
    }
    
    public User getUserByUsername(String username) {
        String sql = "SELECT u.*, r.role_name FROM users u " +
                    "LEFT JOIN user_roles r ON u.role_id = r.role_id " +
                    "WHERE u.username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    UserRole role = new UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    user.setRole(role);
                    
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by username: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateUser(User user) {
        // Check if password is empty or null - if so, don't update password
        boolean updatePassword = (user.getPassword() != null && !user.getPassword().trim().isEmpty());
        
        String sql;
        if (updatePassword) {
            sql = "UPDATE users SET username = ?, password = ?, email = ?, role_id = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        } else {
            sql = "UPDATE users SET username = ?, email = ?, role_id = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        }
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int paramIndex = 1;
            pstmt.setString(paramIndex++, user.getUsername());
            
            if (updatePassword) {
                pstmt.setString(paramIndex++, user.getPassword());
            }
            
            pstmt.setString(paramIndex++, user.getEmail());
            pstmt.setInt(paramIndex++, user.getRole().getRoleId());
            pstmt.setInt(paramIndex, user.getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean authenticateUser(String username, String password) {
        String sql = "SELECT password FROM users WHERE username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    return password.equals(storedPassword);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }
        return false;
    }

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

        // Get current user's role
        String currentUserRole = (String) session.getAttribute("role");
        
        // If no action specified, default to list (load the page with data)
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        
        // Check role-based access
        if (!hasAccess(currentUserRole, action)) {
            response.sendRedirect("dashboard.jsp?error=Access denied.");
            return;
        }

        switch (action) {
            case "create":
                handleCreateUser(request, response, session);
                break;
            case "update":
                handleUpdateUser(request, response, session);
                break;
            case "delete":
                handleDeleteUser(request, response, session);
                break;
            case "view":
                handleViewUser(request, response, session);
                break;
            case "list":
                handleListUsers(request, response, session);
                break;
            default:
                response.sendRedirect("user.jsp?error=Invalid action.");
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can manage CASHIER and CUSTOMER users
            return "create".equals(action) || "update".equals(action) || 
                   "delete".equals(action) || "view".equals(action) || "list".equals(action);
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only view users (no create, update, delete)
            return "view".equals(action) || "list".equals(action);
        }
        return false;
    }

    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            if (!canCreateRole(currentUserRole, roleId)) {
                if ("ADMIN".equals(currentUserRole) && roleId == 4) {
                    response.sendRedirect("user.jsp?error=CUSTOMER accounts should be created through customer registration, not user management.");
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to create users with this role.");
                }
                return;
            }

            UserRole role = new UserRole();
            role.setRoleId(roleId);
            
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean success = this.registerUser(user);

            if (success) {
                eventManager.logEvent("User created successfully: " + username, "INFO");
                response.sendRedirect("user.jsp?message=User created successfully.");
            } else {
                eventManager.logEvent("User creation failed: " + username, "ERROR");
                response.sendRedirect("user.jsp?error=Failed to create user. Username or email might already exist.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error creating user: " + e.getMessage());
        }
    }

    private boolean canCreateRole(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            // Admin can only create system users (ADMIN=1, MANAGER=2, CASHIER=3)
            // CUSTOMER (role_id=4) should be created through customer registration
            return targetRoleId >= 1 && targetRoleId <= 3;
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only create CASHIER (role_id=3)
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only create CUSTOMER (role_id=4)
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            // Debug logging
            System.out.println("=== handleUpdateUser Debug ===");
            System.out.println("User ID: " + userId);
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Password: " + (password != null ? (password.isEmpty() ? "EMPTY" : "SET") : "NULL"));
            System.out.println("Role ID: " + roleId);

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            if (!canUpdateUser(currentUserRole, userId, roleId)) {
                response.sendRedirect("user.jsp?error=You don't have permission to update this user.");
                return;
            }

            UserRole role = new UserRole();
            role.setRoleId(roleId);
            
            User user = new User();
            user.setUserId(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean success = this.updateUser(user);

            if (success) {
                eventManager.logEvent("User updated successfully: " + username, "INFO");
                response.sendRedirect("user.jsp?message=User updated successfully.");
            } else {
                eventManager.logEvent("User update failed: " + username, "ERROR");
                response.sendRedirect("user.jsp?error=Failed to update user.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error updating user: " + e.getMessage());
        }
    }

    private boolean canUpdateUser(String currentUserRole, int targetUserId, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can update any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only update CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only update CUSTOMER users
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            User targetUser = this.getUserById(userId);
            
            if (targetUser == null) {
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"User not found.\"}");
                } else {
                    response.sendRedirect("user.jsp?error=User not found.");
                }
                return;
            }

            if (!canDeleteUser(currentUserRole, targetUser.getRole().getRoleId())) {
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"You don't have permission to delete this user.\"}");
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to delete this user.");
                }
                return;
            }

            boolean success = facade.deleteUser(userId);

            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (success) {
                eventManager.logEvent("User deleted successfully: ID " + userId, "INFO");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"User deleted successfully.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("user.jsp?message=User deleted successfully.");
                }
            } else {
                eventManager.logEvent("User deletion failed: ID " + userId, "ERROR");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete user.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("user.jsp?error=Failed to delete user.");
                }
            }

        } catch (Exception e) {
            eventManager.logEvent("User deletion error: " + e.getMessage(), "ERROR");
            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
            
            if (isAjaxRequest) {
                // Return JSON response for AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Error deleting user: " + e.getMessage() + "\"}");
            } else {
                // Redirect for regular requests
                response.sendRedirect("user.jsp?error=Error deleting user: " + e.getMessage());
            }
        }
    }

    private boolean canDeleteUser(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can delete any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only delete CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only delete CUSTOMER users
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleViewUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            User user = this.getUserById(userId);
            
            if (user != null) {
                // Check if current user has permission to view this user
                String currentUserRole = (String) session.getAttribute("role");
                if (canViewUser(currentUserRole, user.getRole().getRoleId())) {
                    request.setAttribute("user", user);
                    request.setAttribute("userRoles", this.getAllUserRoles());
                    request.getRequestDispatcher("user_edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to view this user.");
                }
            } else {
                response.sendRedirect("user.jsp?error=User not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error viewing user: " + e.getMessage());
        }
    }

    private boolean canViewUser(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can view any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only view CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can view CASHIER and CUSTOMER users
            return targetRoleId == 3 || targetRoleId == 4;
        }
        return false;
    }

    private void handleListUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<User> allUsers = this.getAllUsers();
            String currentUserRole = (String) session.getAttribute("role");
            
            // Filter users based on current user's role
            List<User> filteredUsers = filterUsersByRole(allUsers, currentUserRole);
            
            request.setAttribute("users", filteredUsers);
            request.setAttribute("userRoles", this.getAllUserRoles());
            
            // Preserve any message or error parameters
            String message = request.getParameter("message");
            String error = request.getParameter("error");
            
            if (message != null && !message.isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.isEmpty()) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("user.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("User list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error loading users: " + e.getMessage());
        }
    }

    private List<User> filterUsersByRole(List<User> allUsers, String currentUserRole) {
        if ("ADMIN".equals(currentUserRole)) {
            return allUsers; // Admin can see all users
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only see CASHIER users
            return allUsers.stream()
                .filter(user -> {
                    int roleId = user.getRole().getRoleId();
                    return roleId == 3;
                })
                .collect(java.util.stream.Collectors.toList());
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can see CASHIER and CUSTOMER users
            return allUsers.stream()
                .filter(user -> {
                    int roleId = user.getRole().getRoleId();
                    return roleId == 3 || roleId == 4;
                })
                .collect(java.util.stream.Collectors.toList());
        }
                return new java.util.ArrayList<>();
    }
    
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
    
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role_id, created_at) VALUES (?, ?, ?, ?, NOW())";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setInt(4, user.getRole().getRoleId());
            
            int result = pstmt.executeUpdate();
            System.out.println("User creation result: " + result + " rows affected");
            
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
            return false;
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
        return "User Management Servlet";
    }
} 