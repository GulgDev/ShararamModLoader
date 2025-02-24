import sml.api.types.Player;
import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.events.ChatMessageEvent extends Event
{
	static public var TYPE : String;
	public var from : Player;
	public var text : String;

	public function ChatMessageEvent(from:Player, text:String);

}