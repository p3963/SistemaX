<%-- 
    Document   : xcppassx
    Created on : 3 ago 2025, 10:32:31
    Author     : piero.trentanove
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbUser"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="gest.pc.util.User.*"%>
<%@page import="invioemail.EmailSender"%>
<%@page import="include.PasswordGenerator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="include.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SiastemaX ver: 4</title>
    </head>
    <body style="text-align: center; margin: auto">
        <%
        out.println(Menu.getMenu());
        String username = request.getParameter("username");
        String newpass = request.getParameter("password");
        out.println(username+newpass);
        //DigestUtils du = new DigestUtils(newpass);
        String sha1pass=DigestUtils.sha1Hex(newpass);
        String sql="update utenti set password = '"+sha1pass+"' where username = '"+username+"';";
        SistemaXDbUser sxdbu = new SistemaXDbUser(DbParameter.getDb());
        sxdbu.uquery(sql);
        ArrayList<String> filenames = new ArrayList<String>();

        
        String contenuto= "Il tuo username è: '"+username+"'.<br>";
        contenuto+="La tua password è: '"+newpass+"'.";//"piero-39@libero.it"
        EmailSender es = new EmailSender("piero-39@libero.it",username,"","piero-39@libero.it","New password SistemaX",contenuto,filenames);
        es.inviaEmail();
        response.sendRedirect("index.jsp");
        %>
        <p>Password modificata</p><br><br>

    </body>
</html>
