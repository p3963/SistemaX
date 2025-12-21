<%-- 
    Document   : saldidel
    Created on : 13 dic 2021, 15:16:51
    Author     : p39
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sax=request.getSession();
    String username=(String)sax.getAttribute("username");
    User usera = new User();
    if(sax.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
        
            int i = Integer.parseInt(request.getParameter("id"));
            Conto c = new Conto(DbParameter.getDb());
            c=PiCo.pc.getConto(i);
            String msg ="0";
            
            String sql ="select pcid from mrighe where pcid = "+i+"";
            SistemaXDbMriga mrighe = new SistemaXDbMriga(DbParameter.getDb());
            
            ResultSet rs = mrighe.query(sql);
            if (rs.next()){
                msg="0";
            }else{

    
                String sd = c.getSaldod().toString();
                String sa = c.getSaldoa().toString();
    
                if (sd.compareTo("0.00")==0)
                    if (sa.compareTo("0.00")==0)
                        msg = "1";
                }
        
            out.print(msg);
        }
    //}
%>