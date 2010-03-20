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
	 * Rate a Wordpress post.
	 * This Serializer can work only if the plugin wp-postratings is installed and active in your wordpress configuration.
	 * wp-postratings Plugin URI: http://lesterchan.net/portfolio/programming/php/
	 * wp-postratings Plugin Version tested: 1.50
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onRateSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onRateError);

// instantiate a new RatePostSerializer
var rate_serializer:RatePostSerializer = new RatePostSerializer();

rate_serializer.post_id = 10;
rate_serializer.rating = 5;

// proceed to the request
wp_connection.ratePost(rate_serializer);</listing>
	 * @author Erwan Jégouzo
	 */
	public class RatePostSerializer extends Serializer implements ISerialiser
	{

		/** Post rating. Maximal value depends on the plugin configuration */
		public var rating			:int = 0;
		/** ID of the post in Wordpress to retrieve the respective comments */
		public var post_id			:int = 0;
		
		public function RatePostSerializer(){}
		
		public function serialize():String
		{
			var str:String = "" +
			" rating=\"" + rating +"\"" +
			" post_id=\"" + post_id +"\"";
			
			return str;
		}
		
	}

}