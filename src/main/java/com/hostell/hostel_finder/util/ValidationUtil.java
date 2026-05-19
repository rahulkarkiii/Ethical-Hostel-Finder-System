package com.hostell.hostel_finder.util;

public class ValidationUtil {
    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isPositive(double value) {
        return value > 0;
    }

    public static boolean isStrongPassword(String value) {
        if (value == null || value.length() < 8) {
            return false;
        }
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSymbol = false;

        for (int i = 0; i < value.length(); i++) {
            char ch = value.charAt(i);
            if (Character.isUpperCase(ch)) {
                hasUpper = true;
            } else if (Character.isLowerCase(ch)) {
                hasLower = true;
            } else if (Character.isDigit(ch)) {
                hasDigit = true;
            } else if (!Character.isWhitespace(ch)) {
                hasSymbol = true;
            }
        }

        return hasUpper && hasLower && hasDigit && hasSymbol;
    }
}
