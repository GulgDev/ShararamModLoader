import sml.api.Player;
import sml.api.interfaces.IComparable;
/**
 * ...
 * @author Gulg
 */
class sml.api.types.Player implements IComparable
{
	
	public var userId:Number;
	public var name:String;
	
	public function Player(userId:Number,name:String) 
	{
		this.userId = userId;
		this.name = name;
	}
	
	public function equals(other:Object):Boolean 
	{
		return other instanceof Player && this.userId === other.userId;
	}
	
}