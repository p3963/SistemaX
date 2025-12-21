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
<script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
<%



    User user = new User();
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    gest.pc.util.User usera = new gest.pc.util.User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
        out.println("<div id=\"uname\" style=\"display:none\">"+username+"</div> ");
        %>
            <script>
                if(!confirm("Vuoi cancellare l'utente "+$("#uname").text()+"?")){
                    location.href="menu.jsp";            
                }
            </script>
        <%    
        String data = request.getParameter("pdddn");
        out.println(data);

        String sql = "select username, ddn from utenti where username ='"+username+"';";
        
        SistemaXDb sxdb = new SistemaXDb(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
        ResultSet rs = sxdb.query(sql);
        if (!rs.next()){
        %>
            <script>
                alert("L'utenza non esiste!");
                location.href="delute.jsp";
            </script>
        <%
        
    }else
        if(!(rs.getDate("ddn").toString().compareTo(data)==0)){
        %>
            <script>
                alert("Data di nascita non valida!");
                location.href="delute.jsp";
            </script>
        <%
    }

    else{

        String sql1 = "delete from utenti where username ='"+username+"';";
        SistemaXDbUser sxdbu = new SistemaXDbUser(DbParameter.getDb());
        int i = sxdbu.uquery(sql1);
        %>
        <script>
            alert("Utente "+$("#uname").text()+" cancellato!");
        </script>
        <%
        ArrayList<String> filenames = new ArrayList<String>();

        String contenuto= "Il tuo username '"+username+"' è stato eliminato.<br>";
//        contenuto+="La tua password è: '"+password+"'.";//"piero-39@libero.it"
        EmailSender es = new EmailSender("piero-39@libero.it",username,"","piero-39@libero.it","Salve, ti sei appena cancellato da SistemaX...",contenuto,filenames);
        es.inviaEmail();
        response.sendRedirect("index.jsp");
        
    } 
}
%>