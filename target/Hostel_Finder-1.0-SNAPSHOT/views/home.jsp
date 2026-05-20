<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.dao.HostelDAO, com.hostell.hostel_finder.model.Hostel, com.hostell.hostel_finder.model.User" %>
<%
    Object userObj = session.getAttribute("user");
    boolean loggedIn = userObj != null;
    User currentUser = loggedIn ? (User) userObj : null;
    boolean isAdmin = loggedIn && currentUser != null && currentUser.getRole() != null && "admin".equalsIgnoreCase(currentUser.getRole());
    String submission = request.getParameter("submission");
    String booked = request.getParameter("booked");
    String search = request.getParameter("search");
    String genderFilter = request.getParameter("gender");

    List<Hostel> hostels = null;
    if (loggedIn && !isAdmin) {
        HostelDAO dao = new HostelDAO();
        hostels = dao.getAllHostels();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Finder Nepal - Find Your Perfect Stay</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- NAV -->
<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <% if (loggedIn && isAdmin) { %>
        <a href="<%= request.getContextPath() %>/admin/hostels">Manage Hostels</a>
        <a href="<%= request.getContextPath() %>/admin/bookings">Manage Bookings</a>
        <a href="<%= request.getContextPath() %>/admin/users">Users</a>
        <a href="<%= request.getContextPath() %>/viewComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else if (loggedIn) { %>
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
        <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">+ Submit Hostel</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/views/about_us.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
        <a href="<%= request.getContextPath() %>/views/about_us.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/views/login.jsp">Log In</a>
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn-nav">Sign Up</a>
        <% } %>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-content">
        <% if (isAdmin) { %>
        <div class="hero-badge">Admin Control Center</div>
        <h1>Manage <em>HostelFinder</em><br>Operations</h1>
        <p>Review hostel submissions, process bookings, and handle complaints from one place.</p>
        <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap;">
            <a href="<%= request.getContextPath() %>/admin/hostels" class="btn btn-primary btn-lg">Manage Hostels</a>
            <a href="<%= request.getContextPath() %>/admin/bookings" class="btn btn-outline btn-lg" style="color:white;border-color:rgba(255,255,255,0.4);">Manage Bookings</a>
        </div>
        <% } else { %>
        <div class="hero-badge">Nepal's Hostel Network</div>
        <h1>Find Your <em>Perfect</em><br>Hostel Stay</h1>
        <p>Safe, verified and affordable hostels across Nepal - browse, book, and settle in with confidence.</p>

        <% if (loggedIn) { %>
        <form action="<%= request.getContextPath() %>/views/home.jsp" method="get" style="width:100%;">
            <div class="search-bar">
                <input type="text" name="search" placeholder="Search by location or name..." value="<%= search != null ? search : "" %>">
                <select name="gender">
                    <option value="">All Types</option>
                    <option value="male" <%= "male".equals(genderFilter) ? "selected" : "" %>>Boys Hostel</option>
                    <option value="female" <%= "female".equals(genderFilter) ? "selected" : "" %>>Girls Hostel</option>
                    <option value="mixed" <%= "mixed".equals(genderFilter) ? "selected" : "" %>>Mixed</option>
                </select>
                <button type="submit">Search</button>
            </div>
        </form>
        <% } else { %>
        <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap;">
            <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn btn-primary btn-lg">Get Started Free</a>
            <a href="<%= request.getContextPath() %>/views/login.jsp" class="btn btn-outline btn-lg" style="color:white;border-color:rgba(255,255,255,0.4);">Sign In</a>
        </div>
        <% } %>
        <% } %>
    </div>
</section>

<!-- ALERTS -->
<% if ("pending".equalsIgnoreCase(submission)) { %>
<div style="max-width:900px;margin:24px auto 0;padding:0 24px;">
    <div class="alert alert-info">Your hostel submission is pending admin approval. We'll review it shortly!</div>
</div>
<% } %>
<% if ("success".equalsIgnoreCase(booked)) { %>
<div style="max-width:900px;margin:24px auto 0;padding:0 24px;">
    <div class="alert alert-success">Booking request submitted! Check <a href="<%= request.getContextPath() %>/myBookings" style="color:inherit;font-weight:700;text-decoration:underline;">My Bookings</a> for status.</div>
</div>
<% } else if ("error".equalsIgnoreCase(booked)) { %>
<div style="max-width:900px;margin:24px auto 0;padding:0 24px;">
    <div class="alert alert-error">Booking failed. Please try again.</div>
</div>
<% } else if ("unavailable".equalsIgnoreCase(booked)) { %>
<div style="max-width:900px;margin:24px auto 0;padding:0 24px;">
    <div class="alert alert-info">This hostel is not available for booking right now.</div>
</div>
<% } %>

<% if (isAdmin) { %>
<section class="section">
    <div class="section-header">
        <h2>Admin Workflow</h2>
        <p>Choose what you want to handle next.</p>
        <div class="section-line"></div>
    </div>
    <div class="hostel-grid">
        <div class="hostel-card">
            <div class="card-body">
                <h4>Manage Hostels</h4>
                <p class="page-subtitle" style="margin-bottom:12px;">Approve or reject newly submitted hostels.</p>
                <a href="<%= request.getContextPath() %>/admin/hostels" class="btn btn-primary">Open Hostel Queue</a>
            </div>
        </div>
        <div class="hostel-card">
            <div class="card-body">
                <h4>Manage Bookings</h4>
                <p class="page-subtitle" style="margin-bottom:12px;">Process booking requests from users.</p>
                <a href="<%= request.getContextPath() %>/admin/bookings" class="btn btn-primary">Open Bookings</a>
            </div>
        </div>
        <div class="hostel-card">
            <div class="card-body">
                <h4>Complaints</h4>
                <p class="page-subtitle" style="margin-bottom:12px;">Review complaints and mark them resolved.</p>
                <a href="<%= request.getContextPath() %>/viewComplaints" class="btn btn-primary">Open Complaints</a>
            </div>
        </div>
    </div>
</section>
<% } %>

<!-- STATS -->
<% if (!isAdmin) { %>
<div class="stats-strip">
    <div class="stat-item"><h3>500+</h3><p>Verified Hostels</p></div>
    <div class="stat-item"><h3>10K+</h3><p>Happy Students</p></div>
    <div class="stat-item"><h3>25+</h3><p>Cities Covered</p></div>
    <div class="stat-item"><h3>4.8</h3><p>Average Rating</p></div>
</div>
<% } %>

<!-- HOSTELS SECTION -->
<% if (loggedIn && !isAdmin) { %>
<section class="section">
    <div class="section-header">
        <h2>Available Hostels</h2>
        <p>All listings have been verified and approved by our team</p>
        <div class="section-line"></div>
    </div>

    <div class="hostel-grid">
        <%
            boolean anyFound = false;
            if (hostels != null) {
                for (Hostel h : hostels) {
                    // apply client-side search filter
                    String sLower = (search != null) ? search.toLowerCase() : "";
                    boolean matchesSearch = sLower.isEmpty()
                            || h.getName().toLowerCase().contains(sLower)
                            || h.getLocation().toLowerCase().contains(sLower);
                    String facs = h.getFacilities() != null ? h.getFacilities().toLowerCase() : "";
                    boolean matchesGender = (genderFilter == null || genderFilter.isEmpty())
                            || (genderFilter.equals("male") && facs.contains("boy"))
                            || (genderFilter.equals("female") && (facs.contains("girl") || facs.contains("women")))
                            || (genderFilter.equals("mixed"));
                    if (!matchesSearch || !matchesGender) continue;
                    anyFound = true;
        %>
        <div class="hostel-card">
            <div class="card-img-wrap">
                <% if (h.getImagePath() != null && !h.getImagePath().isEmpty()) { %>
                <img src="<%= request.getContextPath() + "/" + h.getImagePath() %>" alt="<%= h.getName() %>">
                <% } else { %>
                <div class="card-img-placeholder">Hostel</div>
                <% } %>
                <span class="card-badge">Verified</span>
            </div>
            <div class="card-body">
                <h4><%= h.getName() %></h4>
                <div class="card-meta">
                    <div class="card-meta-row">Location: <%= h.getLocation() %></div>
                </div>
                <div class="card-price">Rs. <%= String.format("%.0f", h.getPrice()) %> <span style="font-size:0.78rem;color:var(--light);font-weight:400;">/month</span></div>
                <div style="margin-bottom:8px;">
                    <span class="status-badge status-approved">Approved</span>
                </div>
                <div style="margin-bottom:14px;">
                    <% if (h.getFacilities() != null) {
                        for (String f : h.getFacilities().split(",")) {
                            f = f.trim();
                            if (!f.isEmpty()) { %>
                    <span class="facility-tag"><%= f %></span>
                    <%      }
                    }
                    } %>
                </div>
                <div class="card-actions" style="flex-direction:column;gap:10px;">
                    <form action="<%= request.getContextPath() %>/bookHostel" method="post" style="width:100%;">
                        <input type="hidden" name="id" value="<%= h.getId() %>">
                        <button type="submit" class="btn btn-primary" style="width:100%">Book Now</button>
                    </form>
                    <a href="<%= request.getContextPath() %>/viewHostels" class="btn btn-secondary" style="width:100%;text-align:center;">View Hostels</a>
                </div>
                <div style="margin-top:10px;">
                    <a href="<%= request.getContextPath() %>/viewReviews?hostelId=<%= h.getId() %>" class="btn btn-secondary" style="flex:1;">Reviews</a>
                </div>
            </div>
        </div>
        <%  }
        } %>
        <% if (!anyFound) { %>
        <div style="grid-column:1/-1;">
            <div class="empty-state">
                <div class="empty-icon">Search</div>
                <h3>No hostels found</h3>
                <p>Try adjusting your search or check back later.</p>
            </div>
        </div>
        <% } %>
    </div>
</section>
<% } else { %>
<!-- CTA for guests -->
<section class="section" style="text-align:center;">
    <div class="section-header">
        <h2>Why Choose HostelFinder?</h2>
        <p>We make finding safe, affordable accommodation simple</p>
        <div class="section-line"></div>
    </div>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:28px;max-width:900px;margin:0 auto;">
        <div style="background:white;padding:32px 24px;border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,0.08);">
            <div style="font-size:2.5rem;margin-bottom:12px;">Verified</div>
            <h4 style="margin-bottom:8px;">Verified Listings</h4>
            <p style="color:var(--light);font-size:0.9rem;">Every hostel is reviewed by our admin team before going live.</p>
        </div>
        <div style="background:white;padding:32px 24px;border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,0.08);">
            <div style="font-size:2.5rem;margin-bottom:12px;">Secure</div>
            <h4 style="margin-bottom:8px;">Safe & Secure</h4>
            <p style="color:var(--light);font-size:0.9rem;">Your bookings and data are protected at every step.</p>
        </div>
        <div style="background:white;padding:32px 24px;border-radius:14px;box-shadow:0 4px 24px rgba(0,0,0,0.08);">
            <div style="font-size:2.5rem;margin-bottom:12px;">Affordable</div>
            <h4 style="margin-bottom:8px;">Best Prices</h4>
            <p style="color:var(--light);font-size:0.9rem;">Find affordable hostels that match your budget and needs.</p>
        </div>
    </div>
    <div style="margin-top:48px;">
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn btn-primary btn-lg">Create Free Account</a>
    </div>
</section>
<% } %>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-grid">
        <div class="footer-brand">
            <h3>Hostel<span>Finder</span></h3>
            <p>Nepal's trusted platform for finding safe, affordable, and verified hostel accommodation for students and travelers.</p>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/viewHostels">Browse Hostels</a>
            <a href="<%= request.getContextPath() %>/views/about_us.jsp">About Us</a>
            <% if (isAdmin) { %>
            <a href="<%= request.getContextPath() %>/admin/hostels">Manage Hostels</a>
            <a href="<%= request.getContextPath() %>/admin/bookings">Manage Bookings</a>
            <a href="<%= request.getContextPath() %>/viewComplaints">Complaints</a>
            <% } else { %>
            <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">Submit Hostel</a>
            <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
            <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
            <% } %>
        </div>
        <div class="footer-col">
            <h4>Account</h4>
            <a href="<%= request.getContextPath() %>/views/login.jsp">Login</a>
            <a href="<%= request.getContextPath() %>/views/register.jsp">Register</a>
        </div>
    </div>
    <div class="footer-bottom">(c) 2026 HostelFinder Nepal - All rights reserved.</div>
</footer>

</body>
</html>
