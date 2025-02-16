import sml.api.Api;
import sml.api.ApiClass;
import sml.api.types.Player;
import sml.api.Players;
import sml.util.Promise;
import sml.util.Util;
/**
 * ...
 * @author Gulg
 */
class sml.api.classes.Players extends ApiClass
{
	
	public var self:Player;
	
	public function Players(api:Api) 
	{
		super(api);
		var _this:Players = this;
		api.addEventListener("init", function ():Void 
		{
			Util.patch(_global.Base.prototype, {
				OnUserDataResult: function ($this:Object, event:Object):Void 
				{
					$this.OnUserDataResult.apply(this, [event]);
					_this.self = new Player(this.storage.user_data.UserId, this.storage.user_data.Name);
				}
			});
		});
	}
	
	public function findByName(name:String):Promise
	{
		return new Promise(function (resolve:Function, reject:Function):Void 
		{
			_global.$.FMSApi.SearchUserByName(name, function (user:Object):Void 
			{
				if (user.UserName === name)
					resolve(new Player(user.UserId, user.UserName));
				else
					reject();
			});
		});
	}
	
}