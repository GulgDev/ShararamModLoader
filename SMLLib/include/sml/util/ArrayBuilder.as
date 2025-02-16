/**
 * ...
 * @author Gulg
 */
intrinsic class sml.util.ArrayBuilder
{
	private var array : Array;

	public function ArrayBuilder(array:Array);

	public function build() : Array;

	public function forEach(callback:Function, thisArg:Object) : ArrayBuilder;

	public function map(callback:Function, thisArg:Object) : ArrayBuilder;

	public function filter(callback:Function, thisArg:Object) : ArrayBuilder;

}