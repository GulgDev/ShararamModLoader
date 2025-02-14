import mx.events.EventDispatcher;
import sml.util.Promise;
/**
 * Promise implementation in AS2
 * @author Gulg
 */
class sml.util.Promise
{
	
	private var dispatcher:EventDispatcher = new EventDispatcher();
	
	private var status:String = "pending";
	private var value;
	
	public function Promise(executor:Function) 
	{
		var _this:Promise = this;
		
		var resolve: Function = function (value):Void 
		{
			if (_this.status === "pending") {
                _this.status = "fulfilled";
                _this.value = value;
                _this.dispatcher.dispatchEvent({ type: "fulfilled", value: value });
            }
		};
		
		var reject: Function = function (reason):Void 
		{
			if (_this.status === "pending") {
                _this.status = "rejected";
                _this.value = reason;
                _this.dispatcher.dispatchEvent({ type: "rejected", reason: reason });
            }
		};
		
		executor(resolve, reject);
	}
	
	public function then(onFulfilled:Function, onRejected:Function):Void 
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
	}
	
	public function catch_(onRejected:Function):Void 
	{
		then(undefined, onRejected);
	}
	
}