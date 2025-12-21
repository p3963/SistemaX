<%-- 
    Document   : xregform
    Created on : 31 lug 2025, 15:31:09
    Author     : piero.trentanove
--%>


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

    String username=request.getParameter("user");
    String password=request.getParameter("password");
    String nome = request.getParameter("nome");
    String cognome = request.getParameter("cognome");
    String data = request.getParameter("regddn");
    String sessionid = "sessionId";


    User user = new User();


    String sql = "select username from utenti where username ='"+username+"';";
    SistemaXDb sxdb = new SistemaXDb(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
    ResultSet rs = sxdb.query(sql);
    if (rs.next()){
    %>
    <script>
        alert("Utetne già presente!");
        location.href="registrazione.jsp";
    </script>
    <%    
    }else{
        String sql1 = "INSERT into utenti (username,password,nome,cognome,amm,sessionid,ddn) values"+
        " ('"+username+"', '"+User.sha1(password)+"', '"+nome+"', '"+cognome+"'"+
        ", "+false+""+
        ", '"+sessionid+"'"+
        ",'"+data+"');";
        out.println("<br>"+sql1); 
        SistemaXDbUser sxdbu = new SistemaXDbUser(DbParameter.getDb());
        int i = sxdbu.uquery(sql1);
        if(username.compareTo("")!=0&&password.compareTo("")!=0){
//            if(user.setUser(username)&&user.getUsername().compareTo(username)==0&&user.getPassword().compareTo(User.sha1(password))==0){
                HttpSession s = request.getSession(true);
                s.setAttribute("username", username);
                s.setMaxInactiveInterval(-1);
                user.updateSessionIdUser(username, s.getId());
//                response.sendRedirect("menu.jsp");
//            }
//            else
//                response.sendRedirect("index.jsp");
        }
        ArrayList<String> filenames = new ArrayList<String>();

        String contenuto= "Il tuo username è: '"+username+"'.<br>";
        contenuto+="La tua password è: '"+password+"'.";//"piero-39@libero.it"
        EmailSender es = new EmailSender("piero-39@libero.it",username,"","piero-39@libero.it","Benvenuto su SistemaX",contenuto,filenames);
        es.inviaEmail();
        response.sendRedirect("index.jsp");
        
    }    
%>