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
class Shararam
{
	
	public static var chat:Chat;
	public static var external:External;
	public static var log:Log;
	public static var players:Players;
	public static var remote:Remote;
	public static var resources:Resources;
	public static var ui:UI;
	
	public static var base:Module;
	
	public static function trace():Void 
	{
		Shararam.log.debug.apply(Shararam.log, arguments.slice(0, -3));
	}
	
}