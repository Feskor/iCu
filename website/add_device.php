<?php
require_once('config.php');
require_once('util.php');
require_once('database.php');

$device_id = $_GET['device_id'];

if (!preg_match("/[0-9a-fA-F]{4}/", $device_id)){
	echo "DeviceID does not match specified format.";
	die;
}

$stmt = $pdo->prepare("INSERT INTO `icu_device` (`id`, `last_request`) VALUES ( ? , NULL);");

if (!$stmt->execute([$device_id])) {
	echo "Error inserting $device_id into database";
	die;
}
else
	echo "Successfully inserted device $device_id into database.";
