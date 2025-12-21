<%-- 
    Document   : saldi
    Created on : 14 ago 2022, 09:42:08
    Author     : ptren
--%>

<%@page import="gest.db.SistemaXDb"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.pc.PiCo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
</head>
    
    <body>
  <script type="text/javascript">
    document.write("<div id=\"loading\" align=\"center\"><img src=\"images/fancybox_loading@2x.gif\" alt=\"Caricamento\" /></div>");
    </script>
    <%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    gest.pc.util.User usera = new gest.pc.util.User();
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



            SistemaXDbMriga dbmrighe = new SistemaXDbMriga(DbParameter.getDb());
            SistemaXDbMriga dbmrighe1 = new SistemaXDbMriga(DbParameter.getDb());
            SistemaXDbMriga dbmrighe2 = new SistemaXDbMriga(DbParameter.getDb());
            SistemaXDbMriga dbmrighe3 = new SistemaXDbMriga(DbParameter.getDb());
            PiCo q = new PiCo(DbParameter.getDb());
            q.scorriConti(4, PiCo.pc.getConto(2));
            int j = q.alConti.getSize();
            q.aConti = new Conto[j];
            q.alConti.getArr(q.aConti);
            PiCo p = new PiCo(DbParameter.getDb());
            p.scorriConti(4, PiCo.pc.getConto(1));
            int k = 0;
            int i = p.alConti.getSize();
            p.aConti = new Conto[i];
            p.alConti.getArr(p.aConti);
            String sql2="";
            String sql="";
            SistemaXDb dbpc = new SistemaXDb(DbParameter.getDb());
            for (int m=0;m<p.aConti.length;m++){
                sql="select imp, da from mrighe where pcid='"+p.aConti[m].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (p.aConti[m].getId()==0 || p.aConti[m].getId()==1 || p.aConti[m].getId()==2 || p.aConti[m].getId()==99999999 || p.aConti[m].getId()==999999999){
                    ;
                }else{
                    ResultSet rs = dbmrighe.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+p.aConti[m].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+p.aConti[m].getId()+";";
                    out.println("<br>");
                    dbmrighe1.uquery(sql1);
                }
            }
            out.println("<br><br>");
            for (int m=0;m<q.aConti.length;m++){
                sql="select imp, da from mrighe where pcid='"+q.aConti[m].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (q.aConti[m].getId()==0 || q.aConti[m].getId()==1 || q.aConti[m].getId()==2 || q.aConti[m].getId()==99999999 || q.aConti[m].getId()==999999999){
                    ;
                }else{
                    ResultSet rs = dbmrighe2.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+q.aConti[m].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+q.aConti[m].getId()+";";
                    out.println("<br>");
                    dbmrighe3.uquery(sql1);
                }
            }
        }
    %>
  <script type="text/javascript">
                    document.getElementById("loading").style.display = "none";
    </script>

    </body></html>