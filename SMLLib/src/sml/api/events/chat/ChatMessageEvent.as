import sml.api.types.Player;
import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.chat.ChatMessageEvent extends Event
{
	
	public static var TYPE:String = "message";
	
	public var from:Player;
	public var text:String;
	
	public function ChatMessageEvent(from:Player, text:String) 
	{
		this.from = from;
		this.text = text;
	}
	
}