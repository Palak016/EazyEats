<%-- 
    Document   : register.jsp
    Created on : 18 May 2025, 4:10:54 pm
    Author     : Msft
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign Up | EazyEats</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet">

    <!-- Embedded CSS -->
    <style>
        body {
            background-image: url('Images/l5.jpeg'); /* ✅ Make sure l5.jpeg is inside webapp/images */
            background-size: cover;
            background-position: center;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .form-container label {
            display: block;
            margin-top: 1rem;
            font-weight: 500;
            color: #444;
        }

        .form-container input {
            width: 100%;
            padding: 0.5rem;
            margin-top: 0.3rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-container button {
            width: 100%;
            padding: 0.7rem;
            margin-top: 1.5rem;
            background: #ef2020;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        .form-container button:hover {
            background: #c41616;
        }

        .form-container p {
            margin-top: 1rem;
            text-align: center;
        }

        .form-container a {
            color: #ef2020;
            text-decoration: none;
        }

        .form-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container" id="signup">
        <h2>Sign Up for EazyEats</h2>
        <form action="RegisterUserServlet" method="post">
            <label for="signup-name">Username:</label>
            <input type="text" id="signup-name" name="name" required />

            <label for="signup-email">Email:</label>
            <input type="email" id="signup-email" name="email" required />

            <label for="signup-password">Password:</label>
            <input type="password" id="signup-password" name="password" required />

            <label for="signup-confirm">Contact:</label>
            <input type="number" id="signup-confirm" name="confirm_password" required />

            <button type="submit" value="Register">Sign Up</button>
        </form>
        <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>

