import sml.api.const.MessageBox;
/**
 * ...
 * @author Gulg
 */
class sml.api.const.MessageBox
{
	
	// Message box style
	public static var INFO:Number    = 0x00;
	public static var WARNING:Number = 0x01;
	
	// Message box buttons
	public static var YES:Number    = 0x01;
	public static var NO:Number     = 0x02;
	public static var OK:Number     = 0x04;
	public static var SAVE:Number   = 0x08;
	public static var CANCEL:Number = 0x10;
	
	public static var CLOSE:Number  = 0x20;
	
	public static var BUTTONS:Array = [
		"YES",
		"NO",
		"OK",
		"SAVE",
		"CANCEL"
	];
	
}