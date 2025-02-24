import sml.api.interfaces.IComparable;
import sml.util.Promise;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.types.Player implements IComparable
{
	public var userId : Number;
	public var name : String;

	public function Player(userId:Number, name:String);

	public function equals(other:Object) : Boolean;

	public function getLocation() : Promise;

}