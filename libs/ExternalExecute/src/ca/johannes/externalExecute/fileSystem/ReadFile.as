package ca.johannes.externalExecute.fileSystem
{
	
	
	public class ReadFile extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "readFile";
		
		protected var _fileURI:String
		
		public function ReadFile(fileURI:String)
		{
			super();
			_fileURI = fileURI;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, fileURI);
		}
		
		public function get result():String
		{
			return _result as String;
		}
		
		public function get fileURI():String
		{
			return _fileURI;
		}
	}
}