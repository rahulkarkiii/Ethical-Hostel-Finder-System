package com.hostell.hostel_finder.dao;

import com.hostell.hostel_finder.model.Review;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public boolean submitReview(int userId, int hostelId, int rating, String reviewText) {
        String sql = "INSERT INTO reviews(user_id, hostel_id, rating, review_text, created_at) VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, hostelId);
            ps.setInt(3, rating);
            ps.setString(4, reviewText);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Review> getReviewsByHostel(int hostelId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.id, r.user_id, r.hostel_id, r.rating, r.review_text, r.created_at, " +
                "u.name AS user_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "WHERE r.hostel_id = ? " +
                "ORDER BY r.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hostelId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setHostelId(rs.getInt("hostel_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setReviewText(rs.getString("review_text"));
                    review.setCreatedAt(rs.getTimestamp("created_at"));
                    review.setUserName(rs.getString("user_name"));
                    list.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Review> getReviewsByUser(int userId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.id, r.user_id, r.hostel_id, r.rating, r.review_text, r.created_at, " +
                "h.name AS hostel_name " +
                "FROM reviews r " +
                "JOIN hostels h ON r.hostel_id = h.id " +
                "WHERE r.user_id = ? " +
                "ORDER BY r.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setHostelId(rs.getInt("hostel_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setReviewText(rs.getString("review_text"));
                    review.setCreatedAt(rs.getTimestamp("created_at"));
                    review.setHostelName(rs.getString("hostel_name"));
                    list.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getAverageRating(int hostelId) {
        String sql = "SELECT AVG(rating) as avg_rating FROM reviews WHERE hostel_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hostelId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean userHasBookingForHostel(int userId, int hostelId) {
        String sql = "SELECT 1 FROM bookings WHERE user_id = ? AND hostel_id = ? AND status != 'rejected'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, hostelId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean userHasAlreadyReviewed(int userId, int hostelId) {
        String sql = "SELECT 1 FROM reviews WHERE user_id = ? AND hostel_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, hostelId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
// this is it 