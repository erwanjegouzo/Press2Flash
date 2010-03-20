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
 package com.press2flash.theme
{
	import com.press2flash.events.ServerEvent;
	
	import flash.events.Event;
	import flash.display.Sprite
	
	/**
	 * Superclass for all pages that need to retrieve information from Wordpress
	 * @author Erwan Jégouzo
	 */
	public class WPPage extends Sprite
	{
		public function WPPage(obj:Object = null) {}		
		
		protected function onStageResize(evt:Event = null):void{}
		
		protected function onError(evt:ServerEvent):void{}
		
		public function destroy(obj:Object = null):void{}
		
		
	}

}