/**
 * ...
 * @author Gulg
 */
class sml.util.Util
{
	
	public function Util() 
	{
		
	}
	
	public static function patch(obj:Object, override:Object):Void 
	{
		var original:Object = {};
		for (var method:String in override) {
			original[method] = obj[method];
		}
		for (var method:String in override) {
			obj[method] = function() {
				return override[method].apply(this, [original].concat(arguments));
			};
		}
	}
	
}