package com.booking;

import com.booking.BookServlet.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 * Servlet for handling Stock operations
 */
public class StockServlet extends HttpServlet {



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
        
        // Check role-based access - only ADMIN and MANAGER can access stock
        boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role);
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
                    listStock(request, response);
                    break;
                case "update":
                    updateStock(request, response);
                    break;
                case "add":
                    addStock(request, response);
                    break;
                default:
                    listStock(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in StockServlet: " + e.getMessage());
            response.sendRedirect("stock.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Book> books = new BookServlet().getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("stock.jsp").forward(request, response);
    }

    private void updateStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String stockQuantityStr = request.getParameter("stockQuantity");
        
        // Validation
        if (bookIdStr == null || stockQuantityStr == null || 
            bookIdStr.trim().isEmpty() || stockQuantityStr.trim().isEmpty()) {
            response.sendRedirect("StockServlet?action=list&error=Book ID and stock quantity are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            if (stockQuantity < 0) {
                response.sendRedirect("StockServlet?action=list&error=Stock quantity cannot be negative.");
                return;
            }

            boolean success = new BookServlet().updateStockQuantity(bookId, stockQuantity);
            
            if (success) {
                response.sendRedirect("StockServlet?action=list&message=Stock updated successfully.");
            } else {
                response.sendRedirect("StockServlet?action=list&error=Failed to update stock.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("StockServlet?action=list&error=Invalid book ID or stock quantity.");
        }
    }
    
    private void addStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String stockQuantityStr = request.getParameter("stockQuantity");
        
        // Validation
        if (bookIdStr == null || stockQuantityStr == null || 
            bookIdStr.trim().isEmpty() || stockQuantityStr.trim().isEmpty()) {
            response.sendRedirect("StockServlet?action=list&error=Book ID and stock quantity are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int addQuantity = Integer.parseInt(stockQuantityStr);
            
            if (addQuantity <= 0) {
                response.sendRedirect("StockServlet?action=list&error=Add quantity must be greater than 0.");
                return;
            }

            // Get current stock quantity
            Book book = new BookServlet().getBookById(bookId);
            if (book == null) {
                response.sendRedirect("StockServlet?action=list&error=Book not found.");
                return;
            }
            
            int currentStock = book.getStockQuantity();
            int newStock = currentStock + addQuantity;
            
            boolean success = new BookServlet().updateStockQuantity(bookId, newStock);
            
            if (success) {
                response.sendRedirect("StockServlet?action=list&message=Stock added successfully. New total: " + newStock);
            } else {
                response.sendRedirect("StockServlet?action=list&error=Failed to add stock.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("StockServlet?action=list&error=Invalid book ID or stock quantity.");
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
        return "Stock Management Servlet";
    }
} 