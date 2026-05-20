<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, com.hostell.hostel_finder.model.User, com.hostell.hostel_finder.dao.UserDAO" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    if (users == null) {
        users = new UserDAO().getAllUsers();
    }
    String updated = request.getParameter("updated");
    String action = request.getParameter("action");
    Date now = new Date();
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Users</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="#" class="logo">Hostel<span>Finder</span> <span style="font-size:0.7rem;background:rgba(232,113,42,0.2);color:#FFB085;padding:3px 8px;border-radius:100px;margin-left:8px;font-family:'DM Sans',sans-serif;letter-spacing:1px;">ADMIN</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/admin/hostels">Hostel Approvals</a>
        <a href="<%= request.getContextPath() %>/admin/bookings">Bookings</a>
        <a href="<%= request.getContextPath() %>/admin/users" class="btn-nav">Users</a>
        <a href="<%= request.getContextPath() %>/viewComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</nav>

<div class="admin-layout">
    <aside class="admin-sidebar">
        <div class="sidebar-section">
            <span class="sidebar-label">Management</span>
            <a href="<%= request.getContextPath() %>/admin/hostels" class="sidebar-link">Hostel Approvals</a>
            <a href="<%= request.getContextPath() %>/admin/bookings" class="sidebar-link">Bookings</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="sidebar-link active">Users</a>
            <a href="<%= request.getContextPath() %>/viewComplaints" class="sidebar-link">Complaints</a>
        </div>
        <div class="sidebar-section">
            <span class="sidebar-label">Account</span>
            <a href="<%= request.getContextPath() %>/logout" class="sidebar-link">Logout</a>
        </div>
    </aside>

    <main class="admin-main">
        <h1 class="page-title">Registered Users</h1>
        <p class="page-subtitle">View all user accounts registered on the platform.</p>

        <% if ("success".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-success">User <%= action != null ? action : "updated" %> successfully.</div>
        <% } else if ("error".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-error">Could not update user status.</div>
        <% } %>

        <% if (users != null && !users.isEmpty()) { %>
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% for (User u : users) {
                    boolean suspended = u.getSuspendedUntil() != null && u.getSuspendedUntil().after(now);
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td style="font-weight:600;color:var(--charcoal);"><%= u.getName() %></td>
                    <td style="font-size:0.82rem;"><%= u.getEmail() %></td>
                    <td>
                        <% if (suspended) { %>
                        <span class="status-badge status-rejected">Suspended until <%= fmt.format(u.getSuspendedUntil()) %></span>
                        <% } else { %>
                        <span class="status-badge status-approved">Active</span>
                        <% } %>
                    </td>
                    <td>
                        <div class="table-actions">
                            <form action="<%= request.getContextPath() %>/admin/users" method="post" style="display:flex;gap:8px;align-items:center;">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <input type="number" name="days" min="1" max="365" placeholder="Days" required style="width:90px;padding:6px 8px;border:1px solid #E5E7EB;border-radius:6px;">
                                <button type="submit" name="action" value="suspend" class="btn btn-danger btn-sm">Suspend</button>
                            </form>
                            <% if (suspended) { %>
                            <form action="<%= request.getContextPath() %>/admin/users" method="post">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button type="submit" name="action" value="unsuspend" class="btn btn-teal btn-sm">Unsuspend</button>
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
            <div class="empty-icon">Users</div>
            <h3>No users yet</h3>
            <p>Newly registered users will appear here.</p>
        </div>
        <% } %>
    </main>
</div>

</body>
</html>
