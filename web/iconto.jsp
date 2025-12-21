<%-- 
    Document   : iconto
    Created on : 5 nov 2021, 16:23:43
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="org.json.JSONObject"%>
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

        int c = Integer.parseInt(request.getParameter("i"));
        Conto cu = new Conto(DbParameter.getDb());
        cu = PiCo.pc.getConto(c);
        int id = cu.getId();
        int sid = cu.getsid();
        int nid = cu.getnid();
        int pos = cu.getPos();
        String descr = cu.getdescr();
        String lev = cu.getlevel();
        
        JSONArray result = new JSONArray();
        result.put(id);
        result.put(sid);
        result.put(nid);
        result.put(pos);
        result.put(descr);
        result.put(lev);
        out.println(result.toString());
        }
    %>
