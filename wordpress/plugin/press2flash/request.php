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
 
include("controller.php");
include("utils.php");

$dom;


function press2flash_ratePost($xml)
{
	global $wpdb;
	global $dom;
	
	$post_id = (string)sanitize($xml->call['post_id']);
	$rating = (string)sanitize($xml->call['rating']);
	
	$res = process_ratings($rating, $post_id);
	
	if($res == "user already rated this post"){
		createFailMessage('user already rated this post');
		exit();
	}
	else{
		createSuccessMessage(the_ratings_results($post_id));
		exit();
	}
}
	


function press2flash_insertComment($xml)
{
	global $wpdb;
	global $dom;
	
	$comment = array( 
	'comment_post_ID' 			=> (int)sanitize($xml->params->comment_post_ID),
	'comment_author' 			=> (string)sanitize($xml->params->comment_author),
	'comment_author_email' 		=> (string)sanitize($xml->params->comment_author_email),
	'comment_author_url' 		=> (string)sanitize($xml->params->comment_author_url), 
	'comment_content' 			=> (string)sanitize($xml->params->comment_content),
	'comment_type' 				=> (string)sanitize($xml->params->comment_type),
	'comment_parent' 			=> (int)sanitize($xml->params->comment_parent),
	'user_ID' 					=> (int)sanitize($xml->params->user_ID),
	'comment_approved' 			=> (int)sanitize($xml->params->comment_approved),
	'comment_author_IP' 		=> $_SERVER['REMOTE_ADDR'],
	'comment_agent' 			=> $_SERVER['HTTP_USER_AGENT']
	);

	$post_id = wp_insert_comment($comment);
	
	if ( $post_id != 0 ){
		
		$output = new DomDocument('1.0', 'utf-8');
		$posts = $output->createElement('wp_content');
		
		$content = $output->createElement('post');
		$content->setAttribute("status", "OK");
		$content->setAttribute("id", $post_id);
		
		$output->appendChild($posts);
		$posts->appendChild($content);
		$outputString = $output->saveXML();
		print $outputString;	
	}
	
	else{createFailMessage('Post could not be insert');}
}


function press2flash_insertPost($xml)
{
	require_once(ABSPATH . WPINC . '/registration.php');
	
	global $wpdb;
	global $dom;
	
	$user_name 	= sanitize($xml->params->post_author);
	$user_email = sanitize($xml->params->author_email);

	$random_password = wp_generate_password( 12, false );
	$user_id = wp_create_user( $user_name, $random_password, $user_email );

	$post = array( 
	'post_content' 			=> (string)sanitize($xml->params->post_content), 
	'post_title' 			=> (string)sanitize($xml->params->post_title), 
	'post_category' 		=> array((int)sanitize($xml->params->post_category)),	
	'post_status' 			=> (string)sanitize($xml->params->post_status), 
	'post_type' 			=> (string)sanitize($xml->params->post_type),
	'post_author' 			=> $user_id,
	'ping_status' 			=> (string)sanitize($xml->params->ping_status), 
	'post_parent' 			=> (int)sanitize($xml->params->post_parent),
	'menu_order' 			=> (int)sanitize($xml->params->menu_order),
	'to_ping' 				=> (string)sanitize($xml->params->to_ping),
	'pinged' 				=> (string)sanitize($xml->params->pinged),
	'post_password' 		=> (string)sanitize($xml->params->post_password),
	'guid' 					=> (string)sanitize($xml->params->guid),
	'post_content_filtered' => (string)sanitize($xml->params->post_content_filtered),
	'post_excerpt' 			=> (string)sanitize($xml->params->post_excerpt),
	'import_id' 			=> (int)sanitize($xml->params->import_id),
	'tags_input' 			=> (string)sanitize($xml->params->tags_input)
	
	);
		
	$post_id = wp_insert_post($post);
	
	if ( $post_id != 0 ){
		
		foreach ($xml->customfields->children() as $customfield => $value) {
			if($customfield != ""){
				update_post_meta($post_id, $customfield, $value);
			}
		}
						
		$output = new DomDocument('1.0', 'utf-8');
		$posts = $output->createElement('wp_content');
		
		$content = $output->createElement('post');
		$content->setAttribute("status", "OK");
		$content->setAttribute("id", $post_id);
		
		$output->appendChild($posts);
		$posts->appendChild($content);
		$outputString = $output->saveXML();
		print $outputString;		
	
	}
	else{createFailMessage('Post could not be insert');}
}



