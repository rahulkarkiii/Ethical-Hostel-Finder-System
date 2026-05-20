<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Review, com.hostell.hostel_finder.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    Integer hostelId = (Integer) request.getAttribute("hostelId");
    String hostelName = (String) request.getAttribute("hostelName");
    Double averageRating = (Double) request.getAttribute("averageRating");
    String reviewResult = request.getParameter("review");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews — <%= hostelName != null ? hostelName : "Hostel" %> | HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .reviews-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 24px;
        }
        .reviews-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 2px solid var(--sand);
        }
        .rating-summary {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .rating-large {
            font-size: 3.5rem;
            font-weight: 900;
            color: var(--saffron);
            font-family: 'Playfair Display', serif;
        }
        .rating-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .rating-stars {
            font-size: 1.2rem;
            letter-spacing: 2px;
        }
        .rating-count {
            color: var(--light);
            font-size: 0.9rem;
        }
        .review-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            margin-bottom: 16px;
            border: 1px solid #F3F4F6;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .review-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }
        .review-user {
            font-weight: 600;
            color: var(--charcoal);
        }
        .review-rating {
            color: var(--saffron);
            font-size: 1.1rem;
            letter-spacing: 1px;
        }
        .review-date {
            color: var(--light);
            font-size: 0.8rem;
        }
        .review-text {
            color: var(--mid);
            line-height: 1.6;
        }
        .reviews-page {
            background: var(--cream);
            min-height: calc(100vh - 68px);
        }
        .submit-review-btn {
            display: inline-block;
            margin-top: 20px;
        }
        .empty-state {
            text-align: center;
            padding: 48px 24px;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/views/home.jsp">🏠 Home</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
    </div>
</nav>

<div class="reviews-page">
    <div class="reviews-container">
        <div style="margin-bottom: 32px;">
            <a href="<%= request.getContextPath() %>/views/home.jsp" style="color: var(--saffron); font-weight: 600; font-size: 0.9rem;">← Back to Hostels</a>
        </div>

        <% if (hostelName != null) { %>
        <h1 class="page-title">Reviews for <%= hostelName %></h1>

        <% if ("success".equalsIgnoreCase(reviewResult)) { %>
        <div class="alert alert-success">✅ Review submitted successfully.</div>
        <% } %>

        <% if (averageRating != null && averageRating > 0) { %>
        <div class="reviews-header">
            <div class="rating-summary">
                <div class="rating-large"><%= String.format("%.1f", averageRating) %></div>
                <div class="rating-info">
                    <div class="rating-stars">
                        <%
                            double rating = averageRating;
                            for (int i = 0; i < 5; i++) {
                                System.out.print(i < Math.round(rating) ? "⭐" : "☆");
                            }
                        %>
                    </div>
                    <div class="rating-count">Based on <%= reviews != null ? reviews.size() : 0 %> reviews</div>
                </div>
            </div>
        </div>
        <% } %>

        <a href="<%= request.getContextPath() %>/views/submit_review.jsp?hostelId=<%= hostelId %>" class="btn btn-primary submit-review-btn">Write a Review</a>

        <% if (reviews != null && !reviews.isEmpty()) { %>
        <div style="margin-top: 40px;">
            <h2 style="font-size: 1.5rem; margin-bottom: 24px; color: var(--charcoal);">All Reviews</h2>
            <% for (Review r : reviews) { %>
            <div class="review-card">
                <div class="review-header">
                    <div>
                        <div class="review-user"><%= r.getUserName() %></div>
                        <div class="review-date"><%= r.getCreatedAt() %></div>
                    </div>
                    <div class="review-rating">
                        <% for (int i = 0; i < r.getRating(); i++) { %>⭐<% } %>
                        <% for (int i = r.getRating(); i < 5; i++) { %>☆<% } %>
                    </div>
                </div>
                <div class="review-text"><%= r.getReviewText() %></div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state" style="margin-top: 40px;">
            <div style="font-size: 2.5rem; margin-bottom: 12px;">⭐</div>
            <h3>No reviews yet</h3>
            <p>Be the first to review this hostel!!!</p>
            <a href="<%= request.getContextPath() %>/views/submit_review.jsp?hostelId=<%= hostelId %>" class="btn btn-primary" style="margin-top: 20px;">Write a Review</a>
        </div>
        <% } %>
        <% } else { %>
        <div class="empty-state">
            <div style="font-size: 2.5rem; margin-bottom: 12px;">❌</div>
            <h3>HOSTEL NOT FOUND</h3>
            <p>We couldn't find the hostel you're looking for.</p>
            <a href="<%= request.getContextPath() %>/views/home.jsp" class="btn btn-primary" style="margin-top: 20px;">Back to Home</a>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
