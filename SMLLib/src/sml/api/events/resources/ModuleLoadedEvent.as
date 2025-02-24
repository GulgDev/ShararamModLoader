import sml.api.events.Event;
import sml.api.types.Module;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.resources.ModuleLoadedEvent extends Event
{
	
	public static var TYPE:String = "moduleload";
	
	public var module:Module;
	
	public function ModuleLoadedEvent(module:Module) 
	{
		super(ModuleLoadedEvent.TYPE);
		this.module = module;
	}
	
}