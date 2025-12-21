<%-- 
    Document   : respmov
    Created on : 10 gen 2022, 15:16:31
    Author     : p39
--%>

<%@page import="gest.pc.Conto"%>
<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Array"%>
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
<link type='text/css' rel='stylesheet' href='css/fancybox.css' />
<script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
<script type="text/javascript" src="js/core-fb1.js"></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
</head>

<script>
    function meno(i,idx,dat){
        //alert (i+" "+dat);
        if (confirm("Confermi eliminazione riga "+i+" ?")){
            $.ajax({
                url : "ajdelriga.jsp",
                dataType: "text",
                type: "post",
                data:{
                    id:i,
                },
                success: function(msg){
                    alert ("Riga "+i+" cancellata");
                    location.href="respmov.jsp?idx="+idx+"&dat="+dat+"";
                },
                error: function(e){
                    alert("Errore di comunicazione con il server");
                    location.href="respmov.jsp?idx="+idx+"&dat="+dat+"";                
                }
            });
        }
    }
    function popup(i) {
        //alert (i);
        $.ajax({
            url: "imov.jsp",
            dataType: "json",
            type: "post",
            data: {
                i: i
            },
            success: function (msg) {
                fillfancy(msg);
            },
            error: function (e) {
                alert("popup");
            },
        });
    }
    function fillfancy(msg) {
        var line = new String();
        $("#fancy").empty();
        for (var item in msg) {
            if (msg.hasOwnProperty(item)) {
                line = line.concat("<a href=\"#\" >" + msg[item] + "</a>");
            }
        }
        $("#fancy").html(line);
    }
    $(function () {
        $.extend($.fancybox.defaults, {
            afterClose: function () {
                location.reload();
            },
        });
    });
    function piu(x){
        alert(x);
    }
</script>
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
//        out.println("<br>Ricerca Movimenti<br><br>");
        SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
        SistemaXDbMovc dbmovc1 = new SistemaXDbMovc(DbParameter.getDb());
        SistemaXDbMriga dbmriga = new SistemaXDbMriga(DbParameter.getDb());
        SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
        String querydel="select movc.id from movc where (select count(id) from mrighe where idmovc=movc.id)=0;";
        ResultSet delmovc=dbmovc.query(querydel);
        while(delmovc.next()){
            String querydel1="delete from movc where id='"+delmovc.getInt("id")+"';";
            dbmovc1.uquery(querydel1);
        }
    
        int id=0;
        String data = request.getParameter("dat");
        id =Integer.parseInt(request.getParameter("idx"));
        int idmeno = id;
        String datameno = data;
        String sql = "select * from movc where true";
        if (data!=""){
            sql += " and data='"+data+"'";
        }
        if (id!=0)
            sql += " and id="+id+"";
        sql += " and riga!=0";
        sql += " order by data desc, id desc;";
        int m =0;
        ResultSet rs = dbmovc.query(sql);
        
//out.println("<div class=\"autocenter\"");
    
    double saldo=0.00;
        out.println("<table class=\"autocenter bold\">");// style=\"border:1px solid black\"; margin:\"auto\"; text-align:\"left\" class=\"autocenter\">"); //style=\"border:3px solid black\"
        while(rs.next()){
            out.println("<tr><td>");
            out.println("<div class=\"autocenter bold\">");
            out.println("ID "+rs.getInt("id")+"&nbsp;&nbsp;");
            out.println("data " +rs.getDate("data")+"<br>");
            out.println("</div>");
            out.println("</td></tr>");//<br><br>
            out.println("</div>");
            sql= "select id, riga, da, pcid, descr, imp from mrighe where idmovc='"+rs.getInt("id")+"' order by id;";
            ResultSet rss = dbmriga.query(sql);
            out.println("<table class=\"autoleft\" style=\"border:1px solid black\">");
            int i=0;
            while(rss.next()){
                i++;
                out.println("<tr style=\"background-color:#a8a8a8\">");//#92a8d1
                out.println("<td> ID "+rss.getInt("id")+" </td>");
                //out.println("<td> riga "+rss.getInt("riga")+" </td>");
                sql= "select descr from public.pc where id='"+rss.getInt("pcid")+"';";
                ResultSet rsss = dbpc.query(sql);
                while(rsss.next())
                    out.println("<td> Conto "+rss.getInt("pcid")+" - "+rsss.getString("descr")+" </td>");
                out.println("<td> "+rss.getString("descr")+" </td>");
                if (rss.getBoolean("da"))
                    out.println("<td style=\"color:green\"> + Dare "+rss.getString("imp")+" </td>");
                else
                    out.println("<td style=\"color:red\"> - Avere "+rss.getString("imp")+" </td>");

            if (rss.getBoolean("da")){
//                out.println("<td style=\"color:green\"> + Dare "+rss.getString("imp")+" </td>");
                saldo+=Conto.round(Double.parseDouble(rss.getString("imp")),2);
            }
            else{
//                out.println("<td style=\"color:red\"> - Avere "+rss.getString("imp")+" </td>");
                saldo-=Conto.round(Double.parseDouble(rss.getString("imp")),2);
            }
                    
                
                out.println("<td>&nbsp;<span onclick='meno(\""+rss.getInt("id")+"\",\""+idmeno+"\",\""+datameno+"\");'><img src='images/meno.gif'></span></td>");
                int rssid=rss.getInt("id");
                out.println("<td>&nbsp;<button href=\"modmriga.jsp?id="+rss.getInt("id")+"\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"popup('"+rss.getInt("id")
                        + "');\""
                        + " >Modifica</button></td>");//
                out.println("</tr>");
            }//onclick='piu(\""+rs.getInt("id")+"\");'
            out.println("<tr><td>&nbsp;<a href=\"addmriga.jsp?movcid="+rs.getInt("id")+"\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        //+ " fancybox-close"
                        + " ><img src='images/piu.gif'></a></td></tr>");
            out.println("<tr><td>");        
            out.println("righe " + String.valueOf(i));//rs.getInt("riga"));
            out.println("</td></tr>");
            out.println("</table>");
            out.println("<br><br>");
        }
        out.println("</table>");
    
        out.println("<div class=\"autocenter bold\">Saldo finale "+Conto.round(saldo,2)+"</div>");
        
        out.println("<br><br>");
//        out.println("</div>");

        out.println("<div id=\"fancy\" ></div>");//class=\"fancybox fancybox-close\"
    }
    
%>
