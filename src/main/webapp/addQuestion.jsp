<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Get the question and options from the request parameters
    String question = request.getParameter("question");
    String option1 = request.getParameter("option1");
    String option2 = request.getParameter("option2");
    String option3 = request.getParameter("option3");
    String option4 = request.getParameter("option4");
    String correct_option = request.getParameter("correct_option");
    
    // Determine the table name based on the request parameter
    String tableName;
    if(request.getParameter("javaQuestion") != null) {
        tableName = "questions"; // Java questions table
    } else {
        tableName = "questionsPy"; // Python questions table
    }
    
    // JDBC connection parameters
    String url = "jdbc:mysql://localhost:3306/verif";
    String username = "root";
    String password = "admin";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // Establish the database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        // Prepare the SQL statement to insert the question into the specified table
        String sql = "INSERT INTO " + tableName + " (question, option1, option2, option3, option4, correct_option) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, question);
        pstmt.setString(2, option1);
        pstmt.setString(3, option2);
        pstmt.setString(4, option3);
        pstmt.setString(5, option4);
        pstmt.setString(6, correct_option);
        
        // Execute the update query
        int rowsAffected = pstmt.executeUpdate();
 
    } catch (ClassNotFoundException | SQLException e) {
        // Handle any errors that may occur
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the database resources
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
