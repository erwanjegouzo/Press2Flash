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
 package com.press2flash.text
{
	/**
	 * Several statics methods to play around with String Objects
	 * @author Erwan Jégouzo
	 */

	public class StringUtils 
	{
		
		/**
		 *	search and replace
		 * @param orginal - the string to search in.
		 * @param search - the string to replace
		 * @param replacment - the string to use instead
		 * @return new srting
		 */
		 
		public static function replace(orginal:String, search:String, replacement:String):String
		{
			return orginal.split( search ).join( replacement );
		}
		
		
		public static function toBoolean( p_string:String) :Boolean{
			return (p_string == "true") ? true : false;
		}
		
		public static function booleanToString( p_boolean:Boolean) :String{
			return (p_boolean) ? "true" : "false";
		}

		/**
		* Determines whether the specified string contains any instances of p_char.
		* @param p_string The string.
		* @param p_char The character or sub-string we are looking for.
		* @return Boolean
		*/
		public static function contains(p_string:String, p_char:String):Boolean {
			if (p_string == null) { return false; }
			return p_string.indexOf(p_char) != -1;
		}


		/**
		* Remove's all < and > based tags from a string
		* @param p_string The source string.
		* @return String
		*/
		public static function stripTags(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/<\/?[^>]+>/igm, '');
		}


		/**
		* Removes whitespace from the front and the end of the specified string.
		* @param p_string The String whose beginning and ending whitespace will will be removed.
		* @return String
		*/
		public static function trim(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/^\s+|\s+$/g, '');
		}

		
		/**
		 * formats a String to XML
		 * @param p_string	the String
		 * @return String
		 */
		public static function XMLToText ( p_string:String ) :String {
			p_string = replace(p_string, "<", "&lt;");
			p_string = replace(p_string, ">", "&gt;");
			
			return p_string;
		}
		
		/**
		 * formats a String to XML
		 * @param p_string	The String
		 * @return String
		 */
		public static function textToXML ( p_string:String ) :String {
			p_string = replace(p_string, "&lt;", "<");
			p_string = replace(p_string, "&gt;", ">");
			
			return p_string;
		}
		
		/**
		 * Remove symbols from a string to prevent XML errors
		 * @param	input the String to check
		 * @param   removebreaks true if the breaks should be removed
		 * @return String
		 */
		public static function sanitize(input:String, removebreaks:Boolean = false):String
		{
			var str:String = input.replace(/<\/?[^>]+>/igm, "");
			str = str.replace(/\&lt;\/?[^\&gt;]+\&gt;/igm, "");
			str = StringUtils.replace(str, "<", "");
			str = StringUtils.replace(str, ">", "");
			
			// remove breaks
			if (removebreaks) {
				str = removeBreaks(str);
			}
			
			str = trim(str);
			
			return str;
		}
		
		public static function removeBreaks(input:String):String
		{
			var str:String = input;
			str = str.replace(/\r\n/g, "");
			str = str.replace(/\r/g, "");
			str = str.replace(/\n/g, "");
			
			return str;
		}
		
		
		/**
		 *Returns the given String with the first letter in Uppercase
		 * @param p_string The String
		 * @return String
		 */
		public static function firstLetterUpper ( p_string:String ) :String {
			var str:String = p_string.substring(1, 0);
			var rest:String = p_string.substring(1);
			return (str.toUpperCase()+rest);
			
			return p_string;
		}
		
	}
}