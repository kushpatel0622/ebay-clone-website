<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

    <%
    	
    session.invalidate();
    //session.getAttribute("user");
    
    response.sendRedirect("login.jsp"); 
    
    %>