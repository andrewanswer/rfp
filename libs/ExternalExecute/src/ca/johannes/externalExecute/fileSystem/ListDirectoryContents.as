package ca.johannes.externalExecute.fileSystem
{
	public class ListDirectoryContents extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "listDirectoryContents";
		
		protected var _folderURI:String
		
		public function ListDirectoryContents(folderURI:String)
		{
			super();
			_folderURI = folderURI;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, folderURI);
		}
		
		public function get result():Array
		{
			var contents:Array = (_result as String).split(",");
			
			for (var key:String in contents){
				contents[key] = folderURI + contents[key];
			}
			
			return contents;
		}
		
		public function get folderURI():String
		{
			return _folderURI;
		}
	}
}