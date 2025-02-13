import sml.Main;
import sml.api.Api;
import sml.util.Util;
/**
 * ShararamModLoader entry point. Starts Shararam and loads SML mods
 * @author Gulg
 */
class sml.Main 
{
	
	private static var sharabaseUrl:String = "https://www.shararam.ru/base.swf?noproxy";
	
	public var api:Api;
	public var sharabase:MovieClip;
	
	private var modCount:Number;
	private var mcLoader:MovieClipLoader = new MovieClipLoader();
	
	public static function main(swfRoot:MovieClip):Void 
	{
		System.security.allowDomain("*");
		var main:Main = new Main();
		shararam = main.api;
		main.start();
	}
	
	public function Main() 
	{
		sharabase = _root.createEmptyMovieClip("ShararamBase_MC", 0);
		api = new Api();
		mcLoader.addListener(this);
	}
	
	public function start():Void 
	{
		loadMods();
	}
	
	private function loadMods():Void 
	{
		var main:Main = this;
		var xml:XML = new XML();
		xml.ignoreWhite = true;
		xml.onLoad = function (success:Boolean):Void 
		{
			if (!success) {
				trace("Failed to load SML mod list");
				return;
			}
			
			var root:XMLNode = xml.firstChild;
			main.modCount = root.childNodes.length;
			for (var i in root.childNodes) {
				var modNode:XMLNode = root.childNodes[i];
				var modPath:String = modNode.attributes.path;
				var modMc:MovieClip = _root.createEmptyMovieClip(modPath + "_MC", _root.getNextHighestDepth());
				main.mcLoader.loadClip("https://www.shararam.ru/sml/mods/" + modPath, modMc);
			}
		};
		xml.load("https://www.shararam.ru/sml/mods.xml");
	}
	
	public function onLoadInit(mc:MovieClip):Void 
	{
		if (mc === sharabase) {
			this.api.dispatchEvent({ type: "start" });
		} else {
			modCount--;
			if (modCount === 0) {
				var apply:Function = Function.prototype.apply;
				var _this:Main = this;
				Function.prototype.apply = function(thisObject:Object, argArray:Array) {
					if (thisObject instanceof MovieClip) {
						Function.prototype.apply = apply;
						_this.api.dispatchEvent({ type: "init" });
					}
					return apply.apply(this, [thisObject, argArray]);
				}
				
				mcLoader.loadClip(sharabaseUrl, sharabase);
			}
		}
	}
	
}