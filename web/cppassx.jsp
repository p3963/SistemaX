<?php
	//include "include/mysql_local.php";
	include "include/mysql_remote.php";

	require_once("PHPMailer/src/PHPMailer.php");
	require_once("PHPMailer/src/SMTP.php");
	require_once("PHPMailer/src/Exception.php");
	use PHPMailer\PHPMailer\PHPMailer;
	use PHPMailer\PHPMailer\SMTP;
	use PHPMailer\PHPMailer\Exception;
	$mail = new PHPMailer();
	$mail->isSMTP();
	$mail->SMTPDebug = SMTP::DEBUG_SERVER;
	$mail->Host = 'authsmtp.securemail.pro';
	$mail->Port = 465;
	$mail->setFrom('piero-39@libero.it', 'Webmaster Arcfoto');
	$mail->SMTPSecure = 'ssl';//PHPMailer::ENCRYPTION_SMTPS;
	$mail->SMTPAuth = true;
	$mail->Username = 'smtp@p39.eu';
	$mail->Password = 'SmtpP@ssword';
	session_start();
    $user=$_SESSION["user"];
    $pass=$_POST["oldpass"];
	$newpass=sha1($_POST["password"]);
    $pass=sha1($pass);
    $mysqli = new mysqli($dbhost,$dbuser,$dbpassword,$dbdatabase);
    $sql="select user from users where user='".$user."' and password='".$pass."';";
    $result=mysqli_query($mysqli,$sql);
    $cont=mysqli_num_rows($result);
 	$mysqli->close();
	if($cont == 0){?>
		<script>
			alert("Vecchia password errata");
			location.href="index.php";
		</script><?php
	}
	else{
//		echo $_POST["oldpass"];
		$mysqli1 = new mysqli($dbhost,$dbuser,$dbpassword,$dbdatabase);
		$sql1="update users set password='".$newpass."' where user='".$user."' and password='".$pass."';";
        $result1=$mysqli1->query($sql1);
		$mysqli1->close();
		
		$to=$user;
		$mail->addAddress($to, $user);
		$subject="Cambio Password sito \"Arcfoto\"";
		$mail->Subject=$subject;
		$msg="Cambio Password/o \n".$user."\nLa tua nuova password:\n".$_POST["password"]."";
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

		header("Location:index.php");
	}
	
?>