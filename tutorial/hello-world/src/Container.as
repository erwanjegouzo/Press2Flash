package  
{
	import com.press2flash.data.WPConfig;
	import com.press2flash.events.WPConnectionEvent;
	import com.press2flash.interfaces.ITemplate;
	import com.press2flash.net.WPConnection;
	import com.press2flash.serialization.GetPostSerializer;
	import com.press2flash.text.StyledTextField;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Erwan Jegouzo
	 */
	public class Container extends Sprite
	{
		[Embed(source = '../lib/fonts.swf', fontFamily = 'Arial')]
		private var Arial:Class;
		
		public function Container() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/** instanciate a new Wordpress connection.*/
			var wp_connection:WPConnection = new WPConnection();
			/** add the events */
			wp_connection.addEventListener(WPConnectionEvent.COMPLETE, onPostReceived);
			wp_connection.addEventListener(WPConnectionEvent.ERROR, onPostError);

			/** This will provide some variables that you can fill to build the request */
			var post_serializer:GetPostSerializer = new GetPostSerializer();
			/** this means: give me the wordpress post that has the ID 1 */
			post_serializer.post_id = 1;
			/** show the associated custom fields */
			post_serializer.output_customfields = true;
			/** the post has to be a post (meaning not a page, attachment or revision) */
			post_serializer.post_type = "post";

			/** proceed to the request */
			wp_connection.getPost(post_serializer);
		}

		private function onPostReceived(evt:WPConnectionEvent):void
		{
			/** When the XML sent from the backend has been received, you can retrieve the content this way: */
			var wp_content:XML = evt.data;
			
			/** Use the StyledTextField Class to easily create a textfield with CSS support */
			var post_title:StyledTextField = new StyledTextField("<h1>" + wp_content.post_title + "</h1>", { embedFonts:false } );
			post_title.x = 20;
			post_title.y = 20;
			addChild(post_title);
			
			var post_content:StyledTextField = new StyledTextField("<p>" + wp_content.post_content + "</p>", { embedFonts:false } );
			post_content.x = 20;
			post_content.y = post_title.y + post_title.height + 10;
			addChild(post_content);
			
			/** Set the browser title using SWFAddress */
			SWFAddress.setTitle(WPConfig.blogName + " - " + wp_content.post_title);
		}

		private function onPostError(evt:WPConnectionEvent):void
		{
			trace("the post has not been found");
		}
	}

}