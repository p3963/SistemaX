<%-- 
    Document   : modconto
    Created on : 7 nov 2021, 16:19:30
    Author     : p39
--%>

<%@page import="java.util.ArrayList"%>
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
    <script type="text/javascript" src="js/cbbox1.js"></script>
<!--    <script type="text/javascript" src="js/tinymce.js"></script>-->
    <link rel="stylesheet" href="css/cbbox1.css">
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
        out.println("<form method=\"post\" action=\"respmastr.jsp\">");
        
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
        int[] x = new int[j+k+l+s];
        String[] descriz = new String[j+k+l+s];
        SistemaXDbPc sistpc = new SistemaXDbPc(DbParameter.getDb());
        for (int i=0; i<j; i++){
                x[i] = PiCo.pc.getConto(p.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i] = rspc.getString("descr");
        }
        for (int i=0; i<k; i++){
                x[i+j] = PiCo.pc.getConto(q.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j] = rspc.getString("descr");
        }
        for (int i=0; i<l; i++){
                x[i+j+k] = PiCo.pc.getConto(t.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j+k]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j+k] = rspc.getString("descr");
        }
        for (int i=0; i<s; i++){
                x[i+j+k+l] = PiCo.pc.getConto(m.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j+k+l]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j+k+l] = rspc.getString("descr");
        }
        Conto current = new Conto (DbParameter.getDb());
        String sql= "select distinct id, descr from public.pc where id in (select distinct pcid from mrighe) order by descr";
        ResultSet rs = dbpc.query(sql);
        ArrayList idpc=new ArrayList();
        ArrayList descridpc=new ArrayList();
        while (rs.next()){
            idpc.add(rs.getInt("id"));
            descridpc.add(rs.getString("descr"));
//            out.println("<option value=\""+rs.getInt("id")+"\">"+rs.getString("descr")+"</option>");
        }

        out.println("<input required class=\"con\" onchange=\"descrconto($(this).val(),$(this).attr('id'));\" type=\"text\" name=\"conto\" list=\"piano\" placeholder=\"Scegli il Conto...\" id=\"regular\" /><span class=\"conspan\" id=\"pcspan\"></span>");
        out.println("<datalist id=\"piano\">");
    
//          for (int z=0; z<(j+k); z++){
//            if(!idpc.contains(x[z]))
//                continue;
//    
////                if(x[z]==rsmr.getInt("pcid"))
////                    opz=" selected";
////                else
//                    String opz="";
//
//                if(x[z]==0){
//                    ;
//                }
//                else if(x[z]==1){
//                    out.println("<option disabled value=\"1\">Stato patrimoniale</option>");
//                }else if(x[z]==2){
//                    out.println("<option disabled value=\"2\">Conto economico</option>");
//                }else if(x[z]==99999999){
//                    out.println("<option disabled value=\"99999999\">Coda sp</option>");
//                }else if(x[z]==999999999){
//                    out.println("<option disabled value=\"999999999\">Coda ce</option>");
//                }else{//
//                    out.println("<option "+opz+" id=\"opt\""+x[z]+" value='"+x[z]+" || "+descriz[z]+"'> id: "+x[z]+" descr: "+descriz[z]+"</option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
//                    out.println("<span id=\"spanpc"+x[z]+"\"></span>");
//                }
//                out.println("<span id=\"descrizioneconto\"></span>");
//              
//
//          }

        for (int z=0; z<j; z++){
                if(x[z]==0){
                    ;
                }
                else if(x[z]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z]+" value='"+x[z]+" || "+descriz[z]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<k; z++){
                if(x[z+j]==0){
                    ;
                }
                 else if(x[z+j]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j]+" value='"+x[z+j]+" || "+descriz[z+j]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<l; z++){
                if(x[z+j+k]==0){
                    ;
                }
                 else if(x[z+j+k]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j+k]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j+k]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j+k]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j+k]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j+k]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j+k]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j+k]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j+k]+" value='"+x[z+j+k]+" || "+descriz[z+j+k]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<s; z++){
                if(x[z+j+k+l]==0){
                    ;
                }
                 else if(x[z+j+k+l]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j+k+l]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j+k+l]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j+k+l]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j+k+l]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j+k+l]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j+k+l]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j+k+l]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j+k+l]+" value='"+x[z+j+k+l]+" || "+descriz[z+j+k+l]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }

        
        out.println("</datalist>");

//        out.println("<select name=\"conto\" id=\"conto\">");
        //out.println("<option value=\"0\">Tutti</option>");
//        out.println("</select>");
//String sql = "";
        out.println("<select name=\"datain\" id=\"datain\">");
        out.println("<option value=\"\">Tutte</option>");
        sql= "select distinct data from public.movc order by data";
        ResultSet rs1 = dbmovc.query(sql);
        while (rs1.next()){
            out.println("<option value=\""+rs1.getString("data")+"\">"+rs1.getString("data")+"</option>");
        }
        out.println("</select>");
        out.println("<select name=\"dataout\" id=\"dataout\">");
        out.println("<option value=\"\">Tutte</option>");
        sql= "select distinct data from public.movc order by data";
        ResultSet rs2 = dbmovc.query(sql);
        while (rs2.next()){
            out.println("<option value=\""+rs2.getString("data")+"\">"+rs2.getString("data")+"</option>");
        }
        out.println("</select>");
        out.println("<br><button type=\"submit\">Cerca</button>");
    }
%>
    </body>
        <script>
        function descrconto(f,g){
//            $("#regular"+g).val(f);
            i=f.substring(0,f.indexOf(" || "));
//            alert(f);//regular
            j=g.substring(7);
//            alert(g);
            $("#regular"+j).val(i);
            $("#pcspan"+j).text(f);
        }
    
</script>

</html>