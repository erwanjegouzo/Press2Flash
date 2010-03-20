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
	 * Name of the function to call in the wordpress plugin.<br />
	 * This should be used when the given Serialisers don't 
	 * provide assistance for the action you want to perform.
	 * @example Basic usage:<listing version="3.0">
// instantiate a new WPConnection
var wp_connection:WPConnection = new WPConnection();
wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onWPSuccess);
wp_connection.addEventListener(WPConnectionEvent.ERROR, onWPError);

// instantiate a new CustomSerializer
var custom_serialiser:CustomSerializer = new CustomSerializer();

// Add the parameters you send to Wordpress
custom_serialiser.callFunction = "my_php_function";
custom_serialiser.addParam("my_parameter_1", "My parameter value");
custom_serialiser.addParam("my_parameter_2", "My second parameter value");

// proceed to the request
wp_connection.callCustom(custom_serialiser);</listing>
	 * @author Erwan Jégouzo
	 */
	public class CustomSerializer extends Serializer implements ISerialiser
	{		
		/** Name of the PHP function you want to call */
		public var callFunction	:String = "";
		
		public function CustomSerializer() {}
		
		public function serialize():String
		{
			var str:String = "callFunction='"+callFunction+"'";
			return str;
		}
	}

}
