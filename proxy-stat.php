<!doctype html>
<html>
<head>
<meta charset="utf-8" http-equiv="refresh" content="300">
<title>Local Proxy Stat</title>
</head>
<body>

<?php

// ---------------------------
// Change PORT for you system:
// -------------------
$url="http://localhost:1888/1/workers";

// Format : http://php.net/manual/en/function.date.php
$datetimeFormat = "d-m-Y H:i:s";


// Check curl module installed and loaded
if (!extension_loaded('curl')) {
    if (!dl('curl.so')) {
      echo "<br><h1>CURL module not found!</h1><br>";
            exit;
    }
}

// Check json module installed and loaded
if (!extension_loaded('json')) {
    if (!dl('json.so')) {
       echo  "<br><h1>JSON module not found!</h1><br>";
       exit;
    }
}


// get func from: http://php.net/manual/ru/function.json-decode.php
/**
* Clean comments of json content and decode it with json_decode().
* Work like the original php json_decode() function with the same params
*
* @param   string  $json    The json string being decoded
* @param   bool    $assoc   When TRUE, returned objects will be converted into associative arrays.
* @param   integer $depth   User specified recursion depth. (>=5.3)
* @param   integer $options Bitmask of JSON decode options. (>=5.4)
* @return  string
*/
function json_clean_decode($json, $assoc = false, $depth = 512, $options = 0) {

    // search and remove comments like /* */ and //
    $json = preg_replace("#(/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/)|([\s\t](//).*)#", '', $json);

    if(version_compare(phpversion(), '5.4.0', '>=')) {
        $json = json_decode($json, $assoc, $depth, $options);
    }
    elseif(version_compare(phpversion(), '5.3.0', '>=')) {
        $json = json_decode($json, $assoc, $depth);
    }
    else {
        $json = json_decode($json, $assoc);
    }

    return $json;
}


//  Initiate curl
$ch = curl_init();
// Disable SSL verification
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// Will return the response, if false it print the response
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// Set the url
curl_setopt($ch, CURLOPT_URL,$url);
// Execute
$result=curl_exec($ch);
// Closing
curl_close($ch);

// Will dump a beauty json :3
//var_dump(json_decode($result, true));
//$data = json_decode($result,true);
$data = json_clean_decode($result,true);
if (json_last_error() === JSON_ERROR_NONE) {
    //do something with $json. It's ready to use
    //echo  "<br><h1>JSON Decode NOT ERROR</h1><br>";

?>

<table border="1" cellpadding="5">
<thead>
 Total:
    <tr>
        <th>1 min HR</th>
        <th>10 min HR</th>
        <th>1 hour HR</th>
        <th>12 hours HR</th>
        <th>24 hours HR</th>
        <th>Uptime HR</th>
    </tr>
</thead>

<tbody>
<?php
foreach( $data['hashrate'] as $hr) {  ?>
 <tr>
 <?php  foreach($hr as $key => $wrk) {  ?>
  <td><?php echo $wrk; ?> </td>
 <?php
 }
 ?></tr>
<?php
}
?>
</tbody>


<table border="1" cellpadding="5">
<thead>
Workers:
    <tr>
        <th>Worker Name</th>
        <th>Last IP</th>
        <th>Conn count</th>
        <th>Accept shares</th>
        <th>Upstream Rejected</th>
        <th>Invalid shares</th>
        <th>Total shares</th>
        <th>Time Stamp</th>
        <th>1 min HR</th>
        <th>10 min HR</th>
        <th>1 hour HR</th>
        <th>12 hours HR</th>
        <th>24 hours HR</th>
    </tr>
</thead>

<tbody>
<?php
foreach( $data['workers'] as $hr) {  ?>
 <tr>
 <?php  foreach($hr as $key => $wrk) {  ?>
	<td><?php
		// If TimeStamp key - conevrt milliseconds to humanformat
		if( $key == 7 ) {
			echo  date($datetimeFormat, ($wrk / 1000) );
		} else {
			echo $wrk;
		}
	?> </td>
 <?php
 }
 ?></tr>
<?php
}

} else {
    //yep, it's not JSON. Log error or alert someone or do nothing
    echo  "<br><h1>JSON Decode ERROR</h1><br>";
}

?>
</tbody>

</body>
</html>
