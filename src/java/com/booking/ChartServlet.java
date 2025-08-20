package com.booking;

import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet for providing chart data
 */
public class ChartServlet extends HttpServlet {

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
        response.setContentType("application/json;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Please login first.\"}");
            return;
        }

        if ("transactionSales".equals(action)) {
            handleTransactionSalesChart(request, response);
        } else if ("stockStats".equals(action)) {
            handleStockStats(request, response);
        } else if ("stockByCategory".equals(action)) {
            handleStockByCategory(request, response);
        } else if ("stockLevels".equals(action)) {
            handleStockLevels(request, response);
        } else if ("topSellingBooks".equals(action)) {
            handleTopSellingBooks(request, response);
        } else if ("stockMovement".equals(action)) {
            handleStockMovement(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid action.\"}");
        }
    }

    private void handleTransactionSalesChart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("ChartServlet: Starting to fetch transaction sales data...");
            
            // Get transaction data for the last 30 days
            List<Map<String, Object>> transactionData = facade.getTransactionSalesData(30);
            
            System.out.println("ChartServlet: Fetched " + transactionData.size() + " data points");
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd");
            
            // Build labels array
            for (int i = 0; i < transactionData.size(); i++) {
                Map<String, Object> transaction = transactionData.get(i);
                Timestamp createdAt = (Timestamp) transaction.get("created_at");
                String dateLabel = dateFormat.format(createdAt);
                
                jsonBuilder.append("\"").append(dateLabel).append("\"");
                if (i < transactionData.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"data\":[");
            
            // Build data array
            for (int i = 0; i < transactionData.size(); i++) {
                Map<String, Object> transaction = transactionData.get(i);
                Double totalAmount = (Double) transaction.get("total_amount");
                
                jsonBuilder.append(totalAmount);
                if (i < transactionData.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            String jsonResponse = jsonBuilder.toString();
            System.out.println("ChartServlet: Sending JSON response: " + jsonResponse);
            
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            System.err.println("ChartServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            eventManager.logEvent("Chart data error: " + e.getMessage(), "ERROR");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading chart data: " + e.getMessage() + "\"}");
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
        return "Chart Data Servlet";
    }

    // Stock Analysis Methods
    private void handleStockStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            java.sql.Connection conn = com.booking.patterns.SingletonDP.getInstance().getConnection();
            
            // Get total books
            String totalBooksSql = "SELECT COUNT(*) as total FROM books";
            java.sql.PreparedStatement totalBooksStmt = conn.prepareStatement(totalBooksSql);
            java.sql.ResultSet totalBooksRs = totalBooksStmt.executeQuery();
            int totalBooks = 0;
            if (totalBooksRs.next()) {
                totalBooks = totalBooksRs.getInt("total");
            }
            totalBooksRs.close();
            totalBooksStmt.close();
            
            // Get low stock items (less than 10)
            String lowStockSql = "SELECT COUNT(*) as total FROM books WHERE stock_quantity < 10 AND stock_quantity > 0";
            java.sql.PreparedStatement lowStockStmt = conn.prepareStatement(lowStockSql);
            java.sql.ResultSet lowStockRs = lowStockStmt.executeQuery();
            int lowStockItems = 0;
            if (lowStockRs.next()) {
                lowStockItems = lowStockRs.getInt("total");
            }
            lowStockRs.close();
            lowStockStmt.close();
            
            // Get out of stock items
            String outOfStockSql = "SELECT COUNT(*) as total FROM books WHERE stock_quantity = 0";
            java.sql.PreparedStatement outOfStockStmt = conn.prepareStatement(outOfStockSql);
            java.sql.ResultSet outOfStockRs = outOfStockStmt.executeQuery();
            int outOfStock = 0;
            if (outOfStockRs.next()) {
                outOfStock = outOfStockRs.getInt("total");
            }
            outOfStockRs.close();
            outOfStockStmt.close();
            
            // Get total inventory value
            String totalValueSql = "SELECT SUM(stock_quantity * price_per_unit) as total FROM books";
            java.sql.PreparedStatement totalValueStmt = conn.prepareStatement(totalValueSql);
            java.sql.ResultSet totalValueRs = totalValueStmt.executeQuery();
            double totalValue = 0.0;
            if (totalValueRs.next()) {
                totalValue = totalValueRs.getDouble("total");
            }
            totalValueRs.close();
            totalValueStmt.close();
            
            conn.close();
            
            String jsonResponse = String.format(
                "{\"success\":true,\"totalBooks\":%d,\"lowStockItems\":%d,\"outOfStock\":%d,\"totalValue\":%.2f}",
                totalBooks, lowStockItems, outOfStock, totalValue
            );
            
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            System.err.println("Error loading stock stats: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading stock statistics: " + e.getMessage() + "\"}");
        }
    }

    private void handleStockByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            java.sql.Connection conn = com.booking.patterns.SingletonDP.getInstance().getConnection();
            
            String sql = "SELECT bc.category_name, COUNT(b.book_id) as book_count " +
                        "FROM books b " +
                        "LEFT JOIN book_categories bc ON b.category_id = bc.category_id " +
                        "GROUP BY bc.category_id, bc.category_name " +
                        "ORDER BY book_count DESC";
            
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            List<String> labels = new ArrayList<>();
            List<Integer> data = new ArrayList<>();
            
            while (rs.next()) {
                String categoryName = rs.getString("category_name");
                int bookCount = rs.getInt("book_count");
                
                if (categoryName != null) {
                    labels.add(categoryName);
                    data.add(bookCount);
                }
            }
            
            // Build labels array
            for (int i = 0; i < labels.size(); i++) {
                jsonBuilder.append("\"").append(labels.get(i)).append("\"");
                if (i < labels.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"data\":[");
            
            // Build data array
            for (int i = 0; i < data.size(); i++) {
                jsonBuilder.append(data.get(i));
                if (i < data.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            rs.close();
            stmt.close();
            conn.close();
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Error loading stock by category: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading stock by category: " + e.getMessage() + "\"}");
        }
    }

    private void handleStockLevels(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            java.sql.Connection conn = com.booking.patterns.SingletonDP.getInstance().getConnection();
            
            String sql = "SELECT b.title, b.stock_quantity " +
                        "FROM books b " +
                        "ORDER BY b.stock_quantity DESC " +
                        "LIMIT 10";
            
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            List<String> labels = new ArrayList<>();
            List<Integer> data = new ArrayList<>();
            
            while (rs.next()) {
                String title = rs.getString("title");
                int stockQuantity = rs.getInt("stock_quantity");
                
                labels.add(title);
                data.add(stockQuantity);
            }
            
            // Build labels array
            for (int i = 0; i < labels.size(); i++) {
                jsonBuilder.append("\"").append(labels.get(i)).append("\"");
                if (i < labels.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"data\":[");
            
            // Build data array
            for (int i = 0; i < data.size(); i++) {
                jsonBuilder.append(data.get(i));
                if (i < data.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            rs.close();
            stmt.close();
            conn.close();
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Error loading stock levels: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading stock levels: " + e.getMessage() + "\"}");
        }
    }

    private void handleTopSellingBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            java.sql.Connection conn = com.booking.patterns.SingletonDP.getInstance().getConnection();
            
            String sql = "SELECT b.title, SUM(ti.quantity) as total_sold " +
                        "FROM books b " +
                        "LEFT JOIN transaction_items ti ON b.book_id = ti.book_id " +
                        "LEFT JOIN transactions t ON ti.transaction_id = t.transaction_id " +
                        "WHERE t.created_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) " +
                        "GROUP BY b.book_id, b.title " +
                        "ORDER BY total_sold DESC " +
                        "LIMIT 10";
            
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            List<String> labels = new ArrayList<>();
            List<Integer> data = new ArrayList<>();
            
            while (rs.next()) {
                String title = rs.getString("title");
                int totalSold = rs.getInt("total_sold");
                
                if (title != null) {
                    labels.add(title);
                    data.add(totalSold);
                }
            }
            
            // Build labels array
            for (int i = 0; i < labels.size(); i++) {
                jsonBuilder.append("\"").append(labels.get(i)).append("\"");
                if (i < labels.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"data\":[");
            
            // Build data array
            for (int i = 0; i < data.size(); i++) {
                jsonBuilder.append(data.get(i));
                if (i < data.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            rs.close();
            stmt.close();
            conn.close();
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Error loading top selling books: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading top selling books: " + e.getMessage() + "\"}");
        }
    }

    private void handleStockMovement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            java.sql.Connection conn = com.booking.patterns.SingletonDP.getInstance().getConnection();
            
            // Get stock movement data for last 7 days
            String sql = "SELECT DATE(t.created_at) as date, " +
                        "SUM(CASE WHEN ti.quantity > 0 THEN ti.quantity ELSE 0 END) as stock_out, " +
                        "0 as stock_in " +
                        "FROM transactions t " +
                        "LEFT JOIN transaction_items ti ON t.transaction_id = ti.transaction_id " +
                        "WHERE t.created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
                        "GROUP BY DATE(t.created_at) " +
                        "ORDER BY date";
            
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            List<String> labels = new ArrayList<>();
            List<Integer> outStock = new ArrayList<>();
            List<Integer> inStock = new ArrayList<>();
            
            while (rs.next()) {
                String date = rs.getString("date");
                int stockOut = rs.getInt("stock_out");
                
                labels.add(date);
                outStock.add(stockOut);
                inStock.add(0); // Placeholder for stock in (would need separate table for this)
            }
            
            // Build labels array
            for (int i = 0; i < labels.size(); i++) {
                jsonBuilder.append("\"").append(labels.get(i)).append("\"");
                if (i < labels.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"inStock\":[");
            
            // Build inStock array
            for (int i = 0; i < inStock.size(); i++) {
                jsonBuilder.append(inStock.get(i));
                if (i < inStock.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"outStock\":[");
            
            // Build outStock array
            for (int i = 0; i < outStock.size(); i++) {
                jsonBuilder.append(outStock.get(i));
                if (i < outStock.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            rs.close();
            stmt.close();
            conn.close();
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Error loading stock movement: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading stock movement: " + e.getMessage() + "\"}");
        }
    }
} 