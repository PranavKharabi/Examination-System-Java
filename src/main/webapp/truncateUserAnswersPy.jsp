<%@ page import="java.sql.*" %>
<%
    try {
        // Establish connection to the database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
        
        // Truncate the user_answers table
        String truncateQuery = "TRUNCATE TABLE user_answersPy";
        PreparedStatement truncateStmt = conn.prepareStatement(truncateQuery);
        truncateStmt.executeUpdate();
        
        // Close resources
        truncateStmt.close();
        conn.close();
        
        // Redirect back to the results page
        response.sendRedirect("pythonResult.jsp");
        
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>
