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
	import flash.display.*;
	import flash.text.*;
	
	/**
	 * TextField that automaticly applies a stylesheet.
	 * @author Erwan Jégouzo
	 */
	public class StyledTextField extends Sprite
	{
		/** TextField instance which the styles is applied */
		private var _inst			:TextField;
	
		/**
		 * Add a formated textField
		 * @param	text String to write into the text field
		 */
		public function StyledTextField(inputText:String = "", obj:Object = null) 
		{
			if (obj == null) { obj = new Object(); }
			
			_inst 				= new TextField();
			_inst.selectable 	= (obj.selectable != undefined) ? obj.selectable : false;
			_inst.embedFonts 	= (obj.embedFonts != undefined) ? obj.embedFonts : true;
			_inst.border		= (obj.border != undefined) ? obj.border : false;
			_inst.borderColor	= (obj.borderColor != undefined) ? obj.borderColor : 0xffffff;
			_inst.multiline		= (obj.multiline != undefined) ? obj.multiline : true;
			_inst.wordWrap		= (obj.wordWrap != undefined) ? obj.wordWrap : false;
			switch(obj.type) {
				case "input":	_inst.type	= TextFieldType.INPUT;
				break;
				default:		_inst.type	= TextFieldType.DYNAMIC;
				break;
			}
			
			if (obj.width != undefined) {
				_inst.width		= obj.width;
				_inst.wordWrap	= true;
			}
			
			switch(obj.autoSize) {
				case "center":	_inst.autoSize	= TextFieldAutoSize.CENTER;
				break;
				case "none":	_inst.autoSize	= TextFieldAutoSize.NONE;
				break;
				case "right":	_inst.autoSize	= TextFieldAutoSize.RIGHT;
				break;
				default:		_inst.autoSize	= TextFieldAutoSize.LEFT;
				break;
				
			}
			
			_inst.styleSheet 	= StyleSheetManager.getStyle();
			_inst.antiAliasType = AntiAliasType.ADVANCED;
			
			if (inputText != "") 
			{
				_inst.htmlText = inputText;
			}
			
			addChild(_inst);
		}
		
		/**
		 * Writes the text into the textField. The text has to be html formated.
		 */
		public function set text(value:String):void { _inst.text = value; }
		public function get text():String { return _inst.text; }
		
		public function set htmlText(value:String):void { _inst.htmlText = value;}
		public function get htmlText():String { return _inst.htmlText; }
	}
	
}