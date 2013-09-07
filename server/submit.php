<?php
 include('SimpleImage.php');
ini_set('max_upload_filesize', 8388608);
$link = mysql_connect("localhost", "phoshow", "phoshow")                                                                            
  or die("could not connect");                                                                                                    
  mysql_select_db("putpocket") or die ("No DB");
  

  if ($_FILES["file"]["error"] > 0)
  {
    echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
  }
  else
  {
    echo "Upload: " . $_FILES["file"]["name"] . "<br />";
    echo "Type: " . $_FILES["file"]["type"] . "<br />";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
    //echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

    $newPhotoId = time(); 
    $newFileName = $newPhotoId . ".jpg";
    $basePath = "upload/";
    $fullPath = $basePath.$newFileName;
    mysql_query("INSERT INTO photos (id, event_id, approved) VALUES($newPhotoId, 1, 0)") or die(mysql_error());
 
    //if (file_exists("upload/" . $_FILES["file"]["name"]))
    
    if (file_exists("upload/" . $newFileName))
    {
      echo $_FILES["file"]["name"] . " already exists. ";
    }
    else
    {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $newFileName);
      echo "Stored in: " . "upload/" . $_FILES["file"]["name"];
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
