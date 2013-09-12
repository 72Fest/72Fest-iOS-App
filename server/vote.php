<?php
$link = mysql_connect("localhost", "phoshow", "phoshow")
or die("could not connect");
mysql_select_db("putpocket") or die ("No DB");

$photoID = $_POST["id"];
$unlike = $_POST["unlike"];
$updateStatement = "";

header('Content-Type: application/json');

if ((is_null($photoID)) || (!is_numeric($photoID))) {
	echo json_encode(array('status' => -1));
	return;
}

if (is_null($unlike)) {
	$updateStatement = "+ 1";
} else {
	if (!is_numeric($unlike)) {		
		echo json_encode(array('status' => -2));
		return;
	} else {
		$updateStatement = "- 1";
	}
	
}

	mysql_query("UPDATE photos SET likes = likes " . $updateStatement . " WHERE id = " . $photoID) or die(mysql_error());
	
	$result = mysql_query('SELECT likes FROM photos WHERE id = ' . $photoID);
	if (!$result) {
	    echo json_encode(array('status' => -3));
	} else {
	    echo json_encode(array('status' => 0, 'votes' => mysql_result($result, 0)));
	}

?>
