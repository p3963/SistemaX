<%-- 
    Document   : dump_dt
    Created on : 3 lug 2025, 13:27:39
    Author     : piero.trentanove
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDb"%>
<%@page import="gest.pc.util.User"%>
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
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
    out.println("<body>");
            out.println(Menu.getMenu());
//        out.println("<nav class=\"navbar\">");
//        out.println("<input type=\"checkbox\" id=\"menu-toggle\">");
//        out.println("<label for=\"menu-toggle\" class=\"hamburger\">☰</label>");
//        out.println("<ul class=\"menu\">");
//            out.println("<li><a href=\"menu.jsp\">Home</a></li>");
//            out.println("<li><a href=\"saldi.jsp\">Caricamento saldi</a></li>");
//            out.println("<li><a href=\"mostraconti.jsp\">Elenco conti</a></li>");
//            out.println("<li><a href=\"movimento.jsp\">Movimenti contabili</a></li>");
//            out.println("<li><a href=\"retrimov.jsp\">Ricerca movimenti</a></li>");
//            out.println("<li><a href=\"mastrino.jsp\">Mastrino</a></li>");
//            out.println("<li><a href=\"bilancio.jsp\">Movimenti-Bilancio</a></li>");
//            out.println("<li><a href=\"dump_dt.jsp\">Backup</a></li>");
//            out.println("<li><a href=\"restore_dt.jsp\">Restore</a></li>");
//            out.println("<li><a href=\"logout.jsp\">Bye</a></li>");
//        out.println("</ul>");
//        out.println("</nav>");
    out.println("</body><br><br>");

         SistemaXDb sxdb = new SistemaXDb(DbParameter.getDb());
         String[] tabelle =  sxdb.getDbTables();
         out.println("<form method=\"post\" action=\"dump.jsp\">");
         for(int i=0; i<tabelle.length; i++)
            {
                out.println("Tabella "+tabelle[i]+"  <input type=\"checkbox\" name=\""+tabelle[i]+"\" value=\"SI\" ><br><br>");//
    
            }
            out.println("Database  "+DbParameter.getDb()+"  <input type=\"checkbox\" name=\""+DbParameter.getDb()+"\" value=\"SI\"><br><br>");//value=\"SI\"
            out.println("<button type=\"submit\">INVIA</button>");
            out.println("</form>");
            
    }    
%>