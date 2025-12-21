<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbMovc"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%
    SistemaXDbMovc dbmovc = new SistemaXDbMovc(DbParameter.getDb());
    SistemaXDbMovc dbmovc1 = new SistemaXDbMovc(DbParameter.getDb());
    SistemaXDbMriga dbmriga = new SistemaXDbMriga(DbParameter.getDb());
    int id =Integer.parseInt(request.getParameter("id")); 
    String sql="delete from mrighe where id='"+id+"'";
    dbmriga.uquery(sql);
    String querydel="select movc.id from movc where (select count(id) from mrighe where idmovc=movc.id)=0;";
    ResultSet delmovc=dbmovc.query(querydel);
    while(delmovc.next()){
        //out.println(delmovc.getInt("id"));
        String querydel1="delete from movc where id='"+delmovc.getInt("id")+"';";
        dbmovc1.uquery(querydel1);
    }
%>
