package ca.johannes.externalExecute.fileSystem.utils
{
	import ca.johannes.externalExecute.fileSystem.AbstractFileSystemExecute;
	
	public class URIExists extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "exists";
		
		protected var _uri:String
		
		public function URIExists(uri:String)
		{
			super();
			_uri = uri;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, uri);
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get uri():String
		{
			return _uri;
		}
		
		override public function get success():Boolean
		{
			return (AbstractFileSystemExecute.isAPIInitialized && (_result as Boolean) != null);
		}
	}
}