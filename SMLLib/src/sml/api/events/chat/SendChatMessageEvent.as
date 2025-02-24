import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.chat.SendChatMessageEvent extends Event
{
	
	public static var TYPE:String = "sendmessage";
	
	public var text:String;
	
	public function SendChatMessageEvent(text:String) 
	{
		this.text = text;
	}
	
}