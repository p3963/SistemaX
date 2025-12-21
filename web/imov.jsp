<%-- 
    Document   : imov
    Created on : 5 nov 2021, 16:23:43
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.movc.Mriga"%>
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
            SistemaXDbMriga dbmriga = new SistemaXDbMriga(DbParameter.getDb());

            int m = Integer.parseInt(request.getParameter("i"));
            String sql = "select * from mrighe where id='"+m+"';";
            ResultSet rs = dbmriga.query(sql);
            rs.next();
        
            int id=m;//rs.getInt("id");
            int idmovc=rs.getInt("idmovc");
            String descr = rs.getString("descr");
            boolean da = rs.getBoolean("da");
            BigDecimal imp = rs.getBigDecimal("imp");
            int pcid=rs.getInt("pcid");
            int riga=rs.getInt("riga");
        
        
            JSONArray result = new JSONArray();
            result.put(id);
            result.put(idmovc);
            result.put(descr);
            result.put(da);
            result.put(imp);
            result.put(pcid);
            result.put(riga);
            out.println(result.toString());
        }
    %>
