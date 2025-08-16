package com.booking.patterns;

import java.util.ArrayList;
import java.util.List;

/**
 * Observer Pattern for System Notifications
 * Allows components to subscribe to system events
 */
public class ObserverDP {
    
    // Subject interface
    public interface Subject {
        void registerObserver(Observer observer);
        void removeObserver(Observer observer);
        void notifyObservers(String message, String eventType);
    }
    
    // Observer interface
    public interface Observer {
        void update(String message, String eventType);
    }
    
    // Concrete subject - System Event Manager
    public static class SystemEventManager implements Subject {
        private List<Observer> observers = new ArrayList<>();
        private static SystemEventManager instance;
        
        private SystemEventManager() {}
        
        public static SystemEventManager getInstance() {
            if (instance == null) {
                instance = new SystemEventManager();
            }
            return instance;
        }
        
        @Override
        public void registerObserver(Observer observer) {
            if (!observers.contains(observer)) {
                observers.add(observer);
            }
        }
        
        @Override
        public void removeObserver(Observer observer) {
            observers.remove(observer);
        }
        
        @Override
        public void notifyObservers(String message, String eventType) {
            for (Observer observer : observers) {
                observer.update(message, eventType);
            }
        }
        
        public void logEvent(String message, String eventType) {
            System.out.println("System Event: [" + eventType + "] " + message);
            notifyObservers(message, eventType);
        }
    }
    
    // Concrete observer - System Logger
    public static class SystemLogger implements Observer {
        @Override
        public void update(String message, String eventType) {
            // Log to file or database
            System.out.println("Logger: [" + eventType + "] " + message);
        }
    }
    
    // Concrete observer - Email Notifier
    public static class EmailNotifier implements Observer {
        @Override
        public void update(String message, String eventType) {
            if ("ERROR".equals(eventType) || "CRITICAL".equals(eventType)) {
                // Send email notification
                System.out.println("Email Notification: [" + eventType + "] " + message);
            }
        }
    }
    
    // Concrete observer - Audit Trail
    public static class AuditTrail implements Observer {
        @Override
        public void update(String message, String eventType) {
            // Record in audit trail
            System.out.println("Audit Trail: [" + eventType + "] " + message);
        }
    }
} 