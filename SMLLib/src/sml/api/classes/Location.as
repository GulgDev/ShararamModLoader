import sml.api.Api;
import sml.api.interfaces.IApiClass;
import sml.api.types.Player;
import sml.util.ArrayBuilder;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Location implements IApiClass
{
	
	public function init():Void 
	{
		var _this:Location = this;
		api.addEventListener("init", function ():Void 
		{
			
		});
	}
	
	public function goto(location:Number):Void 
	{
		_global.I.Link.ExecuteAction("R$" + Base.__get__Instance().Location.PreviousLocationId + "$1");
	}
	
}