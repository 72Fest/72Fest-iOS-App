<?php
ini_set('max_upload_filesize', 8388608);
  if ($_FILES["file"]["error"] > 0)
  {
    echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
  }
  else
  {
    echo "Upload: " . $_FILES["file"]["name"] . "<br />";
    echo "Type: " . $_FILES["file"]["type"] . "<br />";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

    $newFileName = "photo_" . time() . "_"  . rand(1000, 9999) . ".jpg";
 
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
    }
  }
?>
