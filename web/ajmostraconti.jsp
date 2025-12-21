<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="java.util.ArrayList"%>
<%
    
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

    String serial= new String();
    serial = request.getParameter("serial");
    ArrayList s = new ArrayList();    
    String num = new String();
    num=serial;
    serial="";
    while(num.indexOf("row") >= 0){
        num=num.substring(num.indexOf("row")+3);
        String ord = new String();
        if(num.indexOf("&") < 0)
            ord=num;
        else
            ord=num.substring(0,num.indexOf("&"));
        s.add(ord); 
        num=num.substring(num.indexOf("&")+1);
    }
    out.print(s.toString());
    }
%>
