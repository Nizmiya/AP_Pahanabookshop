package com.booking;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * Database Utility Class Handles database connection and table creation
 */
public class DatabaseUtil {

    // Load MySQL driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    private static boolean isInitialized = false;

    /**
     * Initialize database and create tables if they don't exist
     */
    public static void initializeDatabase() {
        if (isInitialized) {
            System.out.println("Database already initialized, skipping...");
            return;
        }

        System.out.println("Starting database initialization...");
        Connection connection = null;
        try {
            // Get database connection
            System.out.println("Getting database connection...");
            connection = getConnection();
            System.out.println("Database connection obtained successfully");

            // Create tables in order (respecting foreign key dependencies)
            createUserRolesTable(connection);
            createUsersTable(connection);
            createCustomersTable(connection);
            createBookCategoriesTable(connection);
            createBooksTable(connection);
            createTransactionsTable(connection);
            createTransactionItemsTable(connection);
            createHelpSectionsTable(connection);

            // Insert initial data
            insertInitialData(connection);

            isInitialized = true;
            System.out.println("Database initialization completed successfully!");

        } catch (Exception e) {
            System.err.println("Error initializing database: " + e.getMessage());
            isInitialized = false; // Reset flag so we can try again
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                    System.out.println("Database connection closed");
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    /**
     * Get database connection
     * @return 
     * @throws java.lang.Exception
     */
    public static Connection getConnection() throws Exception {
        // Try to get connection from JNDI first
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/booking");
            Connection conn = ds.getConnection();
            System.out.println("JNDI connection successful");
            return conn;
        } catch (SQLException | NamingException e) {
            // Fallback to direct connection if JNDI fails
            System.out.println("JNDI connection failed, using direct connection: " + e.getMessage());
            String url = "jdbc:mysql://localhost:3306/booking?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            String username = "root";
            String password = "password";
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println("Direct connection successful");
            return conn;
        }
    }

    /**
     * Check if a table exists in the database
     */
    private static boolean tableExists(Connection connection, String tableName) throws SQLException {
        DatabaseMetaData metaData = connection.getMetaData();
        String catalog = connection.getCatalog(); // Get current database name
        System.out.println("Checking for table '" + tableName + "' in database '" + catalog + "'");

        ResultSet tables = metaData.getTables(catalog, null, tableName, new String[]{"TABLE"});
        boolean exists = tables.next();
        System.out.println("Table '" + tableName + "' exists: " + exists);
        return exists;
    }

    /**
     * Create the user_roles table
     */
    private static void createUserRolesTable(Connection connection) throws SQLException {
        if (tableExists(connection, "user_roles")) {
            System.out.println("user_roles table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE user_roles ("
                + "role_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "role_name VARCHAR(50) UNIQUE NOT NULL"
                + ")";

        System.out.println("Creating user_roles table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("user_roles table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating user_roles table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the users table
     */
    private static void createUsersTable(Connection connection) throws SQLException {
        if (tableExists(connection, "users")) {
            System.out.println("users table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE users ("
                + "user_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "username VARCHAR(100) UNIQUE NOT NULL,"
                + "password VARCHAR(255) NOT NULL,"
                + "email VARCHAR(100) UNIQUE NOT NULL,"
                + "role_id INT,"
                + "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
                + "updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,"
                + "FOREIGN KEY (role_id) REFERENCES user_roles(role_id)"
                + ")";

        System.out.println("Creating users table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("users table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating users table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the customers table
     */
    private static void createCustomersTable(Connection connection) throws SQLException {
        if (tableExists(connection, "customers")) {
            System.out.println("customers table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE customers ("
                + "customer_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "account_number VARCHAR(50) UNIQUE NOT NULL,"
                + "name VARCHAR(100) NOT NULL,"
                + "address TEXT NOT NULL,"
                + "phone VARCHAR(15) NOT NULL,"
                + "username VARCHAR(100) UNIQUE,"
                + "email VARCHAR(100) UNIQUE,"
                + "password VARCHAR(255),"
                + "role_id INT DEFAULT 4,"
                + "created_by INT,"
                + "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
                + "updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,"
                + "FOREIGN KEY (created_by) REFERENCES users(user_id),"
                + "FOREIGN KEY (role_id) REFERENCES user_roles(role_id)"
                + ")";

        System.out.println("Creating customers table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("customers table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating customers table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the book_categories table
     */
    private static void createBookCategoriesTable(Connection connection) throws SQLException {
        if (tableExists(connection, "book_categories")) {
            System.out.println("book_categories table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE book_categories ("
                + "category_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "category_name VARCHAR(100) UNIQUE NOT NULL"
                + ")";

        System.out.println("Creating book_categories table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("book_categories table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating book_categories table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the books table
     */
    private static void createBooksTable(Connection connection) throws SQLException {
        if (tableExists(connection, "books")) {
            System.out.println("books table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE books ("
                + "book_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "title VARCHAR(150) NOT NULL,"
                + "description TEXT,"
                + "price_per_unit DECIMAL(10,2) NOT NULL,"
                + "stock_quantity INT NOT NULL,"
                + "category_id INT,"
                + "created_by INT,"
                + "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
                + "FOREIGN KEY (category_id) REFERENCES book_categories(category_id),"
                + "FOREIGN KEY (created_by) REFERENCES users(user_id)"
                + ")";

        System.out.println("Creating books table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("books table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating books table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the transactions table
     */
    private static void createTransactionsTable(Connection connection) throws SQLException {
        if (tableExists(connection, "transactions")) {
            System.out.println("transactions table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE transactions ("
                + "transaction_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "customer_id INT,"
                + "total_amount DECIMAL(10,2) NOT NULL,"
                + "created_by INT,"
                + "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
                + "FOREIGN KEY (customer_id) REFERENCES customers(customer_id),"
                + "FOREIGN KEY (created_by) REFERENCES users(user_id)"
                + ")";

        System.out.println("Creating transactions table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("transactions table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating transactions table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the transaction_items table
     */
    private static void createTransactionItemsTable(Connection connection) throws SQLException {
        if (tableExists(connection, "transaction_items")) {
            System.out.println("transaction_items table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE transaction_items ("
                + "transaction_item_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "transaction_id INT,"
                + "book_id INT,"
                + "quantity INT NOT NULL,"
                + "price DECIMAL(10,2) NOT NULL,"
                + "FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),"
                + "FOREIGN KEY (book_id) REFERENCES books(book_id)"
                + ")";

        System.out.println("Creating transaction_items table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("transaction_items table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating transaction_items table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Create the help_sections table
     */
    private static void createHelpSectionsTable(Connection connection) throws SQLException {
        if (tableExists(connection, "help_sections")) {
            System.out.println("help_sections table already exists.");
            return;
        }

        String createTableSQL = "CREATE TABLE help_sections ("
                + "help_id INT PRIMARY KEY AUTO_INCREMENT,"
                + "title VARCHAR(150) NOT NULL,"
                + "content TEXT NOT NULL,"
                + "role_id INT NOT NULL,"
                + "FOREIGN KEY (role_id) REFERENCES user_roles(role_id)"
                + ")";

        System.out.println("Creating help_sections table...");
        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("help_sections table created successfully!");
        } catch (SQLException e) {
            System.err.println("Error creating help_sections table: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Insert initial data into the database
     */
    private static void insertInitialData(Connection connection) throws SQLException {
        System.out.println("Inserting initial data...");
        
        // Insert user roles
        insertUserRoles(connection);
        
        // Insert admin user
        insertAdminUser(connection);
        
        System.out.println("Initial data inserted successfully!");
    }

    /**
     * Insert user roles data
     */
    private static void insertUserRoles(Connection connection) throws SQLException {
        System.out.println("Inserting user roles...");
        
        String[] roles = {"ADMIN", "MANAGER", "CASHIER", "CUSTOMER"};
        
        for (String role : roles) {
            // Check if role already exists
            String checkSQL = "SELECT COUNT(*) FROM user_roles WHERE role_name = ?";
            try (java.sql.PreparedStatement checkStmt = connection.prepareStatement(checkSQL)) {
                checkStmt.setString(1, role);
                java.sql.ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);
                
                if (count == 0) {
                    // Insert role if it doesn't exist
                    String insertSQL = "INSERT INTO user_roles (role_name) VALUES (?)";
                    try (java.sql.PreparedStatement insertStmt = connection.prepareStatement(insertSQL)) {
                        insertStmt.setString(1, role);
                        insertStmt.executeUpdate();
                        System.out.println("Inserted role: " + role);
                    }
                } else {
                    System.out.println("Role already exists: " + role);
                }
            }
        }
    }

    /**
     * Insert admin user data
     */
    private static void insertAdminUser(Connection connection) throws SQLException {
        System.out.println("Inserting admin user...");
        
        // Check if admin user already exists
        String checkSQL = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (java.sql.PreparedStatement checkStmt = connection.prepareStatement(checkSQL)) {
            checkStmt.setString(1, "admin");
            java.sql.ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            
            if (count == 0) {
                // Insert admin user if it doesn't exist
                String insertSQL = "INSERT INTO users (username, password, email, role_id) VALUES (?, ?, ?, ?)";
                try (java.sql.PreparedStatement insertStmt = connection.prepareStatement(insertSQL)) {
                    insertStmt.setString(1, "admin");
                    insertStmt.setString(2, "admin123");
                    insertStmt.setString(3, "admin@gmail.com");
                    insertStmt.setInt(4, 1); // role_id = 1 for ADMIN
                    insertStmt.executeUpdate();
                    System.out.println("Admin user created successfully!");
                }
            } else {
                System.out.println("Admin user already exists");
            }
        }
    }

    /**
     * Test method to verify database connection and table creation This can be
     * called from a servlet or JSP for testing
     */
    public static String testDatabaseConnection() {
        StringBuilder result = new StringBuilder();
        result.append("Database Connection Test Results:\n");

        try {
            // Test connection
            Connection conn = getConnection();
            result.append("✓ Database connection successful\n");

            // Test all tables existence
            String[] tables = {"user_roles", "users", "customers", "book_categories", 
                             "books", "transactions", "transaction_items", "help_sections"};
            
            for (String table : tables) {
                if (tableExists(conn, table)) {
                    result.append("✓ ").append(table).append(" table exists\n");
                } else {
                    result.append("✗ ").append(table).append(" table does not exist\n");
                }
            }

            conn.close();
            result.append("✓ Connection closed successfully\n");

        } catch (Exception e) {
            result.append("✗ Error: ").append(e.getMessage()).append("\n");
            e.printStackTrace();
        }

        return result.toString();
    }
    
    /**
     * Test method to verify customer authentication
     */
    public static String testCustomerAuthentication() {
        StringBuilder result = new StringBuilder();
        result.append("Customer Authentication Test Results:\n");

        try {
            // Test connection
            Connection conn = getConnection();
            result.append("✓ Database connection successful\n");

            // Test user_roles table
            String checkRolesSQL = "SELECT role_id, role_name FROM user_roles ORDER BY role_id";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(checkRolesSQL)) {
                result.append("User Roles:\n");
                while (rs.next()) {
                    result.append("  Role ID: ").append(rs.getInt("role_id"))
                          .append(", Name: ").append(rs.getString("role_name")).append("\n");
                }
            }

            // Test customers table
            String checkCustomersSQL = "SELECT customer_id, username, email, role_id FROM customers LIMIT 5";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(checkCustomersSQL)) {
                result.append("Customers (first 5):\n");
                while (rs.next()) {
                    result.append("  Customer ID: ").append(rs.getInt("customer_id"))
                          .append(", Username: ").append(rs.getString("username"))
                          .append(", Email: ").append(rs.getString("email"))
                          .append(", Role ID: ").append(rs.getInt("role_id")).append("\n");
                }
            }

            conn.close();
            result.append("✓ Connection closed successfully\n");

        } catch (Exception e) {
            result.append("✗ Error: ").append(e.getMessage()).append("\n");
            e.printStackTrace();
        }

        return result.toString();
    }
}
