<?php 

header("Content-type: application/json"); 

$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "putpocket"; 

$db = new PDO('mysql:host=localhost;dbname=putpocket;charset=utf8', $user, $pass);
$query = "SELECT * FROM photos WHERE approved = 1 ORDER BY id DESC"; 
//$resultID = mysql_query($query, $linkID) or die("Data not found."); 
//$jsonResult = json_encode($resultId);
$array_build = array();
$photo_array = $db->query($query)->fetchAll(PDO::FETCH_ASSOC);

$metadata_array = array("url" => "http://phoshow.me/photoapp/upload",
					"thumb" => "_thmb",
					"extension" => ".jpg");
$array_build = array("Meta" => $metadata_array, "Photos" => $photo_array ) ;
//
//array_push($array_build, $meta_array );
//echo json_encode($array_build);
//
//$jsonResult = $array;
//array_push($array_build, array('Photos' => $photo_array));
echo json_encode($array_build);
//echo json_encode($photo_array);
//echo json_encode($jsonResult);
//
?> 
