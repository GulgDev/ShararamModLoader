import mx.events.EventDispatcher;
/**
 * Promise implementation in AS2
 * @author Gulg
 */
intrinsic class sml.util.Promise
{
	private var dispatcher : EventDispatcher;
	private var status : String;
	private var value : Object;

	public function Promise(executor:Function);

	static public function resolve(value:Object) : Promise;

	static public function reject(reason:Object) : Promise;

	public function then(onFulfilled:Function, onRejected:Function) : Promise;

	public function catch_(onRejected:Function) : Promise;

}