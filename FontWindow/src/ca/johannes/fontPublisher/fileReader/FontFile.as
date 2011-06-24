package ca.johannes.fontPublisher.fileReader
{
	import org.sepy.fontreader.TFont;
	import org.sepy.fontreader.TFontCollection;
	import org.sepy.fontreader.table.DirectoryEntry;
	import org.sepy.fontreader.table.ID;
	import org.sepy.fontreader.table.Table;

	public class FontFile
	{
		protected var _url:String;
		protected var fontCollection:TFontCollection;
		
		public function FontFile(fontCollection:TFontCollection, url:String)
		{
			this.fontCollection = fontCollection;
			_url = url;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function fullFontName(index:uint = 0):String
		{
			return getProperty(ID.nameFullFontName, index);
		}
		
		public function familyName(index:uint = 0):String
		{
			return getProperty(ID.nameFontFamilyName, index);
		}
		
		public function subfamilyName(index:uint = 0):String
		{
			return getProperty(ID.nameFontSubfamilyName, index);
		}
		
		public function uniqueFontIdentifier(index:uint = 0):String
		{
			return getProperty(ID.nameUniqueFontIdentifier, index);
		}
		
		public function versionString(index:uint = 0):String
		{
			return getProperty(ID.nameVersionString, index);
		}
		
		public function copyrightNotice(index:uint = 0):String
		{
			return getProperty(ID.nameCopyrightNotice, index);
		}
		
		public function manufacturer(index:uint = 0):String
		{
			return getProperty(ID.nameManufacturerName, index);
		}
		
		public function get length():uint
		{
			return fontCollection.getFontCount();
		}
		
		protected function getProperty(property:int, index:int = 0):String
		{
			var font:TFont = fontCollection.getFont(index);
			return font.getNameTable().getRecordString(property);
		}
	}
}