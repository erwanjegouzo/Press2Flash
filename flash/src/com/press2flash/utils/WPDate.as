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
	/**
	 * Creates a new Date Object
	 * @author Erwan Jégouzo
	 */
	public class WPDate
	{
		public var year			:String;
		public var month		:String;
		public var day			:String;
		
		public var hour			:String;
		public var min			:String;
		public var sec			:String;
		
		/**
		 * Creates a new Date Object
		 * @param	inputTime a wordpres formated date string (ex: 2009-11-17 13:23:11)
		 */
		public function WPDate(inputTime:String) 
		{
			var ar:Array 		= String(inputTime).split(" ");
			var date:String		= ar[0];
			var time:String		= ar[1];
			
			var dateAr:Array	= date.split("-");
			var timeAr:Array	= time.split(":");
			
			year 				= dateAr[0];
			month 				= dateAr[1];
			day 				= dateAr[2];
			
			hour				= timeAr[0];
			min					= timeAr[1];
			sec					= timeAr[2];
			
		}
		
	}

}