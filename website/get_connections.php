<?php
	require_once("config.php");

	// Create connection
	$conn = mysqli_connect(SERVER_NAME, DB_USERNAME, DB_PASSWORD, DB_NAME)or die('UNABLE TO CONNECT');

	//echo "Connected successfully";

	$sql = "SELECT * FROM icu_device ORDER BY datetime_added";
	$result = mysqli_query($conn, $sql);
	$rows = array();
	
	
	while($r = mysqli_fetch_assoc($result)) {
   		$rows[] = $r;
	}

	$name2ID = array();

	for ( $i=0; $i<sizeof($rows); $i++){
		//$rows[$i]["value"] = 1;
		$rows[$i]["id"] = strtoupper($rows[$i]["id"]);
		$rows[$i]["label"] = $rows[$i]["id"];
		if (isset($rows[$i]["human_name"]))
			$rows[$i]["label"] .= ":" . $rows[$i]["human_name"];

		//$rows[$i]["id"] = $i;
		//unset($rows[$i]["id"]);
		unset($rows[$i]["human_name"]);
		unset($rows[$i]["datetime_added"]);
		unset($rows[$i]["first_ip"]);
 		unset($rows[$i]["last_request"]);
 		$name2ID[$rows[$i]["label"]] = $i;
	}
   
    $output["nodes"] = $rows;

	$sql = "SELECT * FROM icu_device_configuration ORDER BY date_added";
	$result = mysqli_query($conn, $sql);
	$rows = array();

	while($r = mysqli_fetch_assoc($result)) {
   		$rows[] = $r;
	}

	for ( $i=0; $i<sizeof($rows); $i++){
		
		$rows[$i]["from"] = strtoupper($rows[$i]["device_id"]);
		$rows[$i]["to"] = strtoupper($rows[$i]["target_device_id"]);
		$rows[$i]["value"] = 1;
		$rows[$i]["title"] = strtoupper($rows[$i]["device_id"]) . " to " . strtoupper($rows[$i]["target_device_id"]);

		unset($rows[$i]["device_id"]);
		unset($rows[$i]["target_device_id"]);
		unset($rows[$i]["spring"]);
		//unset($rows[$i]["color"]);
		unset($rows[$i]["date_added"]);
		unset($rows[$i]["damp"]);
		unset($rows[$i]["message"]);
		unset($rows[$i]["blacklist"]);
		unset($rows[$i]["temp"]);		
	}

	//print_r($rows);
	$output["links"] = $rows;
	//$output["links"] = array();
	//print_r($output);
	echo (json_encode($output));

?>