import sml.util.ArrayBuilder;
/**
 * ...
 * @author Gulg
 */
class sml.util.ArrayBuilder
{
	
	private var array:Array;
	
	public function ArrayBuilder(array:Array) 
	{
		this.array = array;
	}
	
	public function build():Array 
	{
		return this.array;
	}
	
	function forEach(callback:Function, thisArg:Object):ArrayBuilder 
	{
		for (var i in this.array)
			callback.apply(thisArg, [this.array[i], i, this.array]);
		return this;
	}
	
	function map(callback:Function, thisArg:Object):ArrayBuilder 
	{
		var result:Array = [];
		this.forEach(function ():Void 
		{
			result.push(callback.apply(this, arguments));
		}, thisArg);
		this.array = result;
		return this;
	}
	
	function filter(callback:Function, thisArg:Object):ArrayBuilder 
	{
		var result:Array = [];
		this.forEach(function (element:Object):Void 
		{
			if (callback.apply(this, arguments))
				result.push(element);
		}, thisArg);
		this.array = result;
		return this;
	}
	
}