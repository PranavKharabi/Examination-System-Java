<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java Exam</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/index-styles.css" rel="stylesheet" />
    <style>
        /* Additional styles */
        .hidden {
            display: none;
        }
        
        .footer{
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 225px;
        }

        /* Centering the question container */
        #questionContainer {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: left;
            min-height: 0vh; /* Adjust as needed */
            margin-top: 100px;
        }

        /* Style for radio buttons */
        .option {
            margin-bottom: 10px;
        }

        /* Style for answer options */
        .option-label {
            margin-right: 10px;
            font-weight: bold;
        }

        /* Style for buttons */
        .btn-container {
            display: flex;
            justify-content: space-between;
        }

        .btn-container button {
            margin-top: 20px;
        }
    </style>
</head>
<body id="page-top">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#page-top">Java Test</a>
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
    
    <!-- Java Exam Content -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <form id="examForm" action="pythonResult.jsp" method="post">
                    <div id="questionContainer">
                        <% 
                            try {
                                // Establish connection to the database
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
                                
                                // SQL query to fetch questions in their original order
                                String query = "SELECT * FROM questionsPy";
                                
                                // Create statement
                                Statement stmt = conn.createStatement();
                                
                                // Execute query
                                ResultSet rs = stmt.executeQuery(query);
                                
                                int questionCount = 1; // Counter for question number
                                
                                while (rs.next()) {
                                    String question = rs.getString("question");
                                    String option1 = rs.getString("option1");
                                    String option2 = rs.getString("option2");
                                    String option3 = rs.getString("option3");
                                    String option4 = rs.getString("option4");
                        %>
                                    <!-- Question structure -->
                                    <div class="questionDiv hidden" id="question<%= questionCount %>">
                                        <h4><%= questionCount + ": " + question %></h4>
                                        <ol>
                                            <li class="option">
                                                <input type="radio" name="answer<%= questionCount %>" value="<%= option1 %>">
                                                <span class="option-label">A.</span> <%= option1 %>
                                            </li>
                                            <li class="option">
                                                <input type="radio" name="answer<%= questionCount %>" value="<%= option2 %>">
                                                <span class="option-label">B.</span> <%= option2 %>
                                            </li>
                                            <li class="option">
                                                <input type="radio" name="answer<%= questionCount %>" value="<%= option3 %>">
                                                <span class="option-label">C.</span> <%= option3 %>
                                            </li>
                                            <li class="option">
                                                <input type="radio" name="answer<%= questionCount %>" value="<%= option4 %>">
                                                <span class="option-label">D.</span> <%= option4 %>
                                            </li>
                                        </ol>
                                        <div class="btn-container">
                                            <button type="button" class="btn btn-primary prevQuestion">Previous</button>
                                            <% if (questionCount < 10) { %>
                                                <button type="button" class="btn btn-primary nextAndSelect">Next</button>
                                            <% } else { %>
                                                <button type="button" class="btn btn-primary submitAnswer">Submit</button>
                                            <% } %>
                                        </div>
                                    </div>
                        <%          
                                    questionCount++; // Increment question counter
                                }
                                
                                // Close resources
                                rs.close();
                                stmt.close();
                                conn.close();
                                
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </form>
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
    
    <!-- Bootstrap core JS and custom scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Show the first question initially
            $(".questionDiv:first").removeClass("hidden");
            
            // Handle next and select button click
            $(".nextAndSelect").click(function() {
                var currentQuestion = $(this).closest(".questionDiv");
                var selectedOption = currentQuestion.find("input[name^='answer']:checked").val();
                var questionNumber = currentQuestion.attr("id").substring(8); // Extract question number from the ID
                // Retrieve option number
                
                // Send the response to the server
                $.ajax({
                    url: "submitAnswerPy.jsp", // Change this to the name of your JSP file
                    type: "POST",
                    data: { questionNumber: questionNumber, selectedOption: selectedOption}, // Pass optionNumber to the server
                    success: function(response) {
                        // Handle success response if needed
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });

                currentQuestion.addClass("hidden"); // Hide the current question
                currentQuestion.next(".questionDiv").removeClass("hidden"); // Show the next question
            });
            
            // Handle previous button click
            $(".prevQuestion").click(function() {
                var currentQuestion = $(this).closest(".questionDiv");
                currentQuestion.addClass("hidden"); // Hide the current question
                currentQuestion.prev(".questionDiv").removeClass("hidden"); // Show the previous question
            });

            // Handle submit button click for question 10
            $(".submitAnswer").click(function() {
                var currentQuestion = $(this).closest(".questionDiv");
                var selectedOption = currentQuestion.find("input[name^='answer']:checked").val();
                var questionNumber = currentQuestion.attr("id").substring(8); // Extract question number from the ID
                // Retrieve option number
                
                // Send the response to the server
                $.ajax({
                    url: "submitAnswerPy.jsp", // Change this to the name of your JSP file
                    type: "POST",
                    data: { questionNumber: questionNumber, selectedOption: selectedOption}, // Pass optionNumber to the server
                    success: function(response) {
                        // Handle success response if needed
                        window.location.href = "pythonResult.jsp"; // Redirect to javaresult.jsp after submitting
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });
            });
        });
    </script>
</body>
</html>
