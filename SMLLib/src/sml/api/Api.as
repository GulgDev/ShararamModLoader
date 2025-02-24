import sml.api.classes.Chat;
import sml.api.classes.External;
import sml.api.classes.Log;
import sml.api.classes.Players;
import sml.api.classes.Remote;
import sml.api.classes.Resources;
import sml.api.classes.UI;
import sml.api.types.Module;
import sml.util.extensions.ArrayExtensions;
/**
 * ...
 * @author Gulg
 */
class sml.api.Api
{
	
	public static function main(base:Module):Void 
	{
		Shararam.base = base;
		extendPrototypes();
		createApi();
		initApi();
	}
	
	private static function extendPrototypes():Void 
	{
		ArrayExtensions.apply();
	}
	
	private static function createApi():Void 
	{
		Shararam.chat = new Chat();
		Shararam.external = new External();
		Shararam.log = new Log();
		Shararam.players = new Players();
		Shararam.remote = new Remote();
		Shararam.resources = new Resources();
		Shararam.ui = new UI();
	}
	
	private static function initApi():Void 
	{
		Shararam.chat.init();
		Shararam.external.init();
		Shararam.log.init();
		Shararam.players.init();
		Shararam.remote.init();
		Shararam.resources.init();
		Shararam.ui.init();
	}
	
}