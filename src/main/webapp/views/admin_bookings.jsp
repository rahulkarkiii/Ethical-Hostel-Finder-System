<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Booking" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    String updated = request.getParameter("updated");
    String action = request.getParameter("action");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Bookings</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="#" class="logo">Hostel<span>Finder</span> <span style="font-size:0.7rem;background:rgba(232,113,42,0.2);color:#FFB085;padding:3px 8px;border-radius:100px;margin-left:8px;font-family:'DM Sans',sans-serif;letter-spacing:1px;">ADMIN</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/admin/hostels">Hostel Approvals</a>
        <a href="<%= request.getContextPath() %>/admin/bookings" class="btn-nav">Bookings</a>
        <a href="<%= request.getContextPath() %>/admin/users">Users</a>
        <a href="<%= request.getContextPath() %>/viewComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</nav>

<div class="admin-layout">
    <aside class="admin-sidebar">
        <div class="sidebar-section">
            <span class="sidebar-label">Management</span>
            <a href="<%= request.getContextPath() %>/admin/hostels" class="sidebar-link">Hostel Approvals</a>
            <a href="<%= request.getContextPath() %>/admin/bookings" class="sidebar-link active">Bookings</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="sidebar-link">Users</a>
            <a href="<%= request.getContextPath() %>/viewComplaints" class="sidebar-link">Complaints</a>
        </div>
        <div class="sidebar-section">
            <span class="sidebar-label">Account</span>
            <a href="<%= request.getContextPath() %>/logout" class="sidebar-link">Logout</a>
        </div>
    </aside>

    <main class="admin-main">
        <h1 class="page-title">All Bookings</h1>
        <p class="page-subtitle">Manage and update the status of user booking requests.</p>

        <% if ("success".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-success">Booking <%= action != null ? action : "updated" %> successfully.</div>
        <% } else if ("error".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-error">Could not update booking status. Please retry.</div>
        <% } %>

        <% if (bookings != null && !bookings.isEmpty()) { %>
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th>Hostel</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Booking b : bookings) { %>
                <tr>
                    <td style="font-weight:600;color:var(--charcoal);"><%= b.getUserName() %></td>
                    <td style="font-size:0.82rem;"><%= b.getUserEmail() %></td>
                    <td><%= b.getHostelName() %></td>
                    <td><span class="status-badge status-<%= b.getStatus().toLowerCase() %>"><%= b.getStatus() %></span></td>
                    <td style="font-size:0.82rem;"><%= b.getCreatedAt() %></td>
                    <td>
                        <div class="table-actions">
                            <% if (!"approved".equalsIgnoreCase(b.getStatus())) { %>
                            <form action="<%= request.getContextPath() %>/admin/bookings" method="post">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="id" value="<%= b.getId() %>">
                                <button type="submit" class="btn btn-teal btn-sm">Approve</button>
                            </form>
                            <% } %>
                            <% if (!"rejected".equalsIgnoreCase(b.getStatus())) { %>
                            <form action="<%= request.getContextPath() %>/admin/bookings" method="post">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="id" value="<%= b.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                            </form>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">Bookings</div>
            <h3>No bookings yet</h3>
            <p>User booking requests will appear here.</p>
        </div>
        <% } %>
    </main>
</div>

</body>
</html>
