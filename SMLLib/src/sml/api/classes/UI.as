import sml.api.Api;
import sml.api.ApiClass;
import sml.api.classes.UI;
import sml.api.const.MessageBox;
import sml.util.ArrayBuilder;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.UI extends ApiClass
{
	
	public function UI(api:Api) 
	{
		super(api);
	}
	
	public function messageBox(text:String, style:Number, buttons:Number, callback:Function):Void 
	{
		var type:Number;
		switch (style) 
		{
			case MessageBox.INFO:
				type = _global.MessageBoxConfig.BLUE;
				break;
			case MessageBox.WARNING:
				type = _global.MessageBoxConfig.ORANGE;
				break;
			default:
				type = _global.MessageBoxConfig.BLUE;
				break;
		}
		var data:Object = {
			type: type,
			text1: _global.I.ResourceManager.FormatString(text),
			buttons: (new ArrayBuilder(MessageBox.BUTTONS))
				.filter(function (button:String):Boolean 
				{
					return (buttons & MessageBox[button]) !== 0;
				}).
				map(function (button:String):Object 
				{
					return {
						label: _global.I.ResourceManager.Localize(_global.utilites.Const["LABEL_" + button]),
						callback: function ():Void 
						{
							callback(MessageBox[button]);
						}
					};
				})
				.build(),
			close_btn: (buttons & MessageBox.CLOSE) && {
				show: true,
				callback: callback
			}
		};
		
		_global.MessageBoxConfig.Show(data);
	}
	
	public function showInfo(text:String, buttons:Number, callback:Function):Void 
	{
		this.messageBox(text, MessageBox.INFO, buttons, callback);
	}
	
	public function showWarning(text:String, buttons:Number, callback:Function):Void 
	{
		this.messageBox(text, MessageBox.WARNING, buttons, callback);
	}
	
	public function showOk(text:String, callback:Function):Void 
	{
		this.showInfo(text, MessageBox.OK, callback);
	}
	
	public function showYesNo(text:String, callback:Function):Void 
	{
		this.showInfo(text, MessageBox.YES | MessageBox.NO, callback);
	}
	
	public function showSaveCancel(text:String, callback:Function):Void 
	{
		this.showInfo(text, MessageBox.SAVE | MessageBox.CANCEL, callback);
	}
	
}