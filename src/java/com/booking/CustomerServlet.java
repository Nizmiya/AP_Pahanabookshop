package com.booking;

import com.booking.UserServlet.User;
import com.booking.UserServlet.UserRole;
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
import com.booking.EmailService;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;

/**
 * Servlet for handling Customer operations
 */
public class CustomerServlet extends HttpServlet {

    private FacadeDP facade;
    private ObserverDP.SystemEventManager eventManager;

    // Customer Model Class
    public static class Customer {
        private int customerId;
        private String accountNumber;
        private String name;
        private String address;
        private String phone;
        private String username;
        private String email;
        private String password;
        private UserRole role;
        private User createdBy;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public Customer() {}
        
        public Customer(int customerId, String accountNumber, String name, String address, String phone) {
            this.customerId = customerId;
            this.accountNumber = accountNumber;
            this.name = name;
            this.address = address;
            this.phone = phone;
        }
        
        // Getters and Setters
        public int getCustomerId() {
            return customerId;
        }
        
        public void setCustomerId(int customerId) {
            this.customerId = customerId;
        }
        
        public String getAccountNumber() {
            return accountNumber;
        }
        
        public void setAccountNumber(String accountNumber) {
            this.accountNumber = accountNumber;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getAddress() {
            return address;
        }
        
        public void setAddress(String address) {
            this.address = address;
        }
        
        public String getPhone() {
            return phone;
        }
        
        public void setPhone(String phone) {
            this.phone = phone;
        }
        
        public String getUsername() {
            return username;
        }
        
        public void setUsername(String username) {
            this.username = username;
        }
        
        public String getEmail() {
            return email;
        }
        
        public void setEmail(String email) {
            this.email = email;
        }
        
        public String getPassword() {
            return password;
        }
        
        public void setPassword(String password) {
            this.password = password;
        }
        
        public UserRole getRole() {
            return role;
        }
        
        public void setRole(UserRole role) {
            this.role = role;
        }
        
        public User getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(User createdBy) {
            this.createdBy = createdBy;
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
            return "Customer{" + "customerId=" + customerId + ", accountNumber=" + accountNumber + ", name=" + name + ", phone=" + phone + '}';
        }
    }

    // Customer DAO Methods
    public boolean createCustomer(Customer customer) {
        String sql = "INSERT INTO customers (account_number, name, address, phone, username, email, password, role_id, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        // Debug logging
        System.out.println("Creating customer with data:");
        System.out.println("  Account Number: " + customer.getAccountNumber());
        System.out.println("  Name: " + customer.getName());
        System.out.println("  Address: " + customer.getAddress());
        System.out.println("  Phone: " + customer.getPhone());
        System.out.println("  Username: " + customer.getUsername());
        System.out.println("  Email: " + customer.getEmail());
        System.out.println("  Password: " + (customer.getPassword() != null ? "SET" : "NULL"));
        System.out.println("  Role: " + (customer.getRole() != null ? "ID=" + customer.getRole().getRoleId() : "NULL"));
        System.out.println("  Created By: " + (customer.getCreatedBy() != null ? "ID=" + customer.getCreatedBy().getUserId() : "NULL"));
        
        try (Connection conn = SingletonDP.getInstance().getConnection()) {
            System.out.println("Database connection: " + (conn != null ? "SUCCESS" : "FAILED"));
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, customer.getAccountNumber());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getUsername());
            pstmt.setString(6, customer.getEmail());
            pstmt.setString(7, customer.getPassword());
            pstmt.setInt(8, customer.getRole().getRoleId());
            pstmt.setInt(9, customer.getCreatedBy().getUserId());
            
