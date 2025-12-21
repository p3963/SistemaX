<!DOCTYPE html>
<html>
<head>
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
			if(!emailIsValid($("#pduser").val())){
				s+="L'indirizzo email non è valido!\n";
			}
			if (grecaptcha.getResponse() == ""){
				s+="Valida il captcha!\n";
			}
			if(s!=""){
				event.preventDefault();
				alert(s);
			}
			// if($("#chaty").val()==""||!$.isNumeric($("#chaty").val())){
				// alert("Captcha non valido!");
				// event.preventDefault();
			// }else
			// if(parseInt($("#cha1y").val())
				// +parseInt($("#cha2y").val())
				// +parseInt($("#cha3y").val())
				// !=parseInt($("#chaty").val())
			// ){
				// event.preventDefault();
				// alert("Captcha sbagliato");
			// }
			
			//location.href="index.php";
		});
	});
</script>
</head>
<body>
	<div style="margin: auto; text-align: left;">
	<a href="index.jsp">Home</a>
	</div>
<div style="margin: auto; text-align: center;">
<form id="pdform" action="pdaction.jsp" method="post">
	<p>e-mail di registrazione</p>
	<input required id="pduser" type="text" value="" size="20" name="pduser"><br><br>
    <p>data di nascita</p>
    <input required id="pdddn" type="date" name="pdddn" size="20" value=""><br><br><!--//<?php echo(date('Y-m-d'));?>-->
<!--	<input disabled value="" size="5" id="cha1y">
	<input disabled value="" size="5" id="cha2y">
	<input disabled value="" size="5" id="cha3y"><br>
	Inserire la somma dei tre campi <input id="chaty" value="" size="5"><br><br>-->
	<div class="xrecaptcha">
		<div id="pd_html_element" ></div>
	</div>
	<input type="submit" id="pdsubmit" value="invia"> <a href="index.jsp">Chiudi</a>
</form>
 <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer>
</script>
	<p>Ti arriverà  una email con le tue credenziali<br>Controlla la posta indesiderata</p>
</div>
</body>
<html>