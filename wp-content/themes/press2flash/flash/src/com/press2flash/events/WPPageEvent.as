﻿ /*
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
 package com.press2flash.events 
{
	import flash.events.Event;
	/**
	 * Events triggered by WPPage when creating or removing a template page
	 * @author Erwan Jégouzo
	 */
	public class WPPageEvent extends Event
	{
		public static const ERROR			:String = 'single error';
		public static const READY			:String = 'single ready';
		public static const REMOVED			:String = 'single removed';
		
		public function WPPageEvent(type:String)
		{
			super(type);
        }

		override public function clone():Event 
		{
			return new WPPageEvent(type);
		}
		
	}

}