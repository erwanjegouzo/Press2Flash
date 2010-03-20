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
	
	/**
	 * Retrieves the comments from a Wordpress page.
	 * This serializer has to be used in combinaison 
	 * with GetPostSerialiser or GetPostsSerialiser
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onCommentSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onCommentError);

// instantiate a new GetCommentsSerializer
var comments_serialiser:GetCommentsSerializer = new GetCommentsSerializer();

// Add the parameters you send to Wordpress
comments_serialiser.post_id = 10;
comments_serialiser.offset = 25;
comments_serialiser.order = "ASC";</listing>
	 * @author Erwan Jégouzo
	 */
	public class GetCommentsSerializer extends Serializer implements ISerialiser
	{
		public static var STATUS_APPROVE	:String = "approve";
		public static var STATUS_HOLD		:String = "hold";
		public static var STATUS_SPAM		:String = "spam";
		
		/** ID of the post in Wordpress to retrieve the respective comments */
		public var post_id				:int 	= 0;
		
		/** Specifies the page status */
		public var status				:String = STATUS_APPROVE;
		/** Specifies how the comments should be ordered */
		public var orderby				:String = "comment_date_gmt";
		/** Order ASC or DESC */
		public var order				:String = "DESC";
		/** Amount of comments returned */
		public var number				:String = "";
		/** Offset */
		public var offset				:int = 0;
		
			
		public function GetCommentsSerializer() {}		
		
		public function serialize():String
		{	
			var str:String = "" +
			" c_status=\"" + status +"\"" +
			" c_orderby=\"" + orderby +"\"" +
			" c_order=\"" + order +"\"" +
			" c_number=\"" + number +"\"" +
			" c_offset=\"" + offset +"\"" +
			" c_post_id=\"" + post_id +"\"";		

			return str;
		}
	}
}
