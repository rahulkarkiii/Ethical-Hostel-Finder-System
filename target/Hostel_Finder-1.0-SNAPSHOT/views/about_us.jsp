<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hostell.hostel_finder.model.User" %>
<%
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
    <title>About Us - Hostel Finder Nepal</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        /* ── About Us page extras ── */
        .about-hero {
            background: linear-gradient(135deg, var(--charcoal) 0%, #2D2D45 60%, var(--teal) 100%);
            padding: 100px 40px 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .about-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .about-hero-content { position: relative; z-index: 2; max-width: 680px; margin: 0 auto; animation: riseIn 0.7s ease; }
        .about-hero h1 { font-size: clamp(2.2rem, 5vw, 3.6rem); color: var(--white); margin-bottom: 16px; }
        .about-hero h1 em { color: var(--saffron); font-style: normal; }
        .about-hero p { font-size: 1.1rem; color: rgba(255,255,255,0.65); max-width: 480px; margin: 0 auto; }

        /* Mission strip */
        .mission-strip {
            background: var(--saffron);
            padding: 32px 40px;
            text-align: center;
        }
        .mission-strip p {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--white);
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* Story section */
        .story-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            max-width: 1000px;
            margin: 0 auto;
        }
        .story-text h2 { font-size: clamp(1.6rem, 3vw, 2.2rem); color: var(--charcoal); margin-bottom: 16px; }
        .story-text h2 em { color: var(--saffron); font-style: normal; }
        .story-text p { color: var(--mid); line-height: 1.8; margin-bottom: 14px; font-size: 0.97rem; }
        .story-visual {
            background: linear-gradient(135deg, var(--sand) 0%, #EAD5C0 100%);
            border-radius: 20px;
            padding: 48px 36px;
            text-align: center;
            border: 1px solid rgba(232,113,42,0.15);
        }
        .story-visual .big-number {
            font-size: 4rem;
            font-weight: 900;
            color: var(--saffron);
            font-family: 'Playfair Display', serif;
            line-height: 1;
            margin-bottom: 6px;
        }
        .story-visual .big-label { font-size: 0.9rem; color: var(--mid); font-weight: 600; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 28px; }
        .story-visual .divider { width: 32px; height: 2px; background: var(--saffron); margin: 0 auto 28px; border-radius: 2px; }

        /* Values */
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
            max-width: 1000px;
            margin: 0 auto;
        }
        .value-card {
            background: white;
            border-radius: 16px;
            padding: 32px 24px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            border-top: 4px solid var(--saffron);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .value-card:hover { transform: translateY(-4px); box-shadow: 0 12px 40px rgba(0,0,0,0.12); }
        .value-card:nth-child(2) { border-top-color: var(--teal); }
        .value-card:nth-child(3) { border-top-color: #7C4DFF; }
        .value-card:nth-child(4) { border-top-color: #E53935; }
        .value-icon { font-size: 2.2rem; margin-bottom: 16px; }
        .value-card h4 { font-size: 1.05rem; color: var(--charcoal); margin-bottom: 8px; }
        .value-card p { font-size: 0.875rem; color: var(--light); line-height: 1.65; }

        /* Team */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 28px;
            max-width: 900px;
            margin: 0 auto;
        }
        .team-card {
            background: white;
            border-radius: 16px;
            padding: 28px 20px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            transition: transform 0.2s;
        }
        .team-card:hover { transform: translateY(-3px); }
        .team-avatar {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--saffron), var(--teal));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
            font-weight: 700;
            margin: 0 auto 16px;
            font-family: 'Playfair Display', serif;
        }
        .team-card h4 { font-size: 1rem; color: var(--charcoal); margin-bottom: 4px; }
        .team-card .role { font-size: 0.8rem; color: var(--saffron); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; }
        .team-card p { font-size: 0.82rem; color: var(--light); line-height: 1.55; }

        /* Contact strip */
        .contact-strip {
            background: linear-gradient(135deg, var(--teal) 0%, #0F4A56 100%);
            padding: 64px 40px;
            text-align: center;
        }
        .contact-strip h2 { font-size: clamp(1.6rem, 3vw, 2.2rem); color: var(--white); margin-bottom: 12px; }
        .contact-strip p { color: rgba(255,255,255,0.65); font-size: 1rem; margin-bottom: 32px; max-width: 480px; margin-left: auto; margin-right: auto; }
        .contact-links { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }

        @media (max-width: 768px) {
            .story-grid { grid-template-columns: 1fr; gap: 36px; }
            .about-hero { padding: 80px 20px 60px; }
            .mission-strip { padding: 28px 20px; }
            .contact-strip { padding: 48px 20px; }
        }
    </style>
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
        <a href="<%= request.getContextPath() %>/views/about_us.jsp" style="color:var(--saffron);">About Us</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else if (loggedIn) { %>
        <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
        <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">+ Submit Hostel</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/myComplaints">Complaints</a>
        <a href="<%= request.getContextPath() %>/views/about_us.jsp" style="color:var(--saffron);">About Us</a>
        <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
        <a href="<%= request.getContextPath() %>/views/about_us.jsp" style="color:var(--saffron);">About Us</a>
        <a href="<%= request.getContextPath() %>/views/login.jsp">Log In</a>
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn-nav">Sign Up</a>
        <% } %>
    </div>
</nav>

<!-- HERO -->
<section class="about-hero">
    <div class="about-hero-content">
        <div class="hero-badge">Our Story</div>
        <h1>About <em>HostelFinder</em></h1>
        <p>Nepal's trusted platform connecting students and travelers with safe, verified, and affordable hostel accommodation.</p>
    </div>
</section>

<!-- MISSION STRIP -->
<div class="mission-strip">
    <p>"Our mission is to make quality student housing accessible to everyone — removing the stress of finding a safe home away from home."</p>
</div>

<!-- OUR STORY -->
<section class="section">
    <div class="story-grid">
        <div class="story-text">
            <h2>How <em>We Started</em></h2>
            <p>HostelFinder was born out of a real problem. When students move to new cities for education in Nepal, finding a trustworthy hostel is often stressful, time-consuming, and filled with uncertainty about safety and price.</p>
            <p>We built this platform to change that — a single place where every hostel listing is reviewed and verified by our admin team before going live, so students can browse with confidence.</p>
            <p>Today, HostelFinder covers 25+ cities across Nepal, helping thousands of students and travelers find their perfect stay every year.</p>
        </div>
        <div class="story-visual">
            <div class="big-number">2024</div>
            <div class="big-label">Founded</div>
            <div class="divider"></div>
            <div class="big-number">500+</div>
            <div class="big-label">Verified Hostels</div>
            <div class="divider"></div>
            <div class="big-number">10K+</div>
            <div class="big-label">Happy Students</div>
        </div>
    </div>
</section>

<!-- OUR VALUES -->
<section class="section section-alt">
    <div class="section-header">
        <h2>Our Values</h2>
        <p>The principles that guide everything we do at HostelFinder</p>
        <div class="section-line"></div>
    </div>
    <div class="values-grid">
        <div class="value-card">
            <div class="value-icon">🛡️</div>
            <h4>Trust & Safety</h4>
            <p>Every hostel on our platform goes through a strict admin review. We never publish unverified listings.</p>
        </div>
        <div class="value-card">
            <div class="value-icon">💰</div>
            <h4>Affordability</h4>
            <p>We believe every student deserves a safe place to stay regardless of budget. Our listings cover all price ranges.</p>
        </div>
        <div class="value-card">
            <div class="value-icon">🌐</div>
            <h4>Transparency</h4>
            <p>Real photos, honest reviews, and clear pricing. No hidden fees, no surprises — just straightforward information.</p>
        </div>
        <div class="value-card">
            <div class="value-icon">🤝</div>
            <h4>Community</h4>
            <p>We connect hostel owners with students, building a community that cares about quality accommodation for all.</p>
        </div>
    </div>
</section>

<!-- STATS STRIP -->
<div class="stats-strip">
    <div class="stat-item"><h3>500+</h3><p>Verified Hostels</p></div>
    <div class="stat-item"><h3>10K+</h3><p>Happy Students</p></div>
    <div class="stat-item"><h3>25+</h3><p>Cities Covered</p></div>
    <div class="stat-item"><h3>4.8★</h3><p>Average Rating</p></div>
</div>

<!-- CONTACT / CTA -->
<section class="contact-strip">
    <h2>Get in Touch</h2>
    <p>Have a question, suggestion, or want to list your hostel? We'd love to hear from you.</p>
    <div class="contact-links">
        <a href="mailto:contact@hostelfinder.np" class="btn btn-outline btn-lg" style="color:white;border-color:rgba(255,255,255,0.4);">contact@hostelfinder.np</a>
        <% if (!loggedIn) { %>
        <a href="<%= request.getContextPath() %>/views/register.jsp" class="btn btn-primary btn-lg">Join HostelFinder</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/views/add_hostel.jsp" class="btn btn-primary btn-lg">Submit a Hostel</a>
        <% } %>
    </div>
</section>

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
            <% } else { %>
            <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">Submit Hostel</a>
            <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
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
