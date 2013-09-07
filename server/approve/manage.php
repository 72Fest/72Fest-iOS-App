<html>
<head>
<link href="photoapp.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php 

$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "putpocket"; 
$linkID = mysql_connect($host, $user, $pass) or die("Could not connect to host."); 
mysql_select_db($database, $linkID) or die("Could not find database."); 

$query = "SELECT * FROM photos WHERE approved = '0' ORDER BY id DESC"; 
$resultID = mysql_query($query, $linkID) or die("Data not found."); 

echo "<div id='maindiv'>";
$count = 0;
while ($photo = mysql_fetch_array($resultID, MYSQL_ASSOC)){
  if($count == 0)
  {
    //echo "<div class='row'>";
  }  
  echo "<div class='photo'><a href=\"/photoapp/upload/". $photo['id'].".jpg\"><img src=\"/photoapp/upload/".$photo['id']."_thmb.jpg\"/></a></div>";
  if($count == 3)
  {
    //echo "</div>";
    $count = 0;
  }  
  else{
    $count++;
  }
}

echo "</div>";
?> 

</body>
</html>
