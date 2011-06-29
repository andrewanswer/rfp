package ca.johannes.fontPublisher.commands
{
	import ca.johannes.commands.ICommand;
	import ca.johannes.externalExecute.fileSystem.CreateDirectory;
	import ca.johannes.externalExecute.fileSystem.CreateFile;
	import ca.johannes.externalExecute.fileSystem.WriteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.fontPublisher.publish.FontProfile;

	public class BuildFontClass implements ICommand
	{
		[Embed(source="../../../../../etc/RSFont.txt", mimeType="application/octet-stream")]
		protected static const FontClassTemplate:Class;
		
		//protected static var FONT_CLASS_PREFIX:String = "RSFont";
		
		protected var _fontClass:String;
		
		protected var className:String;
		
		protected var fontProfile:FontProfile;
		
		protected var index:int;
		
		protected var directory:String;
		
		public function BuildFontClass(fontProfile:FontProfile, index:int, directory:String)
		{
			this.fontProfile = fontProfile;
			this.index = index;		
			this.directory = directory;
		}

	public function execute():void {
		buildActionScript();

		var classFile:String = directory + className + ".as";

		var uriExists:URIExists = new URIExists(directory);
		uriExists.execute();

		if (!uriExists.result) {
			var createDirectory:CreateDirectory = new CreateDirectory(directory);
			createDirectory.execute();
		}

		uriExists = new URIExists(classFile);
		uriExists.execute();

		if (uriExists.result) {
			var writeFile:WriteFile = new WriteFile(classFile, _fontClass);
			writeFile.execute();
		} else {
			var createFile:CreateFile = new CreateFile(classFile, _fontClass);
			createFile.execute();
		}
	}

	public function get fontClass():String
		{
			return _fontClass;
		}
		
		protected function buildActionScript():void
		{			
			var pattern:RegExp;
			
			_fontClass = (new FontClassTemplate()).toString();
			//className = FONT_CLASS_PREFIX + index.toString();
			className = fontProfile.fontClassName + index.toString();
			var sourceFontParam:String;
			var systemFontParam:String;
			
			if(fontProfile.sourceFont.length > 0){
				var source:String = fontProfile.sourceFont.replace(pattern = /\\/g,"/");
				sourceFontParam = "source = '"+source+"',";
				systemFontParam = '';
			} else if (fontProfile.systemFont.length > 0){
				sourceFontParam = '';
				systemFontParam = "systemFont = '"+fontProfile.systemFont+"',"			
			}
			
			/*			
			var fontWeightParam:String 
			var fontStyleParam:String
			
			if (profile.fontWeight != FontStyle.REGULAR){
			fontWeightParam = "fontWeight = '"+profile.fontWeight+"',";
			} else {
			fontWeightParam = '';
			}				
			if (profile.fontStyle != FontStyle.REGULAR){
			fontStyleParam = " fontStyle = '"+profile.fontStyle+"',";					
			} else {
			fontStyleParam = '';
			}
			*/
			
			_fontClass = _fontClass.replace(pattern = /\${className}/g, className);
			_fontClass = _fontClass.replace(pattern = /\${fontName}/g, fontProfile.fontName);
			_fontClass = _fontClass.replace(pattern = /\${sourceFont}/g, sourceFontParam);
			_fontClass = _fontClass.replace(pattern = /\${systemFont}/g, systemFontParam);
			_fontClass = _fontClass.replace(pattern = /\${fontWeight}/g, fontProfile.fontWeight);
			_fontClass = _fontClass.replace(pattern = /\${fontStyle}/g, fontProfile.fontStyle);
			_fontClass = _fontClass.replace(pattern = /\${fontType}/g, fontProfile.fontType);
			_fontClass = _fontClass.replace(pattern = /\${unicodeRange}/g, fontProfile.unicodeRange);
			_fontClass = _fontClass.replace(pattern = /\${fontDecoration}/g, fontProfile.fontDecoration);
			_fontClass = _fontClass.replace(pattern = /\${advancedAntiAliasing}/g, fontProfile.advancedAntiAliasing);
			_fontClass = _fontClass.replace(pattern = /\${mimeType}/g, fontProfile.mimeType);
			_fontClass = _fontClass.replace(pattern = /\${cff}/g, fontProfile.cff);
		}
	}
}