function press2flash_getPosts($xml)
{
	global $dom;
	global $wpdb;
	
	$output_customfields 	= (boolean)sanitize($xml->params->output_customfields);
	$output_categories		= true;
	
	$args = array(
		'post_type'			=> (string)sanitize($xml->params->post_type), 
		'post_status' 		=> (string)sanitize($xml->params->post_status),
		'post_parent' 		=> (int)sanitize($xml->params->post_parent),
		'post_mime_type' 	=> (string)sanitize($xml->params->post_mime_type),
		'post__in' 			=> (string)sanitize($xml->params->post__in),
		'post__not_in' 		=> (string)sanitize($xml->params->post__not_in),
		'order' 			=> (string)sanitize($xml->params->order),
		'orderby' 			=> (string)sanitize($xml->params->orderby),
		'author' 			=> (string)sanitize($xml->params->author),
		'author_name' 		=> (string)sanitize($xml->params->author_name),
		'w' 				=> (string)sanitize($xml->params->w),
		'm' 				=> (string)sanitize($xml->params->m),
		'month' 			=> (string)sanitize($xml->params->month),
		'year' 				=> (string)sanitize($xml->params->year),
		'y' 				=> (string)sanitize($xml->params->y),
		'meta_key' 			=> (string)sanitize($xml->params->meta_key),
		'meta_value' 		=> (string)sanitize($xml->params->meta_value),
		'cat' 				=> (string)sanitize($xml->params->cat),
		'category__in' 		=> (string)sanitize($xml->params->category__in),
		'category__not_in' 	=> (string)sanitize($xml->params->category__not_in),
		'category__and' 	=> (string)sanitize($xml->params->category__and),
		'tag__in' 			=> (string)sanitize($xml->params->tag__in),
		'tag__not_in' 		=> (string)sanitize($xml->params->tag__not_in),
		'tag__and' 			=> (string)sanitize($xml->params->tag__and),
		'tag_slug__in' 		=> (string)sanitize($xml->params->tag_slug__in),
		'tag_slug__and' 	=> (string)sanitize($xml->params->tag_slug__and),
		'hour' 				=> (string)sanitize($xml->params->hour),
		'minute' 			=> (string)sanitize($xml->params->minute),
		'second' 			=> (string)sanitize($xml->params->second),
		'suppress_filters' 	=> (int)sanitize($xml->params->suppress_filters),
		'caller_get_posts' 	=> (int)sanitize($xml->params->caller_get_posts),
		'offset' 			=> (int)sanitize($xml->params->offset),
		'numberposts' 		=> (int)sanitize($xml->params->numberposts)
	);
	
	
	$postsContent = get_posts($args);
	
	
	$dom = new DOMDocument('1.0');
	$posts = $dom->createElement('posts');
	$dom->appendChild($posts);
	
	$count = count($postsContent);
	for($i = 0; $i < $count; $i++)
	{
		$post 		= $dom->createElement('post');
		$post_id 	= $postsContent[$i]->ID;
		$posts_info = $postsContent[$i];
		$wp_content = array_to_xml($posts_info, "wp_content");
		$post->appendChild($wp_content);
		
		# output customfields
		if($output_customfields){
			$customfieldsAr = get_post_custom($post_id);
			$customfields = $dom->createElement('customfields');
			foreach ( $customfieldsAr as $key => $value ){
				$customfield = $dom->createElement($key, $value[0]);
				$customfields->appendChild($customfield);
			}
			$wp_content->appendChild($customfields);
		}
		
		# output the categories
		if($output_categories){
			$categoriesAr = get_the_category($post_id);
			$categories = $dom->createElement('categories');
			foreach ( $categoriesAr as $key => $value ){
				$category = $dom->createElement("category", $value->name);
				$category->setAttribute("id", $value->term_id);
				$categories->appendChild($category);
			}
			$wp_content->appendChild($categories);
		}
		
		
		#output author name
		$user_info = get_userdata($posts_info->post_author);
		$author_name = $dom->createElement('author_name', ucfirst($user_info->display_name));
		$wp_content->appendChild($author_name);

		$posts->appendChild($post);
		
	}
	
	$wp_nodes = $dom->documentElement;
	$wp_posts = $wp_nodes->getElementsByTagName('post');

	foreach ( $wp_posts as $domElement ) {
		$child = $domElement->getElementsByTagName('wp_content')->item(0);
		$child->removeChild($child->getElementsByTagName('post_mime_type')->item(0));
		$child->removeChild($child->getElementsByTagName('ping_status')->item(0));
		$child->removeChild($child->getElementsByTagName('post_password')->item(0));
		$child->removeChild($child->getElementsByTagName('to_ping')->item(0));
		$child->removeChild($child->getElementsByTagName('pinged')->item(0));
		$child->removeChild($child->getElementsByTagName('post_modified')->item(0));
		$child->removeChild($child->getElementsByTagName('post_modified_gmt')->item(0));
		$child->removeChild($child->getElementsByTagName('post_content_filtered')->item(0));
		$child->removeChild($child->getElementsByTagName('post_parent')->item(0));
		$child->removeChild($child->getElementsByTagName('menu_order')->item(0));
		$child->removeChild($child->getElementsByTagName('post_status')->item(0));
		$child->removeChild($child->getElementsByTagName('post_type')->item(0));
		$child->removeChild($child->getElementsByTagName('post_excerpt')->item(0));
	}
	
	$outputString = $dom->saveXML();
	print $outputString;
}

