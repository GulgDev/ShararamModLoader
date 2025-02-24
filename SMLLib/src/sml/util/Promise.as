import mx.events.EventDispatcher;
/**
 * Promise implementation in AS2
 * @author Gulg
 */
class sml.util.Promise
{
	
	private var dispatcher:EventDispatcher;
	
	private var status:String = "pending";
	private var value;
	
	public function Promise(executor:Function) 
	{
		this.dispatcher = new EventDispatcher();
		
		var _this:Promise = this;
		
		var resolve:Function = function (value):Void 
		{
			if (_this.status === "pending") {
                _this.status = "fulfilled";
                _this.value = value;
                _this.dispatcher.dispatchEvent({ type: "fulfilled", value: value });
            }
		};
		
		var reject:Function = function (reason):Void 
		{
			if (_this.status === "pending") {
                _this.status = "rejected";
                _this.value = reason;
                _this.dispatcher.dispatchEvent({ type: "rejected", reason: reason });
            }
		};
		
		executor(resolve, reject);
	}
	
	public static function resolve(value:Object):Promise 
	{
		return new Promise(function (resolve:Function, reject:Function):Void 
		{
			resolve(value);
		});
	}
	
	public static function reject(reason:Object):Promise 
	{
		return new Promise(function (resolve:Function, reject:Function):Void 
		{
			reject(reason);
		});
	}
	
	public function then(onFulfilled:Function, onRejected:Function):Promise 
	{
		switch (this.status) 
		{
			case "pending":
				dispatcher.addEventListener("fulfilled", function (event:Object):Void 
				{
					onFulfilled(event.value);
				});
				dispatcher.addEventListener("rejected", function (event:Object):Void 
				{
					onRejected(event.reason);
				});
				break;
			case "fulfilled":
				onFulfilled(this.value);
				break;
			case "rejected":
				onRejected(this.value);
				break;
		}
		return this;
	}
	
	public function catch_(onRejected:Function):Promise 
	{
		return then(undefined, onRejected);
	}
	
}