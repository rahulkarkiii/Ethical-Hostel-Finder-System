<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Complaint, com.hostell.hostel_finder.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String updated = request.getParameter("updated");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints Management - Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .complaint-row {
            display: grid;
            grid-template-columns: 2fr 1.5fr 1fr 1.5fr;
            gap: 16px;
            align-items: center;
            padding: 16px;
            border-bottom: 1px solid #F3F4F6;
            background: var(--white);
        }
        .complaint-row:last-child {
            border-bottom: none;
        }
        .complaint-row:hover {
            background: var(--cream);
        }
        .complaint-detail {
            max-width: 100%;
        }
        .complaint-subject {
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 2px;
        }
        .complaint-user {
            font-size: 0.8rem;
            color: var(--light);
            margin-bottom: 4px;
        }
        .complaint-message {
            font-size: 0.9rem;
            color: var(--mid);
            line-height: 1.4;
            margin-top: 4px;
            white-space: normal;
        }
        .complaints-container {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
        }
        .complaints-header {
            display: grid;
            grid-template-columns: 2fr 1.5fr 1fr 1.5fr;
            gap: 16px;
            padding: 16px;
            background: var(--charcoal);
            color: var(--white);
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .status-form {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .status-form select {
            padding: 6px 8px;
            border: 1px solid #E5E7EB;
            border-radius: 6px;
            font-size: 0.9rem;
        }
        .status-form button {
            padding: 6px 12px;
            font-size: 0.8rem;
        }
    </style>
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
            <a href="<%= request.getContextPath() %>/admin/hostels" class="sidebar-link">Hostel Approvals</a>
            <a href="<%= request.getContextPath() %>/admin/bookings" class="sidebar-link">Bookings</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="sidebar-link">Users</a>
            <a href="<%= request.getContextPath() %>/viewComplaints" class="sidebar-link active">Complaints</a>
        </div>
        <div class="sidebar-section">
            <span class="sidebar-label">Account</span>
            <a href="<%= request.getContextPath() %>/logout" class="sidebar-link">Logout</a>
        </div>
    </aside>

    <main class="admin-main">
        <h1 class="page-title">Complaints Management</h1>
        <p class="page-subtitle">Review and manage user complaints</p>

        <% if ("success".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-success">Complaint status updated.</div>
        <% } else if ("error".equalsIgnoreCase(updated)) { %>
        <div class="alert alert-error">Could not update complaint status.</div>
        <% } %>

        <% if (complaints != null && !complaints.isEmpty()) { %>
        <div class="complaints-container">
            <div class="complaints-header">
                <div>Complaint Subject</div>
                <div>From User</div>
                <div>Date</div>
                <div>Status & Action</div>
            </div>
            
            <% for (Complaint c : complaints) { %>
            <div class="complaint-row">
                <div class="complaint-detail">
                    <div class="complaint-subject"><%= c.getSubject() %></div>
                    <div class="complaint-user">Hostel: <%= c.getHostelName() %></div>
                    <div class="complaint-message"><%= c.getMessage() %></div>
                </div>
                <div class="complaint-user"><%= c.getUserName() %></div>
                <div style="font-size: 0.8rem; color: var(--light);"><%= c.getCreatedAt() %></div>
                <div class="status-form">
                    <form action="<%= request.getContextPath() %>/viewComplaints" method="post" style="display: flex; gap: 8px; align-items: center;">
                        <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                        <select name="status" required>
                            <option value="pending" <%= "pending".equals(c.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="reviewed" <%= "reviewed".equals(c.getStatus()) ? "selected" : "" %>>Reviewed</option>
                        </select>
                        <button type="submit" class="btn btn-sm btn-primary" style="margin: 0;">Update</button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">Complaints</div>
            <h3>No complaints yet</h3>
            <p>No user complaints have been submitted.</p>
        </div>
        <% } %>
    </main>
</div>

</body>
</html>
