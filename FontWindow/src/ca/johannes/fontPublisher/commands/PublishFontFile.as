package ca.johannes.fontPublisher.commands
{
	import ca.johannes.commands.ICommand;
	import ca.johannes.externalExecute.fileSystem.CopyFile;
	import ca.johannes.externalExecute.fileSystem.CreateDirectory;
	import ca.johannes.externalExecute.fileSystem.DeleteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.fla.Publish;
	
	public class PublishFontFile implements ICommand
	{
		public static var FONT_FILE_NAME:String = "RSFont.swf";
		
		protected static var FLA_FILE_NAME:String = "RSFont.fla";
		
		protected var flaURI:String;
		
		protected var binURI:String;
		
		protected var fileURI:String;
		
		protected var publishedURI:String;
		
		protected var className:String;

		public function PublishFontFile(flaURI:String, binURI:String, fileURI:String, className:String)
		{
			this.flaURI = flaURI + FLA_FILE_NAME;
			this.binURI = binURI;
			this.fileURI = fileURI;
			publishedURI = binURI + FONT_FILE_NAME;
			this.className = className;
		}
		
		public function execute():void
		{
			var createDirectory:CreateDirectory = new CreateDirectory(binURI);
			createDirectory.execute();
			
			var publish:Publish = new Publish(flaURI, className);
			publish.execute();
			
			var fileExists:URIExists = new URIExists(fileURI);
			fileExists.execute();
			
			if (fileExists.result) {
				var deleteFile:DeleteFile = new DeleteFile(fileURI);
				deleteFile.execute();
			}
			
			var copyFile:CopyFile = new CopyFile(publishedURI, fileURI);
			copyFile.execute();
		}
		
	}
}