<?php
$caption = "72 Film Fest Countdown";
$year = 2013;
$month = 10;
$day = 03;
$hour = 18;
$minute = 30;
$second = 00;

$timeHash = array("year" =>  $year,
                  "month" => $month,
                  "day" => $day,
                  "hour" => $hour,
                  "minute" => $minute,
                  "second" => $second);

$countdownData = array("caption" => $caption, "time" => $timeHash);

header('Content-Type: application/json');
echo json_encode($countdownData);

?>
