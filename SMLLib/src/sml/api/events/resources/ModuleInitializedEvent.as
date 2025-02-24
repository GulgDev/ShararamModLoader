import sml.api.events.Event;
import sml.api.types.Module;
/**
 * ...
 * @author Gulg
 */
class sml.api.events.resources.ModuleInitializedEvent extends Event
{
	
	public static var TYPE:String = "moduleinit";
	
	public var module:Module;
	
	public function ModuleInitializedEvent(module:Module) 
	{
		super(ModuleInitializedEvent.TYPE);
		this.module = module;
	}
	
}