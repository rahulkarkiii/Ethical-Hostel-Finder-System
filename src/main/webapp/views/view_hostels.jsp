<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Hostel, com.hostell.hostel_finder.model.User" %>
<%
    List<Hostel> list = (List<Hostel>) request.getAttribute("hostels");
    Object userObj = session.getAttribute("user");
    boolean loggedIn = userObj != null;
    User currentUser = loggedIn ? (User) userObj : null;
    boolean isAdmin = loggedIn && currentUser != null && currentUser.getRole() != null && "admin".equalsIgnoreCase(currentUser.getRole());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Hostels - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <% if (loggedIn && !isAdmin) { %>
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">+ Submit Hostel</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
        <a href="<%= request.getContextPath() %>/views/login.jsp">Log In</a>
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn-nav">Sign Up</a>
        <% } %>
    </div>
</nav>

<section class="section">
    <div class="section-header">
        <h2>All Available Hostels</h2>
        <p>Verified and approved listings ready for booking</p>
        <div class="section-line"></div>
    </div>

    <div class="hostel-grid">
        <% if (list != null && !list.isEmpty()) {
            for (Hostel h : list) { %>
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
                <div class="card-price">Rs. <%= String.format("%.0f", h.getPrice()) %><span style="font-size:0.78rem;color:var(--light);font-weight:400;">/month</span></div>
                <div style="margin-bottom:8px;">
                    <span class="status-badge status-approved">Approved</span>
                </div>
                <div style="margin-bottom:8px;">
                    <% if (h.getFacilities() != null) {
                        for (String f : h.getFacilities().split(",")) {
                            f = f.trim();
                            if (!f.isEmpty()) { %>
                    <span class="facility-tag"><%= f %></span>
                    <%      }
                    }
                    } %>
                </div>
                <% if (loggedIn && !isAdmin) { %>
                <form action="<%= request.getContextPath() %>/bookHostel" method="post" style="margin-top:10px;">
                    <input type="hidden" name="id" value="<%= h.getId() %>">
                    <button type="submit" class="btn btn-primary" style="width:100%;">Book Now</button>
                </form>
                <% } else { %>
                <a href="<%= request.getContextPath() %>/views/login.jsp" class="btn btn-primary" style="width:100%;margin-top:10px;display:inline-block;text-align:center;">Log in to Book</a>
                <% } %>
            </div>
        </div>
        <%  }
        } else { %>
        <div style="grid-column:1/-1;">
            <div class="empty-state">
                <div class="empty-icon">Hostel</div>
                <h3>No hostels available yet</h3>
                <p>Check back soon - new listings are reviewed daily.</p>
            </div>
        </div>
        <% } %>
    </div>
</section>

</body>
</html>
