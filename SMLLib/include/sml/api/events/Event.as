/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.events.Event
{
	static public var TYPE : String;
	public var type : String;
	public var target : Object;
	public var _preventDefault : Boolean;

	public function Event(type:String);

	public function preventDefault() : Void;

}