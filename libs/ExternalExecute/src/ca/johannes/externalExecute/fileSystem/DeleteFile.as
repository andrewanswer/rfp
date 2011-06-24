package ca.johannes.externalExecute.fileSystem
{
	
	public class DeleteFile extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "remove";
		
		protected var _fileURI:String
		
		public function DeleteFile(fileURI:String)
		{
			super();
			_fileURI = fileURI;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, fileURI);
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get fileURI():String
		{
			return _fileURI;
		}
	}
}