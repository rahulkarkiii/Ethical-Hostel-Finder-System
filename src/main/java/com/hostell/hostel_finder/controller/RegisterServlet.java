package com.hostell.hostel_finder.controller;

import com.hostell.hostel_finder.dao.UserDAO;
import com.hostell.hostel_finder.model.User;
import com.hostell.hostel_finder.util.PasswordUtil;
import com.hostell.hostel_finder.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Servlet hit!");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (ValidationUtil.isBlank(name) || ValidationUtil.isBlank(email) || ValidationUtil.isBlank(password)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isStrongPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters and include uppercase, lowercase, number, and symbol.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.emailExists(email)) {
            request.setAttribute("error", "Email already registered. Please login.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hash(password));

        boolean result = dao.registerUser(user);

        if (result) {
            HttpSession session = request.getSession();
            session.setAttribute("success", "Registration successful! Please login.");

            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        } else {
            request.setAttribute("error", "Registration failed! Try again.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}