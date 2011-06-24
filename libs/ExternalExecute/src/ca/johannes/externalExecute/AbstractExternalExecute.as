package ca.johannes.externalExecute
{	
	import adobe.utils.MMExecute;
	
	public class AbstractExternalExecute implements IExternalExecute
	{		
		protected var _result:Object;
		
		protected var _success:Boolean = false;
		
			
		public function execute():void
		{
			throw new Error("Abstract class. Execute method not implemented.");
		}
		
		public function get success():Boolean
		{
			return _success;
		}
		
		
		protected function set success(value:Boolean):void
		{
			_success = value;
		}
		
		
		protected function set result(value:String):void
		{
			//MMExecute('fl.trace("result: '+value+'");');
			_success = verifyResult(value);
			_result = parseResult(value);
		}
		
		protected function executeExternal(jsfl:String):String
		{
			return MMExecute(jsfl);
		}
		
		protected function initializeExternalAPI(ExternalAPI:Class):Boolean {
			try {
				var api:String = new ExternalAPI().toString();
				//MMExecute('fl.trace("initializeExternalAPI");');
				MMExecute(api);
			} catch (error:Error) {
				//throw new Error("External API failed to initialize.");
				return false;
			}
			return true;
		}
		
		protected function verifyResult(value:String):Boolean
		{
			return (value != null && value != "false" && value.length > 0);
		}
		
		protected function parseResult(value:String):Object
		{
			var returnObj:Object;
			
			switch (value) {
				case "1": //exception for FLfile.remove
				case "true":
					returnObj = true;
					break;
				case "0": //exception for FLfile.remove
				case "false":
					returnObj = false;
					break;
				case null:
				case "null":
				case "undefined":
					return null;
					break;
				default :
					returnObj = value;
					break;
			}
			
			return returnObj;
		}
	}
}