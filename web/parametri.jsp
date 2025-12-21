<%-- 
    Document   : parametri
    Created on : 23 lug 2025, 15:43:45
    Author     : piero.trentanove
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParm"%>
<%@page import="gest.db.DbParameter"%>
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
    //Menu menu = new Menu();
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
//            out.println("<li><a href=\"logout.jsp\">Bye</a></li>");
//        out.println("</ul>");
//        out.println("</nav>");
    
    
    out.println("<p>Database in uso: <b>"+DbParameter.getDb()+"</b><p>");
    out.println("<br>");
    out.println("<p>Data attuale: <b>"+DbParameter.getDate()+"</b><p>");
    out.println("<br>");
    out.println("<p>Nome utente database: <b>"+DbParameter.getUser()+"</b><p>");
    out.println("<p>Password database: <b>"+DbParameter.getPass()+"</b><p>");
    out.println("<br>");
    out.println("<p>Tabella acquisti: <b>"+DbParameter.getAc()+"</b><p>");
    out.println("<p>Tabella aziende: <b>"+DbParameter.getAziende()+"</b><p>");
    out.println("<p>Tabella aziende per utenti: <b>"+DbParameter.getAzperut()+"</b><p>");
    out.println("<p>Tabella causali movimenti contabili: <b>"+DbParameter.getCaumovc()+"</b><p>");
    out.println("<p>Tabella movimenti contabili: <b>"+DbParameter.getMovc()+"</b><p>");
    out.println("<p>Tabella righe movimento contabili: <b>"+DbParameter.getMrighe()+"</b><p>");
    out.println("<p>Tabella generici movimenti: <b>"+DbParameter.getOd()+"</b><p>");
    out.println("<p>Tabella piano dei conti: <b>"+DbParameter.getPc()+"</b><p>");
    out.println("<p>Tabella utenti applicativo: <b>"+DbParameter.getUtenti()+"</b><p>");
    out.println("<p>Tabella vendite: <b>"+DbParameter.getVe()+"</b><p>");
    
    out.println("<br>");
    out.println("<p>Path della directory di lavoro: <b>"+DbParameter.getPath()+"</b><p>");
    out.println("<br>");
    out.println("<p>Path dell'utilty \"pg_dump\": <b>"+DbParameter.getDump()+"</b><p>");
    //out.println("<p>Path dell'utilty \"pg_restore\": <b>"+DbParameter.getRestore()+"</b><p>");
    out.println("<p>Path dell'utilty \"psql\": <b>"+DbParameter.getPsql_restore()+"</b><p>");
    out.println("<p>Path della directory di restore: <b>"+DbParameter.getSXR()+"</b><p>");
    out.println("<br>");
    out.println("<p>Comando per la lista dei backup: <b>"+DbParameter.getListab()+"</b><p>");
    out.println("<p>Lista dei backup: <b>"+DbParameter.getListab_out()+"</b><p>");

    out.println("<br>");
    out.println("<p>Comando per il drop database: <b>"+DbParameter.getDropdb()+"</b><p>");
    out.println("<p>Comando per il create database: <b>"+DbParameter.getCreatedb()+"</b><p>");
    out.println("<br>");
    //String pippo=DbParameter.
    out.println("<p>Cartella di lavoro: <b>"+DbParm.getLavoro()+"</b><p>");

    out.println("</body>");

    }
    %>
