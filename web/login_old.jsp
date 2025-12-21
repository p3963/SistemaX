<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.Utenti"%>
<%@page import="gest.db.SistemaXDbUser"%>
<%@page import="gest.db.Db"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.DbMaria"%>
<%@page import="java.lang.Object" %>
<!DOCTYPE html>
<%
            
            SistemaXDbUser utedb = new SistemaXDbUser(DbParameter.getDb());
            Utenti utente = new Utenti(DbParameter.getDb());
            //DbMaria db = new DbMaria("arturo","p39","p39");
            Boolean login=false;
            String user=request.getParameter("username");
            String pass=request.getParameter("password");
            String query = "SELECT username, password from public.utenti where username='"+user+"'";
            ResultSet rs =utedb.query(query);
            while (rs.next()){       
                if (rs.getString("password")==org.apache.commons.codec.digest.DigestUtils.sha1Hex(pass)){
                    login=true;
                    request.getSession().setAttribute("usermame","password");
                    try {
                        String uquery ="UPDATE public.utenti set sessionid='"+request.getSession().getId()+"' where username='"+user+"'";
                        utedb.query(uquery);
                    } catch (Exception e) {
                    }
                }
            }
%>
<html>
<head>

<%        if(login){ %>
            <script>
            location.href("index.jsp");
            </script>
<%        }
        else{ %>
            <script>
            location.href("login.jsp");
            </script>
<%        } %>
</head>
</html>


