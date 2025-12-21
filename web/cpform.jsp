<%@page import="include.Menu"%>
<%@page import="gest.pc.util.User"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/password1.css" rel="stylesheet">
<script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
<script type="text/javascript" src="js/pass1.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<link rel="stylesheet" type="text/css" href="css/recaptcha.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
  <script>
  		var onloadCallback = function() {
		    grecaptcha.render('cp_html_element', {
				'sitekey' : '6Ld-6U4UAAAAAJSz-_9bQDIYlDegUEoXegeqQGsL',
				            'badge': 'inline',
            

			});

			//alert("grecaptcha is ready!");
		};
		$(document).ready(function(){
			$("#regformx").on("submit",function(e){
			});
		});

	//$(document).ready(function(){
 		// $("#cha1x").val(Math.round(Math.random() * (99 - 1) + 1));
		// $("#cha2x").val(Math.round(Math.random() * (99 - 1) + 1));
		// $("#cha3x").val(Math.round(Math.random() * (99 - 1) + 1));
		// $("#cpform").on("submit",function(event){
			// if(parseInt($("#cha1x").val())
				// +parseInt($("#cha2x").val())
				// +parseInt($("#cha3x").val())
				// !=parseInt($("#chatx").val())
			// ){
				// event.preventDefault();
				// alert("Captcha sbagliato");
			// }
			// location.href="index.php";
		// });

	//});
</script>
<script>
	$(document).ready(function(){
		$("#regformx").on("submit",function(event){
			var s="";
				// if($("#oldpass").val()==""){
					// s+="Campo password corrente vuoto\n";
				// }
 				if(!validator1()){
					s+="Password non valida!\n";
				}
				// if($("#newpass").val()==""){
					// s+="Campo password vuoto\n";
				// }
				// if($("#regrepassx").val()==""){
					// s+="Campo ripeti password vuoto!\n";
				// }
 				if($("#newpass").val()!=$("#regrepassx").val()){
					s+="Le password non corrispondono!\n";
				}
				if (grecaptcha.getResponse() == ""){
					s+="Valida il captcha!\n";
				}
				if(s!=""){
					event.preventDefault();
					alert(s);
				}
				// if($("#chatx").val()==""||!$.isNumeric($("#chatx").val())){
					// alert("Captcha non valido!");
					// event.preventDefault();
				// }
		});
	});
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
        out.println(Menu.getMenu());
        out.println("<br><br>");
        out.println("<div style=\"text-align:center;margin:auto\">");
//		<form id="regform" action="#" method="post">
	out.println("<form id=\"regformx\" action=\"xcppassx.jsp\" method=\"post\">"); 
        out.println("<input type=\"hidden\" value=\""+username+"\" name=\"username\">");
        out.println("<p>password corrente</p>");
        out.println("<input required id=\"oldpass\" type=\"password\" name=\"oldpass\" size=\"20\"><br><br>");
        out.println("<p>nuova password</p>");
	out.println("<input required type=\"password\" name=\"password\" id=\"newpass\" onkeyup=\"validator1()\" placeholder=\"Insert password\"  autocomplete=\"off\" value=\"\" size=\"20\">");
	out.println("<div id=\"ProgressBarx\">");
	out.println(			"<div id=\"barx\">");
	out.println(			"</div>");
	out.println(			"<p id=\"alertx\">");
	out.println(			"</p>");
	out.println(		"</div>"); 
        out.println("<p>ripeti password</p>");
        out.println("<input required id=\"regrepassx\" type=\"password\" name=\"renewpass\" size=\"20\"><br><br>");
        out.println("<div class=\"xrecaptcha\">");
	out.println("<div id=\"cp_html_element\" ></div>");
	out.println("</div>");
        out.println("<input id=\"reginviax\" type=\"submit\" value=\"Invia\">");
        out.println("</form>");
    %>
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer>
		</script>
    <%
        out.println("<br><br><a id=\"regchiudi\" href=\"menu.jsp\">Chiudi</a><br>");
	out.println("<p>Ti arriver‡† una email con le tue credenziali<br>Controlla la posta indesiderata</p>");

        out.println("</div>");
    }  
%>
<!--<?php
	session_start();
	if (!isset($_SESSION["user"])){
		header("Location:index.php");
	}
	else{
	echo '<div style="margin: auto; text-align: left;">';
	echo '<a href="index.php">Home</a>';
	echo '</div>';
    echo '<div id="reg" style="margin: auto; text-align: center;">';    
	echo $_SESSION["user"];

	?>
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer>
		</script>
	<?php
    echo        '<a id="regchiudi" href="index.php">Chiudi</a><br>';
	echo        '<p>Ti arriver√† una email con le tue credenziali<br>Controlla la posta indesiderata</p>';
	echo '</div>';
	}
?>-->
</body>
</html>
	
