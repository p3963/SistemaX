<%-- 
    Document   : hasson
    Created on : 1 nov 2021, 09:35:15
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONArray"%>
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

    
    String has="";
    JSONArray ab = new JSONArray();
    JSONArray result = new JSONArray();
    ab = (JSONArray) new JSONTokener(request.getParameter("ab")).nextValue();
    for (int i=1; i<ab.length(); i++){
        Conto c = new Conto(DbParameter.getDb());
        c=PiCo.pc.getConto(ab.getInt(i));
        if (c.hasSon())
            has="s";
        else if (c.hasNext())
            has="n";
        else
            has="0";
        result.put(has);
    }
    out.println(result);
    }
%>