package ca.johannes.externalExecute.fileSystem
{
	
	public class WriteFile extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "writeFile";
		
		protected static const APPEND:String = "append";
		
		protected var _fileURI:String;
		
		protected var _data:String;
		
		protected var _append:Boolean;
		
		public function WriteFile(fileURI:String, data:String, append:Boolean = false)
		{
			super();
			_fileURI = fileURI;
			_data = data;
			_append = append;
		}
		
		override public function execute():void
		{
			if (!append) {
				super.result = callMethod(FUNCTION_NAME, fileURI, data);
			} else {
				super.result = callMethod(FUNCTION_NAME, fileURI, data, APPEND);
			}		
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
		
		public function get append():Boolean
		{
			return _append;
		}
	}
}