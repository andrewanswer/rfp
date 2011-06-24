package ca.johannes.externalExecute.fileSystem
{	
	public class CreateFile extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "createFile";
		
		protected var _fileURI:String;
		
		protected var _data:String;
		
		public function CreateFile(fileURI:String, data:String)
		{
			super();
			_fileURI = fileURI;
			_data = data;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, fileURI, data);		
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get fileURI():String
		{
			return _fileURI;
		}
		
		public function get data():String
		{
			return _data;
		}		
	}
}