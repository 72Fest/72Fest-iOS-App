<?php
$link = mysql_connect("localhost", "phoshow", "phoshow")
or die("could not connect");
mysql_select_db("putpocket") or die ("No DB");

$photoID = $_POST["id"];
$unlike = $_POST["unlike"];
$updateStatement = "";

if ((is_null($photoID)) || (!is_numeric($photoID))) {
	echo "Return Code: -1 <br />";
	return;
}

if (is_null($unlike)) {
	$updateStatement = "+ 1";
} else {
	if (!is_numeric($unlike)) {		
	 	echo "Return Code: -2 <br />";
	} else {
		$updateStatement = "- 1";
	}
	
}

	mysql_query("UPDATE photos SET likes = likes " . $updateStatement . " WHERE id = " . $photoID) or die(mysql_error());
	

?>
