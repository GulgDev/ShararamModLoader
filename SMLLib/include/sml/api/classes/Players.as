import mx.events.EventDispatcher;
import sml.api.interfaces.IApiClass;
import sml.api.types.Player;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.classes.Players extends EventDispatcher implements IApiClass
{
	public var self : Player;

	public function init() : Void;

	public function findByName(name:String) : Promise;

}