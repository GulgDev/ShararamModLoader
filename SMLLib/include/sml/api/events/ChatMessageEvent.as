import sml.api.Player;
import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.events.ChatMessageEvent extends Event
{
	public var type : String;
	public var from : Player;
	public var text : String;

	public function ChatMessageEvent(from:Player, text:String);

}