<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%
    String index = request.getParameter("index");
    SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
    String sql = "select id, descr from pc where id ='"+index+"';";
    ResultSet rs=dbpc.query(sql);
    if(rs.next())
        out.print(rs.getString("descr"));
    else
        out.print("Conto non trovato");
%>