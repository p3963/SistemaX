<%-- 
    Document   : modconto
    Created on : 7 nov 2021, 16:19:30
    Author     : p39
--%>

<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
    <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
    <script type="text/javascript" src="js/jQuery.fancybox.js"></script>
<!--    <script type="text/javascript" src="js/tinymce.js"></script>-->
    <script type="text/javascript">
        $(function(){
            $("#contoi").keyup(function(e) {
                if (e.keyCode == 27) { //Escape button
                    $.fancybox.close();
                }
            });
        });
//        function newconto(i){
//            $.ajax({
//                url: "newconto.jsp",
//                dataType:"text",
//                type:"post",
//                data:{
//                    id:i,
//                    descr:"nuovo conto",
//                },
//                success:function (msg){
//                    alert (msg);
//                },
//                error:function(){
//                    alert ("errore newconto");
//                }
//            });
//        }
    </script>

    </head>
    <body>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

    int id = Integer.parseInt(request.getParameter("id"));
//    int idp = Integer.parseInt(request.getParameter("idp"));
//    out.println(id);
//    out.println("<br>");
//    out.println(idp);
//    Conto c = new Conto("gest");
//    c = PiCo.pc.getConto(id);
//    out.println("<ID n. "+c.getId()+"<br>");
//
    out.println("<button id=\"close\" onclick=\"parent.$.fancybox.close();\">Close</button>");//
    out.println("<div id=\"contoi\">");
    out.println("<form method=\"post\" action=\"newconto.jsp?id="+id+"\">");
//    out.println("<label>posizione</label><br><input class=\"in\" disable:disable name=\"pos\" type=\"text\" size=\"100\" value='0'><br>");
//    out.println("<label>id figlio</label><br><input class=\"in\" hidden name=\"sid\" type=\"text\" size=\"100\" value='0'><br>");
//    out.println("<label>id successivo</label><br><input class=\"in\" disable name=\"nid\" type=\"text\" size=\"100\" value='0'><br>");
    out.println("<label>descrizione</label><br><input class=\"in\" disable name=\"descr\" type=\"text\" size=\"100\" value='___'><br>");
//    out.println("<label>livello</label><br><input class=\"in\" disable name=\"livello\" type=\"text\" size=\"100\" value='---'><br>");
//    out.println("<label>saldo dare</label><br><input class=\"in\" disable name=\"saldod\" type=\"text\" size=\"100\" value='0.00'><br>");
//    out.println("<label>saldo avere</label><br><input class=\"in\" disable name=\"saldoa\" type=\"text\" size=\"100\" value='0.00'><br>");
    out.println("<br><button id=\"salva\" onclick=\"parent.$.fancybox.close();\" class=\"fancybox-close\" type=\"submit\" style=\"margin:auto;text-align:center; color:white; background-color:blue;\">Salva</button>");
    //out.println("</form>");//onclose=\"location.href='mostraconti.jsp'\"
    out.println("<div>");//
    }
%>
    </body>
</html>