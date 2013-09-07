<?php 

$failResults = array("status" => false, "message" => "Failed to update approval");
$winResults = array("status" => true, "message" => "Image approval was updated");


if (is_null($_GET["photoId"]) || !is_numeric($_GET["photoId"])) {
    echo json_encode($failResults);
    exit();
} 

$photoId = $_GET["photoId"];

#echo json_encode($countdownData, $JSON_UNESCAPED_UNICODE);

$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "putpocket"; 
$linkID = mysql_connect($host, $user, $pass) or die("Could not connect to host."); 
mysql_select_db($database, $linkID) or die("Could not find database."); 

$query = sprintf("UPDATE photos SET approved = 2 WHERE id = %d", $photoId);
$resultID = mysql_query($query, $linkID) or die("Failed to update."); 


echo json_encode($winResults);
?> 
