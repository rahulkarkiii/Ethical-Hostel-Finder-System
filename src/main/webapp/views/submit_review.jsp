<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.dao.HostelDAO, com.hostell.hostel_finder.model.Hostel, com.hostell.hostel_finder.model.User, com.hostell.hostel_finder.dao.ReviewDAO" %>
<%
    Object userObj = session.getAttribute("user");
    boolean loggedIn = userObj != null;
    User currentUser = loggedIn ? (User) userObj : null;
    String hostelIdParam = request.getParameter("hostelId");
    String reviewResult = request.getParameter("review");
    
    Hostel hostel = null;
    boolean canReview = false;
    String errorMessage = null;
    
    if (hostelIdParam != null && loggedIn) {
        try {
            int hostelId = Integer.parseInt(hostelIdParam);
            HostelDAO hostelDAO = new HostelDAO();
            hostel = hostelDAO.getHostelById(hostelId);
            
            if (hostel != null) {
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Check if user has booking
                if (!reviewDAO.userHasBookingForHostel(currentUser.getId(), hostelId)) {
                    errorMessage = "You must have a booking for this hostel to write a review.";
                } 
                // Check if already reviewed
                else if (reviewDAO.userHasAlreadyReviewed(currentUser.getId(), hostelId)) {
                    errorMessage = "You have already reviewed this hostel. One review per hostel.";
                } else {
                    canReview = true;
                }
            }
        } catch (NumberFormatException e) {
            errorMessage = "Invalid hostel ID.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Review - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .review-page {
            background: var(--cream);
            min-height: calc(100vh - 68px);
            padding: 40px 24px;
        }
        .review-container {
            max-width: 600px;
            margin: 0 auto;
        }
        .review-form {
            background: var(--white);
            border-radius: var(--radius);
            padding: 32px;
            box-shadow: var(--shadow);
        }
        .rating-input {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }
        .star-btn {
            width: 50px;
            height: 50px;
            border: 2px solid #E5E7EB;
            background: transparent;
            border-radius: 8px;
            font-size: 1.8rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .star-btn:hover {
            border-color: var(--saffron);
            background: #FFF5F0;
        }
        .star-btn.selected {
            border-color: var(--saffron);
            background: #FFF5F0;
        }
        .hostel-info {
            background: var(--sand);
            padding: 16px;
            border-radius: 10px;
            margin-bottom: 24px;
        }
        .hostel-info h3 {
            margin-bottom: 4px;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <% if (loggedIn) { %>
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/views/login.jsp">Log In</a>
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn-nav">Sign Up</a>
        <% } %>
    </div>
</nav>

<div class="review-page">
    <div class="review-container">
        <a href="<%= request.getContextPath() %>/views/home.jsp" style="color: var(--saffron); font-weight: 600; font-size: 0.9rem; display: inline-block; margin-bottom: 24px;">Back to Hostels</a>

        <h1 class="page-title">Write a Review</h1>
        <p class="page-subtitle">Share your experience to help other travelers</p>

        <% if (!loggedIn) { %>
        <div class="alert alert-error">You must be logged in to write a review.</div>
        <p style="text-align: center; margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/views/login.jsp" class="btn btn-primary" style="display: inline-block;">Sign In</a>
        </p>
        <% } else if (hostel == null) { %>
        <div class="alert alert-error">Hostel not found.</div>
        <% } else if (errorMessage != null) { %>
        <div class="alert alert-error"><%= errorMessage %></div>
        <p style="text-align: center; margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/viewReviews?hostelId=<%= hostel.getId() %>" class="btn btn-secondary" style="display: inline-block;">View Reviews</a>
        </p>
        <% } else if (canReview) { %>
        <% if ("already_reviewed".equalsIgnoreCase(reviewResult)) { %>
        <div class="alert alert-info">You have already reviewed this hostel.</div>
        <% } else if ("no_booking".equalsIgnoreCase(reviewResult)) { %>
        <div class="alert alert-info">You can review only hostels you have booked.</div>
        <% } else if ("error".equalsIgnoreCase(reviewResult)) { %>
        <div class="alert alert-error">Could not submit review. Please try again.</div>
        <% } %>

        <div class="review-form">
            <div class="hostel-info">
                <h3><%= hostel.getName() %></h3>
                <p style="color: var(--light); margin-bottom: 0;">Location: <%= hostel.getLocation() %></p>
            </div>

            <form action="<%= request.getContextPath() %>/submitReview" method="post">
                <input type="hidden" name="hostelId" value="<%= hostel.getId() %>">

                <div class="form-group">
                    <label>Your Rating</label>
                    <div class="rating-input" id="ratingContainer">
                        <% for (int i = 1; i <= 5; i++) { %>
                        <button type="button" class="star-btn" data-rating="<%= i %>"><%= i %> star</button>
                        <% } %>
                    </div>
                    <input type="hidden" name="rating" id="ratingInput" required>
                </div>

                <div class="form-group">
                    <label>Your Review</label>
                    <textarea name="reviewText" placeholder="Share your experience... What did you like or dislike? Would you recommend this hostel?" required style="min-height: 150px;"></textarea>
                </div>

                <div style="display: flex; gap: 12px; margin-top: 24px;">
                    <button type="submit" class="btn btn-primary" style="flex: 1;">Submit Review</button>
                    <a href="<%= request.getContextPath() %>/viewReviews?hostelId=<%= hostel.getId() %>" class="btn btn-outline" style="flex: 1; text-decoration: none;">Cancel</a>
                </div>
            </form>
        </div>
        <% } %>
    </div>
</div>

<script>
    const ratingButtons = document.querySelectorAll('.star-btn');
    const ratingInput = document.getElementById('ratingInput');

    ratingButtons.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const rating = btn.dataset.rating;
            ratingInput.value = rating;
            
            // Update visual state
            ratingButtons.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');
            // Also highlight all previous stars
            ratingButtons.forEach(b => {
                if (parseInt(b.dataset.rating) <= parseInt(rating)) {
                    b.classList.add('selected');
                }
            });
        });
    });
</script>

</body>
</html>
