package ca.johannes.externalExecute.fileSystem
{	
	public class CopyFile extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "copyFile";
		
		protected var _fileURI:String;
		
		protected var _copyURI:String
		
		public function CopyFile(fileURI:String, copyURI:String)
		{
			super();
			_fileURI = fileURI;
			_copyURI = copyURI;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, fileURI, copyURI);
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get fileURI():String
		{
			return _fileURI;
		}
		
		public function get copyURI():String
		{
			return _copyURI;
		}
	}
}