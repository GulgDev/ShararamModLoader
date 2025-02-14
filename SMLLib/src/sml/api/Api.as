import mx.events.EventDispatcher;
import sml.Main;
import sml.api.Api;
import sml.api.Chat;
import sml.api.Players;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.Api extends EventDispatcher
{
	
	public var chat:Chat;
	public var players:Players;
	
	public function Api() 
	{
		chat = new Chat(this);
		players = new Players(this);
		
		var _this:Api = this;
		this.addEventListener("init", function ():Void 
		{
			Util.patch(_global.Base.prototype, {
				OnRTMPConnect: function ($this:Object, event:Object):Void 
				{
					$this.OnRTMPConnect.apply(this, [event]);
					_this.dispatchEvent({ type: "connect" });
				}
			});
		});
	}
	
}