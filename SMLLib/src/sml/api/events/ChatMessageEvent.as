import sml.api.Player;
import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.ChatMessageEvent extends Event
{
	
	public var type:String = "message";
	
	public var from:Player;
	public var text:String;
	
	public function ChatMessageEvent(from:Player, text:String) 
	{
		this.from = from;
		this.text = text;
	}
	
}