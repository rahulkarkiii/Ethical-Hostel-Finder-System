<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="auth-page">
    <div class="auth-card">
        <div class="brand">
            <a href="<%= request.getContextPath() %>/views/home.jsp" style="font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:900;color:#1E1E2E;">Hostel<span style="color:#E8712A;">Finder</span></a>
            <h2 style="margin-top:16px;">Welcome back</h2>
            <p>Sign in to your account</p>
        </div>

        <%
            String successMsg = (String) session.getAttribute("success");
            if (successMsg != null) { session.removeAttribute("success");
        %><div class="alert alert-success"> <%= successMsg %></div><% } %>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %><div class="alert alert-error"> <%= error %></div><% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="********" required>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;padding:13px;">Sign In</button>
        </form>

        <div class="form-footer">
            Don't have an account? <a href="<%= request.getContextPath() %>/views/register.jsp">Create one free</a>
        </div>
    </div>
</div>
</body>
</html>
