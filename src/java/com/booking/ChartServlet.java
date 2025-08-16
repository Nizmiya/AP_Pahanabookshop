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
        
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Please login first.\"}");
            return;
        }

        if ("transactionSales".equals(action)) {
            handleTransactionSalesChart(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid action.\"}");
        }
    }

    private void handleTransactionSalesChart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get transaction data for the last 30 days
            List<Map<String, Object>> transactionData = facade.getTransactionSalesData(30);
            
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
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
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
} 