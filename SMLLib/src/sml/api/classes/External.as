import flash.external.ExternalInterface;
import sml.api.interfaces.IApiClass;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.External implements IApiClass
{
	
	public function init():Void 
	{
		
	}
	
	public function call(methodName:String):Void 
	{
		this.apply(methodName, arguments.slice(1));
	}
	
	public function apply(methodName:String, args:Array):Void 
	{
		ExternalInterface.call.apply(null, [methodName].concat(args));
	}
	
}