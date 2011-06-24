package ca.johannes.externalExecute.fileSystem.utils
{
	import ca.johannes.externalExecute.fileSystem.AbstractFileSystemExecute;
	
	public class URItoPlatformPath extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "uriToPlatformPath";
		
		protected var _fileURI:String
		
		public function URItoPlatformPath(fileURI:String)
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