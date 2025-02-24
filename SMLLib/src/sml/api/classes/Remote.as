import mx.events.EventDispatcher;
import sml.api.const.RemoteTarget;
import sml.api.events.Event;
import sml.api.events.remote.RemoteMessageEvent;
import sml.api.interfaces.IApiClass;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Remote extends EventDispatcher implements IApiClass
{
	
	private var dispatchers:Object;
	
	public function Remote() 
	{
		dispatchers = {};
	}
	
	public function init():Void 
	{
		var _this:Remote = this;
		Shararam.base.addEventListener("load", function ():Void 
		{
			Util.patch(_global.Base.prototype, {
				OnRTMPConnect: function (_super:Object, event:Object):Void 
				{
					_super.OnRTMPConnect(event);
					_this.dispatchEvent(new Event("connect"));
				}
			});
		});
	}
	
	private function get connector():Object 
	{
		return _global.Base.Instance.rtmpConnectionHandler.nc;
	}
	
	public function send(target:String, method:String, args:Array):Promise 
	{
		return new Promise(function (resolve:Function):Void 
		{
			_global.FMSApi.$_(method, target, null, args, function ():Void 
			{
				resolve(arguments);
			});
		});
	}
	
	public function sendServer(method:String, args:Array):Promise 
	{
		return send(RemoteTarget.SERVER, method, args);
	}
	
	public function invoke(method:String, args:Array):Promise 
	{
		return new Promise(function (resolve:Function):Void 
		{
			_global.FMSApi.$F(method, args, function ():Void 
			{
				resolve(arguments);
			});
		});
	}
	
	public function handle(method:String, handler:Function):Void 
	{
		var dispatcher:EventDispatcher = dispatchers[method];
		if (!dispatcher) {
			dispatchers[method] = dispatcher = new EventDispatcher();
			var m:Function = connector[method];
			if (m) {
				connector.AddMethodHandler(method, function ():Void 
				{
					var event:RemoteMessageEvent = new RemoteMessageEvent(arguments);
					dispatcher.dispatchEvent(event);
					if (!event._preventDefault)
						m.apply(this, event.args);
				});
			}
		}
		dispatcher.addEventListener("$", handler);
	}
	
}