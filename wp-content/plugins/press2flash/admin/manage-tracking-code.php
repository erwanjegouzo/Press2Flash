<?php	

require_once("../../../../wp-config.php");

if($current_user->caps["administrator"] == 1){
	global $wpdb;
	$data_array = array('press2flash_value' => $_GET['tracking_code']);
	$where_array = array('press2flash_option' => 'tracking_code');
	$db_query = $wpdb->update( $wpdb->prefix . 'press2flash', $data_array, $where_array );
	
	echo "success";
}

?>