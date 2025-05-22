<%-- 
    Document   : logout
    Created on : 18 May 2025, 10:18:33 pm
    Author     : Msft
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // End the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>

