import mx.events.EventDispatcher;
import sml.api.events.resources.ModuleInitializedEvent;
import sml.api.events.resources.ModuleLoadedEvent;
import sml.api.interfaces.IApiClass;
import sml.api.types.Module;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Resources extends EventDispatcher implements IApiClass
{
	
	public function init():Void 
	{
		var _this:Resources = this;
		Shararam.base.addEventListener("load", function ():Void 
		{
			Util.patch(_global.utilites.ClipSetLoader.prototype, {
				Start: function (_super:Object):Void 
				{
					if (this.clipsRemains == 0)
					{
						this.dispatchEvent({ type: "onResult" });
						return;
					}
					for (var i in this.loadList) {
						var item:Object = this.loadList[i];
						if (!_global.$.IsObject(item))
						{
							this.clipsRemains--;
						}
						else
						{
							var target:MovieClip = item[this.clipTargetIndex];
							var mrid:Number = item.MediaResourceID || item.MRId;
							var path:String = item[this.clipPathIndex];
							var str:String = "" + target;
							if (item.preloader)
							{
								target = target.createEmptyMovieClip("content", target.getNextHighestDepth());
								target._parent.__hideOnInit = true;
								var preloader:MovieClip = target._parent.attachMovie("assets.IconLoader", "preloader", target._parent.getNextHighestDepth());
								if (item.preloaderPosition)
								{
									preloader._x = item.preloaderPosition.x;
									preloader._y = item.preloaderPosition.y;
								}
							}
							if (!target || (!path && !_global.I.ResourceManager.GetSwfPath(mrid)))
							{
							   this.clipsRemains--;
							   Shararam.log.error("ClipSetLoader - error: " + target);
							}
							else
							{
							    if (item.Color != undefined)
							    {
								    this.colorsList[str] = Number(item.Color);
							    }
							    if (item.onLoad)
							    {
								    this.loadHandlersList[str] = item.onLoad;
							    }
							    if (item.onLoadStart)
							    {
								    this.loadStartHandlersList[str] = item.onLoadStart;
							    }
								
								var resId:String = String(mrid || path);
								var module:Module = _this.loadModule(resId, target, item.version, this.movieClipLoader);
								_global.retries[target] = { attempts: 0, url: module.path, counter: 0 };
							}
						}
					}
				}
			});
		});
	}
	
	public function get server():String 
	{
		return _global.I.Base.Storage().url_path_server || "https://www.shararam.ru/";
	}
	
	public function loadModule(resourceId:String, mc:MovieClip, version:String, mcLoader:MovieClipLoader):Module 
	{
		var _this:Resources = this;
		var moduleId:String;
		var path:String;
		if (isNaN(resourceId)) {
			moduleId = resourceId.split("?")[0].split(".").slice(0, -1).join(".").split("/").at( -1);
			path = resourceId;
		} else {
			var mrid:Number = Number(resourceId);
			moduleId = resourceId;
			path = _global.I.ResourceManager.GetSwfPath(mrid);
		}
		if (path.indexOf("?") === -1 && _global.Base.config.VersionMode !== 0) {
			version = version || (!isNaN(resourceId) && _global.I.ResourceManager.GetSwfVersion(Number(resourceId))) || _global.Base.config.SwfVersion;
			if (_global.Base.config.VersionMode === 2) {
				version = "!" + version + ".";
				path = path.split(".").join(version);
			} else {
				path += "?" + version;
			}
		}
		if (path.indexOf("://") == -1 && server) {
			path = server + path;
		}
		var module:Module = new Module(mc, moduleId, mcLoader);
		module.load(path);
		module.addEventListener("load", function ():Void 
		{
			_this.dispatchEvent(new ModuleLoadedEvent(module));
		});
		module.addEventListener("init", function ():Void 
		{
			_this.dispatchEvent(new ModuleInitializedEvent(module));
		});
		return module;
	}
	
}