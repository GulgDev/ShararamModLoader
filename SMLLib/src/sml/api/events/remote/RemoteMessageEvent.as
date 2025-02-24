import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.remote.RemoteMessageEvent extends Event
{
	
	public var args:Array;
	
	public function RemoteMessageEvent(args:Array) 
	{
		this.args = args;
	}
	
}