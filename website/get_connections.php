<?php
	require_once("config.php");
	require_once('database.php');

	$statement = $pdo->prepare("SELECT * FROM icu_device ORDER BY datetime_added");
	$statement->execute();
	
	$rows = array();
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);
	
	$result = array();
	for ( $i=0; $i<sizeof($rows); $i++){
		$result[$i] = array();
		$result[$i]["id"] = strtoupper($rows[$i]["id"]);
		$result[$i]["label"] = $rows[$i]["id"];
		if (isset($rows[$i]["human_name"]))
			$result[$i]["label"] .= ":" . $rows[$i]["human_name"];
	
	}
   
    $output["nodes"] = $result;

	$statement = $pdo->prepare("SELECT * FROM icu_device_configuration ORDER BY date_added");
	$statement->execute();
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);
	$result = array();

	for ( $i=0; $i<sizeof($rows); $i++){
		$result[$i] = array();
		$result[$i]["from"] = strtoupper($rows[$i]["device_id"]);
		$result[$i]["to"] = strtoupper($rows[$i]["target_device_id"]);		
		$result[$i]["color"] = strtoupper($rows[$i]["color"]);
	}

	$output["links"] = $result;
	echo (json_encode($output));

?>