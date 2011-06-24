package ca.johannes.fontPublisher.fileReader
{
	import ca.johannes.fontPublisher.events.FontFileEvent;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class FontFileTest_TTF
	{
		private var fontFile:FontFile;
		private var fontReader:FontReader;
		
		[Before(async,timeout='10000')]
		public function setUp():void
		{
			fontReader = new FontReader();
			Async.handleEvent(this, fontReader, FontFileEvent.LOADED, getLoad);
			
			var url:String = "../etc/test/GenAI102.TTF";
			fontReader.load(url);			
		}
		private function getLoad(event:FontFileEvent, params:*):void
		{
			fontFile = event.fontFile;
			fontReader.removeEventListener(FontFileEvent.LOADED, getLoad);
		}
		
		[After]
		public function tearDown():void
		{
			fontReader.close();
			fontReader = null;
			fontFile = null;
		}
		
		[Test]
		public function testFamilyName():void
		{
			Assert.assertEquals("GentiumAlt", fontFile.familyName());
		}
		
		[Test]
		public function testFullFontName():void
		{
			Assert.assertEquals("GentiumAlt Italic", fontFile.fullFontName());
		}
		
		[Test]
		public function testGet_length():void
		{
			Assert.assertEquals(1, fontFile.length);
		}
		
		[Test]
		public function testSubfamilyName():void
		{
			Assert.assertEquals("Italic", fontFile.subfamilyName());
		}
		
		[Test]
		public function testUniqueFontIdentifier():void
		{
			Assert.assertEquals("SIL: GentiumAlt Italic: 2005", fontFile.uniqueFontIdentifier());
		}
		
		[Test]
		public function testVersionString():void
		{
			Assert.assertEquals("Version 1.02; 2005; OFL release", fontFile.versionString());
		}
		
	}
}