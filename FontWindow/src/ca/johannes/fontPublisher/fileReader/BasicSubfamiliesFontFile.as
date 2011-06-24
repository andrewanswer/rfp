package ca.johannes.fontPublisher.fileReader
{
	import org.sepy.fontreader.TFontCollection;
	
	public class BasicSubfamiliesFontFile extends FontFile
	{
		public function BasicSubfamiliesFontFile(fontCollection:TFontCollection, url:String)
		{
			super(fontCollection, url);
		}
		
		override public function subfamilyName(index:uint=0):String
		{
			switch (index) {
				case 0:
					return "Regular";
					break;
				case 1:
					return "Bold";
					break;
				case 2:
					return "Italic";
					break;
				case 3:
					return "Bold Italic";
					break;
				default:
					return "";
					break;
			}
		}
		
		override public function get length():uint
		{
			return 4;
		}
		
		override public function fullFontName(index:uint = 0):String
		{
			return "";
		}
		
		override public function familyName(index:uint = 0):String
		{
			return "";
		}
		
		override public function uniqueFontIdentifier(index:uint = 0):String
		{
			return "";
		}
		
		override public function versionString(index:uint = 0):String
		{
			return "";
		}
		
		override public function copyrightNotice(index:uint = 0):String
		{
			return "";
		}
		
		override public function manufacturer(index:uint = 0):String
		{
			return "";
		}
	}
}