import sml.api.classes.Chat;
import sml.api.classes.External;
import sml.api.classes.Log;
import sml.api.classes.Players;
import sml.api.classes.Remote;
import sml.api.classes.Resources;
import sml.api.classes.UI;
import sml.api.types.Module;
/**
 * ...
 * @author Gulg
 */
intrinsic class Shararam
{
	static public var chat : Chat;
	static public var external : External;
	static public var log : Log;
	static public var players : Players;
	static public var remote : Remote;
	static public var resources : Resources;
	static public var ui : UI;
	static public var base : Module;

	static public function trace() : Void;

}