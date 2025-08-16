package com.booking;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Test Servlet for debugging customer authentication
 */
@WebServlet(name="TestServlet", urlPatterns={"/TestServlet"})
public class TestServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Test Results</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Database and Authentication Test Results</h1>");
            
            // Test database connection
            out.println("<h2>Database Connection Test:</h2>");
            out.println("<pre>" + DatabaseUtil.testDatabaseConnection() + "</pre>");
            
            // Test customer authentication
            out.println("<h2>Customer Authentication Test:</h2>");
            out.println("<pre>" + DatabaseUtil.testCustomerAuthentication() + "</pre>");
            
            // Test specific customer authentication
            String testUsername = request.getParameter("username");
            String testPassword = request.getParameter("password");
            
            if (testUsername != null && testPassword != null) {
                out.println("<h2>Specific Customer Authentication Test:</h2>");
                out.println("<p>Testing username: " + testUsername + "</p>");
                
                CustomerServlet customerServlet = new CustomerServlet();
                boolean authResult = customerServlet.authenticateCustomer(testUsername, testPassword);
                out.println("<p>Authentication result: " + (authResult ? "SUCCESS" : "FAILED") + "</p>");
                
                if (authResult) {
                    CustomerServlet.Customer customer = customerServlet.getCustomerByUsername(testUsername);
                    if (customer != null) {
                        out.println("<p>Customer found:</p>");
                        out.println("<ul>");
                        out.println("<li>Customer ID: " + customer.getCustomerId() + "</li>");
                        out.println("<li>Name: " + customer.getName() + "</li>");
                        out.println("<li>Username: " + customer.getUsername() + "</li>");
                        out.println("<li>Email: " + customer.getEmail() + "</li>");
                        if (customer.getRole() != null) {
                            out.println("<li>Role ID: " + customer.getRole().getRoleId() + "</li>");
                            out.println("<li>Role Name: " + customer.getRole().getRoleName() + "</li>");
                        } else {
                            out.println("<li>Role: NULL</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println("<p>Customer object is NULL</p>");
                    }
                }
            }
            
            out.println("<h2>Test Customer Authentication:</h2>");
            out.println("<form method='get'>");
            out.println("Username: <input type='text' name='username'><br>");
            out.println("Password: <input type='password' name='password'><br>");
            out.println("<input type='submit' value='Test Authentication'>");
            out.println("</form>");
            
            out.println("</body>");
            out.println("</html>");
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
}

