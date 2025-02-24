/**
 * ...
 * @author Gulg
 */
class sml.util.Util
{
	
	public static function patch(obj:Object, override:Object):Void 
	{
		var original:Object = {};
		for (var method:String in override) {
			original[method] = obj[method];
		}
		for (var method:String in override) {
			obj[method] = function() {
				var _super:Object = {};
				var _this:Object = this;
				for (var methodName:String in original) {
					_super[methodName] = function ():Object 
					{
						return original[methodName].apply(_this, arguments);
					};
				}
				return override[method].apply(this, [_super].concat(arguments));
			};
		}
	}
	
	public static function extendPrototype(_class:Object, extensions:Object, methods:Array):Void 
	{
		for (var i in methods) {
			var method:String = methods[i];
			_class.prototype[method] = extensions.prototype[method];
		}
		_global.ASSetPropFlags(_class.prototype, methods, 1);
	}
	
}