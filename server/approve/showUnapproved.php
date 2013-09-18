<html>
<head>
<link href='http://fonts.googleapis.com/css?family=Marcellus+SC' rel='stylesheet' type='text/css'>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Approve Photos</title>

<link href="css/approval.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/klass.min.js"></script>
<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="../js/jquery.lazyload.js" type="text/javascript"></script>
<!-- <script type="text/javascript" src="js/code.photoswipe.jquery-3.0.5.min.js"></script> -->
<script type="text/javascript" src="js/code.photoswipe-3.0.5.min.js"></script>

<script type="text/javascript" charset="utf-8">
      $(document).ready(function() {


          //$.forceLazyLoad();

          //make jquery call to load default vals
          $.ajax({
              type: "GET",
              url: "listByStatus.php?statusId=0",
              success: function(e) {
                  $("#photoContainer").html(e);

                  initImages();
              }
          });
          


          $("#refreshBtn").click(function() {
              document.location.reload(true);
          });

          //handle tabs
          $(".approvalStateBtn").click(function() {
              var statusVal = $(this).attr('data-status_id');
              $.ajax({
                  type: "GET",
                  url: "listByStatus.php?statusId=" + statusVal,
                  success: function(e) {
                      $("#photoContainer").html(e);
    
                      initImages();
                  }
              });
          });


      });
          
      function initImages() {
          //activate the lazy load
          $("img.lazy").lazyload({
               effect: "fadeIn"
          });
          $(".imageLink").photoSwipe({captionAndToolbarHide:false, captionAndToolbarShowEmptyCaptions:true});
          Code.PhotoSwipe.attach( window.document.querySelectorAll('.imageLink'), { enableMouseWheel: false , enableKeyboard: false } );

          window.scrollTo(0,10);
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
                           selectedImg.fadeOut(300, function(){ $(this).parent().remove();}); 
                       }
                   }
                 });
              }
          });

          $(".disapproveButton").click(function(e){
              var hrefVal = $(this).attr('href');
              var photoId = hrefVal.replace(/\#/,"");
              var retVal = confirm("Are you sure you want to DISAPPROVE this?");
              if (retVal) {

                 selectedImg = $(this);
                 $.ajax({
                   type: "GET",
                   url:"disapprovalManager.php?photoId=" + photoId,
                   success: function(e) {
                       var results = jQuery.parseJSON(e);
                       if (results.status == true) {
                           selectedImg.fadeOut(300, function(){ $(this).parent().remove();}); 
                       }
                   }
                 });
              }
          });
      }
  </script>
</head>
<body>
<img src="72Numbers.png"> 
<!--
<a id="refreshBtn" class="button">Refresh</a>
-->
<div id="tabSection">
  <a class="button approvalStateBtn" data-status_id="0">New</a>
  <a class="button approvalStateBtn" data-status_id="2"">Denied</a>
  <a class="button approvalStateBtn" data-status_id="1">Approved</a>
</div>
<div id="photoContainer">
</div>
</body>
</html>
