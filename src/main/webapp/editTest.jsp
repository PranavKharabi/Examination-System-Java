<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        #page-content {
            flex: 1 0 auto;
        }

        #footer {
            flex-shrink: 0;
        }
    </style>
    <script>
        // Function to handle deletion of Java question
        function deleteJavaQuestion() {
            var selectedQuestion = document.getElementById("javaDropdown").value;
            // Send an AJAX request to deleteQuestion.jsp
            $.ajax({
                type: "POST",
                url: "deleteQuestion.jsp",
                data: { questionText: selectedQuestion, tableName: "questions" },
                success: function(response) {
                    // Reload the page after successful deletion
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        }

        // Function to handle deletion of Python question
        function deletePythonQuestion() {
            var selectedQuestion = document.getElementById("pythonDropdown").value;
            // Send an AJAX request to deleteQuestion.jsp
            $.ajax({
                type: "POST",
                url: "deleteQuestion.jsp",
                data: { questionText: selectedQuestion, tableName: "questionsPy" },
                success: function(response) {
                    // Reload the page after successful deletion
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        }

        // Function to handle addition of Java question
        function addJavaQuestion() {
            var question = document.getElementById("javaNewQuestion").value;
            var option1 = document.getElementById("javaOption1").value;
            var option2 = document.getElementById("javaOption2").value;
            var option3 = document.getElementById("javaOption3").value;
            var option4 = document.getElementById("javaOption4").value;
            var correct_option = document.getElementById("javaCorrectOption").value;

            // Send an AJAX request to the server-side script
            $.ajax({
                type: "POST",
                url: "addQuestion.jsp",
                data: {
                    question: question,
                    option1: option1,
                    option2: option2,
                    option3: option3,
                    option4: option4,
                    correct_option: correct_option,
                    javaQuestion: true // Add this parameter to specify it's a Java question
                },
                success: function(response) {
                    // Handle success response (if needed)
                    alert("Java question added successfully!");
                    location.reload(); // Reload the page to reflect the new question
                },
                error: function(xhr, status, error) {
                    // Handle error response (if needed)
                    console.error(xhr.responseText);
                    alert("Failed to add Java question. Please try again.");
                }
            });
        }

        // Function to handle addition of Python question
        function addPythonQuestion() {
            var question = document.getElementById("pythonNewQuestion").value;
            var option1 = document.getElementById("pythonOption1").value;
            var option2 = document.getElementById("pythonOption2").value;
            var option3 = document.getElementById("pythonOption3").value;
            var option4 = document.getElementById("pythonOption4").value;
            var correct_option = document.getElementById("pythonCorrectOption").value;

            // Send an AJAX request to the server-side script
            $.ajax({
                type: "POST",
                url: "addQuestion.jsp",
                data: {
                    question: question,
                    option1: option1,
                    option2: option2,
                    option3: option3,
                    option4: option4,
                    correct_option: correct_option,
                    pythonQuestion: true // Add this parameter to specify it's a Python question
                },
                success: function(response) {
                    // Handle success response (if needed)
                    alert("Python question added successfully!");
                    location.reload(); // Reload the page to reflect the new question
                },
                error: function(xhr, status, error) {
                    // Handle error response (if needed)
                    console.error(xhr.responseText);
                    alert("Failed to add Python question. Please try again.");
                }
            });
        }
    </script>
</head>

<body id="page-top" class="d-flex flex-column">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#page-top">Exam Portal</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
                type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
                aria-expanded="false" aria-label="Toggle navigation">
                Menu <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">Test</a></li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="login.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Dropdown Menu Section -->
    <section class="page-section" id="select-subject">
        <div class="container">
            <div class="row justify-content-center"> <!-- Center align -->
                <div class="col-md-6 col-lg-4 mb-5" style="margin-top: 50px;">
                    <div class="form-group">
                        <label for="javaDropdown">Java Questions:</label>
                        <select class="form-control" id="javaDropdown">
                            <% 
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM questions");
                                    while (rs.next()) {
                                        String questionText = rs.getString("question");
                            %>
                                        <option value="<%= questionText %>"><%= questionText %></option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                        <button class="btn btn-danger mt-2" onclick="deleteJavaQuestion()">Delete</button>
                    </div>
                    <!-- Form to add new Java question -->
                    <div class="text-center">
                        <h2 class="text-black mt-4">Add New Java Question</h2>
                        <hr class="divider light my-4" />
                        <form id="addJavaQuestionForm">
                            <div class="form-group">
                                <label for="javaNewQuestion">Question:</label>
                                <textarea class="form-control" id="javaNewQuestion" name="javaNewQuestion" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="javaOption1">Option 1:</label>
                                <input type="text" class="form-control" id="javaOption1" name="javaOption1">
                            </div>
                            <div class="form-group">
                                <label for="javaOption2">Option 2:</label>
                                <input type="text" class="form-control" id="javaOption2" name="javaOption2">
                            </div>
                            <div class="form-group">
                                <label for="javaOption3">Option 3:</label>
                                <input type="text" class="form-control" id="javaOption3" name="javaOption3">
                            </div>
                            <div class="form-group">
                                <label for="javaOption4">Option 4:</label>
                                <input type="text" class="form-control" id="javaOption4" name="javaOption4">
                            </div>
                            <div class="form-group">
                                <label for="javaCorrectOption">Correct Option:</label>
                                <select class="form-control" id="javaCorrectOption" name="javaCorrectOption">
                                    <option value="A">Option A</option>
                                    <option value="B">Option B</option>
                                    <option value="C">Option C</option>
                                    <option value="D">Option D</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="addJavaQuestion()">Add Question</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-5" style="margin-top: 50px;">
                    <div class="form-group">
                        <label for="pythonDropdown">Python Questions:</label>
                        <select class="form-control" id="pythonDropdown">
                            <% 
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/verif", "root", "admin");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM questionsPy");
                                    while (rs.next()) {
                                        String questionText = rs.getString("question");
                            %>
                                        <option value="<%= questionText %>"><%= questionText %></option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                        <button class="btn btn-danger mt-2" onclick="deletePythonQuestion()">Delete</button>
                    </div>
                    <!-- Form to add new Python question -->
                    <div class="text-center">
                        <h2 class="text-black mt-4">Add New Python Question</h2>
                        <hr class="divider light my-4" />
                        <form id="addPythonQuestionForm">
                            <div class="form-group">
                                <label for="pythonNewQuestion">Question:</label>
                                <textarea class="form-control" id="pythonNewQuestion" name="pythonNewQuestion" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="pythonOption1">Option 1:</label>
                                <input type="text" class="form-control" id="pythonOption1" name="pythonOption1">
                            </div>
                            <div class="form-group">
                                <label for="pythonOption2">Option 2:</label>
                                <input type="text" class="form-control" id="pythonOption2" name="pythonOption2">
                            </div>
                            <div class="form-group">
                                <label for="pythonOption3">Option 3:</label>
                                <input type="text" class="form-control" id="pythonOption3" name="pythonOption3">
                            </div>
                            <div class="form-group">
                                <label for="pythonOption4">Option 4:</label>
                                <input type="text" class="form-control" id="pythonOption4" name="pythonOption4">
                            </div>
                            <div class="form-group">
                                <label for="pythonCorrectOption">Correct Option:</label>
                                <select class="form-control" id="pythonCorrectOption" name="pythonCorrectOption">
                                    <option value="A">Option A</option>
                                    <option value="B">Option B</option>
                                    <option value="C">Option C</option>
                                    <option value="D">Option D</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="addPythonQuestion()">Add Question</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

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
    <!-- Bootstrap core JS-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/scripts.js"></script>
</body>

</html>
