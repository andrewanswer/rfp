package ca.johannes.externalExecute.fileSystem
{

	public class DeleteDirectoryContents extends AbstractFileSystemExecute
	{
		
		protected var _folderURI:String
		
		protected var listDirectoryContents:ListDirectoryContents;
		
		protected var deleteFile:DeleteFile;
		
		public function DeleteDirectoryContents(folderURI:String)
		{
			super();
			_folderURI = folderURI;
			listDirectoryContents = new ListDirectoryContents(folderURI);
		}
		
		override public function execute():void
		{
			listDirectoryContents.execute();
			var contents:Array = listDirectoryContents.result;
			super.result = listDirectoryContents.success.toString();
			
			var len:int = contents.length;
			for (var i:int = 0; i < len; i++) {				
				var fileURI:String = contents[i] as String;				
				deleteFile = new DeleteFile(fileURI);
				deleteFile.execute();
				super.result = deleteFile.result.toString();
				if (!_success) {
					break;
				}
			}			
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