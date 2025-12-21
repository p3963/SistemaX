
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.pc.util.User"%>
<%-- 
    Document   : logout.jsp
    Created on : 11-giu-2015, 10.08.32
    Author     : p39
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbUser"%>
<%@page import="gest.pc.util.Utenti"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema X Logout</title>
    </head>
    <body>
        <%  

            User user = new User();
            SistemaXDbUser ute = new SistemaXDbUser(DbParameter.getDb());
            HttpSession s=request.getSession();
            String username=(String)s.getAttribute("username");
            
            String sql = "select sessionid, username from utenti where username='"+username+"';";
            
            ResultSet rs = ute.query(sql);
            String ssid = "";
            while(rs.next()){
                ssid = rs.getString("sessionid");
            }
            
            Db db = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
            sql = "update utenti set sessionid = null where username='"+username+"';";
            db.uquery(sql);
            s.invalidate();
          
            response.sendRedirect("index.jsp");
            
        %>
    </body>
</html>
