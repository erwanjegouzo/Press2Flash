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
	import Error;
	
	/**
	 * SuperClass for the Serialization objects
	 * @author Erwan Jégouzo
	 */
	public class Serializer
	{
		/** Specifies if the application has to keep the content retrieve in memory.
		 * This is usefull to avoid repetitive queries. */
		public var cache				:Boolean = true;
		
		protected var _misc				:Array = new Array();
		
		public function Serializer() { }
		
		/**
		 * Add a value to send to Wordpress
		 * @param	key parameter name
		 * @param	value parameter value
		 */
		public function addParam(key:String, value:String):void
		{
			_misc[key] = value;
		}
		
		/**
		 * Output all the parameters in a XML format
		 * @return the customfields in XML
		 */
		public function getParams():XML
		{
			var xml:XML = <params></params>
			for (var key:String in _misc) 
			{
				xml.appendChild(<{key}>{CDATA(_misc[key])}</{key}>);
			}
			return xml;
		}
		
		/**
		 * Add a CDATA section to enclose a node content
		 * @param	nodeContent text held in the node
		 * @return a formated XML node with CDATA section
		 */
		public function CDATA(nodeContent:String) : XML
		{
			return new XML("<![CDATA[" + nodeContent + "]]>");
		} 
		
	}

}