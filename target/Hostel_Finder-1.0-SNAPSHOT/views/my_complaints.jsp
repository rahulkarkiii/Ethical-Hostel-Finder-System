<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hostell.hostel_finder.model.Complaint, com.hostell.hostel_finder.model.Booking, com.hostell.hostel_finder.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser != null && currentUser.getRole() != null && "admin".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/viewComplaints");
        return;
    }
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    List<Booking> bookedHostels = (List<Booking>) request.getAttribute("bookedHostels");
    boolean hasBookedHostels = bookedHostels != null && !bookedHostels.isEmpty();
    String submitted = request.getParameter("submitted");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints - HostelFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .complaint-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 20px;
            border-left: 4px solid var(--saffron);
            box-shadow: var(--shadow);
            margin-bottom: 16px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
        }
        .complaint-card:hover {
            box-shadow: var(--shadow-lg);
        }
        .complaint-info {
            flex: 1;
        }
        .complaint-subject {
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 6px;
            font-size: 1rem;
        }
        .complaint-hostel {
            color: var(--light);
            font-size: 0.85rem;
            margin-bottom: 8px;
        }
        .complaint-message {
            color: var(--mid);
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 8px;
        }
        .complaint-date {
            color: var(--light);
            font-size: 0.8rem;
        }
        .complaint-status {
            white-space: nowrap;
        }
        .complaints-container {
            max-width: 900px;
            margin: 0 auto;
        }
        .complaints-page {
            padding: 40px;
            background: var(--cream);
            min-height: calc(100vh - 68px);
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
    </div>
</nav>

<div class="complaints-page">
    <div class="complaints-container">
        <h1 class="page-title">My Complaints</h1>
        <p class="page-subtitle">Submit and track complaints about hostels</p>

        <% if ("success".equalsIgnoreCase(submitted)) { %>
        <div class="alert alert-success">Your complaint has been submitted successfully. Admin will review it soon.</div>
        <% } else if ("no_booking".equalsIgnoreCase(submitted)) { %>
        <div class="alert alert-info">You can submit complaints only for hostels you have booked.</div>
        <% } else if ("error".equalsIgnoreCase(submitted)) { %>
        <div class="alert alert-error">Failed to submit complaint. Please try again.</div>
        <% } %>

        <div style="margin-bottom: 32px;">
            <% if (hasBookedHostels) { %>
            <button id="newComplaintBtn" class="btn btn-primary" style="padding: 12px 24px; font-size: 0.95rem;">
                + Submit New Complaint
            </button>
            <% } else { %>
            <div class="alert alert-info">Book a hostel first, then you can submit a complaint for that hostel.</div>
            <% } %>
        </div>

        <!-- Complaint Form Modal -->
        <div id="complaintModal" class="modal-backdrop">
            <div class="modal-card">
                <h2 style="margin-bottom: 20px;">Submit a Complaint</h2>
                <form action="<%= request.getContextPath() %>/submitComplaint" method="post">
                    <div class="form-group">
                        <label>Hostel</label>
                        <select name="hostelId" required>
                            <option value="">-- Select a hostel --</option>
                            <%
                                Set<Integer> seenHostelIds = new HashSet<>();
                                if (bookedHostels != null) {
                                    for (Booking b : bookedHostels) {
                                        if (seenHostelIds.add(b.getHostelId())) {
                            %>
                            <option value="<%= b.getHostelId() %>"><%= b.getHostelName() %></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject" placeholder="Brief subject of complaint" required>
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <textarea name="message" placeholder="Describe your complaint in detail..." required></textarea>
                    </div>
                    <div style="display: flex; gap: 12px; margin-top: 24px;">
                        <button type="submit" class="btn btn-primary" style="flex: 1;">Submit</button>
                        <button type="button" id="closeModal" class="btn btn-outline" style="flex: 1;">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <% if (complaints != null && !complaints.isEmpty()) { %>
        <div>
            <% for (Complaint c : complaints) { %>
            <div class="complaint-card">
                <div class="complaint-info">
                    <div class="complaint-subject"><%= c.getHostelName() %></div>
                    <div class="complaint-hostel"><strong>Complaint:</strong> <%= c.getSubject() %></div>
                    <div class="complaint-message"><%= c.getMessage() %></div>
                    <div class="complaint-date">Submitted: <%= c.getCreatedAt() %></div>
                </div>
                <div class="complaint-status">
                    <span class="status-badge status-<%= c.getStatus().toLowerCase() %>">
                        <%= c.getStatus().substring(0,1).toUpperCase() + c.getStatus().substring(1) %>
                    </span>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">Complaints</div>
            <h3>No complaints yet</h3>
            <p>You haven't submitted any complaints. If you have issues with a hostel, submit a complaint.</p>
            <% if (hasBookedHostels) { %>
            <button id="newComplaintBtn2" class="btn btn-primary" style="margin-top: 20px;">Submit Your First Complaint</button>
            <% } else { %>
            <a href="<%= request.getContextPath() %>/viewHostels" class="btn btn-primary" style="margin-top: 20px;">Browse Hostels</a>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<script>
    const modal = document.getElementById('complaintModal');
    const newComplaintBtn = document.getElementById('newComplaintBtn');
    const newComplaintBtn2 = document.getElementById('newComplaintBtn2');
    const closeModal = document.getElementById('closeModal');

    if (newComplaintBtn) newComplaintBtn.addEventListener('click', () => modal.classList.add('open'));
    if (newComplaintBtn2) newComplaintBtn2.addEventListener('click', () => modal.classList.add('open'));
    closeModal.addEventListener('click', () => modal.classList.remove('open'));

    modal.addEventListener('click', (e) => {
        if (e.target === modal) modal.classList.remove('open');
    });
</script>

</body>
</html>
