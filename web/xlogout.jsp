<?php
        include_once './includes/pdoconnect.php';
	if(isset($_COOKIE['PHPSESSID'])){
		$sessionid=$_COOKIE['PHPSESSID'];
		$dbh = null;
		try {
			$dbh = new PDO($db, $user, $pass);
			$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$dbh->beginTransaction();
			$dbh->exec('UPDATE users set sessionid="" where sessionid="'.$sessionid.'"');
			$dbh->commit();
			session_unset();
			//session_destroy();
			setcookie('PHPSESSID',"",time()-7200,'/');
		} catch (Exception $e) {
			$dbh->rollBack();
			echo "Failed: " . $e->getMessage();
		}
	}
	header("Location:index.php");
?>