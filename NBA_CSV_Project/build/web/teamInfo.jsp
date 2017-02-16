<%-- 
    Document   : teamInfo
    Created on : Nov 30, 2016, 2:27:45 PM
    Author     : steven
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //Retrieve information to connect to database
    String getChoice = request.getParameter("getSelection");
    //Connection string will vary depending on saved CSV
    String database = "jdbc:mysql://localhost:3306/nbadb";
    String user = "root";
    String password = "";
    
    //Locate and connect to the database
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(database, user, password);

    //Commands to be queried to database depending on choice
    String command = "";
    String title = "";
    if (getChoice.equalsIgnoreCase("All Teams")) {
        command = "Select * From nba_table";
        title = "<h2>All Teams</h2>";
    } else if (getChoice.equalsIgnoreCase("Top5Old")) {
        command = "Select * from nba_table order by year limit 5";
        title = "<h2>Top 5 Oldest Teams</h2>";
    } else if (getChoice.equalsIgnoreCase("Top5New")) {
        command = "Select * from nba_table order by year desc limit 5";
        title = "<h2>Top 5 Newest Teams</h2>";
    }

    Statement statement = conn.createStatement();

    ResultSet results = statement.executeQuery(command);
    boolean found = false;
    //Prints results
    out.println(title);
    while (results.next()) {
        found = true;
        int id = results.getInt("id");
        String name = results.getString("name");
        String year = results.getString("year");
        out.println("ID: " + id + ", Team Name: " + name + ", Year: " + year + "<br/>");
    }
%>