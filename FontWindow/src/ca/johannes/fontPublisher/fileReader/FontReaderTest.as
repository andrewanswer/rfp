package ca.johannes.fontPublisher.fileReader
{
	import ca.johannes.fontPublisher.events.FontFileEvent;
	
	import flash.events.IOErrorEvent;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class FontReaderTest
	{
		private var fontReader:FontReader;
		
		[Before]
		public function setUp():void
		{
			fontReader = new FontReader();
		}
		
		[After]
		public function tearDown():void
		{
			fontReader.close();
			fontReader = null;
		}
		
		
		[Test(async,timeout='10000')]
		public function testClose():void
		{
			Async.failOnEvent(this, fontReader, FontFileEvent.LOADED);
			var url:String = "../etc/test/Arial Rounded Bold.ttf";
			fontReader.load(url);
			
			fontReader.close();
			
			Assert.assertNull(fontReader.fontFile);
		}
		
		
		[Test(async,timeout='10000')]
		public function testGet_fontFile():void
		{
			Async.handleEvent(this, fontReader, FontFileEvent.LOADED, getFontFileLoad);
			
			var url:String = "../etc/test/Chunkfive.otf";
			fontReader.load(url);			
		}
		private function getFontFileLoad(event:FontFileEvent, params:*):void
		{
			Assert.assertNotNull(fontReader.fontFile);
		}
		
		[Test(async,timeout='10000')]
		public function testLoad():void
		{
			Async.handleEvent(this, fontReader, FontFileEvent.LOADED, getLoad);
			
			var url:String = "../etc/test/Chunkfive.otf";
			fontReader.load(url);			
		}
		private function getLoad(event:FontFileEvent, params:*):void
		{
			Assert.assertEquals(FontFileEvent.LOADED, event.type);
			Assert.assertNotNull(event.fontFile);
		}
		
		[Test(async,timeout='10000')]
		public function testIOErrorEvent():void
		{
			Async.handleEvent(this, fontReader, IOErrorEvent.IO_ERROR, getIOErrorEvent);
			Async.failOnEvent(this, fontReader, FontFileEvent.LOADED);
			
			var url:String = "../etc/test/no such file";
			fontReader.load(url);	
		}
		private function getIOErrorEvent(event:IOErrorEvent, params:*):void
		{
			Assert.assertEquals(IOErrorEvent.IO_ERROR, event.type);
		}
	}
}