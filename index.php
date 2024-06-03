<?php
require 'vendor/autoload.php';

use Dotenv\Dotenv;
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

$expectedKnockKey = getenv('EXPECTED_KNOCK_KEY');
$knockKey = $_GET['knock'] ?? '';

if (hash_equals($knockKey, $expectedKnockKey) === false) {
    http_response_code(403);
    echo 'Forbidden';
    exit;
}

$clientIp = $_SERVER['REMOTE_ADDR'];
$scriptPath = realpath(dirname(__FILE__)) . '/' . getenv('SCRIPT_NAME');
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
