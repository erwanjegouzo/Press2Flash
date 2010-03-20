<?php	

require_once("../../../../wp-config.php");

if($current_user->caps["administrator"] == 1){
	global $wpdb;
	
		
	$data_array = array('press2flash_value' => $_GET['upload_thumbnail']);
	$where_array = array('press2flash_option' => 'upload_thumbnail');
	$db_query = $wpdb->update( $wpdb->prefix . 'press2flash', $data_array, $where_array );
	
	$data_array = array('press2flash_value' => $_GET['upload_medium']);
	$where_array = array('press2flash_option' => 'upload_medium');
	$db_query = $wpdb->update( $wpdb->prefix . 'press2flash', $data_array, $where_array );
	
	$data_array = array('press2flash_value' => $_GET['upload_large']);
	$where_array = array('press2flash_option' => 'upload_large');
	$db_query = $wpdb->update( $wpdb->prefix . 'press2flash', $data_array, $where_array );
	
	echo "success";
}

?>