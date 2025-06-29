package com.ecommerce.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    private static final SecureRandom RANDOM = new SecureRandom();

    public static String hash(String password) {
        try {
            byte[] salt = new byte[16];
            RANDOM.nextBytes(salt);
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());
            
            byte[] combined = new byte[salt.length + hashedPassword.length];
            System.arraycopy(salt, 0, combined, 0, salt.length);
            System.arraycopy(hashedPassword, 0, combined, salt.length, hashedPassword.length);
            
            return Base64.getEncoder().encodeToString(combined);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public static boolean verify(String password, String hashedPassword) {
        try {
            byte[] combined = Base64.getDecoder().decode(hashedPassword);
            byte[] salt = new byte[16];
            System.arraycopy(combined, 0, salt, 0, salt.length);
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedInput = md.digest(password.getBytes());
            
            byte[] storedHash = new byte[combined.length - salt.length];
            System.arraycopy(combined, salt.length, storedHash, 0, storedHash.length);
            
            return MessageDigest.isEqual(hashedInput, storedHash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error verifying password", e);
        }
    }
} 