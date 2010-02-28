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
	 * Retrieves the configuration from your Wordpress installation
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onConfigSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onConfigError);

// instantiate a new GetConfigSerializer.
var configSerialiser:GetConfigSerializer = new GetConfigSerializer();

// grab the categories configured in the Wordpress backend
configSerialiser.output_categories = true;
// grab the pages created in the Wordpress backend
configSerialiser.output_pages = true;

// proceed to the request
wpConnect.getConfig(configSerialiser);</listing>
	 * @author Erwan Jégouzo
	 */
	public class GetConfigSerializer extends Serializer implements ISerialiser
	{
		/** output information about the Wordpress categories or not */
		public var output_categories		:Boolean = true;
		/** output information about the Wordpress pages or not */
		public var output_pages				:Boolean = true;
		
		public function GetConfigSerializer() {}		
		
		public function serialize():String
		{
			addParam("output_categories", String(output_categories));
			addParam("output_pages", String(output_pages));
			
			return new String();
		}
	
	}
}