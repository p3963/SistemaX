<%-- 
    Document   : modconto
    Created on : 7 nov 2021, 16:19:30
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
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
            $("#conto").keyup(function(e) {
                if (e.keyCode == 27) { //Escape button
                    $.fancybox.close();
                }
            });
            $("#mvmble").click(function(event){
                //event.preventDefault();
                $('#mvmble').change(function () {
                if ($(this).prop("checked")) {
                   // alert("1");
                    $("#mvmble").attr("checked","checked");
                    
                    return;
                }
                //alert("2");
                $("#mvmble").removeAttr("checked");
                
            });

//                if($("#mvmble").is(":checked")){
//                    alert("1");
//                    $("#mvmble").removeAttr("checked");
//                }else{
//                    alert("2");
//                    $("#mvmble").attr("checked","checked");
//                }
//                if(document.getElementById("mvmble").checked==true){
//                    document.getElementById("mvmble").checked=false;
//                    document.getElementById('mvmble').removeAttribute('checked');
//                }
//                else{
//                    document.getElementById("mvmble").checked=true;
//                    document.getElementById('mvmble').setAttribute('checked', 'checked');
//                }
            });
        });
        function movble(x){
        }
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
    Conto c = new Conto(DbParameter.getDb());
    c = PiCo.pc.getConto(id);
    out.println("<ID n. "+c.getId()+"<br>");
    out.println("<button id=\"close\" onclick=\"parent.$.fancybox.close();\">Close</button>");
    out.println("<div id=\"conto\">");
    out.println("<form method=\"post\" action=\"updateconto.jsp?id="+c.getId()+"\">");
    out.println("<label>posizione</label><br><input disabled class=\"in\" name=\"pos\" type=\"text\" size=\"100\" value='"+ c.getPos()+"'><br>");
    out.println("<label>id figlio</label><br><input disabled class=\"in\" name=\"sid\" type=\"text\" size=\"100\" value='"+ c.getsid()+"'><br>");
    out.println("<label>id successivo</label><br><input disabled class=\"in\" name=\"nid\" type=\"text\" size=\"100\" value='"+ c.getnid()+"'><br>");
    out.println("<label>descrizione</label><br><input class=\"in\" name=\"descr\" type=\"text\" size=\"100\" value='"+ c.getdescr()+"'><br>");
//    out.println("<input type=\"hidden\ ">");
    out.println("<label>livello</label><br><input disabled class=\"in\" name=\"livello\" type=\"text\" size=\"100\" value='"+ c.getlevel()+"'><br>");
    out.println("<label>saldo dare</label><br><input disabled class=\"in\" name=\"saldod\" type=\"text\" size=\"100\" value='"+ c.getSaldod()+"'><br>");
    out.println("<label>saldo avere</label><br><input disabled class=\"in\" name=\"saldoa\" type=\"text\" size=\"100\" value='"+ c.getSaldoa()+"'><br>");
    String z = "";
    String y = "";
    if(c.getMvmble())
        z = " checked=\"checked\"";
    else
        y = " checked=\"checked\"";
    out.println("<label>movimentabile</label><input  class=\"in\" name=\"mvmble\" id=\"mvmble\"  value=\"vero\" type=\"radio\" "+z+" ><br>");//value='"+ c.getMvmble()+"';
    out.println("<label>non movimentabile</label><input  class=\"in\" name=\"mvmble\" id=\"mvmble1\"  value=\"falso\" type=\"radio\" "+y+" ><br>");//value='"+ c.getMvmble()+"';
    out.println("<br><button id=\"salva\" onclick=\"parent.$.fancybox.close();\" class=\"fancybox-close\" type=\"submit\" style=\"margin:auto;text-align:center; color:white; background-color:blue;\">Salva</button>");
    out.println("</form>");
    out.println("<div>");
    }
%>
    </body>
</html>