import sml.Main;
import sml.api.Api;
import sml.api.ApiClass;
import sml.api.events.ChatMessageEvent;
import sml.api.events.Event;
import sml.api.Player;
import sml.api.events.SendChatMessageEvent;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.Chat extends ApiClass
{
	public function Chat(api:Api);

	public function sendMessage(message:String, dispatch:Boolean) : Void;

}