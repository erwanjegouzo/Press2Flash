<?php

session_start();
if (!isset($_SESSION['showFlash'])) { // no session;
	$_SESSION["wp_query"] = $wp_query;
	
	$protocol = strtolower(substr($_SERVER["SERVER_PROTOCOL"],0,5))=="https"?"https":"http";
	$url =  $protocol.'://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	$query_sting = explode(get_option("siteurl")."/", $url);
	$flash_deeplink = (count($query_sting) > 0) ? $query_sting[1] : '';
	$flash_deeplink = str_replace("?", "", $flash_deeplink);
	$flash_deeplink = str_replace("=", "/", $flash_deeplink);
	
	$_SESSION['showFlash'] = $flash_deeplink;
	?>
    
    <script type="text/javascript">
		window.location.href= "<?php echo get_option("siteurl")."/#".$_SESSION['showFlash']; ?>";
	</script>
    
	<?php
}
else{
	$wp_query = $_SESSION["wp_query"];
	unset($_SESSION['showFlash']);
}

require(TEMPLATEPATH . '/plugindeps.php');
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" <?php language_attributes(); ?>>

<head profile="http://gmpg.org/xfn/11">
<meta http-equiv="Content-Type" content="<?php bloginfo('html_type'); ?>; charset=<?php bloginfo('charset'); ?>" />

<title><?php bloginfo('name'); ?> <?php if ( is_single() ) { ?> &raquo; Blog Archive <?php } ?> <?php wp_title(); ?></title>

<link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" media="screen" />
<link rel="alternate" type="application/rss+xml" title="<?php bloginfo('name'); ?> RSS Feed" href="<?php bloginfo('rss2_url'); ?>" />
<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>" />
<script type="text/javascript" src="<?php bloginfo('template_directory'); ?>/js/swfobject.js"></script>
<script type="text/javascript" src="<?php bloginfo('template_directory'); ?>/js/swfaddress.js"></script>
<link rel="SHORTCUT ICON" href="<?php bloginfo('template_directory'); ?>/../favicon.ico" type="image/x-icon" />
<script type="text/javascript">
		
	var params = {};
	params.allowFullScreen = "true";
	params.menu = "false";
	params.bgcolor = "#8b2c55";
	
	var attributes = {};
	attributes.id = "press2flash";
	attributes.name = "press2flash";
	
	var flashVars = {};
	flashVars.plugin_path = "<?php bloginfo('wpurl'); ?>/wp-content/plugins/press2flash/";
	
	swfobject.embedSWF("<?php bloginfo('template_directory'); ?>/flash/press2flash.swf", "flashContainer", "100%", "100%", "9.0.0", "<?php bloginfo('template_directory'); ?>/flash/expressInstall.swf", flashVars, params, attributes);

</script>

<?php wp_head(); ?>
</head>
<body>  

<div id="flashContainer">
		<?php echo press2flash_fallback(); ?>

<div id="header">
		<h1><a href="<?php echo get_option('home'); ?>/"><?php bloginfo('name'); ?></a></h1>
		<h2><?php bloginfo('description'); ?></h2>
</div>

<div id="menu"><ul><?php wp_list_pages('title_li=&depth=1'); ?></ul></div>
