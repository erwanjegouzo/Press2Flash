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
	import flash.events.KeyboardEvent;
	/**
	 * Insert a new post into the Wordpress database
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onPostSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onPostError);

// instantiate a new InsertPostSerializer
var post_serializer:InsertPostSerializer = new InsertPostSerializer();

post_serializer.post_author = "erwan";
post_serializer.post_category = "news";
post_serializer.post_content = "Hi, this is my new post!";

// proceed to the request
wpConnect.insertPost(post_serializer);</listing>
	 * @author Erwan Jégouzo
	 */
	public class InsertPostSerializer extends Serializer implements ISerialiser
	{

		public static const POST_STATUS_PUBLISH 	:String = "publish";
		public static const POST_STATUS_DRAFT 		:String = "draft";
		public static const POST_STATUS_PRIVATE 	:String = "private";
		public static const POST_STATUS_FUTURE 		:String = "future";
		public static const POST_STATUS_PENDING 	:String = "pending";
		public static const POST_STATUS_NEW 		:String = "new";
		
		public static const POST_TYPE_ANY			:String = "any";
		public static const POST_TYPE_POST			:String = "post";
		public static const POST_TYPE_PAGE			:String = "page";
		public static const POST_TYPE_ATTACHMENT	:String = "attachment";
		public static const POST_TYPE_REVISION		:String = "revision";
		public static const POST_TYPE_CUSTOM		:String = "custom";
		
		/** Post content */
		public var post_content				:String = ""; 
		/** Post title */
		public var post_title				:String = ""; 
		/** Post category */
		public var post_category			:String = "";	
		/** Post category */
		public var post_status				:String = POST_STATUS_PUBLISH; 
		/** Post type */
		public var post_type				:String = POST_TYPE_POST;
		/** Post author */
		public var post_author				:String = "";
		/** Author email */
		public var author_email				:String = "";
		
		public var ping_status				:String = ""; 
		/** Post parent*/
		public var post_parent				:String = "0";
		
		public var menu_order				:String = "0";
		
		public var to_ping					:String = "";
		
		public var pinged					:String = "";
		/** Post password */
		public var post_password			:String = "";
		
		public var guid						:String = "";
		
		public var post_content_filtered	:String = "";
		/** Post excerpt */
		public var post_excerpt				:String = "";
		
		public var import_id				:String = "0";
		
		public var tags_input				:String = "";
		
		private var _customFields			:Array = new Array();
		
		
		public function InsertPostSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("post_category", post_category);
			addParam("post_status", post_status);
			addParam("post_type", post_type);
			addParam("post_author", post_author);
			addParam("author_email", author_email);
			addParam("ping_status", ping_status);
			addParam("post_parent", post_parent);
			addParam("menu_order", menu_order);
			addParam("pinged", pinged);
			addParam("post_password", post_password);
			addParam("guid", guid);
			addParam("post_content_filtered", post_content_filtered);
			addParam("import_id", import_id);
			addParam("tags_input", tags_input);
			addParam("post_content", post_content);
			addParam("post_title", post_title);
			addParam("post_excerpt", post_excerpt);
			
			return str;
		}
		
		/**
		 * Add a customfield to the post
		 * @param	key customfield name
		 * @param	value customfield value
		 */
		public function addCustomField(key:String, value:String):void
		{
			_customFields[key] = value;
		}
		
		/**
		 * Output the customfield in a XML format
		 * @return the customfields in XML
		 */
		public function getCustomFields():XML
		{
			var xml:XML = <customfields></customfields>
			for (var key:String in _customFields) {
				xml.appendChild(<{key}>{CDATA(_customFields[key])}</{key}>);
			}
			
			return xml;
		}
		
	}
}