<%-- 
    Document   : respmov
    Created on : 10 gen 2022, 15:16:31
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.Conto"%>
<%@page import="java.util.ArrayList"%>
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
//    out.println("<a href=\"menu.jsp\" style=\"text-align:right\">menu</a>");
//    out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>"+"<br>");
    
    out.println("<div><br><br>Movimenti Bilancio</div><br><br>");

        SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
        SistemaXDbMriga dbmriga = new SistemaXDbMriga(DbParameter.getDb());
        SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
    
    int id=0;
    String datain = request.getParameter("datain");
    String dataout = request.getParameter("dataout");
    if (datain==null || dataout==null || datain.toString().compareTo(dataout.toString())>0){
        %>
<script>

    window.history.back();

</script>
        <%
    
    }else{
    
//    id =Integer.parseInt(request.getParameter("conto"));
//    String descr ="" //request.getParameter("descr");
//    String imp ="" //request.getParameter("imp");
    String sql = "select distinct pcid from mrighe where idmovc in (select id from movc where true";
    if (datain!=""){
        //String formattedDate =(data.substring(0,4)+"-"+data.substring(3,5)+"-"+data.substring(6,10));
    
        sql += " and data >= '"+datain+"'";
    }
    if (dataout!=""){
        //String formattedDate =(data.substring(0,4)+"-"+data.substring(3,5)+"-"+data.substring(6,10));
    
        sql += " and data <= '"+dataout+"'";
    }
//    if (id!=0)
//        sql += " and id in (select distinct idmovc from mrighe where pcid='"+id+"')";
    sql += " order by data desc) order by pcid";
//    int [] pid = new int[99999];
    ArrayList ppcid= new ArrayList();
    int m =0;
    ResultSet rs = dbmriga.query(sql);
    while(rs.next()){
        ppcid.add(rs.getInt("pcid"));
        m++;
    }
    out.println("<table style=\"border:1px solid black\">"); //style=\"border:3px solid black\"
    out.println("<tr><td colspan=\"4\">");
    double saldo=0.00;
    for(int i=0; i<ppcid.size(); i++){
        String sql1="select descr from pc where id='"+ppcid.get(i)+"';";
        ResultSet rsss = dbpc.query(sql1);
        rsss.next();
        //out.println("ID "+pid[i]+"<br>");
        //out.println("data " +rs.getDate("data")+"<br>");//idmovc='"+rs.getInt("id")+"' and
        sql= "select distinct idmovc, da, pcid, descr, imp from mrighe where   pcid = '"+ppcid.get(i)+"' order by pcid;";
        ResultSet rss = dbmriga.query(sql);
        //out.println("<table style=\"border:1px solid black\">");
        out.println("<tr><td>Conto Id:"+ppcid.get(i)+" "+rsss.getString("descr")+"</td></tr>");
        double saldo1=0.00;
        while(rss.next()){
        
            //-----
            String sqlpc="select descr from pc where id='"+rss.getInt("pcid")+"';";
            ResultSet rspc=dbpc.query(sqlpc);
            rspc.next();
            String descrpc=rspc.getString("descr");
            //-----
        
            String ssql="select distinct id, data from movc where id ='"+rss.getInt("idmovc")+"'  and data >= '"+datain+"' and data <= '"+dataout+"'";
            ResultSet rss1 = dbmovc.query(ssql);
            while(rss1.next()){
                out.println("<tr style=\"background-color:#a8a8a8\">");
                out.println("<td>data " +rss1.getDate("data")+"</td>");//idmovc='"+rs.getInt("id")+"' and            
                out.println("<td>ID "+rss1.getInt("id")+"</td>");
                    //out.println("<td> Conto "+rss.getInt("pcid")+"-"+descrpc+" </td>");//rss.getString("descr")
                    out.println("<td> "+rss.getString("descr")+" </td>");
                if (rss.getBoolean("da")){
                    out.println("<td style=\"color:green\"> + Dare "+rss.getString("imp")+" </td>");
                    saldo+=Conto.round(Double.parseDouble(rss.getString("imp")),2);
                    saldo1+=Conto.round(Double.parseDouble(rss.getString("imp")),2);
                }
                else{
                    out.println("<td style=\"color:red\"> - Avere "+rss.getString("imp")+" </td>");
                    saldo-=Conto.round(Double.parseDouble(rss.getString("imp")),2);
                    saldo1-=Conto.round(Double.parseDouble(rss.getString("imp")),2);
                }
            }
            out.println("</tr>");
        }
//        out.println("</table>");
//        out.println("</td></tr>");
        out.println("<tr><td colspan=\"4\">");//<br><br>
        out.println("<div>Saldo conto "+Conto.round(saldo1,2)+"</div>");
        out.println("<br><br></td></tr>");
    }
    out.println("</table>");
    //out.println("<br><br>");
    out.println("<div>Saldo finale "+Conto.round(saldo,2)+"</div>");
//    FileWriter f = new FileWriter ("/home/p39/Documenti/retrimov.txt", true);
//    f.write(sql+"\n");
//    f.close();
    }
}
    
%>
