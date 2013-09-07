<?php 

header("Content-type: text/xml"); 

$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "putpocket"; 
$linkID = mysql_connect($host, $user, $pass) or die("Could not connect to host."); 
mysql_select_db($database, $linkID) or die("Could not find database."); 

$query = "SELECT * FROM photos WHERE approved = 1 ORDER BY id DESC"; 
$resultID = mysql_query($query, $linkID) or die("Data not found."); 

$xml_output = "<?xml version=\"1.0\"?>\n"; 
$xml_output .= "<entries>\n"; 

for($x = 0 ; $x < mysql_num_rows($resultID) ; $x++){ 
    $row = mysql_fetch_assoc($resultID); 
    $xml_output .= "\t<image>\n"; 
    $xml_output .= "\t\t<id>" . $row['id'] . "</id>\n"; 
    $xml_output .= "\t\t<fullsrc>http://putpocket.com/photoapp/upload/" . $row['id'] . ".jpg</fullsrc>\n"; 
    $xml_output .= "\t\t<thumbsrc>http://putpocket.com/photoapp/upload/" . $row['id'] . "_thmb.jpg</thumbsrc>\n"; 
    $xml_output .= "\t\t<event>" . $row['event_id'] . "</event>\n"; 
    $xml_output .= "\t\t<approved>" . $row['approved'] . "</approved>\n"; 
    $xml_output .= "\t\t<likes>" . $row['likes'] . "</likes>\n"; 
    $xml_output .= "\t</image>\n"; 
} 

$xml_output .= "</entries>"; 

echo $xml_output; 

?> 
