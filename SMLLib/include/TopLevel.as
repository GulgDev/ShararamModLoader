/**
 * Override MTASC toplevel variables & functions
 * @author Gulg
 */
intrinsic class TopLevels
{
	static public var Base : Object;
	static public var I : Object;
	static public var $ : Object;
	static public var _quality : String;
	static public var _focusrect : Boolean;
	static public var _soundbuftime : Number;
	static public var newline : String;
	static public var Infinity : Number;
	static public var NaN : Number;
	static private var arguments : FunctionArguments;

	static public function escape(value:String) : String;

	static public function unescape(value:String) : String;

	static public function parseInt(value:String, radix:Number) : Number;

	static public function parseFloat(value:String) : Number;

	static public function updateAfterEvent() : Void;

	static public function isNaN(value:Object) : Boolean;

	static public function isFinite(value:Object) : Boolean;

	static public function setInterval() : Number;

	static public function clearInterval(id:Number) : Void;

	static public function setTimeout() : Number;

	static public function clearTimeout(id:Number) : Void;

	static public function MMExecute(expr:String);

	static private function FSCommand2(p1:Object, p2:Object);

	static private function getVersion() : String;

	static private function trace(value) : Void;

	static private function eval(e:String);

	static private function getURL(url:String, target:String, vars:String) : Void;

	static private function getTimer() : Number;

	static private function random(n:Number) : Number;

	static private function int(o:Object) : Number;

	static private function string(o:Object) : String;

	static private function chr(o:Number) : String;

	static private function ord(s:String) : Number;

	static private function delete(o) : Boolean;

	static private function loadMovie(url:String, target:MovieClip, method:String) : Void;

	static private function loadVariables(url:String, target:MovieClip, method:String) : Void;

	static private function typeof(o) : String;

	static private function instanceof(o:Object, cl:Object) : Boolean;

	static private function targetPath(o:Object) : String;

	static private function throw(x) : Void;

	static private function fscommand(x, y) : Void;

	static private function print(x, y:String) : Void;

	static private function stopAllSounds() : Void;

}