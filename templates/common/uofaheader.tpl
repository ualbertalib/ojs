<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" 2>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>University of Alberta - Journal Hosting</title>
	<meta value=test name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}

	<link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="{$baseUrl}/styles/custom.css" type="text/css" />

	<link rel="stylesheet" href="{$baseUrl}/styles/nivo-slider.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="{$baseUrl}/styles/nivo-default.css" type="text/css" media="screen" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
	<script src="{$baseUrl}/js/uofa/jquery.nivo.slider.pack.js" type="text/javascript"></script>
		<script type="text/javascript" src="{$baseUrl}/js/uofa/fontController.js"></script>
	<script type="text/javascript">{literal}
	$(window).load(function() {
	    $('#slider').nivoSlider({
	 		effect:'fade',
	 		pauseTime: 6000,
	 		animSpeed: 400,
		 	directionNav: true, 
		    directionNavHide: false
		});
	});
		{/literal}</script>
	<script type="text/javascript">{literal}
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
		});
	{/literal}</script>

	<script type="text/javascript">
        // initialise plugins
		{literal}
        $(function(){
        	{/literal}{if $validateId}{literal}
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			$("form[name={/literal}{$validateId}{literal}]").validate({
				errorClass: "error",
				highlight: function(element, errorClass) {
					$(element).parent().parent().addClass(errorClass);
				},
				unhighlight: function(element, errorClass) {
					$(element).parent().parent().removeClass(errorClass);
				}
			});
			{/literal}{/if}{literal}
		});
		{/literal}
	</script>

	{$additionalHeadData}
</head>
<body>
<div id="container">

<div id="header">
	<a href="http://www.ualberta.ca"><img src="{$baseUrl}/templates/images/custom/logo.jpg" alt="uofa logo"></a><div id="uanav">
		        	<ul>
		        		<li><a href="http://webapps.srv.ualberta.ca/search/">Find a Person</a></li>
		            	<li><a href="https://www.myonecard.ualberta.ca/">ONEcard</a></li>
		            	<li><a href="https://www.beartracks.ualberta.ca/">Bear Tracks</a></li>
						<li><a href="https://webmail.ualberta.ca/">Webmail</a></li>
		            	<li><a href="http://apps.ualberta.ca/">Apps@UAlberta</a></li>
		            	<li><a href="https://eclass.srv.ualberta.ca/portal/">eClass</a></li>
		            	<li><a href="http://www.library.ualberta.ca/" class="last">Libraries</a></li>
		        	</ul>
		        </div>
<div id="headerTitle">
	<h1>
		<span>Libraries</span> Journal Hosting
	</h1>
</div>
</div>

{include file="common/navbar.tpl"}