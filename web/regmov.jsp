<%-- 
    Document   : regmov
    Created on : 28 dic 2021, 18:39:53
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.movc.Mriga"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="gest.db.SistemaXDbMovc"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="gest.movc.Movc"%>
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
//        out.println("</nav>");

    
    SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
    Movc mov = new Movc(DbParameter.getDb());
    
    SistemaXDbMriga riga = new SistemaXDbMriga(DbParameter.getDb());
    Mriga mriga = new Mriga (DbParameter.getDb());
    
    int tot = Integer.parseInt(request.getParameter("tot"));
    
    
    String data =request.getParameter("data");
    mov.setData(data.substring(0,4)+"-"+data.substring(5,7)+"-"+data.substring(8,10));
    
    String tipo = request.getParameter("tipo");
    //String cau = request.getParameter("cau");
    String descr[] = new String[tot];
    Float imp[] = new Float[tot];
//    String imp[] = new String[tot];
    String da[] = new String[tot];
    String pc[] = new String[tot];
    
    int i=1;
    int j=0;
    int m=0;
    int idx=0;
    boolean flag =true;
    while(i<imp.length) {
    
        imp[i]=Float.parseFloat(request.getParameter("impout"+i));
        pc[i]=request.getParameter("pcout"+i);
        descr[i]=request.getParameter("desout"+i);
        da[i]=request.getParameter("daout"+i);
        //double d = bd.doubleValue();
//        if (imp[i].compareTo("")==0){
//        }
// || imp[i].compareTo("")==0                
        if(imp[i]==null || descr[i]==null || pc[i]==null){//Double.valueOf(imp[i]).compareTo(0.00)==0 ){
//        if(String.valueOf(imp[i]).compareTo("0.00")==0){
            j++;
        }else{
            if(flag){
                flag = false;
                dbmovc.qinsert(mov);
                idx=dbmovc.maxid();
            }
            mriga.setIdmovc(idx);
            mriga.setRiga(i);
            mriga.setImp(imp[i].toString());
        
        
        
            mriga.setDescr(descr[i]);
            if (Integer.parseInt(da[i])==1)
                mriga.setDa(true);
            else
                mriga.setDa(false);
                
                            
            int p= Integer.parseUnsignedInt(pc[i]);
            
            mriga.setPcid((int)p);
            riga.qinsert(mriga);
        }    
        i++;
    }
    Movc x = new Movc(DbParameter.getDb());
    x=dbmovc.getMovc(idx);
    x.setRiga(i-j-1);
    if (String.valueOf(tipo).compareTo("1")==0)
        x.setVeid(i-j-1);
    else if (String.valueOf(tipo).compareTo("2")==0)
        x.setAcid(i-j-1);
    else
        x.setOdid(i-j-1);
    dbmovc.update(x);
    }
//        <script>
//            alert("Ci sono campi non valorizzati!");
//            location.href="movimento.jsp";            
//        </script>
    
    %>
    <script type="text/javascript">
        location.href="movimento.jsp";
    </script>