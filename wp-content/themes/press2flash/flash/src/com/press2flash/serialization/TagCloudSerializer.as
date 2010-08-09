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
	 * 
	 * @author Erwan Jégouzo
	 * http://codex.wordpress.org/Template_Tags/wp_tag_cloud
	 */
	public class TagCloudSerializer extends Serializer implements ISerialiser
	{
		public var smallest				:int = 8; 
		public var largest				:int = 22;
		public var unit					:String = "pt"; 
		public var number				:int = 45;  
		public var format				:String = "flat";
		public var separator			:String = "n";
		public var orderby				:String = "name"; 
		public var order				:String = "ASC";
		public var tag_exclude			:String = ""; 
		public var tag_include			:String = "";
		public var link					:String = "view"; 
		public var taxonomy				:String = "post_tag";
		public var echo					:Boolean = true;
		
		public function TagCloudSerializer() {}		
		
		public function serialize():String
		{
			var str:String = "";
			
			addParam("smallest", String(smallest));
			addParam("largest", String(largest));
			addParam("unit", unit);
			addParam("number", String(number));
			addParam("format", format);
			addParam("separator", separator);
			addParam("orderby", orderby);
			addParam("order", order);
			addParam("exclude", tag_exclude);
			addParam("include", tag_include);
			addParam("link", link);
			addParam("taxonomy", taxonomy);
			addParam("echo", StringUtils.booleanToString(echo));			
			
			return str;
		}
	}
}