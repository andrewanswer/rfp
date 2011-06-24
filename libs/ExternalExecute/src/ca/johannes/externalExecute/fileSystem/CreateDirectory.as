package ca.johannes.externalExecute.fileSystem
{
	
	public class CreateDirectory extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "createDirectory";
		
		protected var _folderURI:String;
		
		public function CreateDirectory(folderURI:String)
		{
			super();
			_folderURI = folderURI;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, folderURI);		
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get folderURI():String
		{
			return _folderURI;
		}
	}
}