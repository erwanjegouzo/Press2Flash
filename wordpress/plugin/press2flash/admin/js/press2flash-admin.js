jQuery(document).ready(function($) {

		/* wp options */
		$("#resotre_default_wp_options").click(function(){
			$.ajax({
				url: plugin_url+"admin/manage-wp-options.php",
				type: "GET",
				async: false,
				data: "wp_options="+default_wp_options,
				success: function(msg){location.reload(true);}
			});
		});
		$('#add').click(function() {
			!$('#available_options option:selected').remove().appendTo('#choosen_options');
			$.ajax({
				url: plugin_url+"admin/manage-wp-options.php",
				type: "GET",
				async: false,
				data: "wp_options="+retrieveOptionsValues(),
				success: function(msg){showMessage(msg);}
			});
		});
		$('#remove').click(function() {
			!$('#choosen_options option:selected').remove().appendTo('#available_options');
			$.ajax({
				url: plugin_url+"admin/manage-wp-options.php",
				type: "GET",
				async: false,
				data: "wp_options="+retrieveOptionsValues(),
				success: function(msg){showMessage(msg);}
			});
		});
		
		/* tracking code */
		$('#press2flash_tracking_code_save').click(function() {
			$.ajax({
			  url: plugin_url+"admin/manage-tracking-code.php",
			  type: "GET",
			  async: false,
			  data: "tracking_code="+$("#press2flash_tracking_code").val(),
			  success: function(msg){showMessage(msg);}
			});
		});
		
		/* custom xml export */
		$('#press2flash_xml_export_save').click(function() {
			$.ajax({
				url: plugin_url+"admin/manage-xml-export.php",
				type: "GET",
				async: false,
				data: "xml_export="+$("#press2flash_xml_export").val(),
				success: function(msg){showMessage(msg);}
			});
		});		
		$('#press2flash_xml_export_validate').click(function() {
			var url = escape(plugin_url+"admin/xml-export-validate.php?xml_export="+$("#press2flash_xml_export").val());
			var url_validate = "http://validator.w3.org/check?uri="+url+"+&charset=%28detect+automatically%29";
			window.open(url_validate,'','scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		});
		
		
		
		/* fallback message */
		$('#press2flash_fallback_message_save').click(function() {
			$.ajax({
				url: plugin_url+"admin/manage-fallback-message.php",
				type: "GET",
				async: false,
				data: "fallback_message="+$("#press2flash_fallback_message").val(),
				success: function(msg){showMessage(msg);}
			});
		});
		
		
		/* upload images */
		$('.upload_images_size').click(function() {
			var values = "";
			$('.upload_images_size').each(function(){
				values+= "&"+$(this).attr("id")+"="+$(this).attr("checked");
			});
			$.ajax({
				url: plugin_url+"admin/manage-upload-sizes.php",
				type: "GET",
				async: false,
				data: values,
				success: function(msg){showMessage(msg);}
			});
		});
		
		
		
		
		function retrieveOptionsValues(){
			var values = $('#choosen_options option');
			var vals = new Array();
			$(values).each(function(e){
				vals.push($(values[e]).val());
			});
			return vals;
		}
	
		function showMessage(msg){
			if(msg != "success" && msg!= "error"){msg = "error";}
			var ScreenH = document.documentElement.scrollTop + 10;
			$("#p2f_"+msg+"_message").css("top", ScreenH+"px")
			$("#p2f_"+msg+"_message").fadeIn(2000, function() {			
				$(this).fadeOut('slow');
			});
		}
	
	});
	
	