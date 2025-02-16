import sml.api.Api;
import sml.api.ApiClass;
import sml.api.const.MessageBox;
import sml.util.ArrayBuilder;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.classes.UI extends ApiClass
{
	public function UI(api:Api);

	public function messageBox(text:String, style:Number, buttons:Number, callback:Function) : Void;

	public function showInfo(text:String, buttons:Number, callback:Function) : Void;

	public function showWarning(text:String, buttons:Number, callback:Function) : Void;

	public function showOk(text:String, callback:Function) : Void;

	public function showYesNo(text:String, callback:Function) : Void;

	public function showSaveCancel(text:String, callback:Function) : Void;

}