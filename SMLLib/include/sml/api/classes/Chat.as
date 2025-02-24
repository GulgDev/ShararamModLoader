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
intrinsic class sml.api.classes.Chat extends EventDispatcher implements IApiClass
{
	public function init() : Void;

	public function sendMessage(message:String) : Void;

}