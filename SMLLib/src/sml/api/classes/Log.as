import flash.external.ExternalInterface;
import sml.api.interfaces.IApiClass;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Log implements IApiClass
{
	
	public function init():Void 
	{
		
	}
	
	public function debug():Void 
	{
		ExternalInterface.call.apply(null, ["console.log"].concat(arguments));
	}
	
	public function warning():Void 
	{
		ExternalInterface.call.apply(null, ["console.warn"].concat(arguments));
	}
	
	public function error():Void 
	{
		ExternalInterface.call.apply(null, ["console.error"].concat(arguments));
	}
	
}