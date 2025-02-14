import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.events.SendChatMessageEvent extends Event
{
	public var type : String;
	public var text : String;

	public function SendChatMessageEvent(text:String);

}