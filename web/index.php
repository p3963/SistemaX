<!DOCTYPE html>
<html>
    <head>
       <meta charset="UTF-8">
       <title>ARCFOTO</title>
    </head>
    <body>
<?php
        include_once './includes/pdoconnect.php';
	$username='';
	$login=false;
	$dbh = null;
	if(isset($_COOKIE['PHPSESSID'])){
		$sessionid=$_COOKIE['PHPSESSID'];
		try {
			$dbh = new PDO($db, $user, $pass);
			foreach($dbh->query('SELECT sessionid, username from users where sessionid="'.$sessionid.'"') as $row) {
				if($row[0]==$sessionid){
					$username=$row[1];
					break;
				}
			}
		} catch (Exception $e) {
			$dbh->rollBack();
			echo "Failed: " . $e->getMessage();
		}
	}
	$dbh = null;
	if($username!='')
		header("Location:menu.php");
	else{
		echo '<form method="post" action="login.php">';
		echo '<div style="text-align:center">';
		echo '<p>Indirizzo e-mail<br>';
		echo '<input type="text" size=30 name="username"/></p>';
		echo '<p>Password<br>';
		echo '<input type="password" size=30 name="password"/></p>';
		echo '<br><input type="submit" value="Login">';
		echo '</div>';
		echo '</form>';
//                echo '<div style="text-align:center">';
//                echo '<br><a href="registrati.php">Registrazione</a>';
//                echo '</div>';
//                echo '<div style="text-align:center">';
//                echo '<br><a href="repassword.php">Password perduta?</a>';
//                echo '</div>';
	}
?>
    </body>
</html>