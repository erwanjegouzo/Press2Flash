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
wpConnect.getPost(post_serializer);</listing>
	 * @author Erwan Jégouzo
	 */
	public class GetPostSerializer extends Serializer implements ISerialiser
	{
		
		public static const POST_TYPE_ANY			:String = "any";
		public static const POST_TYPE_POST			:String = "post";
		public static const POST_TYPE_PAGE			:String = "page";
		public static const POST_TYPE_ATTACHMENT	:String = "attachment";
		public static const POST_TYPE_REVISION		:String = "revision";
		public static const POST_TYPE_CUSTOM		:String = "custom";
		
		
		/** ID of the post in Wordpress to retrieve the respective information */
		public var post_id				:int = 0;
		
		public var post_type			:String = POST_TYPE_ANY;
		
		/** Output the comments for the post or not */
		public var output_comments		:Boolean = false;
		/** Output the categories for the post or not */
		public var output_categories	:Boolean = false;
		/** Output the customfields for the post or not */
		public var output_customfields	:Boolean = false;
		
		/** Specifies what kind of comments have to be displayed */
		public var comments_param		:GetCommentsSerializer;
		
		public function GetPostSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("post_id", String(post_id));
			addParam("post_type", post_type);
			addParam("output_comments", String(output_comments));
			addParam("output_categories", String(output_categories));
			addParam("output_customfields", String(output_customfields));
			
			if (comments_param != null && output_comments) {	
				str+=comments_param.serialize();	
			}
			
			return str;
		}
	}
}