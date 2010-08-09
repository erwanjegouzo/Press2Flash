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
 package com.press2flash.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
		
	import com.press2flash.net.ServerConnection;
	import com.press2flash.events.ServerEvent;
	import com.press2flash.events.WPConnectionEvent;
	import com.press2flash.data.CacheManager;
	import com.press2flash.text.StringUtils;
	import com.press2flash.serialization.*;
	
	/**
	 * Receive the information from the serialisers and prepare the query to attack the Wordpres API.
	 * @see com.press2flash.net.ServerConnection
	 * @see com.press2flash.data.CacheManager
	 * @author Erwan Jégouzo
	 */
	
	public class WPConnection
	{
		private var _dispatcher			:EventDispatcher;
		private var _serverConnection	:ServerConnection;
		private var _request			:XML;
		
		private var _cachepost			:Boolean;
		private var _post_id			:int;
		
		public function WPConnection():void
		{
			_dispatcher	= new EventDispatcher();
			
			_serverConnection = new ServerConnection();
			_serverConnection.addEventListener(ServerEvent.COMPLETE, onComplete);
			_serverConnection.addEventListener(ServerEvent.ERROR, onFail);
		}
		
		/**
		 * Call a custom function
		 * @param	obj CustomSerializer object holding the parameters
		 * @param	XMLText true if the post content should be formated as XML
		 */
		public function callCustom(obj:CustomSerializer, XMLText:Boolean=true):void
		{
			_serverConnection.xmlOutput = XMLText;
			_request = 	<press2flash>
							<call {obj.serialize()} />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		public function getTagCloud(obj:TagCloudSerializer):void
		{
			_serverConnection.xmlOutput = true;
			_request = 	<press2flash>
							<call callFunction = "getTagCloud" { obj.serialize() } />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		
		public function getMenu(obj:GetMenuSerializer):void
		{
			_serverConnection.xmlOutput = true;
			_request = 	<press2flash>
							<call callFunction = "getMenu" { obj.serialize() } />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		/**
		 * Get the wordpress configuration
		 * @param	obj GetConfigSerializer object holding the parameters to retrieve from WP
		 */
		public function getConfig(obj:GetConfigSerializer):void
		{
			_serverConnection.xmlOutput = true;
			_request = 	<press2flash>
							<call callFunction = "getConfig" { obj.serialize() } />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		
		/**
		 * Insert a comment into a post
		 * @param	obj InsertCommentSerializer object holding the parameters
		 * @param	XMLText true if the post content should be formated as XML
		 */
		public function insertComment(obj:InsertCommentSerializer, XMLText:Boolean=true):void
		{
			_serverConnection.xmlOutput = XMLText;
			_request = 	<press2flash>
							<call callFunction = "insertComment" { obj.serialize() } />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		/**
		 * Insert a new post in the wordpress database
		 * @param	obj InsertPostSerializer object holding the parameters
		 * @param	XMLText true if the post content should be formated as XML
		 */
		public function insertPost(obj:InsertPostSerializer, XMLText:Boolean=true):void
		{
			_serverConnection.xmlOutput = XMLText;
			_request = 	<press2flash>
							<call callFunction = "insertPost" { obj.serialize() } />
							{obj.getParams()}
							{obj.getCustomFields()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		
		/**
		 * Rate a wordpress post
		 * @param	obj RatePostSerializer object holding the parameters 
		 * @param	XMLText true if the post content should be formated as XML 
		 */
		public function ratePost(obj:RatePostSerializer, XMLText:Boolean=true):void
		{
			_serverConnection.xmlOutput = XMLText;
			_request = 	<press2flash>
							<call callFunction="ratePost" {obj.serialize()} />
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		/**
		 * Retrieve a post lists depending on the parameters
		 * @param	obj GetPostsSerializer object holding the parameters 
		 * @param	XMLText true if the post content should be formated as XML 
		 */
		public function getPosts(obj:GetPostsSerializer, XMLText:Boolean=true):void
		{
			_serverConnection.xmlOutput = XMLText;
			_request = 	<press2flash>
							<call callFunction="getPosts" {obj.serialize()} />
							{obj.getParams()}
						</press2flash>;
			_serverConnection.send(_request);
		}
		
		/**
		 * Retrieve the content of a single post depending on the parameters
		 * @param	obj GetPostSerializer object holding the parameters 
		 * @param	XMLText true if the post content should be formated as XML 
		 */
		public function getPost(obj:GetPostSerializer, XMLText:Boolean=true):void
		{
			_post_id = obj.post_id;
			_cachepost = obj.cache;
			if (CacheManager.isCached(obj.post_id)) {
				_dispatcher.dispatchEvent(new WPConnectionEvent(WPConnectionEvent.COMPLETE, CacheManager.getCache(obj.post_id)));
			}
			
			else{
				_serverConnection.xmlOutput = XMLText;
				_request = 	<press2flash>
								<call callFunction="getPost" {obj.serialize()} />
								{obj.getParams()}
							</press2flash>;
				_serverConnection.send(_request);
			}
		}

		/** @private */
		private function onComplete(event:ServerEvent):void
		{	
			var xml:XML;
			
			if (event.XMLText) {
				var s:String = StringUtils.textToXML(event.data);
				xml = new XML(s);
			}
			else {
				xml = event.data;
			}
			
			if (_cachepost && !CacheManager.isCached(_post_id)) {
				CacheManager.setCache(_post_id, xml);
			}
			
			if (xml.message.@status == "failure"){
				_dispatcher.dispatchEvent(new WPConnectionEvent(WPConnectionEvent.ERROR, xml));
			}
			else{
				_dispatcher.dispatchEvent(new WPConnectionEvent(WPConnectionEvent.COMPLETE, xml));
			}
		}

		/** @private */
		private function onFail(event:ServerEvent):void
		{
			_dispatcher.dispatchEvent(new WPConnectionEvent(WPConnectionEvent.ERROR, event.data));
		}
		
		/** @private */
		public function addEventListener(type:String, listener:Function):void 
		{
	        _dispatcher.addEventListener(type, listener, false, 0, false);
	    }
		
		
	}
	
}