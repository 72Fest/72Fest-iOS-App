<?php
$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "putpocket"; 

$db = new PDO('mysql:host=localhost;dbname=putpocket;charset=utf8', $user, $pass);
$photoID = $_GET["id"];

header('Content-Type: application/json');

$baseSQL = "SELECT id, likes as votes FROM photos WHERE approved = 1 and likes > 0 ";
$orderBySQL = " ORDER BY likes DESC";

$voteResults;
if ((is_null($photoID)) || (!is_numeric($photoID))) {
	//if no id is supplied then get all votes
	$voteResults = $db->query($baseSQL . $orderBySQL)->fetchAll(PDO::FETCH_ASSOC);
} else {
	//retreive the total for only the specified vote
	$voteQuery = $baseSQL . " AND id=$photoID " . $orderBySQL;
	$voteResults = $db->query($voteQuery)->fetchAll(PDO::FETCH_ASSOC);
}

echo json_encode($voteResults);
