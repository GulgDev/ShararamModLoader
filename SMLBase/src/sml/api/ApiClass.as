import mx.events.EventDispatcher;
import sml.Main;
import sml.api.Api;
/**
 * ...
 * @author Gulg
 */
class sml.api.ApiClass extends EventDispatcher
{
	
	private var api:Api;
	
	public function ApiClass(api:Api) 
	{
		this.api = api;
	}
	
}