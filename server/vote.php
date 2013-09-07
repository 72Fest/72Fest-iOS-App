<?php
$link = mysql_connect("localhost", "phoshow", "phoshow")
or die("could not connect");
mysql_select_db("putpocket") or die ("No DB");

$photoID = $_POST["id"];

if ((is_null($photoID)) || (!is_numeric($photoID))) {
	echo "Return Code: -1 <br />";
} else {
	
	mysql_query("UPDATE photos SET likes = likes + 1 WHERE id = " . $photoID) or die(mysql_error());
	
}

?>
