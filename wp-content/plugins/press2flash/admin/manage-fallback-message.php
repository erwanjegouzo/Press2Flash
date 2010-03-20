<?php	

require_once("../../../../wp-config.php");

if($current_user->caps["administrator"] == 1){
	global $wpdb;
	$data_array = array('press2flash_value' => $_GET['fallback_message']);
	$where_array = array('press2flash_option' => 'fallback_message');
	$db_query = $wpdb->update( $wpdb->prefix . 'press2flash', $data_array, $where_array );
	
	if($db_query == 1){echo "success";}
	else{echo "error";}
}

?>