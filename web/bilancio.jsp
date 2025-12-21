<%-- 
    Document   : modconto
    Created on : 7 nov 2021, 16:19:30
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbMovc"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
    <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
    <script type="text/javascript" src="js/jQuery.fancybox.js"></script>
<!--    <script type="text/javascript" src="js/tinymce.js"></script>-->
    <script type="text/javascript">
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SistemaX ver.2.0</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="css/p39.css">
    </head>
    <body>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
        out.println(Menu.getMenu());
        out.println("<br><br>");
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
//        out.println("</nav><br><br>");
    
//    out.println("<a href=\"menu.jsp\" style=\"text-align:right\">menu</a>");
//    out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>"+"<br>");
        SistemaXDbPc dbpc = new SistemaXDbPc (DbParameter.getDb());
        SistemaXDbMovc dbmovc = new SistemaXDbMovc (DbParameter.getDb());
        out.println("<div>");
        out.println("<form method=\"post\" action=\"rbila.jsp\">");
//        out.println("<select name=\"conto\" id=\"conto\">");
//        out.println("<option value=\"0\">Tutti</option>");
//        String sql= "select distinct id, descr from public.pc where id in (select distinct pcid from mrighe) order by id";
//        ResultSet rs = dbpc.query(sql);
//        while (rs.next()){
//            out.println("<option value=\""+rs.getInt("id")+"\">"+rs.getString("descr")+"</option>");
//        }
//        out.println("</select>");
        out.println("<select name=\"datain\" id=\"datain\">");
//        out.println("<option value=\"\">Tutte</option>");
        String sql= "select distinct data from public.movc order by data asc";
        ResultSet rs1 = dbmovc.query(sql);
        while (rs1.next()){
            out.println("<option value=\""+rs1.getString("data")+"\">"+rs1.getString("data")+"</option>");
        }
        out.println("</select>");
        out.println("<select name=\"dataout\" id=\"dataout\">");
//        out.println("<option value=\"\">Tutte</option>");
        sql= "select distinct data from public.movc order by data desc";
        ResultSet rs2 = dbmovc.query(sql);
        while (rs2.next()){
            out.println("<option value=\""+rs2.getString("data")+"\">"+rs2.getString("data")+"</option>");
        }
        out.println("</select>");
        out.println("<br><button type=\"submit\">Cerca</button>");
    }
%>
    </body>
</html>