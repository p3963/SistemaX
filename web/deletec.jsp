<%-- 
    Document   : deletec
    Created on : 13 dic 2021, 16:53:34
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

            int i = Integer.parseInt(request.getParameter("id"));
            JSONArray ab = (JSONArray) new JSONTokener(request.getParameter("ab")).nextValue();
            JSONArray a = (JSONArray) new JSONTokener(request.getParameter("a")).nextValue();
            JSONArray b = (JSONArray) new JSONTokener(request.getParameter("b")).nextValue();
            JSONArray c = (JSONArray) new JSONTokener(request.getParameter("c")).nextValue();
            JSONArray d = (JSONArray) new JSONTokener(request.getParameter("d")).nextValue();
            Conto conto = new Conto (DbParameter.getDb());
            Conto prec = new Conto(DbParameter.getDb());
            Conto succ = new Conto(DbParameter.getDb());
            conto=PiCo.pc.getConto(i);
            int k;
            for (k=1;k<ab.length();k++){
                if (i==ab.getInt(k)){
                    prec = PiCo.pc.getConto(ab.getInt(k-1));
                }
            }
            int idn=conto.getnid();
            int ids=conto.getsid();
            if (prec.getId()==1||prec.getId()==50000||prec.getId()==100000||prec.getId()==150000){
                if (ids>=idn){
                    prec.setSid(ids);
                    prec.setNid(0);
                }else{
                    prec.setSid(idn);
                    prec.setNid(0);
                }
            }
            else{
                prec.setSid(conto.getsid());
                prec.setNid(conto.getnid());
            }
//    for (k=0;k<ab.length();k++){
//        if (99999999==ab.getInt(k)){
//            succ = PiCo.pc.getConto(99999999);
//           
//        }
//        else if (999999999==ab.getInt(k)){
//            succ = PiCo.pc.getConto(999999999);
//        }
//        else
//            succ=PiCo.pc.getConto(ab.getInt(k+1));
//    }
//    
//    
//        if (prec.hasSon()){
//            prec.setSid(c.getsid());
//            prec.setNid(0);
//        }
//        else if(prec.hasNext()){
//            prec.setSid(0);
//            prec.setNid(c.getnid());
//        }
//        else
//        if (succ.getId()==99999999){
//            prec.setSid(99999999);
//            prec.setNid(0);
//        }else if (succ.getId()==999999999){
//            prec.setSid(999999999);
//            prec.setNid(0);
//        }
//        else 
//        if(prec.getId()==1){
//            prec.setSid(c.getsid());
//            prec.setNid(0);
//        }else if(prec.getId()==2){
//            prec.setSid(c.getsid());
//            prec.setNid(0);
//        }
//    
//    
            PiCo.pc.update(prec);
            PiCo.pc.dquery(conto);
//    out.println(prec.getId()+ab.toString());
    }
    
%>