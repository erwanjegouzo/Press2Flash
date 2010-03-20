<?php require(TEMPLATEPATH . '/plugindeps.php'); ?>
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
		
	var params = {"allowFullScreen":"true"};
	params.menu = "false";
	params.bgcolor = "#8b2c55";
	
	var attributes = {};
	attributes.id = "index";
	attributes.name = "index";
	
	swfobject.embedSWF("<?php bloginfo('template_directory'); ?>/flash/main.swf", "flashContainer", "100%", "100%", "9.0.0", "<?php bloginfo('template_directory'); ?>/flash/expressInstall.swf", {}, params, attributes);

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
