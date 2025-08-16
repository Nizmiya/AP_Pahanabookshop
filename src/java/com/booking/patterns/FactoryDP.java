package com.booking.patterns;

import com.booking.UserServlet.User;
import com.booking.CustomerServlet.Customer;
import com.booking.BookServlet.Book;
import com.booking.TransactionServlet.Transaction;
import com.booking.HelpServlet.HelpSection;
import com.booking.UserServlet.UserRole;
import com.booking.BookCategoryServlet.BookCategory;

/**
 * Simplified Factory Design Pattern implementation
 * Note: DAO classes have been consolidated into servlets
 */
public class FactoryDP {
    
    public FactoryDP() {
        // DAO classes have been consolidated into servlets
    }
    
    // This is a simplified factory that can be extended as needed
    // The actual data access is now handled directly by the servlets
    
    public String getInfo() {
        return "Factory Design Pattern - DAO classes consolidated into servlets";
    }
} 