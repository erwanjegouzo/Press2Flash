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
 package com.press2flash.interfaces 
{
	import flash.events.Event;
	import com.press2flash.events.WPConnectionEvent;
	/**
	 * Interface for template pages
	 * @author Erwan Jégouzo
	 */
	public interface ITemplate 
	{
		function create(evt:WPConnectionEvent = null):void
		function call(obj:Object):void
		function destroy(obj:Object = null):void
	}
	
}