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
 package com.press2flash.serialization 
{
	import com.press2flash.interfaces.ISerialiser;
	import com.press2flash.text.StringUtils;
	/**
	 * Retrieve the content of a single of Wordpress post
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onPostSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onPostError);

// instantiate a new GetPostSerializer.
var post_serializer:GetPostSerializer = new GetPostSerializer();

post_serializer.post_id = 10;
post_serializer.output_customfields = true;
post_serializer.post_type = "post";

// proceed to the request
wp_connection.getPost(post_serializer);</listing>
	 * @author Erwan Jégouzo
	 * 
	 * http://codex.wordpress.org/Function_Reference/wp_nav_menu
	 */
	public class GetMenuSerializer extends Serializer implements ISerialiser
	{
		/** ID of the post in Wordpress to retrieve the respective information */
		public var id		:int = 0;
		
		public var slug		:String = "";
		
		public var menu		:String = "";
		
		
		
		public function GetMenuSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("id", String(id));
			addParam("slug", slug);
			addParam("menu", menu);			
			
			return str;
		}
	}
}