/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.events.Event
{
	public var type : String;
	public var target : Object;
	public var _preventDefault : Boolean;

	public function Event();

	public function preventDefault() : Void;

}