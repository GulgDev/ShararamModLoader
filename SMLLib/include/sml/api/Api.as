import mx.events.EventDispatcher;
import sml.Main;
import sml.api.Chat;
import sml.api.Players;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.Api extends EventDispatcher
{
	public var chat : Chat;
	public var players : Players;

	public function Api();

}