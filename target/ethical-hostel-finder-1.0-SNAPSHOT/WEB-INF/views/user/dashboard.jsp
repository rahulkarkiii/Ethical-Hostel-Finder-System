<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - SafeNest Hostel Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<nav class="navbar">
    <div class="nav-brand">
        <h1>SafeNest</h1>
    </div>
    <div class="nav-links">
        <span>Welcome, ${sessionScope.userName}</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
    </div>
</nav>

<main class="dashboard-container">
    <h2>Welcome to Your Dashboard</h2>
    <p>You are successfully logged in!</p>

    <div class="dashboard-cards">
        <div class="card">
            <h3>Search Hostels</h3>
            <p>Find safe and verified hostels near you</p>
            <a href="${pageContext.request.contextPath}/hostels" class="btn btn-primary">Search</a>
        </div>

        <div class="card">
            <h3>My Bookings</h3>
            <p>View your hostel booking history</p>
            <a href="${pageContext.request.contextPath}/bookings" class="btn btn-primary">View</a>
        </div>

        <div class="card">
            <h3>My Reviews</h3>
            <p>Manage your hostel reviews</p>
            <a href="${pageContext.request.contextPath}/reviews" class="btn btn-primary">View</a>
        </div>

        <div class="card">
            <h3>Profile</h3>
            <p>Update your profile information</p>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">Edit</a>
        </div>
    </div>
</main>
</body>
</html>