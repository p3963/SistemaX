<%-- 
    Document   : cbbox1
    Created on : 13 ago 2025, 10:08:35
    Author     : piero.trentanove
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="css/cbbox1.css">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
        <script type="text/javascript" src="js/cbbox1.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
<h2>Regular - Input + Datalist</h2>
<form action="responsecb.jsp" method="post">
<label>Choose a browser from this list:
</label>
<%
out.println("<input type=\"text\" name=\"pc\" list=\"pc\" placeholder=\"Scegli il Conto...\" id=\"regular\" />");

out.println("<datalist id=\"pc\">");
    out.println("<option value=\"20\"/>Chrome</option>");
    out.println("<option value=\"21\"/>Firefox</option>");
  out.println("<option value=\"22\"/>3°browser</option>");
  out.println("<option value=\"23\"/>4°browser Opera</option>");
  out.println("<option value=\"24\"/>5°browser</option>");
  out.println("<option value=\"25\"/>6°browser</option>");
out.println("</datalist><span id=\"ext\"></span>");
out.println("<button name=\"submitbtn\" type=\"submit\">Invia</button>");
out.println("</form>");
        %>
<script>
    $(document).ready(function(){
        $("#regular").on("change",function(){
            if($('#pc > option:selected')){
                var k = $(this).val();
                $.ajax({
                    url: "ajcb.jsp",
                    dataType:"text",
                    type: "post",
                    data:{
                        index:k,
                    },
                    success: function(msg){
                        $('#ext').text(k+"-"+msg);
                    },
                    error:function(e){
                        alert("errore di comunicazione con il server"+e);
                    },
                });
            }//break;
            //});
        });
    });
</script>
<!--<h2>Workaround - ContentEditable + Datalist</h2>

<label>Choose a browser from this list:
<span contenteditable list="pc" name="myBrowser">edit me</span></label>-->
    </body>
</html>
