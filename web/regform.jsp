<?php
	//include "include/mysql_local.php";
	require_once("include/mysql_remote.php");

	require_once("PHPMailer/src/PHPMailer.php");
	require_once("PHPMailer/src/SMTP.php");
	require_once("PHPMailer/src/Exception.php");

//	include("PHPMailer/src/OAuth.php");
	use PHPMailer\PHPMailer\PHPMailer;
	use PHPMailer\PHPMailer\SMTP;
	use PHPMailer\PHPMailer\Exception;
	$mail = new PHPMailer();
	$mail->isSMTP();
	$mail->SMTPDebug = SMTP::DEBUG_SERVER;
 	$mail->setFrom('piero-39@libero.it', 'Webmaster Arcfoto');
	//$mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
	//echo (PHPMailer::ENCRYPTION_SMTPS);
	$mail->Host = 'authsmtp.securemail.pro';
	$mail->SMTPAuth = true;
	$mail->Username = 'smtp@p39.eu';
	$mail->Password = 'SmtpP@ssword';
	$mail->SMTPSecure = 'ssl';//'tls';
	$mail->Port = 465;
 	
    $user=$_POST["user"];
    $pass=$_POST["password"];
	$ddn=$_POST["regddn"];
	$yddn=substr($ddn,0,4);
	$mddn=substr($ddn,5,2);
	$gddn=substr($ddn,8,2);
	if(!checkdate($mddn,$gddn,$yddn)){
		echo '<script>';
		echo 'alert ("Data non valida!");';
		echo 'location.href="registrazione.php";';
		echo '</script>';
	}
    $pass=sha1($pass);
    $mysqli = new mysqli($dbhost,$dbuser,$dbpassword,$dbdatabase);
    $sql="select user from users where user='".$user."';";
    $result=mysqli_query($mysqli,$sql);
//	$result=$mysqli->query($sql);
    $cont=mysqli_num_rows($result);
 	$mysqli->close();
	if($cont == 0){
	    $mysqli1 = new mysqli($dbhost,$dbuser,$dbpassword,$dbdatabase);
		$sql1="insert into users (user, password, sessione, nome, cognome, ddn) values ('".$user."','".$pass."','','".$_POST["nome"]."','".$_POST["cognome"]."','".$ddn."');";
        $result1=$mysqli1->query($sql1);
		$mysqli1->close();
		$to=$user;
		$mail->addAddress($to);//, $user
		$subject="Registrazione al sito \"Arcfoto\"";
		$mail->Subject=$subject;
		$msg="Benvenuta/o!\nLa tua e-mail:\n".$user."\nLa tua password:\n".$_POST["password"]."";
		$mail->Body=$msg;
		if (!$mail->send()) {
			echo 'Mailer Error: ' . $mail->ErrorInfo;
		} else {
			echo 'Message sent!';
			$path = '{imapmail.libero.it:993/imap/ssl/novalidate-cert}outbox'; //
			$imapuser="piero-39@libero.it";
			$imappass="P4ssw4rd$";
			$imapStream = imap_open($path, $imapuser, $imappass);
			$result = imap_append($imapStream, $path, $mail->getSentMIMEMessage());
			imap_close($imapStream);
			if ($result) {		
				echo "Message saved!";
			}
		}		
		header("location:index.php");
    }else{
		?>
		<script type="text/javascript">
			alert("Utente già presente!");
			location.href="index.php";
		</script>
		<?php
    }

?>