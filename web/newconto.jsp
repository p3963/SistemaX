<%-- 
    Document   : newconto
    Created on : 11 dic 2021, 13:20:04
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.*"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.pc.util.Wtd"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
        Db db = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
        SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
        String descr= request.getParameter("descr");
        int id =0;
        id = Integer.parseInt(request.getParameter("id"));
    
        Conto result = new Conto(DbParameter.getDb());
        Conto prec = new Conto(DbParameter.getDb());
        
        //result.setId(idnuovo);
        result.setDescr(descr);
        result.setCat(0);
//        result.setDescr(descr);
        result.setFid(0);
        result.setLevel("0");
        result.setMvmble(true);
    
        result.setSid(0);
        result.setNid(0);
        result.setPid(0);
        result.setPos(0);
        result.setRc(0);
        result.setSaldoa("0.00");
        result.setSaldod("0.00");
        //(descr, cat, fid, sid, nid, pid, level, mvmble, pos, rc, saldoa, saldod)
        //String sql = "insert into pc values ("+descr+", 0, 0,0,0,0,\"0\",true,0,0,\"0.00\",\"0.00\");";
    
        //db.xquery(sql);
        dbpc.qinsert(result);
        
        int idnuovo=dbpc.currvalid();
                
        Conto penultimo = new Conto(DbParameter.getDb());
//        Conto penultimo1 = new Conto(DbParameter.getDb());
//        Conto penultimo2 = new Conto(DbParameter.getDb());
//        Conto penultimo3 = new Conto(DbParameter.getDb());
//        Conto penultimo4 = new Conto(DbParameter.getDb());
        if (id==6){
            String sql1 = "select id,sid,nid from pc where sid='49999'" +// or nid = '49999' "+
                            ";";
            ResultSet rs =dbpc.query(sql1);
            rs.next();
            penultimo=PiCo.pc.getConto(rs.getInt("id"));
            //if (rs.getInt("sid")==49999){
                penultimo.setSid(idnuovo+6);
                penultimo.setNid(0);
            //}
            /*else{
                penultimo1.setNid(idnuovo+6);
                penultimo1.setSid(0);
            }*/
        }else if (id==50000){
            String sql2 = "select id,sid,nid from pc where sid='99999'"+
                             ";";// or nid = '99999';";
            ResultSet rs =dbpc.query(sql2);
            rs.next();
            penultimo=PiCo.pc.getConto(rs.getInt("id"));
            //if (rs.getInt("sid")==99999){
                penultimo.setSid(idnuovo+50000);
                penultimo.setNid(0);
            //}
            /*else{
                penultimo2.setNid(idnuovo+50000);
                penultimo2.setSid(0);
            }*/
        }else if (id==100000){
            String sql3 = "select id,sid,nid from pc where sid='149999'"+// or nid = '149999';";
                             ";";
            ResultSet rs =dbpc.query(sql3);
            rs.next();
            penultimo=PiCo.pc.getConto(rs.getInt("id"));
            //if (rs.getInt("sid")==149999){
                penultimo.setSid(idnuovo+100000);
                penultimo.setNid(0);
            //}
            /*else{
                penultimo3.setNid(idnuovo+100000);
                penultimo3.setSid(0);
            }*/
        }else if (id==150000){
            String sql4 = "select id,sid,nid from pc where sid='199999'"+// or nid = '199999';";
                             ";";
            ResultSet rs =dbpc.query(sql4);
            rs.next();
            penultimo=PiCo.pc.getConto(rs.getInt("id"));
            //if (rs.getInt("sid")==149999){
                penultimo.setSid(idnuovo+150000);
                penultimo.setNid(0);
            //}
            /*else{
                penultimo4.setNid(idnuovo+150000);
                penultimo4.setSid(0);
            }*/
        }
        dbpc.update(penultimo);
        
        Conto dopo = new Conto(DbParameter.getDb());
        
        
        dopo=PiCo.pc.getConto(idnuovo);
        if (id==6){
            dopo.setSid(49999);
            dopo.setNid(0);
        }else if(id==50000){
            dopo.setSid(99999);
            dopo.setNid(0);
        }else if (id==100000){
            dopo.setSid(149999);
            dopo.setNid(0);
        }else if(id==150000){
            dopo.setSid(199999);
            dopo.setNid(0);
        }
        
        dbpc.update(dopo);
        
        String sqla="";
        if (id==6){
            sqla = "update pc set id = "+idnuovo+"+6 where id ="+idnuovo+";";
        }else if(id==50000){
            sqla = "update pc set id = "+idnuovo+"+50000 where id ="+idnuovo+";";
        }else if (id==100000){
            sqla = "update pc set id = "+idnuovo+"+100000 where id ="+idnuovo+";";
        }else if(id==150000){
            sqla = "update pc set id = "+idnuovo+"+150000 where id ="+idnuovo+";";
        }
        dbpc.uquery(sqla);

    }
%>
