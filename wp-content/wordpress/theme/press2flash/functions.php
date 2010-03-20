<?php



function press2flash_tracking_code(){
	global $wpdb;
	
	$tracking_code = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option='tracking_code'");
	echo $tracking_code;
}


function press2flash_fallback(){
	global $wpdb;
	
	$fallback = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option='fallback_message'");
	echo $fallback;
}



remove_action('wp_head', 'wp_generator');
add_action('wp_footer', 'press2flash_tracking_code');
?>