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
	 * Util class to retrieve information received from the GetConfigSerializer
	 * @see com.press2flash.serialization.GetConfigSerializer
	 * @author Erwan Jégouzo
	 */
	public class WPConfig
	{
		/** Holds the path to the flash file */
		public static var APP_PATH				:String;
		
		/** Holds wordpress's configuration information */
		public static var WP_CONFIG				:XML = new XML();
		
		public function WPConfig(data:XML) 
		{
			WP_CONFIG = data;
		}
		
		/**
		 * Returns the content of the page node : slug, title and id
		 * @param	pageId the page id
		 * @example <page id="27" title="TV-Spot" slug="tv-spot"/>
		 * 			getPageById(27).page.@slug //trace tv-spot
		 * 			getPageById(27)..@title // trace TV-Spot
		 * @return XML
		 */
		public static function getPageById(pageId:int):XML
		{
			var xml:XML = <root></root>;
			return xml.appendChild(WP_CONFIG..page.(@id == String(pageId)).toXMLString());
		}
		
		/**
		 * Returns the content of the page node : slug, title and id
		 * @param	slugName the slug attribute in the xml
		 * @example <page id="27" title="TV-Spot" slug="tv-spot"/>
		 * 			getPageBySlug("tv-spot").page.@id //trace 27
		 * 			getPageById("tv-spot")..@title // trace TV-Spot
		 * @return XML
		 */
		public static function getPageBySlug(slugName:String):XML
		{
			var xml:XML = <root></root>;
			return xml.appendChild(WP_CONFIG..page.(@slug == slugName).toXMLString());
		}
	
		/**
		 * Returns the content of the category node : slug, title and id
		 * @param	categoryId the category id
		 * @example <category id="1" title="My First Category" slug="my-first-category"/>
		 * 			getCategoryById(1).category.@slug //trace my-first-category
		 * 			getCategoryById(1)..@title // trace 'My First Category'
		 * @return XML
		 */
		public static function getCategoryById(categoryId:int):XML
		{
			var xml:XML = <root></root>;
			return xml.appendChild(WP_CONFIG..category.(@id == String(categoryId)).toXMLString());
		}

		/**
		 * Returns the content of the category node : slug, title and id
		 * @param	slugName the category slug
		 * @example <category id="1" title="My First Category" slug="my-first-category"/>
		 * 			getCategoryBySlug(uncategorized).category.@id //trace 1
		 * 			getCategoryBySlug(uncategorized)..@title // trace 'My First Category'
		 * @return XML
		 */
		public static function getCategoryBySlug(slugName:String):XML
		{
			var xml:XML = <root></root>;
			return xml.appendChild(WP_CONFIG..category.(@slug == slugName).toXMLString());
		}
	
		
		/** Return the Blog Name */
		public static function getBlogName():String { 			return WP_CONFIG.blogname.@value; }
		/** Return the Blog Description */
		public static function getBlogDescription():String { 	return WP_CONFIG.blogdescription.@value; }
		/** Return the Blog URL */
		public static function getSiteURL():String { 			return WP_CONFIG.siteurl.@value; }
		/** Return the first page to show */
		public static function getBlogFirstPage():String { 		return WP_CONFIG.page_on_front.@value; }
		/** Return the categories */
		public static function getCategories():XML { 			return WP_CONFIG.categories; }
		/** Return the amount of posts to display on each page */ 
		public static function getPostsAmountPerPage():int{ 			return Number(WP_CONFIG.posts_per_page.@value); }
	}
}