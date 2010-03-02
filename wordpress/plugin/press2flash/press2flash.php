<?php
/* 
Plugin Name: Press2Flash
Plugin URI: http://wordpress.org/#
Description: Add the Flash experience to your Wordpress-powered Website!.
Version: 0.1
Author: Erwan Jegouzo
Author URI: http://www.erwanjegouzo.com
*/

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

if (!class_exists("Press2Flash")) {

	class Press2Flash {
	
		#global $wpdb;
		
		public $default_wp_options 	= "siteurl,blogname,blogdescription,posts_per_page,page_on_front,home,template,stylesheet,show_on_front";
		public $default_fallback 	= "<p>The Adobe Flash Plugin (Version 10) is Required to view this Website</p>The Flash Plugin gives additional functionality to your Web Browser.<br />It is free, safe and easy to install.<p>-Get it here: <a href=\"http://www.adobe.com/go/getflashplayer\" target=\"_blank\">www.adobe.com/go/getFlashPlayer</a></p>";
		public $default_upload_thumbnail 	= "true";
		public $default_upload_medium 		= "";
		public $default_upload_large 		= "";
		
		function Press2Flash() {}
		
		function press2flash_update_feed_permalink($the_link) {
			if(is_feed()) {
				$link = preg_split("/\?p=/", $the_link);
				echo $link[0]."#/".$link[1];
			}
		}
				
		function install(){
			global $wpdb;
			$charset_collate = '';
			
			if(@is_file(ABSPATH.'/wp-admin/upgrade-functions.php')) {
				include_once(ABSPATH.'/wp-admin/upgrade-functions.php');
			} elseif(@is_file(ABSPATH.'/wp-admin/includes/upgrade.php')) {
				include_once(ABSPATH.'/wp-admin/includes/upgrade.php');
			} else {
				die('We have problem finding your \'/wp-admin/upgrade-functions.php\' and \'/wp-admin/includes/upgrade.php\'');
			}
			
			$charset_collate = '';
			if($wpdb->supports_collation()) {
				if(!empty($wpdb->charset)) {
					$charset_collate = "DEFAULT CHARACTER SET $wpdb->charset";
				}
				if(!empty($wpdb->collate)) {
					$charset_collate .= " COLLATE $wpdb->collate";
				}
			}
			
			$table=$wpdb->prefix."press2flash";
			
			$sql="CREATE TABLE IF NOT EXISTS $table (
			id int(11) NOT NULL auto_increment,
			press2flash_option varchar(50) collate utf8_unicode_ci NOT NULL,
			press2flash_value longtext collate utf8_unicode_ci NOT NULL,
			PRIMARY KEY (id));";
			$wpdb->query($sql);
			
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('fallback_message', '".$this->default_fallback."');");
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('wp_options', '".$this->default_wp_options."');");
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('tracking_code', '');");
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('xml_export', '');");
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('upload_thumbnail', '".$this->default_upload_thumbnail."');");		
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('upload_medium', '".$this->default_upload_medium."');");
			$wpdb->query("INSERT INTO ".$table." (press2flash_option, press2flash_value) VALUES ('upload_large', '".$this->default_upload_large."');");		
		}
		
		function uninstall(){
			global $wpdb;
			
			$table=$wpdb->prefix."press2flash";
			$sql="DROP TABLE $table;";
			$wpdb->query($sql);
		}
		
		
		//Prints out the admin page
		function print_admin_page() {
		
		global $wpdb;
		?>
        
        
        <div class="wrap">		
		<div id="press2flash_wrap">
		
		<script type="text/javascript">
			var plugin_url = "<?php echo WP_PLUGIN_URL ?>/press2flash/";
			var default_wp_options = "<?php echo $default_wp_options; ?>";
		</script>

		
			<div class="p2f_validation_message" id="p2f_success_message"><p>Option saved!</p></div>
			<div class="p2f_validation_message" id="p2f_error_message"><p>The option could not be saved!</p></div>
			<form>
			<h2>Export Wordpress configuration</h2>
				<p>The selected options will be exported as soon as the application is called.<br />They contain the Wordpress basics configuration for the website</p>
				
				<?php
					$av_op = "";
					$ch_op = "";
					
					# retrieve all the available wp_options
					$db_query_available_options = $wpdb->get_results("SELECT* FROM ".$wpdb->prefix."options");
					
					# retrieve all the choosen wp_options for the xml export
					$db_query_choosen_options = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'wp_options'");
					$exported_ids = preg_split("/,/", $db_query_choosen_options);
					
					# check if an option is already listed in the choosen options
					foreach($db_query_available_options as $available_option){
						$op_found = false;
						foreach($exported_ids as $choosen_option){
							if($available_option->option_name == $choosen_option){ $op_found = true; }
						}
						if($op_found == false){
							$av_op.= "<option value='".$available_option->option_name."'>".$available_option->option_name." (".$available_option->option_value.")</option>\n";
						}
					}
					
					foreach($exported_ids as $option_id){
						$ch_op.= "<option value='".$option_id."'>".$option_id." (".get_option($option_id).")</option>\n";
					}
					
					?>
					
				<div class="p2f_left">
					<p><b>available</b></p>
					<select multiple='multiple' name='available_options'  id='available_options' style="width:300px; height:300px;">
						<?php echo $av_op; ?>
					</select>
				</div>
				<div id="p2f_options_middle"
					<input type='button' name='add' id='add' value='>'/><br />
					<input type='button' name='remove' id='remove' value='<'/>
				</div>
				<div class="p2f_left">
					<p><b>choosen</b></p>
					<select multiple='multiple' name='choosen_options' id='choosen_options' style="width:300px; height:300px;">
						<?php echo $ch_op; ?>
					</select>
				</div>
				<div class="clear"></div>
				<br />
				<a href="#" id="resotre_default_wp_options">Restore default options</a>
			
			
            
            <h2>Export additional XML content</h2>
				<p>if you want to add more content to the XML configuration file, you can write it here<br />
                Be aware that the content you write has to be XML valid.</p>
              <?php
				$db_query_xml_export = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'xml_export'");
			?>
				<textarea type="text" name="press2flash_xml_export" id="press2flash_xml_export" class="p2f_textarea" /><?php echo esc_attr($db_query_xml_export); ?></textarea>
                <br />
                <input type="button" value="Validate XML" name="press2flash_xml_export_validate" id="press2flash_xml_export_validate"/>
                <input type="button" value="Save" name="press2flash_xml_export_save" id="press2flash_xml_export_save"/>
                   
            <h2>Tracking code</h2>
				<p>Paste the tracking code provided by your Analytics tool</p>
                <?php
				$db_query_tracking_code = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'tracking_code'");
			?>
				<textarea type="text" name="press2flash_tracking_code" id="press2flash_tracking_code" class="p2f_textarea" /><?php echo esc_attr($db_query_tracking_code); ?></textarea>
                <br />
                <input type="button" value="Save" name="press2flash_tracking_code_save" id="press2flash_tracking_code_save"/>
                
               
			<h2>Fallback Message</h2>
            <?php
				$db_query_fallback_message = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option = 'fallback_message'");
			?>
				<p>The selected options will be exported as soon as the application is called.<br />They contain the Wordpress basics configuration for the website</p>
			<textarea type="text" name="press2flash_fallback_message" id="press2flash_fallback_message" class="p2f_textarea" /><?php echo esc_attr($db_query_fallback_message); ?></textarea><br />
			<input type="button" id="press2flash_fallback_message_save"  name="press2flash_fallback_message_save" value="set"/>
                
                
                </form>
			</div>
            
            
            
            <h2>Upload</h2>
            <p>Choose how Press2Fash should resize the images you uploaded:</p>
			
            <?php
				$db_query_upload = $wpdb->get_results("SELECT press2flash_value, press2flash_option FROM ".$wpdb->prefix."press2flash 
													WHERE press2flash_option = 'upload_thumbnail' 
													OR press2flash_option = 'upload_medium'
													OR press2flash_option = 'upload_large'");
													
				
				foreach ($db_query_upload as $upload_option) {
				switch($upload_option->press2flash_option){
					case "upload_thumbnail":
						$w = get_option("thumbnail_size_w");
						$h = get_option("thumbnail_size_h");
					break;
					case "upload_medium":
						$w = get_option("medium_size_w");
						$h = get_option("medium_size_h");
					break;
					case "upload_large":
						$w = get_option("large_size_w");
						$h = get_option("large_size_h");
					break;
				}
					if($upload_option->press2flash_value == "true"){ $checked = "true";}
					else{ $checked = "false";}
					echo "<div><label><input type='checkbox' checked='".$checked."' class='upload_images_size' id='".$upload_option->press2flash_option."' name='".$upload_option->press2flash_option."' /> ".preg_replace("/_/", " ", $upload_option->press2flash_option)." (".$w." x ".$h.")</label></div>";
				}

			?>
            
                </form>
				<br />
			</div>
            
			</div>
	<?php
				}//End function print_admin_page()
	
	}

} //End Class Press2Flash







