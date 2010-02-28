<?php 
/*
 Copyright 2010 Erwan Jegouzo
 Licensed under the Apache License, Version 2.0 (the "License"); 
 you may not use this file except in compliance with the License. 
 You may obtain a copy of the License at 
 http://www.apache.org/licenses/LICENSE-2.0 
 Unless required by applicable law or agreed to in writing, software 
 distributed under the License is distributed on an "AS IS" BASIS, 
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 See the License for the specific language governing permissions and 
 limitations under the License. 
 */
 
if (!empty($_FILES['Filedata']) ) {

	include("../../../wp-config.php");
	include("../../../wp-admin/includes/image.php");

	global $wpdb;
	$upload_path = "";

	$fp = fopen($_FILES['Filedata']['tmp_name'], "rb");
	$bits = "";
	while(!feof($fp)) { $bits .= fread($fp, 4096); }
	fclose($fp);
		
	
	#original
	$original = wp_upload_bits($_FILES['Filedata']['name'], NULL, $bits);
	$original_output = "file=".$original["file"]."&url=".$original["url"]."&error=".$original["error"];
	
	$original_path = pathinfo($original["url"]);
	$upload_path = $original_path["dirname"];
	
	#thumbnail	
	$thumbnail_output = "";
	$is_upload_thumb = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'upload_thumbnail'");			
	if($is_upload_thumb == "true"){
		$thumbnail = image_resize($original["file"], get_option("thumbnail_size_w"), get_option("thumbnail_size_h"), false, get_option("thumbnail_size_w")."_".get_option("thumbnail_size_h"));
		if($thumbnail->errors){$thumbnail_output = "thumbnail_error=true";}
		else{$thumbnail_output = "thumbnail=".$upload_path."/".basename($thumbnail);}
	}
	
	#medium
	$medium_output = "";
	$is_upload_medium = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'upload_medium'");			
	if($is_upload_medium == "true"){
		$medium = image_resize($original["file"], get_option("medium_size_w"), get_option("medium_size_h"), false, get_option("medium_size_w")."_".get_option("medium_size_h"));
		if($medium->errors){$medium_output = "medium_error=true";}
		elseif(basename($medium) == ""){$medium_output = "medium=";}
		else{$medium_output = "medium=".$upload_path."/".basename($medium);}
	}
	
	#large
	$large_output = "";
	$is_upload_large = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'upload_large'");			
	if($is_upload_large == "true"){
		$large = image_resize($original["file"], get_option("large_size_w"), get_option("large_size_h"), false, get_option("large_size_w")."_".get_option("large_size_h"));
		if($large->errors){$large_output = "large_error=true";}
		elseif(basename($large) == ""){$large_output = "large=";}
		else{$large_output = "large=".$upload_path."/".basename($large);}
	}
	
	echo $thumbnail_output."&".$medium_output."&".$large_output."&".$original_output;
	die();
}
else
{
	echo "error=file doesn't exit";
	die();
}

?>