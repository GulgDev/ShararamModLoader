import sml.api.interfaces.IComparable;
import sml.util.Promise;
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
	
	public function getLocation():Promise 
	{
		var _this:Player = this;
		return new Promise(function (resolve:Function, reject:Function):Void 
		{
			_global.I.FMSApi.GetUserLocationInfo(_this.userId, function(value:String):Void 
			{
				_global.flash.external.ExternalInterface.call("console.log", "location", value);
				var locationInfo:Object = _global.$.XMLToObject((new XML(value)).firstChild);
			});
		});
	}
	
}