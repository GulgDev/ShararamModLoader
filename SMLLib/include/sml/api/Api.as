import mx.events.EventDispatcher;
import sml.Main;
import sml.api.classes.Chat;
import sml.api.classes.Players;
import sml.api.classes.UI;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.Api extends EventDispatcher
{
	public var chat : Chat;
	public var players : Players;
	public var ui : UI;

	public function Api();

}