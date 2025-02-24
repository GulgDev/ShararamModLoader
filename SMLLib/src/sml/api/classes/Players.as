import mx.events.EventDispatcher;
import sml.api.interfaces.IApiClass;
import sml.api.types.Player;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Players extends EventDispatcher implements IApiClass
{
	
	public var self:Player;
	
	public function init():Void 
	{
		var _this:Players = this;
		Shararam.base.addEventListener("load", function ():Void 
		{
			Util.patch(_global.Base.prototype, {
				OnUserDataResult: function (_super:Object, event:Object):Void 
				{
					_super.OnUserDataResult(event);
					_this.self = new Player(_global.Base.storage.user_data.UserId, _global.Base.storage.user_data.Name);
				}
			});
		});
	}
	
	public function findByName(name:String):Promise
	{
		if (name === this.self.name)
			return Promise.resolve(this.self);
		return new Promise(function (resolve:Function, reject:Function):Void 
		{
			// TODO
			Shararam.remote
			_global.I.FMSApi.SearchUserByName(name, function (arguments):Void 
			{
				for (var i in arguments) {
					var user:Object = arguments[i];
					if (user.UserName === name) {
						resolve(new Player(user.UserId, user.UserName));
						return;
					}
				}
				reject();
			});
		});
	}
	
}