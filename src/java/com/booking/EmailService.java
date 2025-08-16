package com.booking;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

/**
 * Email service for sending verification emails using Gmail SMTP.
 * This uses the jakarta.mail API, which is implemented by Angus Mail (angus-mail-2.x).
 */
public class EmailService {

    private static final String FROM_EMAIL = "nizmiya0801@gmail.com";
    private static final String FROM_PASSWORD = "stuw rwfb ghhf hznb"; // Gmail App Password
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;

    private Session session;

    public EmailService() {
        try {
            initializeSession();
            System.out.println("✓ EmailService initialized (jakarta.mail via Angus Mail)");
        } catch (Exception e) {
            System.err.println("⚠ Failed to initialize real email session: " + e.getMessage());
            e.printStackTrace();
            session = null; // fallback to mock mode
        }
    }

    private void initializeSession() {
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        // Harden TLS for Gmail
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        // Optional: enable debug
        // props.put("mail.debug", "true");

        this.session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });
    }

    /**
     * Generate a random 6-digit verification code
     */
    public String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // Generates 100000-999999
        return String.valueOf(code);
    }

    /**
     * Send verification email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendVerificationEmail(String toEmail, String verificationCode) {
        if (session == null) {
            System.out.println("⚠ Real email session not available. Using mock service.");
            return sendMockEmail(toEmail, verificationCode);
        }

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Email Verification - BookShop");

            String emailContent = buildEmailContent(verificationCode);
            message.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✓ Verification email sent to: " + toEmail + " (jakarta.mail/Angus)");
            return true;
        } catch (MessagingException e) {
            System.err.println("✗ SMTP send failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("↻ Falling back to mock email service");
            return sendMockEmail(toEmail, verificationCode);
        }
    }

    /**
     * Send mock email (prints to console)
     */
    private boolean sendMockEmail(String toEmail, String verificationCode) {
        System.out.println("=== MOCK EMAIL VERIFICATION ===");
        System.out.println("To: " + toEmail);
        System.out.println("Verification Code: " + verificationCode);
        System.out.println("================================");
        System.out.println("Note: This is a mock email. To send real emails, ensure angus-mail and jakarta.activation are in WEB-INF/lib and rebuild.");
        System.out.println("================================================");
        return true;
    }

    private String buildEmailContent(String verificationCode) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>Email Verification</title>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }" +
                ".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 8px 8px; }" +
                ".verification-code { background: #e9ecef; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; color: #1e3c72; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6c757d; font-size: 14px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h1>BookShop Email Verification</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello!</p>" +
                "<p>Use the following verification code to continue:</p>" +
                "<div class='verification-code'>" + verificationCode + "</div>" +
                "<p>If you didn't request this verification, please ignore this email.</p>" +
                "<p>Best regards,<br>The BookShop Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated message, please do not reply.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    public String getEmailConfig() {
        StringBuilder config = new StringBuilder();
        config.append("Email Service Configuration:\n");
        config.append("From: ").append(FROM_EMAIL).append("\n");
        config.append("SMTP: ").append(SMTP_HOST).append(":").append(SMTP_PORT).append("\n");
        config.append("API: jakarta.mail (implementation: Angus Mail)\n");
        config.append("TLS: STARTTLS, protocols TLSv1.2+\n");
        config.append("Mode: ").append(session == null ? "Mock" : "Real").append('\n');
        return config.toString();
    }
}
