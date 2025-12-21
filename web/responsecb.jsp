<%-- 
    Document   : responsecb
    Created on : 13 ago 2025, 10:24:25
    Author     : piero.trentanove
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String resp=request.getParameter("pc");
            out.println(resp);
            %>
    </body>
</html>
