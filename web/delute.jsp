<%@page import="gest.pc.util.User"%>
<%@page import="include.Menu"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">    
<script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<link rel="stylesheet" type="text/css" href="css/recaptcha.css">
  <script>
		var onloadCallback = function() {
		    grecaptcha.render('pd_html_element', {
				'sitekey' : '6Ld-6U4UAAAAAJSz-_9bQDIYlDegUEoXegeqQGsL',
				            'badge': 'inline',
            

			});

			//alert("grecaptcha is ready!");
		};
		$(document).ready(function(){
			$("#pdform").on("submit",function(e){
			});
		});
</script>
  <script>
function emailIsValid(email) {
  var regex_email_valida = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return regex_email_valida.test(email);
}
  
	$(document).ready(function(){
		// $("#cha1y").val(Math.round(Math.random() * (99 - 1) + 1));
		// $("#cha2y").val(Math.round(Math.random() * (99 - 1) + 1));
		// $("#cha3y").val(Math.round(Math.random() * (99 - 1) + 1));
		$("#pdform").on("submit",function(event){
			var s="";
//			if(!emailIsValid($("#pduser").val())){
//				s+="L'indirizzo email dell'utente non è valido!\n";
//			}
			if (grecaptcha.getResponse() == ""){
				s+="Valida il captcha!\n";
			}
			if(s!=""){
				event.preventDefault();
				alert(s);
			}
		});
	});
</script>
</head>
<body>
<%
    User user = new User();
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    gest.pc.util.User usera = new gest.pc.util.User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
    
%>
	<div style="margin: auto; text-align: left;">
            <%
                out.println(Menu.getMenu());
                out.println("<br><br>");
                out.println("<p class=\"autocenter\"><b>Cancellazione utenza "+username+"...</b></p>");
            %>
<!--	<a href="index.jsp">Home</a>-->
	</div>
<div style="margin: auto; text-align: center;">
<form id="pdform" action="du.jsp" method="post">
	<!--<p>e-mail di registrazione</p>
	<input required id="pduser" type="text" value="" size="20" name="pduser"><br><br>-->
    <p>data di nascita</p>
    <input required id="pdddn" type="date" name="pdddn" size="20" value=""><br><br><!--//<?php echo(date('Y-m-d'));?>-->
	<div class="xrecaptcha">
		<div id="pd_html_element" ></div>
	</div>
	<input type="submit" id="pdsubmit" value="invia"> <a href="menu.jsp">Chiudi</a>
</form>
 <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer>
</script>
	<p>Ti arriverà una email di conferma cancellazione.<br>Controlla la posta indesiderata</p>
</div>
</body>
<%
    }
%>
<html>