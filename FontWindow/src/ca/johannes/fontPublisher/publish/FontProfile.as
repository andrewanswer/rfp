package ca.johannes.fontPublisher.publish
{	
	import ca.johannes.utils.convertToUHexNotation;
	import ca.johannes.utils.parseFileExtension;
	import ca.johannes.utils.removeDuplicates;
	
	import flash.events.EventDispatcher;
	import flash.text.FontStyle;
	import flash.text.FontType;
	
	import mx.core.IPropertyChangeNotifier;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	
	public class FontProfile extends EventDispatcher implements IPropertyChangeNotifier
	{
		public static const OTF:String = "otf";
		public static const TTF:String = "ttf";
		public static const TTC:String = "ttc";
		public static const OPEN_TYPE:String = "OpenType";
		public static const TRUE_TYPE:String = "TrueType";
		public static const TRUE_TYPE_COLLECTION:String = "TrueTypeCollection";
		public static const MIMETYPE_TTF:String = "application/x-font-truetype";
		public static const MIMETYPE_TTC:String = "application/x-font-truetype-collection";
		public static const MIMETYPE_OTF:String = "application/x-font-opentype";

		protected var _uid:String;
	
		protected var _sourceFont:String;
		protected var _systemFont:String;
		protected var _fontName:String;
		protected var _fontDecoration:String = FontStyle.REGULAR;
		protected var _fontWeight:String = FontStyle.REGULAR;
		protected var _fontStyle:String = FontStyle.REGULAR;
		protected var _fontType:String = FontType.EMBEDDED;
		protected var _fontFamily:String;
		protected var _fontSubfamily:String;
		protected var _fontFileType:String;
		protected var _mimeType:String;
		protected var _advancedAntiAliasing:Boolean;
		protected var _cff:Boolean;
		protected var _unicodeRange:String;
		
		protected var _embeddedCharacters:String;
		protected var _embeddedCharactersUHex:String;
		protected var _embeddedRanges:String;
		protected var _embeddedRangeIds:Array = new Array();
		
		public function get uid():String
		{
			return _uid;	
		}
		public function set uid(value:String):void
		{
			_uid = value;
		}
		
		public function get advancedAntiAliasing():Boolean
		{
			return _advancedAntiAliasing;
		}
		public function set advancedAntiAliasing(value:Boolean):void
		{
			setProperty("advancedAntiAliasing", advancedAntiAliasing, value);
		}
		
		public function get cff():Boolean
		{
			return _cff;
		}
		public function set cff(value:Boolean):void
		{
			setProperty("cff", cff, value);
			
			if(value){
				fontType = FontType.EMBEDDED_CFF;
				advancedAntiAliasing = false;
			} else {
				fontType = FontType.EMBEDDED;
			}
		}
		
		public function get systemFont():String
		{
			return _systemFont;
		}
		public function set systemFont(value:String):void
		{
			setProperty("sourceFont", sourceFont, null);
			setProperty("systemFont", systemFont, value);
		}
		
		public function get sourceFont():String
		{
			return _sourceFont;
		}
		public function set sourceFont(value:String):void
		{
			setProperty("systemFont", systemFont, null);

			var fileType:String = null;
			var extension:String = parseFileExtension(value);
			switch (extension) {
				case OTF:
					fileType = OPEN_TYPE;
					mimeType = MIMETYPE_OTF;
					break;
				case TTF:
					fileType = TRUE_TYPE;
					mimeType = MIMETYPE_TTF;
					break;
				case TTC:
					fileType = TRUE_TYPE_COLLECTION;
					mimeType = MIMETYPE_TTC;
					break;
				default:
					break;
			}
			fontFileType = fileType;
			
			setProperty("sourceFont", sourceFont, value);
		}
		
		public function get fontName():String
		{
			return _fontName;
		}
		public function set fontName(value:String):void
		{
			setProperty("fontName", fontName, value);
		}
		
		public function get fontFamily():String
		{
			return _fontFamily;
		}
		public function set fontFamily(value:String):void
		{
			setProperty("fontFamily", fontFamily, value);
		}
		
		public function get fontSubfamily():String
		{
			return _fontSubfamily;
		}
		public function set fontSubfamily(value:String):void
		{
			setProperty("fontSubfamily", fontSubfamily, value);
			
			if (isBold(fontSubfamily)) {
				fontWeight = FontStyle.BOLD;
			} else {
				fontWeight = FontStyle.REGULAR;
			}
			
			if (isItalic(fontSubfamily)) {
				fontStyle = FontStyle.ITALIC;
			} else {
				fontStyle = FontStyle.REGULAR;
			}
		}
		
		public function get fontWeight():String
		{
			return _fontWeight;
		}
		public function set fontWeight(value:String):void
		{
			setProperty("fontWeight", fontWeight, value);
			setFontDecoration(fontWeight, fontStyle);
		}
		
		public function get fontStyle():String
		{
			return _fontStyle;
		}
		public function set fontStyle(value:String):void
		{			
			setProperty("fontStyle", fontStyle, value);
			setFontDecoration(fontWeight, fontStyle);
		}
		
		public function get fontType():String
		{
			return _fontType;
		}
		public function set fontType(value:String):void
		{
			setProperty("fontType", fontType, value);
		}
		
		public function get fontFileType():String
		{
			return _fontFileType;
		}
		public function set fontFileType(value:String):void
		{
			setProperty("fontFileType", fontFileType, value);
		}
		
		public function get mimeType():String
		{
			return _mimeType;
		}
		public function set mimeType(value:String):void
		{
			setProperty("mimeType", mimeType, value);
		}
		
		public function get fontDecoration():String
		{
			return _fontDecoration;
		}
		public function set fontDecoration(value:String):void
		{
			setProperty("fontDecoration", fontDecoration, value);
		}
		public function setFontDecoration(fontWeight:String, fontStyle:String):void
		{
			if (fontWeight == FontStyle.REGULAR) {
				fontDecoration = fontStyle;
			} else if (fontStyle == FontStyle.REGULAR) {
				fontDecoration = fontWeight;
			} else if (fontWeight == FontStyle.BOLD && fontStyle == FontStyle.ITALIC) {
				fontDecoration = FontStyle.BOLD_ITALIC;
			}
		}
		
		public function get unicodeRange():String
		{
			return _unicodeRange;
		}
		public function set unicodeRange(value:String):void
		{
			setProperty("unicodeRange", unicodeRange, value);
		}
		public function setUnicodeRange(embeddedCharacters:String, embeddedRanges:String):void
		{
			if (embeddedCharacters && embeddedRanges){
				unicodeRange = embeddedCharacters + ", " + embeddedRanges;
			} else if (!embeddedCharacters && embeddedRanges) {
				unicodeRange = embeddedRanges;
			} else if (embeddedCharacters && !embeddedRanges) {
				unicodeRange = embeddedCharacters;
			} else if (!embeddedCharacters && !embeddedRanges){
				unicodeRange = null;
			}
		}
		
		public function get embeddedCharacters():String
		{
			return _embeddedCharacters;
		}
		public function set embeddedCharacters(value:String):void
		{
			if (value == ''){
				value = null;
			}
			
			value = removeDuplicates(value);
			setProperty("embeddedCharacters", embeddedCharacters, value);
			embeddedCharactersUHex = convertToUHexNotation(value, ", ");
		}

		public function get embeddedCharactersUHex():String
		{
			return _embeddedCharactersUHex;
		}
		public function set embeddedCharactersUHex(value:String):void
		{
			if (value == ''){
				value = null;
			}
			setProperty("embeddedCharactersUHex", embeddedCharactersUHex, value);
			setUnicodeRange(embeddedCharactersUHex, embeddedRanges);
		}
		
		public function get embeddedRanges():String
		{
			return _embeddedRanges;
		}
		public function set embeddedRanges(value:String):void
		{
			setProperty("embeddedRanges", embeddedRanges, value);
			setUnicodeRange(embeddedCharactersUHex, embeddedRanges);
		}
		public function setEmbeddedRanges(value:Vector.<Object>):void
		{
			var ranges:String ='';			
			var len:int = value.length;
			var rangeIds:Array = new Array();
			for (var i:int = 0; i < len; i++){
				var glyphRange:XML = value[i] as XML;
				var range:XMLList = glyphRange..range;
				rangeIds.push(glyphRange.@id.toString());
				for each (var item:XML in range){
					var min:String = item.@min.toString();
					min = min.replace("0x", "U+");
					var max:String = item.@max.toString();
					max = max.replace("0x", "U+");
					if(min == max){
						ranges += min;
					} else {
						ranges += min + "-" + max;
					}
					ranges += ", ";
				}
			}
			ranges = ranges.substr(0, ranges.length-2);
			
			if (ranges == '') {
				ranges = null;
			}
			
			embeddedRanges = ranges;
			embeddedRangeIds = rangeIds;
		}
		
		public function get embeddedRangeIds():Array
		{
			return _embeddedRangeIds;
		}
		public function set embeddedRangeIds(value:Array):void
		{
			setProperty("embeddedRangeIds", embeddedRangeIds, value);
		}
		
		public function get publishReady():Boolean
		{
			return (fontName && unicodeRange && (systemFont || sourceFont));
		}
		
		public function setProperty(name:String, oldValue:*, newValue:*):void
		{
			//if (this["_"+name] != newValue){ //Breaks text input updating
				this["_"+name] = newValue;
				var event:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, 
																		false, 
																		false, 
																		PropertyChangeEventKind.UPDATE,
																		name,
																		oldValue,
																		newValue,
																		this);
				
				dispatchEvent(event);
			//}
		}
		
		protected static function isBold(value:String):Boolean
		{
			var bold:Boolean = false;
			
			if (value != null) {
				value = value.toLowerCase();
				if ((value.indexOf("bold") > -1) || (value.indexOf("heavy")  > -1)) {
					bold = true;
					
				} else {
					try {
						var w:int = parseInt(value);
						if (w >= 700) {
							bold = true;
						}
					} catch (error:Error) {
					}
				}
			}

			return bold;
		}
		
		protected static function isItalic(value:String):Boolean
		{
			var italic:Boolean = false;
			
			if (value != null) {
				value = value.toLowerCase();
				if ((value.indexOf("italic") > -1) || (value.indexOf("oblique") > -1)) {
					italic = true;
				}
			}
			
			return italic;
		}
	}
}