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
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	/**
	 * Load and parse an external Stylesheet
	 * @example Basic usage:<listing version="3.0">
	 * </listing>
	 * @author  Erwan Jégouzo
	 */
	public class StyleSheetManager 
	{
		
		public static var 	S_SHEET			:StyleSheet;
		/** @private */
		private static var 	LOADER			:URLLoader;
		/** @private */
		private static var 	INST			:StyleSheetManager;
		
		public function StyleSheetManager():void 
		{
			S_SHEET = new StyleSheet();
		}
		
		public static function loadStyleSheet(s:String):void 
		{
			var req:URLRequest = new URLRequest(s);

			LOADER = new URLLoader();
			LOADER.addEventListener(Event.COMPLETE, (INST as StyleSheetManager).onCSSFileLoaded);
			LOADER.load(req);
		}


		public static function parseStyleSheet(s:String):void 
		{
			if (S_SHEET == null) { S_SHEET = new StyleSheet(); }
			S_SHEET.parseCSS(s);
		}
		
		public function onCSSFileLoaded(event:Event):void 
		
		{
			S_SHEET.parseCSS(LOADER.data);
		}
		
		/*/////////////////////////////////////////////////////
		 * 
		 * PUBLIC FUNCTIONS
		 * 
		 *///////////////////////////////////////////////////// 
		
		public static function getStyle():StyleSheet 
		{
			return S_SHEET;
		}
		
		public static function getTextFormat(tag:String):TextFormat 
		{
			var cssFormat:TextFormat = new TextFormat();
			var style:Object = S_SHEET.getStyle(tag);
			cssFormat = S_SHEET.transform(style);
			return cssFormat;
		}

	}
	
}