import sml.api.Api;
import sml.api.ApiClass;
import sml.api.Player;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
intrinsic class sml.api.Players extends ApiClass
{
	public var self : Player;

	public function Players(api:Api);

	public function findByName(name:String) : Promise;

}