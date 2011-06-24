package ca.johannes.fontPublisher.publish
{	
	import flash.text.FontStyle;
	import flash.text.FontType;
	
	import flexunit.framework.Assert;
	
	import mx.events.PropertyChangeEvent;
	
	import org.flexunit.async.Async;	
	
	public class FontProfileTest
	{
		private var fontProfile:FontProfile;
		private var rangeIds:Array;
		
		[Before]
		public function setupFontProfile():void
		{
			fontProfile = new FontProfile();
		}
		
		[After]
		public function destroyFontProfile():void
		{
			fontProfile = null;
		}
		
		[Test]
		public function testGet_embeddedCharacters():void
		{			
			fontProfile.embeddedCharacters = "abc";
			Assert.assertEquals("abc", fontProfile.embeddedCharacters);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_embeddedCharacters():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, embeddedCharactersChange);
			fontProfile.embeddedCharacters = "abc";			
		}
		private function embeddedCharactersChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("abc", event.newValue);
			Assert.assertEquals("embeddedCharacters", event.property);
			Assert.assertEquals("abc", fontProfile.embeddedCharacters);
		}
		

		[Test]
		public function testGet_embeddedCharactersUHex():void
		{
			fontProfile.embeddedCharactersUHex = "U+000";
			Assert.assertEquals("U+000", fontProfile.embeddedCharactersUHex);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_embeddedCharactersUHex():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, embeddedCharactersUHexChange);
			fontProfile.embeddedCharactersUHex = "U+000";			
		}
		private function embeddedCharactersUHexChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("U+000", event.newValue);
			Assert.assertEquals("embeddedCharactersUHex", event.property);
			Assert.assertEquals("U+000", fontProfile.embeddedCharactersUHex);
		}		

		[Test]
		public function testGet_embeddedRangeIds():void
		{
			var rangeIds:Array = new Array();
			fontProfile.embeddedRangeIds = rangeIds;
			Assert.assertEquals(rangeIds, fontProfile.embeddedRangeIds);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_embeddedRangeIds():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, embeddedRangeIdsChange);
			rangeIds = new Array();
			fontProfile.embeddedRangeIds = rangeIds;
		}
		private function embeddedRangeIdsChange(event:PropertyChangeEvent, params:*):void
		{
			var isOldValueArray:Boolean = event.oldValue is Array;
			Assert.assertTrue(isOldValueArray);
			var isNewValueArray:Boolean = event.newValue is Array;
			Assert.assertTrue(isNewValueArray);
			Assert.assertEquals("embeddedRangeIds", event.property);
			Assert.assertEquals(rangeIds, fontProfile.embeddedRangeIds);
		}
		
		[Test]
		public function testGet_embeddedRanges():void
		{
			fontProfile.embeddedRanges = "abc";
			Assert.assertEquals("abc", fontProfile.embeddedRanges);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_embeddedRanges():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, embeddedRangesChange);
			fontProfile.embeddedRanges = "abc";			
		}
		private function embeddedRangesChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("abc", event.newValue);
			Assert.assertEquals("embeddedRanges", event.property);
			Assert.assertEquals("abc", fontProfile.embeddedRanges);
		}
		
		[Test]
		public function testGet_advancedAntiAliasing():void
		{
			Assert.assertFalse(fontProfile.advancedAntiAliasing);
			fontProfile.advancedAntiAliasing = true;
			Assert.assertTrue(fontProfile.advancedAntiAliasing);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_advancedAntiAliasing():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, advancedAntiAliasingChange);
			fontProfile.advancedAntiAliasing = true;			
		}
		private function advancedAntiAliasingChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertFalse(event.oldValue);
			Assert.assertTrue(event.newValue);
			Assert.assertEquals("advancedAntiAliasing", event.property);
			Assert.assertTrue(fontProfile.advancedAntiAliasing);
		}
		
		[Test]
		public function testGet_cff():void
		{
			Assert.assertFalse(fontProfile.cff);
			fontProfile.cff = true;
			Assert.assertTrue(fontProfile.cff);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_cff():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, cffChange);
			fontProfile.cff = true;			
		}
		private function cffChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertFalse(event.oldValue);
			Assert.assertTrue(event.newValue);
			Assert.assertEquals("cff", event.property);
			Assert.assertTrue(fontProfile.cff);
		}
		
		[Test]
		public function testGet_fontDecoration():void
		{
			fontProfile.fontDecoration = FontStyle.BOLD;
			Assert.assertEquals(FontStyle.BOLD, fontProfile.fontDecoration);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontDecoration():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontDecorationChange);
			fontProfile.fontDecoration = FontStyle.BOLD;
		}
		private function fontDecorationChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertEquals(FontStyle.REGULAR, event.oldValue);
			Assert.assertEquals(FontStyle.BOLD, event.newValue);
			Assert.assertEquals("fontDecoration", event.property);
			Assert.assertEquals(FontStyle.BOLD, fontProfile.fontDecoration);
		}
		
		
		[Test]
		public function testGet_fontName():void
		{
			fontProfile.fontName = "my font";
			Assert.assertEquals("my font", fontProfile.fontName);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontName():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontNameChange);
			fontProfile.fontName = "my font";
		}
		private function fontNameChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("my font", event.newValue);
			Assert.assertEquals("fontName", event.property);
			Assert.assertEquals("my font", fontProfile.fontName);
		}
		
		
		[Test]
		public function testGet_fontType():void
		{
			Assert.assertEquals(FontType.EMBEDDED, fontProfile.fontType);
			fontProfile.fontType = FontType.EMBEDDED_CFF;
			Assert.assertEquals(FontType.EMBEDDED_CFF, fontProfile.fontType);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontType():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontTypeChange);
			fontProfile.fontType = FontType.EMBEDDED_CFF;
		}
		private function fontTypeChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertEquals(FontType.EMBEDDED, event.oldValue);
			Assert.assertEquals(FontType.EMBEDDED_CFF, event.newValue);
			Assert.assertEquals("fontType", event.property);
			Assert.assertEquals(FontType.EMBEDDED_CFF, fontProfile.fontType);
		}		
		
		[Test]
		public function testFontProfile():void
		{
			Assert.assertEquals(FontStyle.REGULAR, fontProfile.fontDecoration);
			Assert.assertEquals(FontStyle.REGULAR, fontProfile.fontStyle);
			Assert.assertEquals(FontStyle.REGULAR, fontProfile.fontWeight);
			Assert.assertFalse(fontProfile.advancedAntiAliasing);
			Assert.assertFalse(fontProfile.cff);
		}
		
		[Test]
		public function testGet_fontStyle():void
		{
			fontProfile.fontStyle = FontStyle.ITALIC;
			Assert.assertEquals(FontStyle.ITALIC, fontProfile.fontStyle);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontStyle():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontStyleChange);
			fontProfile.fontStyle = FontStyle.ITALIC;
		}
		private function fontStyleChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertEquals(FontStyle.REGULAR, event.oldValue);
			Assert.assertEquals(FontStyle.ITALIC, event.newValue);
			Assert.assertEquals("fontStyle", event.property);
			Assert.assertEquals(FontStyle.ITALIC, fontProfile.fontStyle);
		}
		
		[Test]
		public function testGet_fontWeight():void
		{
			fontProfile.fontWeight = FontStyle.BOLD;
			Assert.assertEquals(FontStyle.BOLD, fontProfile.fontWeight);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontWeight():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontWeightChange);
			fontProfile.fontWeight = FontStyle.BOLD;
		}
		private function fontWeightChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertEquals(FontStyle.REGULAR, event.oldValue);
			Assert.assertEquals(FontStyle.BOLD, event.newValue);
			Assert.assertEquals("fontWeight", event.property);
			Assert.assertEquals(FontStyle.BOLD, fontProfile.fontWeight);
		}
		
		[Test]
		public function testGet_publishReady():void
		{
			Assert.assertFalse(fontProfile.publishReady);
			fontProfile.fontName = "my font";
			fontProfile.unicodeRange = "abc";
			fontProfile.systemFont = "Arial";			
			Assert.assertTrue(fontProfile.publishReady);
			fontProfile.systemFont = "";
			fontProfile.sourceFont = "c://sysfont.tff";
			Assert.assertTrue(fontProfile.publishReady);
			fontProfile.sourceFont = "";
			Assert.assertFalse(fontProfile.publishReady);
			fontProfile.unicodeRange = "";
			Assert.assertFalse(fontProfile.publishReady);
			fontProfile.fontName = "";
			Assert.assertFalse(fontProfile.publishReady);			
		}
		
		[Test]
		public function testSetEmbeddedCharacters():void
		{
			fontProfile.embeddedCharacters = "abc";
			Assert.assertEquals("abc", fontProfile.embeddedCharacters);
			Assert.assertEquals("U+0061, U+0062, U+0063", fontProfile.embeddedCharactersUHex);
			Assert.assertEquals("U+0061, U+0062, U+0063", fontProfile.unicodeRange);
			
			fontProfile.embeddedCharacters = "";
			Assert.assertNull(fontProfile.embeddedCharacters);
			Assert.assertNull(fontProfile.embeddedCharactersUHex);
			Assert.assertNull(fontProfile.unicodeRange);
			
			fontProfile.embeddedCharactersUHex = "U+0061, U+0062, U+0063";
			Assert.assertNull(fontProfile.embeddedCharacters); //Does not convert back to regular characters
			Assert.assertEquals("U+0061, U+0062, U+0063", fontProfile.embeddedCharactersUHex);
			Assert.assertEquals("U+0061, U+0062, U+0063", fontProfile.unicodeRange);
			
			fontProfile.embeddedCharactersUHex = "";
			Assert.assertNull(fontProfile.embeddedCharacters);
			Assert.assertNull(fontProfile.embeddedCharactersUHex);
			Assert.assertNull(fontProfile.unicodeRange);
		}

		[Test]
		public function testSetEmbeddedRanges():void
		{
			var ranges:Vector.<Object> = new Vector.<Object>();
			var numeralRange:XML = <glyphRange name="Numerals [0..9] " id="3" >
							<range min="0x0030" max ="0x0039" />
							<range min="0x002E" max ="0x002E" />
							</glyphRange>;
			ranges.push(numeralRange);	
			
			fontProfile.setEmbeddedRanges(ranges);			
			Assert.assertEquals("U+0030-U+0039, U+002E", fontProfile.embeddedRanges);
			Assert.assertEquals("3", fontProfile.embeddedRangeIds[0]);
			
			var lowercaseRange:XML = <glyphRange name="Lowercase [a..z] " id="2" >
									<range min="0x0020" max ="0x0020" />
									<range min="0x0061" max ="0x007A" />
									</glyphRange>
			ranges.push(lowercaseRange);
			
			fontProfile.setEmbeddedRanges(ranges);			
			Assert.assertEquals("U+0030-U+0039, U+002E, U+0020, U+0061-U+007A", fontProfile.embeddedRanges);
			Assert.assertEquals("3", fontProfile.embeddedRangeIds[0]);
			Assert.assertEquals("2", fontProfile.embeddedRangeIds[1]);
			
			ranges = new Vector.<Object>();
			
			fontProfile.setEmbeddedRanges(ranges);
			Assert.assertNull(fontProfile.embeddedRanges);
			Assert.assertEquals(0, fontProfile.embeddedRangeIds.length);
		}

		[Test]
		public function testSetFontDecoration():void
		{
			fontProfile.setFontDecoration(FontStyle.REGULAR, FontStyle.REGULAR);
			Assert.assertEquals(FontStyle.REGULAR, fontProfile.fontDecoration);
			
			fontProfile.setFontDecoration(FontStyle.BOLD, FontStyle.REGULAR);
			Assert.assertEquals(FontStyle.BOLD, fontProfile.fontDecoration);
			
			fontProfile.setFontDecoration(FontStyle.REGULAR, FontStyle.ITALIC);
			Assert.assertEquals(FontStyle.ITALIC, fontProfile.fontDecoration);
			
			fontProfile.setFontDecoration(FontStyle.BOLD, FontStyle.ITALIC);
			Assert.assertEquals(FontStyle.BOLD_ITALIC, fontProfile.fontDecoration);			
		}
		
		[Test]
		public function testSetCFF():void
		{			
			fontProfile.cff = true;
			Assert.assertTrue(fontProfile.cff);
			Assert.assertFalse(fontProfile.advancedAntiAliasing);
			Assert.assertEquals(FontType.EMBEDDED_CFF, fontProfile.fontType);
			
			fontProfile.cff = false;
			Assert.assertFalse(fontProfile.cff);
			Assert.assertEquals(FontType.EMBEDDED, fontProfile.fontType);
			
			fontProfile.advancedAntiAliasing = true;
			Assert.assertTrue(fontProfile.advancedAntiAliasing);
			
			fontProfile.cff = true;
			Assert.assertTrue(fontProfile.cff);
			Assert.assertFalse(fontProfile.advancedAntiAliasing);
			Assert.assertEquals(FontType.EMBEDDED_CFF, fontProfile.fontType);			
		}
		
		[Test(async,timeout='1000')]
		public function testSetProperty():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, propertyChange);
			fontProfile.setProperty("embeddedCharacters", fontProfile.embeddedCharacters, "abc");
		}
		private function propertyChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("abc", event.newValue);
			Assert.assertEquals("embeddedCharacters", event.property);
			Assert.assertEquals("abc", fontProfile.embeddedCharacters);
		}
		
		[Test]
		public function testSetUnicodeRange():void
		{
			fontProfile.setUnicodeRange("", "");
			Assert.assertNull(fontProfile.unicodeRange);
			
			fontProfile.setUnicodeRange("U+0061", "");
			Assert.assertEquals("U+0061", fontProfile.unicodeRange);
			
			fontProfile.setUnicodeRange("", "U+0061");
			Assert.assertEquals("U+0061", fontProfile.unicodeRange);
			
			fontProfile.setUnicodeRange("U+0061", "U+0062, U+0063");
			Assert.assertEquals("U+0061, U+0062, U+0063", fontProfile.unicodeRange);
		}
		
		[Test]
		public function testGet_fontFileType():void
		{
			fontProfile.fontFileType = FontProfile.OPEN_TYPE;
			Assert.assertEquals(FontProfile.OPEN_TYPE, fontProfile.fontFileType);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontFileType():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, fontFileTypeChange);
			fontProfile.fontFileType = FontProfile.OPEN_TYPE;
		}
		private function fontFileTypeChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals(FontProfile.OPEN_TYPE, event.newValue);
			Assert.assertEquals("fontFileType", event.property);
			Assert.assertEquals(FontProfile.OPEN_TYPE, fontProfile.fontFileType);
		}
		
		[Test]
		public function testGet_sourceFont():void
		{
			fontProfile.sourceFont = "source";
			Assert.assertEquals("source", fontProfile.sourceFont);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_sourceFont():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, sourceFontChange);
			fontProfile.sourceFont = "source";
		}
		private function sourceFontChange(event:PropertyChangeEvent, params:*):void
		{
			if (event.property == "sourceFont") {
				Assert.assertNull(event.oldValue);
				Assert.assertEquals("source", event.newValue);
				Assert.assertEquals("sourceFont", event.property);
				Assert.assertEquals("source", fontProfile.sourceFont);
			}
		}
		
		[Test]
		public function testSetSourceFont():void
		{
			fontProfile.sourceFont = "c:/akbar.otf";
			Assert.assertEquals("c:/akbar.otf", fontProfile.sourceFont);
			Assert.assertEquals(FontProfile.OPEN_TYPE, fontProfile.fontFileType);
			
			fontProfile.sourceFont = "c:/AKBAR.OTF";
			Assert.assertEquals("c:/AKBAR.OTF", fontProfile.sourceFont);
			Assert.assertEquals(FontProfile.OPEN_TYPE, fontProfile.fontFileType);
			
			fontProfile.sourceFont = "c:/akbar.ttf";
			Assert.assertEquals("c:/akbar.ttf", fontProfile.sourceFont);
			Assert.assertEquals(FontProfile.TRUE_TYPE, fontProfile.fontFileType);
			
			fontProfile.sourceFont = "c:/AKBAR.TTF";
			Assert.assertEquals("c:/AKBAR.TTF", fontProfile.sourceFont);
			Assert.assertEquals(FontProfile.TRUE_TYPE, fontProfile.fontFileType);
			
			fontProfile.sourceFont = "c:/akbar.ttf.otf";
			Assert.assertEquals("c:/akbar.ttf.otf", fontProfile.sourceFont);
			Assert.assertEquals(FontProfile.OPEN_TYPE, fontProfile.fontFileType);
		}
		
		
		[Test]
		public function testGet_systemFont():void
		{
			fontProfile.systemFont = "system";
			Assert.assertEquals("system", fontProfile.systemFont);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_systemFont():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, systemFontChange);
			fontProfile.systemFont = "system";
		}
		private function systemFontChange(event:PropertyChangeEvent, params:*):void
		{
			if (event.property == "systemFont") {
				Assert.assertNull(event.oldValue);
				Assert.assertEquals("system", event.newValue);
				Assert.assertEquals("systemFont", event.property);
				Assert.assertEquals("system", fontProfile.systemFont);
			}
		}
		
		[Test]
		public function testGet_uid():void
		{
			fontProfile.uid = "01234";
			Assert.assertEquals("01234", fontProfile.uid);
		}
		
		[Test]
		public function testSet_uid():void
		{
			Assert.assertNull(fontProfile.uid);
			fontProfile.uid = "01234";
			Assert.assertEquals("01234", fontProfile.uid);
		}
		
		[Test]
		public function testGet_unicodeRange():void
		{
			fontProfile.unicodeRange = "U+0000";
			Assert.assertEquals("U+0000",fontProfile.unicodeRange);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_unicodeRange():void
		{
			Async.handleEvent(this, fontProfile, PropertyChangeEvent.PROPERTY_CHANGE, unicodeRangeChange);
			fontProfile.unicodeRange = "U+0000";
		}
		private function unicodeRangeChange(event:PropertyChangeEvent, params:*):void
		{
			Assert.assertNull(event.oldValue);
			Assert.assertEquals("U+0000", event.newValue);
			Assert.assertEquals("unicodeRange", event.property);
			Assert.assertEquals("U+0000", fontProfile.unicodeRange);
		}
		
	}
}