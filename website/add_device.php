<?php
// Adds a device to the database
// Makes sure only one device can be added from the same IP address 
require_once('config.php');
require_once('util.php');
require_once('database.php');

$device_id = $_GET['device_id'];
$client_ip = "";

// Fetch the client IP address
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
	$client_ip = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
	$client_ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
	$client_ip = $_SERVER['REMOTE_ADDR'];
}

// Check wether the device ID matches the pattern (4 digit HEX number)
if (!preg_match("/[0-9a-fA-F]{4}/", $device_id)){
	echo "DeviceID does not match specified format.";
	exit;
}

// Check if the device is already added to the database
$stmt = $pdo->prepare("SELECT * FROM icu_device WHERE id=?");
if (!$stmt->execute([$device_id])){
	echo "Error selecting device from database.";
}
elseif ($stmt->rowCount() > 0){
	echo "Device " . $device_id . " already exists.";
	exit;
}

// // Check wether another device was already added from this IP in the last 10 minutes
// $stmt = $pdo->prepare("SELECT * FROM icu_device WHERE TIMESTAMPADD(MINUTE,10,datetime_added) > CURRENT_TIMESTAMP AND first_ip= ? ");

// if (!$stmt->execute([$client_ip])){
// 	echo "Error retrieving device info from database.";
// 	exit;
// } else {
// 	if ($stmt->rowCount() > 0){
// 		echo "Another device wase already added from this IP address.";
// 		exit;
// 	}
// }

// Insert the device properties into the database
$stmt = $pdo->prepare("INSERT INTO icu_device(id, first_ip) VALUES ( ? , ? )");

if (!$stmt->execute([$device_id, $client_ip])) {
	echo "Error inserting $device_id into database";
	exit;
}
else
	echo "Successfully inserted device $device_id into database.";