function press2flash_getPost($xml)
{
	global $wpdb;
	global $dom;
	
	$post_id 				= (int)sanitize($xml->params->post_id);
	$post_type		 		= (string)sanitize($xml->params->post_type);
	$output_comments 		= (string)sanitize($xml->params->output_comments);
	$output_categories 		= (string)sanitize($xml->params->output_categories);
	$output_customfields 	= (string)sanitize($xml->params->output_customfields);
	
	$db_query = get_post($post_id);
	
	if($post_type != "any" && $db_query->post_type != $post_type)
	{
		createFailMessage('Post [id: '.$post_id.'] Not Found'); 
		exit();
	}
	
	
	if ( !$db_query ){createFailMessage('Post [id: '.$post_id.'] Not Found'); exit();}
	
	$dom = new DOMDocument('1.0');
	
	$wp_content = array_to_xml($db_query, "wp_content");
	$dom->appendChild($wp_content);
	
	#output comments
	if($output_comments == "true"){
		$commentsParam = array( 
			'status' 	=> (string)sanitize($xml->call['c_status']),
			'orderby' 	=> (string)sanitize($xml->call['c_orderby']),
			'order' 	=> (string)sanitize($xml->call['c_order']),
			'number' 	=> (string)sanitize($xml->call['c_number']),
			'offset' 	=> (int)sanitize($xml->call['c_offset']),
			'post_id' 	=> (int)sanitize($xml->call['c_post_id'])
		);
		
		$commentsAr = get_comments($commentsParam);
		if(count($commentsAr) > 0){
			$wp_comments = $dom->createElement("comments");
			$wp_content->appendChild($wp_comments);
			
			for($i = 0; $i < count($commentsAr); $i++){
				$comments = array_to_xml($commentsAr[$i], "comment");
				$wp_comments->appendChild($comments);
			}
		}
	}
	
	# output customfields
	if($output_customfields == "true"){
		$customfieldsAr = get_post_custom($post_id);
		$customfields = $dom->createElement('customfields');
		foreach ( $customfieldsAr as $key => $value ){
			$customfield = $dom->createElement($key, $value[0]);
			$customfields->appendChild($customfield);
		}
		$wp_content->appendChild($customfields);
	}
	
	# output the categories
	if($output_categories == "true"){
		$categoriesAr = get_the_category($post_id);
		$categories = $dom->createElement('categories');
		foreach ( $categoriesAr as $key => $value ){
			$category = $dom->createElement("category", $value->name);
			$category->setAttribute("id", $value->term_id);
			$categories->appendChild($category);
		}
		$wp_content->appendChild($categories);
	}
	
	#output author name
	$user_info = get_userdata($db_query->post_author);
	$author_name = $dom->createElement('author_name', ucfirst($user_info->display_name));
	$wp_content->appendChild($author_name);

	
	#output rating
	if (function_exists('the_ratings_results')) {
		$rating_info = get_userdata($db_query->post_author);
		$rating = $dom->createElement('rating', the_ratings_results($post_id));
		$wp_content->appendChild($rating);
	}
	
	// remove Tags
	$wp_nodes = $dom->documentElement;
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_mime_type')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('ping_status')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_password')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('to_ping')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('pinged')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_modified')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_modified_gmt')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_content_filtered')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_parent')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('menu_order')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_type')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_status')->item(0));
	$wp_nodes->removeChild($wp_nodes->getElementsByTagName('post_excerpt')->item(0));

	$outputString = $dom->saveXML();
	print $outputString;
}



