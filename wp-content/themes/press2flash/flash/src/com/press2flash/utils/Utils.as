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
package com.press2flash.utils 
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	/**
	 * Several statics methods
	 * @author  Erwan Jégouzo
	 */
	public class Utils extends Sprite{
		
		public function Utils() {}
		
		/**
		 * Specifies if Application is online
		 * @return true if the runtime Environmment is either ActivX or PlugIn
		 */
		public static function isOnline():Boolean {
			var player:String = Capabilities.playerType;
			var r:Boolean;
			switch(player) {
				case "ActiveX":
					r = true;
				break;
				case "PlugIn":
					r = true;
				break;
				case "External":
					r = false;
				break;				
			}
			return r;
		}
		
		/**
		 * Specifies if Application is running in the external flash player
		 */
		public static function isStandAlone():Boolean {
			if (Capabilities.playerType == "External") {
				return true;
			}
			return false;
		}
		
		/**
		*	If a string has the same structure as a filename (name.ext), this methods returns the extension.
		*	@param s The complete file name
		*	@param completeExtention Indicates if the dot has to be returned.
		*	@return The extension
		*/
		public static function getFileExtension(s:String, completeExtention:Boolean = true):String {
			var extensionIndex:Number = s.lastIndexOf(".");
			var r:String;
			if(extensionIndex == -1) { r = ""; } 
			else {
				if (completeExtention) { 	r = s.substr(extensionIndex, s.length); }
				else { 						r = s.substr(extensionIndex + 1, s.length); }
			}
			
			return r.toLocaleLowerCase();
		}
		
		/**
		*	If a string has the same structure as a filename (name.ext), this methods returns the the file name.
		*	@param s The complete file name
		*	@return The file name
		*/
		public static function getFileName(s:String):String {
			var extensionIndex:Number = s.lastIndexOf(".");
			var r:String;
			if(extensionIndex == -1) { r = s; } 
			else {
				r = s.substr(0, extensionIndex); 
			}
			
			return r;
		}
		
		
		/**
		 * Returns the path associated to a file
		 * @param	s a String corresponding to a path
		 * @return a path
		*/
		public static function extractPath(s:String):String {
			var pathIndex:Number = s.lastIndexOf("/");
			var r:String;
			if(pathIndex == -1) { r = s; } 
			else {
				r = s.substr(0, pathIndex+1); 
			}
			
			return r;
		}
		
		/**
		 * Returns the file contained into a String formated like a path
		 * @param	s a String formated like a path
		 * @return The file name with its extension
		 */
		public static function extractFile(s:String):String {
			var pathIndex:Number = s.lastIndexOf("/");
			var r:String;
			if(pathIndex == -1) { r = s; } 
			else {
				r = s.substr(pathIndex+1, s.length); 
			}
			
			return r;
		}
		
	}
	
}