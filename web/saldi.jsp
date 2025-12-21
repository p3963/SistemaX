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
        PiCo p = new PiCo(DbParameter.getDb());
        p.scorriConti(4, PiCo.pc.getConto(6));
        int j = p.alConti.getSize();
        p.aConti = new Conto[j];
        p.alConti.getArr(p.aConti);
        PiCo q = new PiCo(DbParameter.getDb());
        q.scorriConti(4, PiCo.pc.getConto(50000));
        int k = q.alConti.getSize();
        q.aConti = new Conto[k];
        q.alConti.getArr(q.aConti);
        PiCo t = new PiCo(DbParameter.getDb());
        t.scorriConti(4, PiCo.pc.getConto(100000));
        int l = t.alConti.getSize();
        t.aConti = new Conto[l];
        t.alConti.getArr(t.aConti);
        PiCo m = new PiCo(DbParameter.getDb());
        m.scorriConti(4, PiCo.pc.getConto(150000));
        int s = m.alConti.getSize();
        m.aConti = new Conto[s];
        m.alConti.getArr(m.aConti);
            String sql2="";
            String sql="";
            SistemaXDb dbpc = new SistemaXDb(DbParameter.getDb());
            for (int a=0;a<p.aConti.length;a++){
                sql="select imp, da from mrighe where pcid='"+p.aConti[a].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (p.aConti[a].getId()==0
                || p.aConti[a].getId()==6
                || p.aConti[a].getId()==50000
                || p.aConti[a].getId()==100000
                || p.aConti[a].getId()==150000
                || p.aConti[a].getId()==49999
                || p.aConti[a].getId()==99999
                || p.aConti[a].getId()==149999
                || p.aConti[a].getId()==199999
                ){
                    ;
                }else{
                    ResultSet rs = dbmrighe.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+p.aConti[a].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+p.aConti[a].getId()+";";
                    out.println("<br>");
                    dbmrighe1.uquery(sql1);
                }
            }
            for (int b=0;b<q.aConti.length;b++){
                sql="select imp, da from mrighe where pcid='"+q.aConti[b].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (q.aConti[b].getId()==0
                || q.aConti[b].getId()==6
                || q.aConti[b].getId()==50000
                || q.aConti[b].getId()==100000
                || q.aConti[b].getId()==150000
                || q.aConti[b].getId()==49999
                || q.aConti[b].getId()==99999
                || q.aConti[b].getId()==149999
                || q.aConti[b].getId()==199999
                ){
                    ;
                }else{
                    ResultSet rs = dbmrighe.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+q.aConti[b].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+q.aConti[b].getId()+";";
                    out.println("<br>");
                    dbmrighe1.uquery(sql1);
                }
            }
            for (int c=0;c<t.aConti.length;c++){
                sql="select imp, da from mrighe where pcid='"+t.aConti[c].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (t.aConti[c].getId()==0
                || t.aConti[c].getId()==6
                || t.aConti[c].getId()==50000
                || t.aConti[c].getId()==100000
                || t.aConti[c].getId()==150000
                || t.aConti[c].getId()==49999
                || t.aConti[c].getId()==99999
                || t.aConti[c].getId()==149999
                || t.aConti[c].getId()==199999
                ){
                    ;
                }else{
                    ResultSet rs = dbmrighe.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+t.aConti[c].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+t.aConti[c].getId()+";";
                    out.println("<br>");
                    dbmrighe1.uquery(sql1);
                }
            }
            for (int d=0;d<m.aConti.length;d++){
                sql="select imp, da from mrighe where pcid='"+m.aConti[d].getId()+"'";
                Double impd = 0.0;
                Double impa = 0.0;
                if (m.aConti[d].getId()==0
                || m.aConti[d].getId()==6
                || m.aConti[d].getId()==50000
                || m.aConti[d].getId()==100000
                || m.aConti[d].getId()==150000
                || m.aConti[d].getId()==49999
                || m.aConti[d].getId()==99999
                || m.aConti[d].getId()==149999
                || m.aConti[d].getId()==199999
                ){
                    ;
                }else{
                    ResultSet rs = dbmrighe.query(sql);
                    while (rs.next()){
                        if (rs.getBoolean("da"))
                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
                        else
                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
                    }
                    sql2="select id, descr from pc where id='"+m.aConti[d].getId()+"';";
                    ResultSet rs2=dbpc.query(sql2);
                    rs2.next();
                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
                    out.println(pp);
                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+m.aConti[d].getId()+";";
                    out.println("<br>");
                    dbmrighe1.uquery(sql1);
                }
            }
            out.println("<br><br>");
//            for (int m=0;m<q.aConti.length;m++){
//                sql="select imp, da from mrighe where pcid='"+q.aConti[m].getId()+"'";
//                Double impd = 0.0;
//                Double impa = 0.0;
//                if (q.aConti[m].getId()==0 || q.aConti[m].getId()==1 || q.aConti[m].getId()==2 || q.aConti[m].getId()==99999999 || q.aConti[m].getId()==999999999){
//                    ;
//                }else{
//                    ResultSet rs = dbmrighe2.query(sql);
//                    while (rs.next()){
//                        if (rs.getBoolean("da"))
//                            impd+=Double.valueOf(rs.getBigDecimal("imp").toString());
//                        else
//                            impa+=Double.valueOf(rs.getBigDecimal("imp").toString());
//                    }
//                    sql2="select id, descr from pc where id='"+q.aConti[m].getId()+"';";
//                    ResultSet rs2=dbpc.query(sql2);
//                    rs2.next();
//                    String pp ="Conto: <b>"+rs2.getString("id")+"</b> - Descrizione: <b>"+rs2.getString("descr")+"</b> - Saldo dare: <b>"+impd.toString()+"</b> - Saldo avere <b>"+impa.toString()+"</b><br>";
//                    out.println(pp);
//                    String sql1 = "update public.pc set saldoa="+impa.toString()+", saldod="+impd.toString()+" where id="+q.aConti[m].getId()+";";
//                    out.println("<br>");
//                    dbmrighe3.uquery(sql1);
//                }
//            }
        }
    %>
  <script type="text/javascript">
                    document.getElementById("loading").style.display = "none";
    </script>

    </body></html>