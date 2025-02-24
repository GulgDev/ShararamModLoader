import mx.events.EventDispatcher;
import sml.api.events.remote.RemoteMessageEvent;
import sml.api.interfaces.IApiClass;
import sml.api.types.Player;
import sml.api.events.chat.ChatMessageEvent;
import sml.api.events.chat.SendChatMessageEvent;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Chat extends EventDispatcher implements IApiClass
{
	
	public function init():Void 
	{
		var _this:Chat = this;
		Shararam.base.addEventListener("load", function ():Void 
		{
			Util.patch(_global.server.FMSApi.prototype, {
				ChatMessage: function (_super, text:String):Void 
				{
					var event:SendChatMessageEvent = new SendChatMessageEvent(text);
					_this.dispatchEvent(event);
					if (event._preventDefault) return;
					text = event.text;
					_super.ChatMessage(text);
				}
			});
		});
		Shararam.remote.addEventListener("connect", function ():Void 
		{
			Shararam.remote.handle("_C", function (event:RemoteMessageEvent):Void 
			{
				var userName:String = undefined;
				if (_global.I.GameController)
				{
					userName = _global.$.SelectObject(_global.I.GameController.GetGameUsers(), "ID", event.args[0]).Name;
				}
				else
				{
					var avatar = _global.I.AvatarController.GetUserAvatar(event.args[0]);
					userName = avatar.AvatarData.Name;
				}
				var chatEvent:ChatMessageEvent = new ChatMessageEvent(new Player(event.args[0], userName), event.args[1]);
				_this.dispatchEvent(chatEvent);
				if (chatEvent._preventDefault)
					event.preventDefault();
				event.args[1] = chatEvent.text;
			});
		});
	}
	
	public function sendMessage(message:String):Void 
	{
		Shararam.remote.sendServer("_C", [message]);
	}
	
}