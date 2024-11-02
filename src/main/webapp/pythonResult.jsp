<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Exam</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet"
        type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/index-styles.css" rel="stylesheet" />
    <!-- Bootstrap core JS-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/index-scripts.js"></script>
    <script>
        $(document).ready(function() {
            // Handle click on "Back to Home" button
            $("#homeButton").click(function(e) {
                e.preventDefault(); // Prevent default link behavior
                
                // Send AJAX request to truncate user_answers table
                $.ajax({
                    url: "truncateUserAnswersPy.jsp", // Change this to the appropriate URL
                    type: "POST",
                    success: function(response) {
                        // Redirect to home page after truncating
                        window.location.href = "index.jsp";
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText);
                        // Redirect to home page even if there's an error
                        window.location.href = "index.jsp";
                    }
                });
            });
        });
    </script>
</head>

<body id="page-top">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#page-top">Results</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
                type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
                aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="login.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Java Exam Result Content -->
    <div class="container mt-5" style="padding-top: 100px;"> <!-- Adjust the padding top value according to your needs -->
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div id="resultContainer">
                    <table style="border: 1px solid black;">
                        <tr>
                            <th style="border: 1px solid black;">Question</th>
                            <th style="border: 1px solid black;">Option 1</th>
                            <th style="border: 1px solid black;">Option 2</th>
                            <th style="border: 1px solid black;">Option 3</th>
                            <th style="border: 1px solid black;">Option 4</th>
                            <th style="border: 1px solid black;">Correct Option</th>
                        </tr>
                        <% 
                            try {
                                // Establish connection to the database
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
                                
                                // Fetch data from the questions table
                                String questionQuery = "SELECT * FROM questionsPy";
                                PreparedStatement questionStmt = conn.prepareStatement(questionQuery);
                                ResultSet questionRs = questionStmt.executeQuery();
                                
                                // Display questions
                                while (questionRs.next()) {
                        %>
                        <tr>
                            <td style="border: 1px solid black;"><%= questionRs.getString("question") %></td>
                            <td style="border: 1px solid black;"><%= questionRs.getString("option1") %></td>
                            <td style="border: 1px solid black;"><%= questionRs.getString("option2") %></td>
                            <td style="border: 1px solid black;"><%= questionRs.getString("option3") %></td>
                            <td style="border: 1px solid black;"><%= questionRs.getString("option4") %></td>
                            <td style="border: 1px solid black;"><%= questionRs.getString("correct_option") %></td>
                        </tr>
                        <%          
                                }
                                questionRs.close();
                                questionStmt.close();
                                
                                // Fetch data from the user_answers table
                                String answerQuery = "SELECT * FROM user_answersPy";
                                PreparedStatement answerStmt = conn.prepareStatement(answerQuery);
                                ResultSet answerRs = answerStmt.executeQuery();
                                
                        %>
                    </table>
                    <h1>User Answers</h1>
                    <table style="border: 1px solid black;">
                        <tr>
                            <th style="border: 1px solid black;">Question Number</th>
                            <th style="border: 1px solid black;">Selected Option</th>
                            <th style="border: 1px solid black;">Submission Time</th>
                        </tr>
                        <% 
                                // Display user answers
                                while (answerRs.next()) {
                        %>
                        <tr>
                            <td style="border: 1px solid black;"><%= answerRs.getInt("question_number") %></td>
                            <td style="border: 1px solid black;"><%= answerRs.getString("selected_option") %></td>                           
                            <td style="border: 1px solid black;"><%= answerRs.getTimestamp("submission_time") %></td>
                        </tr>
                        <%          
                                }
                                answerRs.close();
                                answerStmt.close();
                                
                                conn.close();
                                
                            } catch (SQLException e) {
                                out.println("Error: " + e.getMessage());
                                e.printStackTrace();
                            }
                        %>
                    </table>
                    <a href="#" id="homeButton" class="btn btn-primary">Back to Home</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer-->
    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                <!-- Footer Location-->
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="text-uppercase mb-4">Location</h4>
                    <p class="lead mb-0">
                        1234, DY Patil Collage
                        <br />
                        Mobile: 9876543210
                    </p>
                </div>
                <!-- Footer Social Icons-->
                <div class="col-lg-4 mb-5 mb-lg-0" >
                    <h4 class="text-uppercase mb-4">Around the Web</h4>
                    <a class="btn btn-outline-light btn-social mx-1" href="https://www.facebook.com/"><i class="fab fa-fw fa-facebook-f"></i></a>
                    <a class="btn btn-outline-light btn-social mx-1" href="https://twitter.com/?lang=en"><i class="fab fa-fw fa-twitter"></i></a>
                    <a class="btn btn-outline-light btn-social mx-1" href="https://in.linkedin.com/"><i class="fab fa-fw fa-linkedin-in"></i></a>  
                </div>
                <!-- Footer About Text-->
                <div class="col-lg-4">
                    <p class="lead mb-0">
                         An online test platform is a digital solution designed to facilitate the creation, administration, and evaluation of tests or exams over the internet.  
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- Truncate User Answers Script -->
    <%
        // Truncate user_answers table when this page is accessed
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
            Statement stmt = conn.createStatement();
            String truncateQuery = "TRUNCATE TABLE user_answersPy";
            stmt.executeUpdate(truncateQuery);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            out.println("Error truncating user_answersPy table: " + e.getMessage());
            e.printStackTrace();
        }
    %>
</body>
</html>