function press2flash_getConfig($xml)
{
	global $wpdb;
	
	$output_pages = (string)sanitize($xml->params->output_pages);
	$output_categories = (string)sanitize($xml->params->output_categories);
	
	# get the wp_options	
	$db_query = $wpdb->get_results("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option='wp_options'");
	
	$options =  preg_split("/,/", $db_query[0]->press2flash_value);
	
	
	$output = new DomDocument('1.0', 'utf-8');
	$posts = $output->createElement('config');
	
	$posts->setAttribute("status", "OK");		
	$output->appendChild($posts);
	
	foreach ($options as $op => $value) {
		$post = $output->createElement($value);
		$post->setAttribute("value", get_option($options[$op]));
		$posts->appendChild($post);	
	}

	
	
	# get the categories
	if($output_categories == "true"){
	
		$db_query = $wpdb->get_results("SELECT wp_terms.term_id, wp_terms.slug, wp_terms.name FROM wp_terms, wp_term_taxonomy WHERE wp_terms.term_id = wp_term_taxonomy.term_id AND wp_term_taxonomy.taxonomy = 'category'");
			
		$categories = $output->createElement('categories');
		$posts->appendChild($categories);
		
		$count = count($db_query);
		for($i = 0; $i < $count; $i++ ){
			$category = $output->createElement('category', $db_query[$i]->name);	
			$category->setAttribute("id", $db_query[$i]->term_id);
			$category->setAttribute("slug", $db_query[$i]->slug);
			$categories->appendChild($category);	
		}
	
	}
	
	# get pages information
	if($output_pages == "true"){
		$db_query = $wpdb->get_results("SELECT id, post_title, post_name FROM wp_posts WHERE post_status='publish' AND post_type ='page'");
		
		$pages = $output->createElement('pages');
		$posts->appendChild($pages);
		
		$count = count($db_query);
		for($i = 0; $i < $count; $i++ ){	
			$page = $output->createElement('page');	
			$page->setAttribute("id", 	$db_query[$i]->id);
			$page->setAttribute("title",$db_query[$i]->post_title);
			$page->setAttribute("slug", $db_query[$i]->post_name);
			$pages->appendChild($page);	
		}
	}
	
	# get the xml export from the plugin page
	$xml_export = $wpdb->get_var("SELECT press2flash_value FROM ".$wpdb->prefix."press2flash WHERE press2flash_option='xml_export'");
	$custom_export = $output->createElement('custom', html_entity_decode($xml_export));
	$posts->appendChild($custom_export);
	
	$outputString = $output->saveXML();
	print $outputString;
}



function array_to_xml($aArr, $sName, &$item = null) {
	global $dom;
	
	if (is_null($item))
		$item = $dom->createElement($sName);
	
		// Loop thru each element
		foreach ($aArr as $key => $val) {
		if (is_array($val)) {
			//
			$sub = $dom->createElement($key);
			$item->appendChild($sub);
			array_to_xml($val, $key, $sub);
		} 
		else {
			// Add this item
			$sub = $dom->createElement($key, $val);
			$item->appendChild($sub);
		}
	}
	return $item;
}


function sanitize($input){
	$san = strip_tags($input);
	$san = htmlspecialchars($san);
	return $san;
}


?>