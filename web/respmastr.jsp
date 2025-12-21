<%-- 
    Document   : respmov
    Created on : 10 gen 2022, 15:16:31
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbMovc"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.io.FileWriter"%>
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
    
//        out.println("<a href=\"menu.jsp\" style=\"text-align:right\">menu</a>");
//        out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>"+"<br>");

        SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
        SistemaXDbMriga dbmriga = new SistemaXDbMriga(DbParameter.getDb());
        SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
    
        int id=0;
        String datain = request.getParameter("datain");
        String dataout = request.getParameter("dataout");
        String idconto=request.getParameter("conto");
        
        if (idconto == null){
            out.println("conto non valido");
        %>
<script>

    window.history.back();

</script>
        <%
        }else{
    if(request.getParameter("conto")!=null && request.getParameter("conto")!=""){
        
        id =Integer.parseInt(request.getParameter("conto"));
        String queryconto="select id, descr from pc where id='"+id+"';";
        ResultSet rqc=dbpc.query(queryconto);
        rqc.next();
        out.println("<br><div class=\"autocenter bold\">Mastrino di conto&nbsp;IDconto&nbsp;"+id+"&nbsp;"+rqc.getString("descr")+"</div><br><br>");//");
//    String descr ="" //request.getParameter("descr");
//    String imp ="" //request.getParameter("imp");
    String sql = "select * from movc where true";
    if (datain!=""){
        //String formattedDate =(data.substring(0,4)+"-"+data.substring(3,5)+"-"+data.substring(6,10));
    
        sql += " and data >= '"+datain+"'";
    }
    if (dataout!=""){
        //String formattedDate =(data.substring(0,4)+"-"+data.substring(3,5)+"-"+data.substring(6,10));
    
        sql += " and data <= '"+dataout+"'";
    }
    if (id!=0)
        sql += " and id in (select distinct idmovc from mrighe where pcid='"+id+"')";
    sql += " order by data desc;";
//    if (descr!="")
//        sql += " and descr="+descr+"";
//    if(imp!="")
//        sql += " and imp="+imp+"";
    int m =0;
    ResultSet rs = dbmovc.query(sql);
//    out.println("<br>");
    out.println("<table class=\"autocenter bold\">"); // style=\"border:3px solid black\"
    double saldo=0.00;
    while(rs.next()){
        int i=0;
      if (rs.getInt("riga")>0){
        out.println("<br><br><tr><td colspan=\"3\">");
        out.println("<div class=\"autocenter bold\">ID "+rs.getInt("id")+"&nbsp;&nbsp;");
        out.println("data " +rs.getDate("data")+"<br>");
        out.println("</div>");
        out.println("</td></tr>");
        sql= "select id, riga, da, pcid, descr, imp from mrighe where idmovc='"+rs.getInt("id")+"' and pcid = '"+id+"';";
        ResultSet rss = dbmriga.query(sql);
        out.println("<table class=\"autoleft\" style=\"border:1px solid black\">");
//        out.println("<blockquote>");
        while(rss.next()){
            i++;
            out.println("<tr style=\"background-color:#a8a8a8\">");
            out.println("<td> ID "+rss.getInt("id")+" </td>");
            //out.println("<td> riga "+rss.getInt("riga")+" </td>");
            sql= "select descr from public.pc where id='"+rss.getInt("pcid")+"';";
            ResultSet rsss = dbpc.query(sql);
            while(rsss.next()){
                //out.println("<td> Conto "+rss.getInt("pcid")+"-"+rsss.getString("descr")+" </td>");
            }
            out.println("<td> "+rss.getString("descr")+" </td>");
            if (rss.getBoolean("da")){
                out.println("<td style=\"color:green\"> + Dare "+rss.getString("imp")+" </td>");
                saldo+=Conto.round(Double.parseDouble(rss.getString("imp")),2);
            }
            else{
                out.println("<td style=\"color:red\"> - Avere "+rss.getString("imp")+" </td>");
                saldo-=Conto.round(Double.parseDouble(rss.getString("imp")),2);
            }
            out.println("</tr>");
        }
        //out.println("<br>Righe " + String.valueOf(i));//rs.getInt("riga"));
        out.println("<tr><td colspan=\"3\">Righe " + String.valueOf(i)+"</td></tr>");//rs.getInt("riga"));
      }
//        out.println("</blockquote>");
    out.println("</table>");
    out.println("<br>");
//    out.println("Saldo finale: "+saldo);
        //out.println("<tr><td>");        
        //out.println("</td><tr>"); //<br><br>       
        //out.println("</tr>");
    }
    
    out.println("</table>");
    out.println("<br><br>");
    out.println("<div class=\"autocenter bold\">Saldo finale "+Conto.round(saldo,2)+"</div>");
//    FileWriter f = new FileWriter ("/home/p39/Documenti/retrimov.txt", true);
//    f.write(sql+"\n");
//    f.close();
    }
    }
}
%>
