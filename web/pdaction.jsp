<%-- 
    Document   : xregform
    Created on : 31 lug 2025, 15:31:09
    Author     : piero.trentanove
--%>


<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Locale"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="include.PasswordGenerator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="invioemail.EmailSender"%>
<%@page import="gest.db.SistemaXDbUser"%>
<%@page import="gest.pc.util.User.*"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String username=request.getParameter("pduser");
    String password=request.getParameter("password");
    String nome = request.getParameter("nome");
    String cognome = request.getParameter("cognome");
    String data = request.getParameter("pdddn");
    String sessionid = "sessionId";


    User user = new User();


    String sql = "select username, nome, cognome, ddn from utenti where username ='"+username+"';";
    //out.println("<br>"+sql);
    SistemaXDb sxdb = new SistemaXDb(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
    ResultSet rs = sxdb.query(sql);
    
    if (!rs.next()){
    %>
    <script>
        alert("Utente non presente!");
        location.href="pdform.jsp";
    </script>
    <%    
    }else//==request.getParameter("ddn")
    if(!(rs.getDate("ddn").toString().compareTo(data)==0)){
    %>
    <script>
        alert("Data di nascita non valida!");
        location.href="pdform.jsp";
    </script>
    <%
    }else{
        ArrayList<String> filenames = new ArrayList<String>();
        String newpass = PasswordGenerator.Password();
        String contenuto= "Il tuo username è: '"+username+"'.<br>";
        contenuto+="La tua password è: '"+newpass+"'.";//"piero-39@libero.it"
        EmailSender es = new EmailSender("piero-39@libero.it",username,"","piero-39@libero.it","New password SistemaX",contenuto,filenames);
        es.inviaEmail();
        String sha1pass=User.sha1(newpass);
        sql="update utenti set password = '"+sha1pass+"' where username ='"+username+"';";
        SistemaXDbUser sxdbu = new SistemaXDbUser(DbParameter.getDb());
        int i = sxdbu.uquery(sql);
        response.sendRedirect("menu.jsp");        
    }    
%>