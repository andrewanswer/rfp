package ca.johannes.fontPublisher.commands
{
	import ca.johannes.commands.ICommand;
	import ca.johannes.externalExecute.fileSystem.CreateDirectory;
	import ca.johannes.externalExecute.fileSystem.CreateFile;
	import ca.johannes.externalExecute.fileSystem.WriteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.fontPublisher.publish.FontProfile;
	
	import mx.collections.ArrayCollection;
	
	public class BuildFontRegister implements ICommand
	{
		[Embed(source="../../../../../etc/FontRegister.txt", mimeType="application/octet-stream")]
		protected static const FontRegisterTemplate:Class;
		
		//protected static var FONT_CLASS_PREFIX:String = "RSFont";
		
		protected static var FONT_REGISTER_CLASS_NAME:String = "FontRegister";
		
		protected var _fontRegister:String;
		
		protected var fontProfiles:ArrayCollection;
		
		protected var directory:String;
		
		public function BuildFontRegister(fontProfiles:ArrayCollection, directory:String)
		{
			this.fontProfiles = fontProfiles;
			this.directory = directory;
		}
		
		public function execute():void
		{
			buildActionScript();
			
			var classFile:String = directory + className + ".as";
			
			var uriExists:URIExists = new URIExists(directory);
			uriExists.execute();
			
			if(!uriExists.result) {
				var createDirectory:CreateDirectory = new CreateDirectory(directory);
				createDirectory.execute();
			}
			
			uriExists = new URIExists(classFile);
			uriExists.execute();
			
			if (uriExists.result) {
				var writeFile:WriteFile = new WriteFile(classFile, _fontRegister);
				writeFile.execute();
			} else {
				var createFile:CreateFile = new CreateFile(classFile, _fontRegister);
				createFile.execute();
			}
		}
		
		public function get fontRegister():String
		{
			return _fontRegister;
		}
		
		protected function buildActionScript():void
		{			
			//var pattern:RegExp;
			
			_fontRegister = (new FontRegisterTemplate()).toString();
			var registerConstructor:String = "";
			var registerFontArray:String = "[";			
			
			var len:int = fontProfiles.length;
			for (var i:int = 0; i<len; i++) {
				var profile:FontProfile = fontProfiles.getItemAt(i) as FontProfile;
				//var className:String = FONT_CLASS_PREFIX + i.toString();
				var className:String = profile.fontClassName + i.toString();
				registerConstructor += "registerFont(" + className + ".font); "; //+ ".font);\n"
				registerFontArray += "new " + className + "()";
				if (i != (len-1)){
					registerFontArray += ", ";
				}
			}
			registerFontArray += "]";			
			
			var pattern:RegExp;
			_fontRegister = _fontRegister.replace(pattern = /\${className}/g, this.className);
			_fontRegister = _fontRegister.replace(pattern = /\${constructor}/g, registerConstructor);
			_fontRegister = _fontRegister.replace(pattern = /\${fontArray}/g, registerFontArray);
		}
		public function get className():String
		{
			// First font name used for extending FontRegister class name
			var profile:FontProfile = fontProfiles.getItemAt(0) as FontProfile;
			return FONT_REGISTER_CLASS_NAME + "_" + profile.fontClassName;
		}
	}
}