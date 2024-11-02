<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve parameters from the request
    String questionText = request.getParameter("questionText");
    String tableName = request.getParameter("tableName");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/verif";
    String username = "root";
    String password = "admin";

    // JDBC variables
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        connection = DriverManager.getConnection(url, username, password);

        // Prepare the SQL statement to delete the question
        String sql = "DELETE FROM " + tableName + " WHERE question = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, questionText);

        // Execute the delete operation
        int rowsAffected = preparedStatement.executeUpdate();

        // Check if the deletion was successful
        if (rowsAffected > 0) {
            out.println("Question deleted successfully!");
        } else {
            out.println("Failed to delete the question.");
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close JDBC resources
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
