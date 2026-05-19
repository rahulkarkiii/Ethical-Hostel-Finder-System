<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Booking, com.hostell.hostel_finder.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser != null && currentUser.getRole() != null && "admin".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
        return;
    }
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    String booked = request.getParameter("booked");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">+ Submit Hostel</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
    </div>
</nav>

<div class="bookings-page">
    <h1 class="page-title">My Bookings</h1>
    <p class="page-subtitle">Track all your hostel booking requests below</p>

    <% if ("success".equalsIgnoreCase(booked)) { %>
    <div class="alert alert-success">Booking request sent successfully. Admin will review it soon.</div>
    <% } else if ("duplicate".equalsIgnoreCase(booked)) { %>
    <div class="alert alert-info">You already have an active booking request for this hostel.</div>
    <% } else if ("error".equalsIgnoreCase(booked)) { %>
    <div class="alert alert-error">We could not create your booking request. Please try again.</div>
    <% } %>

    <% if (bookings != null && !bookings.isEmpty()) { %>
    <% for (Booking b : bookings) { %>
    <div class="booking-card">
        <div>
            <div class="hostel-name"><%= b.getHostelName() %></div>
            <div class="booking-date">Booked on <%= b.getCreatedAt() %></div>
        </div>
        <span class="status-badge status-<%= b.getStatus().toLowerCase() %>">
                <%= b.getStatus().substring(0,1).toUpperCase() + b.getStatus().substring(1) %>
            </span>
    </div>
    <% } %>
    <% } else { %>
    <div class="empty-state">
        <div class="empty-icon">Bookings</div>
        <h3>No bookings yet</h3>
        <p>Browse available hostels and make your first booking!</p>
        <a href="<%= request.getContextPath() %>/views/home.jsp" class="btn btn-primary" style="margin-top:20px;">Browse Hostels</a>
    </div>
    <% } %>
</div>

</body>
</html>
