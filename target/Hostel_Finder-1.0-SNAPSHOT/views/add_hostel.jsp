<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hostell.hostel_finder.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser != null && currentUser.getRole() != null && "admin".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/hostels");
        return;
    }
    String submitted = request.getParameter("submitted");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>Submit Hostel - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
    </div>
</nav>

<div class="form-page" style="margin-top:40px;">
    <div style="margin-bottom:28px;">
        <h1 class="page-title">Submit a Hostel</h1>
        <p class="page-subtitle">Your listing will be reviewed by our admin team before going live.</p>
    </div>

    <% if ("pending".equalsIgnoreCase(submitted)) { %>
    <div class="alert alert-info">Hostel submitted. It is currently pending admin approval.</div>
    <% } %>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %><div class="alert alert-error"><%= error %></div><% } %>

    <div class="form-card">
        <form action="<%= request.getContextPath() %>/addHostel" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group">
                    <label>Hostel Name</label>
                    <input type="text" name="name" placeholder="e.g. Sunrise Boys Hostel" required>
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="location" placeholder="e.g. Thamel, Kathmandu" required>
                </div>
            </div>
            <div class="form-group">
                <label>Monthly Price (NPR)</label>
                <input type="number" name="price" placeholder="e.g. 8500" min="1" required>
            </div>
            <div class="form-group">
                <label>Facilities</label>
                <input type="text" name="facilities" placeholder="e.g. WiFi, Food, Parking, Laundry" required>
                <p style="font-size:0.78rem;color:var(--light);margin-top:4px;">Separate multiple facilities with commas</p>
            </div>
            <div class="form-group">
                <label>Hostel Photo</label>
                <input type="file" name="image" accept="image/*">
                <p style="font-size:0.78rem;color:var(--light);margin-top:4px;">JPG, PNG or WebP - Max 5MB</p>
            </div>
            <div style="display:flex;gap:12px;margin-top:8px;">
                <button type="submit" class="btn btn-primary" style="padding:13px 32px;">Submit for Review</button>
                <a href="<%= request.getContextPath() %>/views/home.jsp" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
