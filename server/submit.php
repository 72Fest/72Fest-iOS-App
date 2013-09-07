<?php
 include('SimpleImage.php');
ini_set('max_upload_filesize', 8388608);
$link = mysql_connect("localhost", "phoshow", "phoshow")                                                                            
  or die("could not connect");                                                                                                    
  mysql_select_db("putpocket") or die ("No DB");
  

  if ($_FILES["file"]["error"] > 0)
  {
    error_log ("Return Code: " . $_FILES["file"]["error"] . "<br />");
  }
  else
  {
    error_log( "Upload: " . $_FILES["file"]["name"] . "<br />");
    error_log ("Type: " . $_FILES["file"]["type"] . "<br />");
    error_log ("Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />");
    //error_log "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

    $newPhotoId = time(); 
    $newFileName = $newPhotoId . ".jpg";
    $basePath = "upload/";
    $fullPath = $basePath.$newFileName;
    error_log("INSERT INTO photos (id, event_id, ss_order, approved) VALUES($newPhotoId, 1, 0, 0)");
    mysql_query("INSERT INTO photos (id, event_id, ss_order, approved) VALUES($newPhotoId, 1, 0, 0)") or die(mysql_error());
    error_log("after mysql");
    //if (file_exists("upload/" . $_FILES["file"]["name"]))
    
    if (file_exists("upload/" . $newFileName))
    {
      error_log ($_FILES["file"]["name"] . " already exists. ");
    }
    else
    {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $newFileName);
      error_log ("Stored in: " . "upload/" . $_FILES["file"]["name"]);
       $image = new SimpleImage();
   $image->load($fullPath);
   if ($image->getWidth > $image->getHeight) {
      $image->resizeToWidth(160);
   } else {
      $image->resizeToHeight(160);
   }
   //$image->scale(30);
   $image->save($basePath.$newPhotoId."_thmb.jpg");
    }
  }
?>
