import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.util.extensions.ArrayExtensions extends Array
{
	
	public static function apply():Void 
	{
		Util.extendPrototype(Array, ArrayExtensions, ["at", "forEach", "map", "filter"]);
	}
	
	public function at(index:Number):Object 
	{
		return this[index >= 0 ? index : this.length + index];
	}
	
	public function forEach(callback:Function, thisArg:Object):Void 
	{
		for (var i in this)
			callback.apply(thisArg, [this[i], i, this]);
	}
	
	public function map(callback:Function, thisArg:Object):Array 
	{
		var result:Array = [];
		this.forEach(function ():Void 
		{
			result.push(callback.apply(this, arguments));
		}, thisArg);
		return result;
	}
	
	public function filter(callback:Function, thisArg:Object):Array 
	{
		var result:Array = [];
		this.forEach(function (element:Object):Void 
		{
			if (callback.apply(this, arguments))
				result.push(element);
		}, thisArg);
		return result;
	}
	
}