if (class_exists("Press2Flash")) {
	$press2flash = new Press2Flash();
}

//Initialize the admin panel
if (!function_exists("Press2Flash_ap")) {
	function Press2Flash_ap() {
		global $press2flash;
		if (!isset($press2flash)) {
			return;
		}
		if (function_exists('add_options_page')) {
			add_menu_page('Press2Flash', 'Press2Flash', 9, basename(__FILE__), array(&$press2flash, 'print_admin_page'));
		}
	}
}

//Actions and Filters	
if (isset($press2flash)) {
	//Actions
	add_action('admin_menu', 'Press2Flash_ap');
	register_activation_hook(__FILE__, array(&$press2flash, 'install'));
	register_deactivation_hook(__FILE__,  array(&$press2flash, 'uninstall'));
	
	add_filter('the_permalink_rss', array(&$press2flash, 'press2flash_update_feed_permalink'));
	
	if(is_admin()){
		wp_enqueue_script('jquery');
		wp_enqueue_script('press2flash_admin_js', WP_PLUGIN_URL . '/press2flash/admin/js/press2flash-admin.js', array('jquery'));
		wp_enqueue_style( 'press2flash_admin_css', WP_PLUGIN_URL . '/press2flash/admin/css/press2flash-admin.css');
		
	}
	
}

?>