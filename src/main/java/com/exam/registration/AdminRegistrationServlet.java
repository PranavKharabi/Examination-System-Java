package com.exam.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.DriverManager;
import java.sql.*;

@WebServlet("/registerAdmin")
public class AdminRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aname = request.getParameter("name");
		String aemail = request.getParameter("email");
		String apwd = request.getParameter("pass");
		String aid = request.getParameter("aid");
		RequestDispatcher dispatcher = null;
		Connection  con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif?useSSL=false", "root", "admin");
			PreparedStatement pst = con.prepareStatement("INSERT INTO admin(aname, apwd, aemail, aid) VALUES(?,?,?,?)");
			pst.setString(1, aname);
			pst.setString(2, apwd);
			pst.setString(3, aemail);
			pst.setString(4, aid);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("adminRegistration.jsp");
			
			if (rowCount > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con .close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
