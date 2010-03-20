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
package com.press2flash.data 
{
	/**
	 * Manage the cache 
	 * @see com.press2flash.net.WPConnection
	 * @author Erwan Jégouzo
	 */
	public class CacheManager
	{
		
		private static var CACHE		: Array = new Array();
		
		public function CacheManager(){}
		
		/**
		 * Check if a post has been cached in the application
		 * @param	post_id ID of the post to check
		 * @return Boolean
		 */
		public static function isCached(post_id:int):Boolean
		{
			if (CACHE[String(post_id)] == undefined) { return false; }
			return true;
		}
		
		/**
		 * Returns the post content held in the cache
		 * @param	post_id ID of the post to check
		 * @return XML
		 */
		public static function getCache(post_id:int):XML
		{
			if (CACHE[String(post_id)] == undefined) { return new XML(); }
			return CACHE[String(post_id)];
		}
		
		/**
		 * set the content in the cache for the post, selected by his ID
		 * @param	post_id ID of the post to apply the cache for
		 * @param	content the content to cachee
		 */
		public static function setCache(post_id:int, content:XML):void
		{
			CACHE[String(post_id)] = content;
		}
		
	}

}