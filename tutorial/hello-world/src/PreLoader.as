package  
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Erwan Jégouzo
	 */
	public class PreLoader extends MovieClip
	{

		public function PreLoader() 
		{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
 
		/*
		 * Handle the loading progress
		 */
		public function onEnterFrame(event:Event):void {
			if(framesLoaded == totalFrames) {
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				applicationLoaded();
				
			}
		}
		
		private function applicationLoaded():void {
			var mainClass:Class = Class(getDefinitionByName("Main"));
			var app:Object = new mainClass();
			addChildAt(app as DisplayObject,0);
		}
	}
}