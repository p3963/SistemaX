<%-- 
    Document   : menu
    Created on : 8 gen 2022, 11:40:13
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
</head>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    gest.pc.util.User usera = new gest.pc.util.User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

    out.println("<body>");
    out.println(Menu.getMenu());
//        out.println("<nav class=\"navbar\">");
//        out.println("<input type=\"checkbox\" id=\"menu-toggle\">");
//        out.println("<label for=\"menu-toggle\" class=\"hamburger\">☰</label>");
//        out.println("<ul class=\"menu\">");
//            out.println("<li><a href=\"saldi.jsp\">Caricamento saldi</a></li>");
//            out.println("<li><a href=\"mostraconti.jsp\">Elenco conti</a></li>");
//            out.println("<li><a href=\"movimento.jsp\">Movimenti contabili</a></li>");
//            out.println("<li><a href=\"retrimov.jsp\">Ricerca movimenti</a></li>");
//            out.println("<li><a href=\"mastrino.jsp\">Mastrino</a></li>");
//            out.println("<li><a href=\"bilancio.jsp\">Movimenti-Bilancio</a></li>");
//            out.println("<li><a href=\"dump_dt.jsp\">Backup</a></li>");
//            out.println("<li><a href=\"restore_dt.jsp\">Restore</a></li>");
//            out.println("<li><a href=\"parametri.jsp\"><em>Parametri</em></a></li>");
//            out.println("<li><a href=\"logout.jsp\">Bye</a></li>");
//        out.println("</ul>");
//        out.println("</nav>");
    out.println("</body>");
%>
<!--        <h1>Hello World!</h1>
        <p><a href="saldi.jsp">Caricamento saldi</a></p>
        <p><a href="mostraconti.jsp">Elenco conti</a></p>
        <p><a href="movimento.jsp">Movimenti contabili</a></p>
        <p><a href="retrimov.jsp">Ricerca movimenti</a></p>
        <p><a href="mastrino.jsp">Mastrino</a></p>
        <p><a href="bilancio.jsp">Movimenti-Bilancio</a><br><br></p>
        <p><a href="dump_dt.jsp">Backup</a><br></p>
        <p><a href="restore_dt.jsp">Restore</a></p>
        <p><a href="logout.jsp">Bye</a></p> -->
<%
    }
%>
