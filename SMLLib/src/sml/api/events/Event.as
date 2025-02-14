/**
 * ...
 * @author Gulg
 */
class sml.api.events.Event
{
	
	public var type:String = "event";
	public var target:Object = null;
	
	public var _preventDefault:Boolean = false;
	
	public function Event() 
	{
		
	}
	
	public function preventDefault():Void 
	{
		_preventDefault = true;
	}
	
}