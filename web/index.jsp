<%-- 
    Document   : index
    Created on : 9-giu-2013, 16.58.23
    Author     : p39
--%>

<%@page import="gest.pc.util.User"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="gest.db.SistemaXDbUser"%>
<%@page import="gest.pc.util.Utenti"%>
<%@page import="gest.db.DbMaria"%>
<%@page import="java.util.Enumeration"%>
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
<link rel="stylesheet" type="text/css" href="css/p39.css">

<%
//            FileWriter f = new FileWriter("/home/p39/Documenti/login.txt", false);
//            //HttpSession sl=request.getSession();
//            HttpSession sl = request.getSession();
//            sl.setAttribute("username", request.getParameter("username"));
//            String username = (String)sl.getAttribute("username");
//            if (username.compareTo("")==0){
////            else{
////                User userl = new User();
////                String sll = sl.getId();  
////                String ssl = userl.getSessionId(username);
////                f.write(sll+"\n"+ssl+"\n");
////                f.flush();
//            
//            
//            //String username=(String)sl.getAttribute("username");
////            f.write(username);
////            f.flush();
////           if(sll.compareTo(ssl)==0)
//                response.sendRedirect("menu.jsp");
//                }else{
//            username="";
//            if (username.compareTo("")==0){
                String username="";
                String password="";
                Enumeration paramNames=request.getParameterNames();
                while(paramNames.hasMoreElements()) {
                    String paramName = (String)paramNames.nextElement();
                    if(paramName.compareTo("username")==0)
                        username=request.getParameter("username");
                    if(paramName.compareTo("password")==0)
                        password=request.getParameter("password");
                }
                if(username.compareTo("")!=0&&password.compareTo("")!=0){
                    User user = new User();
                    if(user.setUser(username)&&user.getUsername().compareTo(username)==0&&user.getPassword().compareTo(User.sha1(password))==0){
                        HttpSession s = request.getSession(true);
                        s.setAttribute("username", username);
                        s.setMaxInactiveInterval(-1);
                        user.updateSessionIdUser(username, s.getId());
                        response.sendRedirect("menu.jsp");
                    }
                    else
                        response.sendRedirect("index.jsp");
                }
                else{
                out.println("<div class=\"autocenter\" >");
                    out.println("<form method=\"post\" action=\"index.jsp\">");
                    out.println("Username&nbsp;<input name=\"username\" type=\"text\" size=20 value=\"\"><br>");
                    out.println("Password&nbsp;<input name=\"password\" type=\"password\" size=20 value=\"\"><br>");
                    out.println("<input type=\"submit\" value=\"Login\">");
                    out.println("</form>");
                    out.println("<br><br><a href=\"pdform.jsp\">Password dimenticata?</a>");
                    out.println("<br><br><a href=\"registrazione.jsp\">Registrati!</a>");
                out.println("</div>");
                }
            
        %>
