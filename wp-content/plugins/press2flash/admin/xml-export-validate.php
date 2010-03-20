<?php

require_once("../../../../wp-config.php");

$xml = esc_html($_GET["xml_export"]);
echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
echo $xml;
?>