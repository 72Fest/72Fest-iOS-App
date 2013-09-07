<html>
<head>
<link href='http://fonts.googleapis.com/css?family=Marcellus+SC' rel='stylesheet' type='text/css'>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Approve Photos</title>

<link href="css/approval.css" rel="stylesheet" type="text/css" />
<link href="../js/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script src="../js/jquery.js" type="text/javascript"></script>
<script src="../js/jquery-ui.min.js" type="text/javascript"></script>
<script src="../js/jquery.lazyload.js" type="text/javascript"></script>

<script type="text/javascript" charset="utf-8">
      $(document).ready(function() {
          $("img.lazy").lazyload({
              effect: "fadeIn"
          });

          $("#imgPopup").dialog({ 
              modal: true,
              disabled: true
          });

          $(".imageLink").click(function(e){
alert("asdf");
              //$("#imgPopup").dialog( { show: "slide" }"open");
              $("#imgPopup").dialog("open");
          });

          //$.forceLazyLoad();
          //alert($.forceLazyLoad);

          $("#refreshBtn").click(function() {
              document.location.reload(true);
          });

          $(".approveButton").click(function(e){
              //var s = "";
              //for (key in e) {
              //   s += key + " = " + e[key] + "\n";
              //}

              var hrefVal = $(this).attr('href');
              var photoId = hrefVal.replace(/\#/,"");
              var retVal = confirm("Are you sure you want to approve this?");
              if (retVal) {

                 selectedImg = $(this);
                 $.ajax({
                   type: "GET",
                   url:"approvalManager.php?photoId=" + photoId,
                   success: function(e) {
                       var results = jQuery.parseJSON(e);
                       if (results.status == true) {
                           selectedImg.fadeOut(300, function(){ $(this).remove();}); 
                       }
                   }
                 });
              }
          });
      });
          
  </script>
</head>
<body>

<a id="refreshBtn" class="button">Refresh</a>
<?php 

$host = "localhost"; 
$user = "phoshow"; 
$pass = "phoshow"; 
$database = "phoshow"; 
$linkID = mysql_connect($host, $user, $pass) or die("Could not connect to host."); 
mysql_select_db($database, $linkID) or die("Could not find database."); 

$query = "SELECT * FROM photos WHERE approved = '0' ORDER BY id DESC"; 
$resultID = mysql_query($query, $linkID) or die("Data not found."); 

$xml_output = "";

$base_url = "/photoapp/upload/";
for($x = 0 ; $x < mysql_num_rows($resultID) ; $x++){ 
    $row = mysql_fetch_assoc($resultID); 
    $xml_output .= "<div class='imageDiv'>\n"; 
    $xml_output .= "<a class='imageLink' href='" . $row['id'] . "'>"; 
    $xml_output .= "<img class='lazy' src='../imgs/loading.gif' data-original='/photoapp/upload/" . $row['id'] . "_thmb.jpg'/></a>\n"; 
    $xml_output .= "<a class='button approveButton' href='#" . $row['id'] . "'>Approve</div>\n</div>\n";
} 

if (mysql_num_rows($resultID) == 0) {
    $xml_output .= "<h1>There are no unapproved photos</h1>";
}


echo $xml_output; 

?> 
<div id="imgPopup" title="Dialog Title">
Show an image!
This is what is up
Why can we show it!!!
</div>

</body>
</html>
