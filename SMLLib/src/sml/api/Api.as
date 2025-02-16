import mx.events.EventDispatcher;
import sml.Main;
import sml.api.Api;
import sml.api.classes.Chat;
import sml.api.classes.Players;
import sml.api.classes.UI;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.Api extends EventDispatcher
{
	
	public var chat:Chat;
	public var players:Players;
	public var ui:UI;
	
	public function Api() 
	{
		chat = new Chat(this);
		players = new Players(this);
		ui = new UI(this);
		
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