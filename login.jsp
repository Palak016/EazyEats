<%-- 
    Document   : login.jsp
    Created on : 18 May 2025, 6:30:51?pm
    Author     : Msft
--%>
<form action="RegisterUserServlet" method="post"></form>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login | EazyEats</title>

  <!-- Embedded CSS -->
  <style>
    body {
      background-image: url('Images/l5.jpeg');
      background-size: cover;
      background-position: center;
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
    }

    .login-container {
      max-width: 400px;
      margin: 100px auto;
      padding: 2rem;
      background: #f4f4f4;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .login-container h2 {
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .login-container label {
      display: block;
      margin-top: 1rem;
    }

    .login-container input {
      width: 100%;
      padding: 0.5rem;
      margin-top: 0.3rem;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .login-container button {
      width: 100%;
      padding: 0.7rem;
      margin-top: 1.5rem;
      background: #ef2626;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .login-container p {
      text-align: center;
      margin-top: 1rem;
    }

    .login-container a {
      color: #ef2626;
      text-decoration: none;
    }

    .login-container a:hover {
      text-decoration: underline;
    }
  </style>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet">
</head>
<body>
  <div class="login-container">
    <h2>Login to EazyEats</h2>

    <!-- Show error message if login fails -->
    <%
      String error = (String) request.getAttribute("errorMessage");
      if (error != null) {
    %>
      <p style="color:red; text-align:center;"><%= error %></p>
    <%
      }
    %>

    <form action="LoginServlet" method="POST">
      <label for="email">Username:</label>
      <input type="email" id="email" name="email" required />

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required />

      <button type="submit">Login</button>
    </form>

    <p>Don't have an account? <a href="register.jsp">Sign up</a></p>
  </div>
</body>
</html>
