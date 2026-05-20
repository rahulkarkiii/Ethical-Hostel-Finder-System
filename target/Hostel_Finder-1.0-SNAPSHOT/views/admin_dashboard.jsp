<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Hostel" %>
<%
    List<Hostel> pendingHostels = (List<Hostel>) request.getAttribute("pendingHostels");
    String updated = request.getParameter("updated");
    String action = request.getParameter("action");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Hostel Approvals</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="#" class="logo">Hostel<span>Finder</span> <span style="font-size:0.7rem;background:rgba(232,113,42,0.2);color:#FFB085;padding:3px 8px;border-radius:100px;margin-left:8px;font-family:'DM Sans',sans-serif;letter-spacing:1px;">ADMIN</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/admin/hostels" class="btn-nav">Hostel Approvals</a>
        <a href="<%= request.getContextPath() %>/admin/bookings">Bookings</a>
        <a href="<%= request.getContextPath() %>/admin/users">Users</a>
        <a href="<%= request.getContextPath() %>/viewComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</nav>

<div class="admin-layout">
    <aside class="admin-sidebar">
        <div class="sidebar-section">
            <span class="sidebar-label">Management</span>
            <a href="<%= request.getContextPath() %>/admin/hostels" class="sidebar-link active">Hostel Approvals</a>
            <a href="<%= request.getContextPath() %>/admin/bookings" class="sidebar-link">Bookings</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="sidebar-link">Users</a>
            <a href="<%= request.getContextPath() %>/viewComplaints" class="sidebar-link">Complaints</a>
        </div>
        <div class="sidebar-section">
            <span class="sidebar-label">Account</span>
            <a href="<%= request.getContextPath() %>/logout" class="sidebar-link">Logout</a>
        </div>
    </aside>

    <main class="admin-main">
        <h1 class="page-title">Pending Hostel Submissions</h1>
        <p class="page-subtitle">Review and approve or reject hostel listings below.</p>

        <% if ("success".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-success">Hostel <%= action != null ? action : "updated" %> successfully.</div>
        <% } else if ("error".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-error">Could not update hostel status. Please retry.</div>
        <% } %>

        <% if (pendingHostels != null && !pendingHostels.isEmpty()) { %>
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Image</th>
                    <th>Hostel Name</th>
                    <th>Location</th>
                    <th>Price (NPR)</th>
                    <th>Facilities</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Hostel h : pendingHostels) { %>
                <tr>
                    <td>
                        <% if (h.getImagePath() != null && !h.getImagePath().isEmpty()) { %>
                        <img src="<%= request.getContextPath() + "/" + h.getImagePath() %>" class="table-img" alt="Hostel">
                        <% } else { %>
                        <div style="width:64px;height:48px;background:var(--sand);border-radius:6px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;">Hostel</div>
                        <% } %>
                    </td>
                    <td style="font-weight:600;color:var(--charcoal);"><%= h.getName() %></td>
                    <td>Location: <%= h.getLocation() %></td>
                    <td>Rs. <%= String.format("%.0f", h.getPrice()) %></td>
                    <td style="max-width:180px;">
                        <% if (h.getFacilities() != null) {
                            for (String f : h.getFacilities().split(",")) {
                                f = f.trim();
                                if (!f.isEmpty()) { %>
                        <span class="facility-tag"><%= f %></span>
                        <%      }
                        }
                        } %>
                    </td>
                    <td><span class="status-badge status-<%= h.getStatus().toLowerCase() %>"><%= h.getStatus() %></span></td>
                    <td>
                        <div class="table-actions">
                            <form action="<%= request.getContextPath() %>/admin/hostels" method="post">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="id" value="<%= h.getId() %>">
                                <button type="submit" class="btn btn-teal btn-sm">Approve</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/admin/hostels" method="post">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="id" value="<%= h.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">All done</div>
            <h3>All caught up!</h3>
            <p>No pending hostel submissions to review right now.</p>
        </div>
        <% } %>
    </main>
</div>

</body>
</html>
