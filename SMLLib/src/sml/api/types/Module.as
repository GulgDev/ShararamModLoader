import mx.events.EventDispatcher;
import sml.api.events.Event;
/**
 * ...
 * @author Gulg
 */
class sml.api.types.Module extends EventDispatcher
{
	
	public var id:String;
	public var path:String;
	public var mc:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	
	public function Module(mc:MovieClip, id:String, loader:MovieClipLoader) 
	{
		this.mc = mc;
		this.id = id;
		mcLoader = loader || new MovieClipLoader();
		mcLoader.addListener(this);
	}
	
	public function load(url:String):Void 
	{
		mcLoader.loadClip(url || path, mc);
		path = url;
	}
	
	private function onLoadComplete():Void 
	{
		var _this:Module = this;
		mc.onEnterFrame = function ():Void 
		{
			delete _this.mc.onEnterFrame;
			_this.dispatchEvent(new Event("load"));
		};
	}
	
	private function onLoadInit():Void 
	{
		dispatchEvent(new Event("init"));
	}
	
	private function onLoadError():Void 
	{
		dispatchEvent(new Event("error"));
	}
	
}