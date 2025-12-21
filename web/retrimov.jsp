<%-- 
    Document   : retrimov
    Created on : 10 gen 2022, 10:39:33
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbMovc"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.movc.Movc"%>
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

    SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
//    out.println("<a href=\"menu.jsp\" style=\"text-align:right\">menu</a>");
//    out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>"+"<br>");

    out.println("<form method=\"post\" action=\"respmov.jsp\">");
    
    String sql = "select distinct data from public.movc order by data desc";
    ResultSet rs = dbmovc.query(sql);
    out.println("<select id=\"dat\" name=\"dat\">");
    out.println("<option value=\"\">Tutte</option>");
    while (rs.next()){
        out.println("<option value='"+rs.getString("data")+"'>"+rs.getString("data")+"</option>");
    }
    out.println("</select><br>");
    
    sql = "select distinct id from public.movc order by id desc";
    rs = dbmovc.query(sql);
    out.println("<select id=\"id\" name=\"idx\">");
    out.println("<option value=\"0\">Tutte</option>");
    while (rs.next()){
        out.println("<option value='"+rs.getString("id")+"'>"+rs.getString("id")+"</option>");
    }
    out.println("</select><br>");
    
//    sql = "select distinct descr from public.movc order by descr desc";
//    rs = dbmovc.query(sql);
//    out.println("<select id=\"descr\" name=\"descr\">");
//    out.println("<option value=\"\">Tutte</option>");
//    while (rs.next()){
//        out.println("<option value='"+rs.getString("descr")+"'>"+rs.getString("descr")+"</option>");
//    }
//    out.println("</select><br>");
    
//    sql = "select distinct imp from public.movc order by imp desc";
//    rs = dbmovc.query(sql);
//    out.println("<select id=\"imp\" name=\"imp\">");
//    out.println("<option value=\"\">Tutte</option>");
//    while (rs.next()){
//        out.println("<option value='"+rs.getString("imp")+"'>"+rs.getString("imp")+"</option>");
//    }
//    out.println("</select>");
    out.println("<br><button type=\"submit\">Invia</button>");
    out.println("</form>");
    }
%>