import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.SendChatMessageEvent extends Event
{
	
	public var type:String = "sendmessage";
	
	public var text:String;
	
	public function SendChatMessageEvent(text:String) 
	{
		this.text = text;
	}
	
}