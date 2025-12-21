<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigInteger"%>
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

        JSONArray x = new JSONArray();
        x = (JSONArray) new JSONTokener(request.getParameter("ab")).nextValue();
        Conto current = new Conto (DbParameter.getDb());
        Conto prec = new Conto (DbParameter.getDb());
        int i=0;
        String pos="[";
        String id="[";
                        
        for(i=1; i<x.length(); i++){
           
            current = PiCo.pc.getConto(i);
            prec = PiCo.pc.getConto(i-1);
            if(current.getId()==1||current.getId()==2||current.getId()==99999999||current.getId()==999999999){
                //i--;
                continue;
            }
            if (prec.hasNext())
                current.setLevel(String.valueOf(i));
            else if(prec.hasSon()){
                String sl=prec.getlevel();
                sl+=".1";
                current.setLevel(sl);
            }
            current.setPos(i);
            PiCo.pc.update(current);
            pos+=String.valueOf(i);
            pos+=",";
        }
        pos=pos.substring(0, pos.length()-1);
        pos+="]'";
        id=id.substring(0, id.length()-1);
        id+="]";
        out.print(id);
    }
%>
