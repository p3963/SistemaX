<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.util.DisLivello"%>
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

    int prec=0;
    int idx = Integer.parseInt(request.getParameter("in"));
    JSONArray a = (JSONArray) new JSONTokener(request.getParameter("aa")).nextValue();
    JSONArray b = (JSONArray) new JSONTokener(request.getParameter("bb")).nextValue();
    String inout=request.getParameter("io");
    int n,m,i,j=0;
    for (i=1; i<a.length(); i++){
        if (a.getInt(i)==idx){
            prec=a.getInt(i-1);
            break;
        }
    }
    n=i;
    for (i=1; i<b.length(); i++){
        if (b.getInt(i)==idx){
            prec=b.getInt(i-1);
            break;
        }
    }
    m=i;
    Conto current = PiCo.pc.getConto(idx);
    Conto p = PiCo.pc.getConto(prec);
    if (inout=="in"){
        String slp=p.getlevel();
        if(p.hasSon())
            ;
        else if(p.hasNext()){
            current.setLevel(slp+".1");
            p.setNid(0);
            p.setSid(current.getId());
        }    
        else
            ;
        PiCo.pc.update(p);
        PiCo.pc.update(current);
    }
    else if (inout=="out"){
        String slp=p.getlevel();
        int lp = Integer.parseInt(slp.substring(slp.lastIndexOf(".")+1));
        lp++;
        String lpp=slp.substring(0, slp.lastIndexOf("."))+"."+String.valueOf(lp);
        if(p.hasSon()){
            current.setLevel(slp.substring(0,slp.lastIndexOf(".")));
            p.setSid(0);
            p.setNid(current.getId());
        }
        else if(p.hasNext()){
            current.setLevel(lpp);
        }  
        else
            ;
        PiCo.pc.update(p);
        PiCo.pc.update(current);
    }
    else
        ;
    
    }
%>
