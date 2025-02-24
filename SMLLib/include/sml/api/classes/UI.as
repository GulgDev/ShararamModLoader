import mx.events.EventDispatcher;
import sml.api.const.MessageBox;
import sml.api.interfaces.IApiClass;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.classes.UI extends EventDispatcher implements IApiClass
{
	public function init() : Void;

	public function messageBox(text:String, style:Number, buttons:Number, callback:Function) : Void;

	public function showInfo(text:String, buttons:Number, callback:Function) : Void;

	public function showWarning(text:String, buttons:Number, callback:Function) : Void;

	public function showOk(text:String, callback:Function) : Void;

	public function showYesNo(text:String, callback:Function) : Void;

	public function showSaveCancel(text:String, callback:Function) : Void;

	public function showError(text:String, callback:Function) : Void;

}