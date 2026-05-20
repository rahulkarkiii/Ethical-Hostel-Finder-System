<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Hostel - HostelFinder</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
  <a href="<%= request.getContextPath() %>/views/home.jsp" class="logo">Hostel<span>Finder</span></a>
  <div class="nav-links">
    <a href="<%= request.getContextPath() %>/views/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/viewHostels">Browse</a>
    <a href="<%= request.getContextPath() %>/views/add_hostel.jsp">+ Submit Hostel</a>
    <a href="<%= request.getContextPath() %>/logout" class="btn-nav">Logout</a>
  </div>
</nav>

<div class="placeholder-page">
  <div class="placeholder-card">
    <h1>Edit Hostel</h1>
    <p>This screen is being polished and will be available soon with a full edit workflow.</p>
    <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap;">
      <a href="<%= request.getContextPath() %>/viewHostels" class="btn btn-primary">Back to Listings</a>
      <a href="<%= request.getContextPath() %>/views/add_hostel.jsp" class="btn btn-outline">Submit New Hostel</a>
    </div>
  </div>
</div>

</body>
</html>
