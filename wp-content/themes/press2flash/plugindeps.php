<?php

$required_plugins = array(
    'press2flash'
);
$missing = array();
foreach ($required_plugins as $plugin)
    if (!function_exists($plugin) && !class_exists($plugin))
        $missing[] = $plugin;

if (!empty($missing)) {
    header('Content-Type: text/plain');
    foreach ($missing as $plugin)
        echo "Required plugin '$plugin' is missing\r\n";
    die();
}

?>