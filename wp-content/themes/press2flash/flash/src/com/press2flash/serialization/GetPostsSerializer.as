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
	import com.press2flash.data.WPConfig;
	import com.press2flash.interfaces.ISerialiser;
	/**
	 * Retrieve the content of a list of Wordpress post
	 * http://codex.wordpress.org/Function_Reference/query_posts
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onPostsSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onPostsError);

// instantiate a new GetPostsSerializer
var posts_serializer:GetPostsSerializer = new GetPostsSerializer();

posts_serializer.author_name = "erwan";
posts_serializer.numberposts = 10;
posts_serializer.cat = "news";

// proceed to the request
wp_connection.getPosts(posts_serializer);</listing>
	 * @author Erwan Jégouzo
	 */
	public class GetPostsSerializer extends Serializer implements ISerialiser
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
		/** Specifies the type of the post. Could be : any, post, page, attachment, revision, custom */
		public var post_type				:String = "any";
		
		public var post_status				:String = "publish";
		public var post_mime_type			:String = "";
		public var post__in					:String = "";
		public var post__not_in				:String = "";
		/** Specifies how the posts should be ordered. Accept: post_date, author, title, modified, menu_order, parent, ID, rand */
		public var orderby					:String = "post_date";
		/** Order ASC or DESC */
		public var order					:String = "DESC"; 
		public var author					:String = ""; 
		public var author_name				:String = ""; 
		public var w						:String = ""; 
		public var m						:String = ""; 
		public var y						:String = ""; 
		public var hour						:String = ""; 
		public var month					:String = ""; 
		public var minute					:String = ""; 
		public var second					:String = "";
		public var year						:String = "";
		public var meta_key					:String = "";
		public var meta_value				:String = "";
		public var cat						:String = "";
		public var category__in				:String = "";
		public var category__not_in			:String = "";
		public var category__and			:String = "";
		public var tag						:String = "";
		public var tag__in					:String = "";
		public var tag__not_in				:String = "";
		public var tag__and					:String = "";
		public var tag_slug__in				:String = "";
		public var tag_slug__and			:String = "";
		public var suppress_filters			:String = "";
		public var caller_get_posts			:String = "";
		public var offset					:int 	= 0;
		
		
		/** Amount of post that should be displayed */
		public var numberposts				:int = WPConfig.postsAmountPerPage;
			
		/** Output the customfields for the post or not */
		public var output_customfields		:Boolean = false;
		
		public var output_featured_image	:Boolean = false;
		
		public function GetPostsSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("post_type", post_type);
			addParam("post_status", post_status);
			addParam("post_mime_type", post_mime_type);
			addParam("post__in", post__in);
			addParam("post__not_in", post__not_in);
			addParam("orderby", orderby);
			addParam("order", order);
			addParam("author", author);
			addParam("author_name", author_name);
			addParam("w", w);
			addParam("m", m);
			addParam("y", y);
			addParam("hour", hour);
			addParam("month", month);
			addParam("minute", minute);
			addParam("second", second);
			addParam("year", year);
			addParam("meta_key", meta_key);
			addParam("meta_value", meta_value);
			addParam("cat", cat);
			addParam("category__in", category__in);
			addParam("category__not_in", category__not_in);
			addParam("category__and", category__and);
			addParam("tag", tag);
			addParam("tag__in", tag__in);
			addParam("tag__not_in", tag__not_in);
			addParam("tag__and", tag__and);
			addParam("tag_slug__in", tag_slug__in);
			addParam("tag_slug__and", tag_slug__and);
			addParam("suppress_filters", suppress_filters);
			addParam("caller_get_posts", caller_get_posts);
			addParam("offset", String(offset));
			addParam("output_customfields", String(output_customfields));
			addParam("output_featured_image", String(output_featured_image));
			addParam("numberposts", String(numberposts));
			
			return str;
		}
	}
}