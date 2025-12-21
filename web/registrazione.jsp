<%@page import="gest.db.DbParameter"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/password.css" rel="stylesheet">
<script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
<script type="text/javascript" src="js/pass.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<link rel="stylesheet" type="text/css" href="css/recaptcha.css">
<link rel="stylesheet" type="text/css" href="css/p39.css">
  <script>
		var onloadCallback = function() {
		    grecaptcha.render('re_html_element', {
				'sitekey' : '6Ld-6U4UAAAAAJSz-_9bQDIYlDegUEoXegeqQGsL',
				            'badge': 'inline',
            

			});

			//alert("grecaptcha is ready!");
		};
		$(document).ready(function(){
			$("#regform").on("submit",function(e){
			});
		});
</script>
<!-- <script>
   'use strict';

const isValidPwd = pwd => {
    return (pwd.length >= 12 && /[A-Za-z]+/.test(pwd) && /[0-9]+/.test(pwd) && /[^a-z0-9]+/i.test(pwd));
};
 </script> -->
<script>
function emailIsValid(email) {
  var regex_email_valida = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return regex_email_valida.test(email);
}
function validaEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
</script>
<!-- <input type="email" id="emailInput" onchange="validaInput()">-->

<script>
    function chiudi(e){
        e.preventDefault()
        location.href="index.jsp";
    }
</script>
</head>
<body>
	<div>
	<a href="index.jsp">Home</a>
	</div>
    <div id="reg" class="autocenter">    
<!--		<form id="regform" action="#" method="post">-->
		<form id="regform" action="xregform.jsp" method="post"> 
            <p>email</p><!-- onblur="validaInput()"-->
            <input id="reguser" type="text" name="user" size="20"  required><br><br>
			<p>password</p>
			<input required type="password" name="password" id="regpass" onclick="validator();" placeholder="Insert password"  autocomplete="off" value="" size="20">
<!--			<div id="ProgressBar">
				<div id="bar">
				</div>
				<p id="alert">
				</p
			</div> >-->
            <p>ripeti password</p>
            <input required id="regrepass" type="password" name="repassword" size="20"><br><br>
            <p>nome</p>
            <input required id="regnome" type="text" name="nome" size="20"><br><br>
            <p>cognome</p>
            <input required id="regcognome" type="text" name="cognome" size="20"><br><br>
            <p>data di nascita</p>
            <input required id="regddn" type="date" name="regddn" size="20" value="<% out.print(DbParameter.getDate());%>"><br><br>
			<div class="xrecaptcha">
				<div id="re_html_element" ></div>
			</div>
            
			<input id="reginvia" type="submit" name="submit" value="Invia" onclick="onSubmit();">
        </form>
    <p>Ti arriverà  una email con le tue credenziali<br>Controlla la posta indesiderata</p>
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer>
		</script>
                
		<script>
		$(document).ready(function(){
			$("#regform").on("submit",function(event){
			var s="";
                                if (!emailIsValid($("#reguser").val())){
                                        s+="Email non valida!\n";
                                }
                                var textpwd="/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(\W|_)).{5,}$/";
                                if(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(\W|_)).{5,}$/.test($("#regpass").val())){
			              // valid password
                                }else				
                        		s+="Password non valida!\n";
//                                  if(!validator()){
//					s+="Password non valida!\n";
//				}
				if($("#regpass").val()!=$("#regrepass").val()){
					s+="Le password non corrispondono!\n";
				}
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
 <div class="autocenter">
     <p><a id="regchiudi"  href= "index.jsp">Chiudi</a></p><br><!-- href="index.jsp"-->
</div>
	</div>
</body>
</html>
