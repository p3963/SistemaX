<%-- 
    Document   : index
    Created on : 9-giu-2013, 16.58.23
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDb"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.pc.util.Livello"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.lang.Object"%>
<%@page import="gest.pc.util.Arr"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <p><a href="mostraconti.jsp">Elenco conti</a></p>
        <%
            FileReader f = new FileReader ("/home/p39/Documenti/pc.csv");
            Scanner in = new Scanner(f);
            String [] s = new String [99999];
            int [] sn = new int [99999];
            String [] t = new String [99999];
            int i=0;
            int id=0;
            SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
            Db db = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
            String z = in.nextLine();
            s[0]= z.substring(0,4);
            sn[0]=(int)Integer.parseInt(s[0]);
            t[0]= z.substring(5);
            t[0]= t[0].replace("'","");
            id=7;
            String sql="INSERT into public.pc (id,descr,fid,pid,nid,sid,rc,cat,level,mvmble,saldoa,saldod,pos) values ("+id+",'"+t[0]+"',0,0,0,0,0,0,0,true,0.00,0.00,3);";
            db.uquery(sql);//dbpc.insert(c);
            while(in.hasNextLine()){
                i=id;
                id++;
                z = in.nextLine();
                s[i]= z.substring(0,4);
                sn[i]=(int)Integer.parseInt(s[i]);
                t[i]= z.substring(5);
                t[i]= t[i].replace("'","");
                //Conto n = new Conto("gest");
                sql="INSERT into public.pc (id,descr,fid,pid,nid,sid,rc,cat,level,mvmble,saldoa,saldod,pos) values ("+id+",'"+t[i]+"',0,0,0,0,0,0,0,true,0.00,0.00,'"+i+"');";
                db.uquery(sql);
                sql="UPDATE public.pc set nid="+id+" where id="+i+";";
                db.uquery(sql);
                i++;
            }


        %>
    </body>
</html>
