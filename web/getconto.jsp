<%-- 
    Document   : getconto
    Created on : 5 nov 2021, 10:04:35
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

    int c = Integer.parseInt(request.getParameter("i"));
    Conto cc = new Conto(DbParameter.getDb());
    cc=PiCo.pc.getConto(c);
    }
    
%>