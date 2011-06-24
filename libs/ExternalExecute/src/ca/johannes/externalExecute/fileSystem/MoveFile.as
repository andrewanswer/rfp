package ca.johannes.externalExecute.fileSystem
{
	
	public class MoveFile extends AbstractFileSystemExecute
	{
		protected var _fileURI:String;
		
		protected var _newURI:String
		
		protected var copyFile:CopyFile;
		
		protected var deleteFile:DeleteFile;
		
		public function MoveFile(fileURI:String, newURI:String)
		{
			super();
			_fileURI = fileURI;
			_newURI = newURI;
			copyFile = new CopyFile(fileURI, newURI);
			deleteFile = new DeleteFile(fileURI);
		}
		
		override public function execute():void
		{
			copyFile.execute();
			super.result = copyFile.result.toString();
			
			if (copyFile.success) {
				deleteFile.execute();
				super.result = deleteFile.result.toString();
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
		
		public function get newURI():String
		{
			return _newURI;
		}
	}
}