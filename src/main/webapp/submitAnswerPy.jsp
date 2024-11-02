<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve data sent from client-side AJAX request
    String questionNumber = request.getParameter("questionNumber");
    String selectedOption = request.getParameter("selectedOption");
  

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/verif";
    String username = "root";
    String password = "admin";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to insert selected option into the database
        String sql = "INSERT INTO user_answersPy (question_number, selected_option) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, questionNumber);
        pstmt.setString(2, selectedOption);

        // Execute the query
        int rowsAffected = pstmt.executeUpdate();

        // Check if the insertion was successful
        if (rowsAffected > 0) {
            // Send a success response back to the client
            response.getWriter().write("Answer submitted successfully!");
        } else {
            // Send an error response back to the client
            response.getWriter().write("Failed to submit answer!");
        }
    } catch (SQLException | ClassNotFoundException e) {
        // Handle exceptions
        e.printStackTrace();
        response.getWriter().write("An error occurred: " + e.getMessage());
    } finally {
        // Close JDBC resources
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
