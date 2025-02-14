import sml.Main;
import sml.api.Api;
import sml.api.ApiClass;
import sml.api.Chat;
import sml.api.events.ChatMessageEvent;
import sml.api.events.Event;
import sml.api.Player;
import sml.api.events.SendChatMessageEvent;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.Chat extends ApiClass
{
	
	public function Chat(api:Api) 
	{
		super(api);
		var _this:Chat = this;
		api.addEventListener("start", function ():Void 
		{
			Util.patch(_global.I.FMSApi, {
				ChatMessage: function ($this:Object, text:String, noDispatch:Boolean):Void 
				{
					if (!noDispatch) {
						var event:SendChatMessageEvent = new SendChatMessageEvent(text);
						_this.dispatchEvent(event);
						if (event._preventDefault) return;
						text = event.text;
					}
					$this.ChatMessage.apply(this, [text]);
				}
			});
		});
		api.addEventListener("connect", function ():Void 
		{
			Util.patch(_global.Base.Instance.rtmpConnectionHandler.nc, {
				_C: function ($this:Object, userId:Number, text:String):Void 
				{
					var userName:String = undefined;
					if(_global.I.GameController)
					{
						userName = _global.$.SelectObject(_global.I.GameController.GetGameUsers(), "ID", userId).Name;
					}
					else
					{
						var avatar = _global.I.AvatarController.GetUserAvatar(userId);
						userName = avatar.AvatarData.Name;
					}
					{
						var event:ChatMessageEvent = new ChatMessageEvent(new Player(userId, userName), text);
						_this.dispatchEvent(event);
						if (event._preventDefault) return;
						text = event.text;
					}
					$this._C.apply(this, [userId, text]);
				}
			});
		});
	}
	
	public function sendMessage(message:String, dispatch:Boolean): Void 
	{
		_global.I.FMSApi.ChatMessage(message, !dispatch);
	}
	
}