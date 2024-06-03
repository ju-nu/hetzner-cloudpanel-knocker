<?php
require 'vendor/autoload.php';

use Dotenv\Dotenv;

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

$expectedKnockKey = $_ENV['EXPECTED_KNOCK_KEY'] ?? false;

if ($expectedKnockKey === false) {
    echo "Error: .env file not loaded or EXPECTED_KNOCK_KEY not set.";
    exit;
}

$knockKey = $_GET['knock'] ?? '';

if (!is_string($knockKey)) {
    $knockKey = '';
}

if (hash_equals($expectedKnockKey, $knockKey) === false) {
    http_response_code(403);
    echo 'Forbidden';
    exit;
}

$clientIp = $_SERVER['REMOTE_ADDR'];
$scriptPath = realpath(__DIR__) . '/' . $_ENV['RUN_NAME'];
$command = escapeshellcmd("$scriptPath $clientIp");
$output = shell_exec($command);

if ($output === null) {
    http_response_code(500);
    echo 'Error executing script';
} else {
    http_response_code(200);
    echo 'Script executed successfully. Output: <pre>' . htmlspecialchars($output) . '</pre>';
}
?>
