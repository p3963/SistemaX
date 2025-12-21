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


    JSONArray a = new JSONArray();
        a = (JSONArray) new JSONTokener(request.getParameter("a")).nextValue();
    

        int j=Integer.parseInt(request.getParameter("j"));            
        
        Conto prec = new Conto (DbParameter.getDb());
        
        Conto current = new Conto (DbParameter.getDb());
        
        int i=0;
                
        for(i=1; i<a.length()-1; i++){
        
            current = PiCo.pc.getConto(i);
            
            prec = PiCo.pc.getConto(i-1);
            
            if (i==1)
            
                current.setLevel("1");
                
            else if (i==2)
            
                current.setLevel("2");
                
            else 
                current.setLevel(String.valueOf(i));
                
            current.setPos(i+j-1);
            PiCo.pc.update(current);                 
        }
        out.println(i);
    }
%>
