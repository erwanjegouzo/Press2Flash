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
	 * Insert a new comment into a specific Wordpress post
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onCommentSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onCommentError);

// instantiate a new InsertCommentSerializer
var com_serializer:InsertCommentSerializer = new InsertCommentSerializer();

com_serializer.comment_post_ID = 10;
com_serializer.comment_author = "Erwan";
com_serializer.comment_content = "this is my great comment!";

// proceed to the request
wp_connection.insertComment(com_serializer);</listing>
	 * @author Erwan Jégouzo
	 */
	public class InsertCommentSerializer extends Serializer implements ISerialiser
	{	
		/** ID of the post in Wordpress to insert the comment */
		public var comment_post_ID			:int; 
		
		/** The authors name of the comment  */
		public var comment_author			:String = "";
		/** The authors email of the comment  */
		public var comment_author_email		:String = "";
		/** The authors URL of the comment  */
		public var comment_author_url		:String = "";
		/** Content of the comment  */
		public var comment_content			:String = ""; 
		
		public var comment_type				:String = ""; ///////////
		/** ID of the comments parent */
		public var comment_parent			:int 	= 0;
		
		public var user_ID					:int 	= 1;
		/**@private The authors IP. This will be set in the plugin */		
		public var comment_author_IP		:String = ""; 
		/**@private The authors user agent information. This will be set in the plugin */
		public var comment_agent			:String = ""; 
		/**@private Date of the comment. This will be set in the plugin */
		public var comment_date				:String = "";
		/**@private Date GMT of the comment. This will be set in the plugin */
		public var comment_date_gmt			:String = ""; 
		
		public var comment_approved			:int = 1; 
	
		
		public function InsertCommentSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("comment_post_ID", 	String(comment_post_ID));
			addParam("comment_author", 		comment_author);
			addParam("comment_author_email",comment_author_email);
			addParam("comment_author_url", 	comment_author_url);
			addParam("comment_content", 	comment_content);
			addParam("comment_type", 		comment_type);
			addParam("comment_parent", 		String(comment_parent));
			addParam("user_ID", 			String(user_ID));
			addParam("comment_approved", 	String(comment_approved));
			
			return str;
		}
		
	}
}