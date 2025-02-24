/**
 * ...
 * @author Gulg
 */
class sml.api.events.Event
{
	
	public static var TYPE:String = "event";
	
	public var type:String;
	public var target:Object = null;
	
	public var _preventDefault:Boolean = false;
	
	public function Event(type:String) 
	{
		this.type = type || this.constructor.TYPE;
	}
	
	public function preventDefault():Void 
	{
		_preventDefault = true;
	}
	
}