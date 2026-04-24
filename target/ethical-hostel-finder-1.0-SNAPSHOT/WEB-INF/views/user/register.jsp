<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SafeNest Hostel Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-card">
        <div class="auth-header">
            <h1>SafeNest</h1>
            <p>Ethical Hostel Finder</p>
        </div>

        <h2>Create an Account</h2>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
            <div class="form-group">
                <label for="fullName">Full Name *</label>
                <input type="text"
                       id="fullName"
                       name="fullName"
                       value="${user.fullName}"
                       placeholder="Enter your full name"
                       required>
            </div>

            <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email"
                       id="email"
                       name="email"
                       value="${user.email}"
                       placeholder="Enter your email"
                       required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel"
                       id="phone"
                       name="phone"
                       value="${user.phone}"
                       placeholder="Enter your phone number">
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text"
                       id="address"
                       name="address"
                       value="${user.address}"
                       placeholder="Enter your address">
            </div>

            <div class="form-group">
                <label for="gender">Gender</label>
                <select id="gender" name="gender">
                    <option value="">Select Gender</option>
                    <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="password">Password *</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Enter password (min 6 characters)"
                       required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password *</label>
                <input type="password"
                       id="confirmPassword"
                       name="confirmPassword"
                       placeholder="Confirm your password"
                       required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>

        <div class="auth-footer">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/login">Login here</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>