            int result = pstmt.executeUpdate();
            System.out.println("SQL execute result: " + result + " rows affected");
            
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error creating customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("Unexpected error creating customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT c.*, u.username as created_by_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "ORDER BY c.customer_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Set role
                if (rs.getInt("role_id") > 0) {
                    UserRole role = new UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    customer.setRole(role);
                }
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                customer.setCreatedBy(createdBy);
                
                customers.add(customer);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all customers: " + e.getMessage());
        }
        return customers;
    }
    
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT c.*, u.username as created_by_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "WHERE c.customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    if (rs.getInt("role_id") > 0) {
                        UserRole role = new UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        customer.setRole(role);
                    }
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET account_number = ?, name = ?, address = ?, phone = ?, username = ?, email = ?, password = ?, role_id = ?, updated_at = CURRENT_TIMESTAMP WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customer.getAccountNumber());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getUsername());
            pstmt.setString(6, customer.getEmail());
            pstmt.setString(7, customer.getPassword());
            pstmt.setInt(8, customer.getRole().getRoleId());
            pstmt.setInt(9, customer.getCustomerId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating customer: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteCustomer(int customerId) {
        String sql = "DELETE FROM customers WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            return false;
        }
    }
    
    public Customer getCustomerByUsername(String username) {
        System.out.println("CustomerServlet: Getting customer by username: " + username);
        String sql = "SELECT c.*, u.username as created_by_name, ur.role_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "LEFT JOIN user_roles ur ON c.role_id = ur.role_id " +
                    "WHERE c.username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("CustomerServlet: Customer found in database");
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    if (rs.getInt("role_id") > 0) {
                        UserRole role = new UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        role.setRoleName(rs.getString("role_name"));
                        customer.setRole(role);
                    }
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                } else {
                    System.out.println("CustomerServlet: No customer found with username: " + username);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by username: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT c.*, u.username as created_by_name, ur.role_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "LEFT JOIN user_roles ur ON c.role_id = ur.role_id " +
                    "WHERE c.email = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    if (rs.getInt("role_id") > 0) {
                        UserRole role = new UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        role.setRoleName(rs.getString("role_name"));
                        customer.setRole(role);
                    }
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by email: " + e.getMessage());
        }
        return null;
    }
    
    public boolean authenticateCustomer(String username, String password) {
        System.out.println("CustomerServlet: Authenticating customer with username: " + username);
        String sql = "SELECT password FROM customers WHERE username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    boolean result = password.equals(storedPassword);
                    System.out.println("CustomerServlet: Password comparison result: " + result);
                    return result;
                } else {
                    System.out.println("CustomerServlet: No customer found with username: " + username);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating customer: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM customers WHERE username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
        }
        return false;
    }
    
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM customers WHERE email = ?";
        
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
    
    public int getCustomerTransactionCount(int customerId) {
        String sql = "SELECT COUNT(*) FROM transactions WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, String.valueOf(customerId));
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer transaction count: " + e.getMessage());
        }
        return 0;
    }
    
    public String generateUniqueAccountNumber() {
        String sql = "SELECT MAX(CAST(SUBSTRING(account_number, 2) AS UNSIGNED)) FROM customers WHERE account_number LIKE 'C%'";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int maxNumber = rs.getInt(1);
                    return "C" + String.format("%06d", maxNumber + 1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error generating unique account number: " + e.getMessage());
        }
        
        // Fallback: return a default account number
        return "C000001";
    }
    
    private String getRoleNameById(int roleId) {
        String sql = "SELECT role_name FROM user_roles WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("role_name");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting role name by ID: " + e.getMessage());
        }
        return null;
    }

    // Static map to store email verification codes (in production, use Redis or database)
    private static final java.util.Map<String, String> emailVerificationCodes = new java.util.HashMap<>();
    private static EmailService emailService;
    
    static {
        try {
            System.out.println("=== CustomerServlet Static Initialization ===");
            emailService = new EmailService();
            System.out.println("✓ EmailService initialized in CustomerServlet");
        } catch (Throwable e) {
            System.err.println("✗ Failed to initialize EmailService: " + e.getClass().getSimpleName() + ": " + e.getMessage());
            e.printStackTrace();
            emailService = null;
        }
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
        
        // If no action specified, default to list (load the page with data)
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        // Handle customer registration and email verification (no authentication required)
        if ("register".equals(action)) {
            handleCustomerRegistration(request, response);
            return;
        }
        
        // Handle email verification (no authentication required)
        if ("sendVerificationCode".equals(action)) {
            handleSendVerificationCode(request, response);
            return;
        }
        
        if ("verifyEmail".equals(action)) {
            handleVerifyEmail(request, response);
            return;
        }
        
        // For other actions, require authentication
        System.out.println("Session check - Session: " + (session != null ? "EXISTS" : "NULL"));
        if (session != null) {
            System.out.println("Session user: " + (session.getAttribute("user") != null ? "EXISTS" : "NULL"));
            System.out.println("Session ID: " + session.getId());
        }
        
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("Authentication failed - redirecting to login");
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        switch (action) {
            case "create":
                handleCreateCustomer(request, response, session);
                break;
            case "update":
                handleUpdateCustomer(request, response, session);
                break;
            case "delete":
                handleDeleteCustomer(request, response, session);
                break;
            case "view":
                handleViewCustomer(request, response, session);
                break;
            case "list":
                handleListCustomers(request, response, session);
                break;
            default:
                response.sendRedirect("customer.jsp?error=Invalid action.");
        }
    }

    private void handleCustomerRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=All fields are required.");
                return;
            }

            // Generate unique account number
            String accountNumber = this.generateUniqueAccountNumber();

            // Check if username already exists
            if (this.isUsernameExists(username.trim())) {
                response.sendRedirect("login.jsp?error=Username already exists.");
                return;
            }

            // Check if email already exists
            if (this.isEmailExists(email.trim())) {
                response.sendRedirect("login.jsp?error=Email already exists.");
                return;
            }

            Customer customer = new Customer();
            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);
            
            // Set role to CUSTOMER (role_id = 4)
            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            customer.setRole(role);
            
            // For customer registration, set created_by to null or a default admin user
            // You might want to create a default admin user or handle this differently
            User defaultAdmin = new User();
            defaultAdmin.setUserId(1); // Assuming admin user_id is 1
            customer.setCreatedBy(defaultAdmin);

            boolean success = this.createCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer registered successfully: " + accountNumber, "INFO");
                response.sendRedirect("login.jsp?message=Registration successful! You can now login with your username and password.");
            } else {
                eventManager.logEvent("Customer registration failed: " + accountNumber, "ERROR");
                response.sendRedirect("login.jsp?error=Failed to create account. Please try again.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer registration error: " + e.getMessage(), "ERROR");
            response.sendRedirect("login.jsp?error=Error creating account: " + e.getMessage());
        }
    }

    private void handleCreateCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            // Debug: Log all received parameters
            System.out.println("=== handleCreateCustomer Debug ===");
            System.out.println("Request method: " + request.getMethod());
            System.out.println("Content type: " + request.getContentType());
            
            // Log all parameter names
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            System.out.println("All parameter names:");
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println("  " + paramName + " = " + (paramValue != null ? paramValue : "NULL"));
            }
            
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            System.out.println("Extracted parameters:");
            System.out.println("  name = " + name);
            System.out.println("  address = " + address);
            System.out.println("  phone = " + phone);
            System.out.println("  username = " + username);
            System.out.println("  email = " + email);
            System.out.println("  password = " + password);

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                System.out.println("Validation failed - redirecting with error");
                response.sendRedirect("customer.jsp?error=All fields are required.");
                return;
            }

            // Generate unique account number
            String accountNumber = this.generateUniqueAccountNumber();

            // Check if username already exists
            if (this.isUsernameExists(username.trim())) {
                response.sendRedirect("customer.jsp?error=Username already exists.");
                return;
            }

            // Check if email already exists
            if (this.isEmailExists(email.trim())) {
                response.sendRedirect("customer.jsp?error=Email already exists.");
                return;
            }

            Customer customer = new Customer();
            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);
            
            // Set role to CUSTOMER (role_id = 4)
            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            customer.setRole(role);
            
            // Debug session user
            User sessionUser = (User) session.getAttribute("user");
            System.out.println("Session user: " + (sessionUser != null ? sessionUser.getUsername() : "NULL"));
            System.out.println("Session user ID: " + (sessionUser != null ? sessionUser.getUserId() : "NULL"));
            
            customer.setCreatedBy(sessionUser);

            boolean success = this.createCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer created successfully: " + accountNumber, "INFO");
                response.sendRedirect("customer.jsp?message=Customer created successfully.");
            } else {
                eventManager.logEvent("Customer creation failed: " + accountNumber, "ERROR");
                response.sendRedirect("customer.jsp?error=Failed to create customer.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error creating customer: " + e.getMessage());
        }
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String accountNumber = request.getParameter("account_number");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            Customer customer = this.getCustomerById(customerId);
            if (customer == null) {
                response.sendRedirect("customer.jsp?error=Customer not found.");
                return;
            }

            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);

            boolean success = this.updateCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer updated successfully: " + accountNumber, "INFO");
                response.sendRedirect("customer.jsp?message=Customer updated successfully.");
            } else {
                eventManager.logEvent("Customer update failed: " + accountNumber, "ERROR");
                response.sendRedirect("customer.jsp?error=Failed to update customer.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error updating customer: " + e.getMessage());
        }
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));

            // Check if customer has transactions before attempting deletion
            int transactionCount = this.getCustomerTransactionCount(customerId);
            
            if (transactionCount > 0) {
                eventManager.logEvent("Customer deletion blocked: ID " + customerId + " has " + transactionCount + " transactions", "WARNING");
                
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?error=Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.");
                }
                return;
            }

            boolean success = this.deleteCustomer(customerId);

            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (success) {
                eventManager.logEvent("Customer deleted successfully: ID " + customerId, "INFO");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"Customer deleted successfully.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?message=Customer deleted successfully.");
                }
            } else {
                eventManager.logEvent("Customer deletion failed: ID " + customerId, "ERROR");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete customer. Please try again.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?error=Failed to delete customer. Please try again.");
                }
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer deletion error: " + e.getMessage(), "ERROR");
            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
            
            if (isAjaxRequest) {
                // Return JSON response for AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Error deleting customer: " + e.getMessage() + "\"}");
            } else {
                // Redirect for regular requests
                response.sendRedirect("customer.jsp?error=Error deleting customer: " + e.getMessage());
            }
        }
    }

    private void handleViewCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            Customer customer = this.getCustomerById(customerId);
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("customer.jsp?error=Customer not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error viewing customer: " + e.getMessage());
        }
    }

    private void handleListCustomers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<Customer> customers = this.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("customer.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("Customer list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error loading customers: " + e.getMessage());
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
        return "Customer Management Servlet";
    }
    
    /**
     * Handle sending verification code to email
     */
    private void handleSendVerificationCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            
            if (email == null || email.trim().isEmpty()) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email is required.\"}");
                return;
            }
            
            // Check if email service is available
            if (emailService == null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email service not available. Please try again later.\"}");
                return;
            }
            
            // Generate verification code
            String verificationCode = emailService.generateVerificationCode();
            
            // Store the code (in production, use Redis or database with expiration)
            emailVerificationCodes.put(email.trim(), verificationCode);
            
            // Send verification email
            boolean emailSent = emailService.sendVerificationEmail(email.trim(), verificationCode);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (emailSent) {
                response.getWriter().write("{\"success\": true, \"message\": \"Verification code sent to your email.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to send verification code. Please try again.\"}");
            }
            
        } catch (Throwable e) {
            System.err.println("=== Error in handleSendVerificationCode ===");
            System.err.println("Exception type: " + e.getClass().getSimpleName());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getClass().getSimpleName() + "\"}");
        }
    }
    
    /**
     * Handle email verification
     */
    private void handleVerifyEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String verificationCode = request.getParameter("verificationCode");
            
            if (email == null || email.trim().isEmpty() || 
                verificationCode == null || verificationCode.trim().isEmpty()) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Email and verification code are required.\"}");
                return;
            }
            
            String storedCode = emailVerificationCodes.get(email.trim());
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (storedCode != null && storedCode.equals(verificationCode.trim())) {
                // Remove the used code
                emailVerificationCodes.remove(email.trim());
                response.getWriter().write("{\"success\": true, \"message\": \"Email verified successfully.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid verification code.\"}");
            }
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
} 