<%-- 
    Document   : aggconto
    Created on : 18 ago 2025, 13:14:07
    Author     : piero.trentanove
--%>

<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="gest.db.Db"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String ins = request.getParameter("id");
    out.println(ins);
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
//        Db db = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
        SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
        String descr= request.getParameter("descr");
        int id =0;
        int idp =0;
        int start =0;
        id = Integer.parseInt(request.getParameter("id"));
        idp= Integer.parseInt(request.getParameter("idp"));
        start= Integer.parseInt(request.getParameter("start"));
        
    
        Conto result = new Conto(DbParameter.getDb());
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
        int idpc = dbpc.currvalid();
            
        
        
    out.print("idpc"+idpc+"<br>");
    out.print("id"+id+"<br>");
    out.print("idp"+idp+"<br>");
      
        
        Conto prima = new Conto(DbParameter.getDb());
        Conto current = new Conto(DbParameter.getDb());        
        
        prima = PiCo.pc.getConto(idp);
        
        current = PiCo.pc.getConto(idpc);
        current.setNid(0);
        current.setSid(prima.getsid());
        dbpc.update(current);
        
        String sqla="";
        if (start==6){
            sqla = "update pc set id = "+idpc+"+6 where id ="+idpc+";";
        }else if(start==50000){
            sqla = "update pc set id = "+idpc+"+50000 where id ="+idpc+";";
        }else if (start==100000){
            sqla = "update pc set id = "+idpc+"+100000 where id ="+idpc+";";
        }else if(start==150000){
            sqla = "update pc set id = "+idpc+"+150000 where id ="+idpc+";";
        }
        dbpc.uquery(sqla);
        
//        current = PiCo.pc.getConto(idpc);
        
        
    if (start==6){
//        if (prima.hasNext()){
//            prima.setNid(idpc+6);
//            prima.setSid(0);
//        }        
//        else{
            prima.setSid(idpc+6);
            prima.setNid(0);
//        }
    }else if (start==50000){
//        if (prima.hasNext()){
//            prima.setNid(idpc+50000);
//            prima.setSid(0);
//        }        
//        else{
            prima.setSid(idpc+50000);
            prima.setNid(0);
//        }
    
    }else if (start==100000){
//        if (prima.hasNext()){
//            prima.setNid(idpc+100000);
//            prima.setSid(0);
//        }        
//        else{
            prima.setSid(idpc+100000);
            prima.setNid(0);
//        }
    }else if (start==150000){
//        if (prima.hasNext()){
//            prima.setNid(idpc+150000);
//            prima.setSid(0);
//        }        
//        else{
            prima.setSid(idpc+150000);
            prima.setNid(0);
//        }
    }
    dbpc.update(prima);    
    }
        
%>
