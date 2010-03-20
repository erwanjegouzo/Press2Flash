package 
{
	import com.press2flash.data.WPConfig;
	import com.press2flash.events.WPConnectionEvent;
	import com.press2flash.net.WPConnection;
	import com.press2flash.serialization.GetConfigSerializer;
	import com.press2flash.text.StyledTextField;
	import com.press2flash.text.StyleSheetManager;
	import com.press2flash.utils.Utils;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Erwan Jegouzo
	 */
	
	[Frame(factoryClass = "PreLoader")]
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#ffffff", pageTitle="Press2Flash Hello-world")]
	public class Main extends Sprite 
	{		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align 	= StageAlign.TOP_LEFT;
			
			/** Tell WPConfig where your flash app is located. */
			WPConfig.TEMPLATE_DIRECTORY	= Utils.extractPath(loaderInfo.loaderURL);
			WPConfig.PLUGIN_DIRECTORY	= loaderInfo.parameters.plugin_path;
			
			/** instanciate a new Wordpress connection.*/
			var wpConnect:WPConnection = new WPConnection();
			/** Add the events */
			wpConnect.addEventListener(WPConnectionEvent.COMPLETE, onConfigReceived);
			wpConnect.addEventListener(WPConnectionEvent.ERROR, onConfigError);
			
			/** The first thing you want to retrieve is your wordpress configuration. So let's get it! */
			var configSerialiser:GetConfigSerializer = new GetConfigSerializer();
			/** Give me the categories I created in Wordpress... */
			configSerialiser.output_categories = true;
			/** ...and the pages */
			configSerialiser.output_pages = true;
			/** send the request! */
			wpConnect.getConfig(configSerialiser);
		}

		private function onConfigError(evt:WPConnectionEvent):void
		{
			trace("an error occured");
		}

		private function onConfigReceived(evt:WPConnectionEvent):void
		{
			/** When the configuration has been received, save it using the WPConfig Class */
			var wp_config:WPConfig = new WPConfig(evt.data);
			/** load all your assets */
			loadAssets();
		}

		private function loadAssets():void
		{
			/** in this simple exemple, we just need to load a stylesheet */
			var loader:URLLoader = new URLLoader(new URLRequest(WPConfig.TEMPLATE_URL+"flash.css"));
			loader.addEventListener(Event.COMPLETE, onAssetsLoaded);
		}

		private function onAssetsLoaded(evt:Event):void
		{
			/** Parse the stylesheet to the StyleSheetManager.
			 * We are going to need it to display some text */
			StyleSheetManager.parseStyleSheet(evt.target.data);
			
			/** add a container in which all your content is going to be displayed */
			var container:Container = new Container();
			addChild(container);
			
		}
	}
}