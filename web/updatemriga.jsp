<%-- 
    Document   : updatemriga
    Created on : 14 nov 2021, 10:15:08
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="gest.movc.Mriga"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.lang.Boolean"%>
<%@page import="java.io.FileWriter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0){
        response.sendRedirect("index.jsp");
    }
    else{
//        Mriga m = new Mriga("gest");
        int id = Integer.parseInt(request.getParameter("id"));
        int idmovc = Integer.parseInt(request.getParameter("idmovc"));
        String descr = request.getParameter("descr");
        String da = request.getParameter("da").toString();//Boolean.getBoolean(
//        int dax=0;
//        if(da)
//            dax=1;
//        else
//            dax=0;
        int riga = Integer.parseInt(request.getParameter("riga"));
        int pcid = Integer.parseInt(request.getParameter("pcid"));
        String imp = request.getParameter("imp");
        
        String sql="update mrighe set idmovc='"+idmovc+"', descr='"+descr+"', da="+da+", imp='"+imp+"', pcid='"+pcid+"', riga='"+riga+"' where id='"+id+"';";
        SistemaXDbMriga mr=new SistemaXDbMriga(DbParameter.getDb());
        mr.uquery(sql);
    }
%>
