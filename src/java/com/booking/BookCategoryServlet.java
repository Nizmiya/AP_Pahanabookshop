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
 * Servlet for handling BookCategory operations
 */
public class BookCategoryServlet extends HttpServlet {

    // BookCategory Model Class
    public static class BookCategory {
        private int categoryId;
        private String categoryName;
        
        public BookCategory() {}
        
        public BookCategory(int categoryId, String categoryName) {
            this.categoryId = categoryId;
            this.categoryName = categoryName;
        }
        
        // Getters and Setters
        public int getCategoryId() {
            return categoryId;
        }
        
        public void setCategoryId(int categoryId) {
            this.categoryId = categoryId;
        }
        
        public String getCategoryName() {
            return categoryName;
        }
        
        public void setCategoryName(String categoryName) {
            this.categoryName = categoryName;
        }
    }

    // BookCategory DAO Methods
    public boolean createBookCategory(BookCategory bookCategory) {
        String sql = "INSERT INTO book_categories (category_name) VALUES (?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating book category: " + e.getMessage());
            return false;
        }
    }
    
    public List<BookCategory> getAllBookCategories() {
        List<BookCategory> bookCategories = new ArrayList<>();
        String sql = "SELECT * FROM book_categories ORDER BY category_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                BookCategory bookCategory = new BookCategory();
                bookCategory.setCategoryId(rs.getInt("category_id"));
                bookCategory.setCategoryName(rs.getString("category_name"));
                bookCategories.add(bookCategory);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all book categories: " + e.getMessage());
        }
        return bookCategories;
    }
    
    public BookCategory getBookCategoryById(int categoryId) {
        String sql = "SELECT * FROM book_categories WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BookCategory bookCategory = new BookCategory();
                    bookCategory.setCategoryId(rs.getInt("category_id"));
                    bookCategory.setCategoryName(rs.getString("category_name"));
                    return bookCategory;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting book category by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBookCategory(BookCategory bookCategory) {
        String sql = "UPDATE book_categories SET category_name = ? WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            pstmt.setInt(2, bookCategory.getCategoryId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book category: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBookCategory(int categoryId) {
        String sql = "DELETE FROM book_categories WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book category: " + e.getMessage());
            return false;
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
        // Removed bookCategoryDAO initialization
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
        
        // Check role-based access
        boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
        if (!canAccess) {
            response.sendRedirect("dashboard.jsp?error=Access denied.");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listBookCategories(request, response);
                    break;
                case "add":
                    addBookCategory(request, response);
                    break;
                case "edit":
                    editBookCategory(request, response);
                    break;
                case "update":
                    updateBookCategory(request, response);
                    break;
                case "delete":
                    deleteBookCategory(request, response);
                    break;
                default:
                    listBookCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in BookCategoryServlet: " + e.getMessage());
            response.sendRedirect("book_category.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listBookCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<BookCategory> bookCategories = getAllBookCategories(); // Use the new method
        request.setAttribute("bookCategories", bookCategories);
        request.getRequestDispatcher("book_category.jsp").forward(request, response);
    }

    private void addBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            response.sendRedirect("book_category.jsp?error=Category name is required.");
            return;
        }

        BookCategory bookCategory = new BookCategory();
        bookCategory.setCategoryName(categoryName.trim());

        boolean success = createBookCategory(bookCategory); // Use the new method
        
        if (success) {
            response.sendRedirect("BookCategoryServlet?action=list&message=Category added successfully.");
        } else {
            response.sendRedirect("book_category.jsp?error=Failed to add category.");
        }
    }

    private void editBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            BookCategory bookCategory = getBookCategoryById(categoryId); // Use the new method
            
            if (bookCategory != null) {
                request.setAttribute("bookCategory", bookCategory);
                request.getRequestDispatcher("book_category_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Category not found.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void updateBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        
        if (categoryIdStr == null || categoryName == null || 
            categoryIdStr.trim().isEmpty() || categoryName.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID and name are required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            BookCategory bookCategory = new BookCategory();
            bookCategory.setCategoryId(categoryId);
            bookCategory.setCategoryName(categoryName.trim());

            boolean success = updateBookCategory(bookCategory); // Use the new method
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category updated successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to update category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void deleteBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            boolean success = deleteBookCategory(categoryId); // Use the new method
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category deleted successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to delete category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
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
        return "Book Category Management Servlet";
    }
} 