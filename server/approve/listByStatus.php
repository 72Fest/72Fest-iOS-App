<?php
if (is_null($_GET["statusId"]) || !is_numeric($_GET["statusId"])) {
   $statusId = -1; 
} else {
   $statusId = $_GET["statusId"];
}

$host = "localhost";
$user = "phoshow";
$pass = "phoshow";
$database = "putpocket";
$linkID = mysql_connect($host, $user, $pass) or die("Could not connect to host.");
mysql_select_db($database, $linkID) or die("Could not find database.");

//NOTE: we have made the value 2 to equal disapproved

//if the id is -1 a parameter wasn't supplied or an invalid parameter was given
//so show everything
if ($statusId == -1) {
    $query = "SELECT * FROM photos ORDER BY id DESC";
} else {
    $query = sprintf("SELECT * FROM photos WHERE approved=%d ORDER BY id DESC", $statusId);
}
$resultID = mysql_query($query, $linkID) or die("Data not found.");

$xml_output = "";

$base_url = "/photoapp/upload/";

for($x = 0 ; $x < mysql_num_rows($resultID) ; $x++){
    $row = mysql_fetch_assoc($resultID);
    $xml_output .= "<div class='imageDiv'>\n";
    $xml_output .= "<a class='imageLink' href='$base_url" . $row['id'] . ".jpg'>";
    $xml_output .= "<img class='lazy' src='../imgs/loading.gif' data-original='$base_url" . $row['id'] . "_thmb.jpg'/></a>\n";
    if ($row['approved'] == 0){
      $xml_output .= "<div><a class='button approveButton' href='#" . $row['id'] . "'></a></div>\n\n";
      $xml_output .= "<div><a class='button disapproveButton' style='margin-top:10px;margin-bottom:20px;' href='#" . $row['id'] . "'></a></div>\n</div>\n";
    } elseif ($row['approved'] == 2) {
      $xml_output .= "<a class='button approveButton' href='#" . $row['id'] . "'></a></div>\n";
    }else{
      $xml_output .= "<a class='button disapproveButton' href='#" . $row['id'] . "'></a>\n</div>\n";
    }
}

if (mysql_num_rows($resultID) == 0) {
    $photoType = "NEW";

    if ($statusId == 1) {
        $photoType = "APPROVED";
    } elseif ($statusId == 2) {
        $photoType = "DENIED";
    }

    $xml_output .= "<h1>There are no $photoType photos</h1>";
}

echo $xml_output;

?>
