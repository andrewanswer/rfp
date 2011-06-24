package ca.johannes.fontPublisher.model
{
	import ca.johannes.fontPublisher.events.FontProfileChangeEvent;
	import ca.johannes.fontPublisher.publish.FontProfile;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	
	import org.flexunit.async.Async;
	
	public class FontPublisherTest
	{
		private var fontPublisher:FontPublisherModel;
		private var oldFontProfile:FontProfile;
		private var newFontProfile:FontProfile;
		private var fontProfiles:ArrayCollection;
		private var fontSubfamilies:ArrayCollection;
		
		[Before]
		public function setupFontPublisher():void
		{
			fontPublisher = new FontPublisherModel();
		}
		
		[After]
		public function destroyFontPublisher():void
		{
			fontProfiles = null;
			fontSubfamilies = null;
			fontPublisher = null;
		}
		
		[Test]
		public function testCreateFontProfile():void
		{
			var fontProfile:FontProfile = fontPublisher.fontProfile;
			
			fontPublisher.createFontProfile();
			Assert.assertTrue(fontProfile != fontPublisher.fontProfile);
		}		
		
		[Test]
		public function testAddFontProfile():void
		{
			var fontProfile:FontProfile = new FontProfile();
			var totalProfiles:int = fontPublisher.fontProfiles.length;
			var profileIsInCollection:Boolean = false;
			
			fontPublisher.addFontProfile(fontProfile);
			for each (var profile:FontProfile in fontPublisher.fontProfiles){
				if (profile == fontProfile) {
					profileIsInCollection = true;
					break;
				}
			}
			Assert.assertFalse(profileIsInCollection);
			Assert.assertFalse(fontPublisher.fontProfiles.length > totalProfiles);
			
			fontProfile.fontName = "my font";
			fontProfile.systemFont = "Arial";
			fontProfile.embeddedCharacters = "abc";
			
			fontPublisher.addFontProfile(fontProfile);
			for each (profile in fontPublisher.fontProfiles){
				if (profile == fontProfile) {
					profileIsInCollection = true;
					break;
				}
			}
			Assert.assertTrue(profileIsInCollection);
			Assert.assertTrue(fontPublisher.fontProfiles.length > totalProfiles);			
		}
		
		[Test]
		public function testRemoveFontProfile():void
		{
			var fontProfile:FontProfile = new FontProfile();
			fontProfile.fontName = "my font";
			fontProfile.systemFont = "Arial";
			fontProfile.embeddedCharacters = "abc";
			fontPublisher.addFontProfile(fontProfile);
			
			var totalProfiles:int = fontPublisher.fontProfiles.length;
			var profileIsInCollection:Boolean = false;		
			
			fontPublisher.removeFontProfile(new FontProfile());
			for each (var profile:FontProfile in fontPublisher.fontProfiles){
				if (profile == fontProfile) {
					profileIsInCollection = true;
					break;
				}
			}
			Assert.assertTrue(profileIsInCollection);
			Assert.assertEquals(totalProfiles, fontPublisher.fontProfiles.length);
			
			fontPublisher.removeFontProfile(fontProfile);
			profileIsInCollection = false;
			for each (profile in fontPublisher.fontProfiles){
				if (profile == fontProfile) {
					profileIsInCollection = true;
					break;
				}
			}
			Assert.assertFalse(profileIsInCollection);
			Assert.assertTrue(totalProfiles > fontPublisher.fontProfiles.length);
		}		
		
		[Test]
		public function testGet_fontProfile():void
		{
			var fontProfile:FontProfile = new FontProfile();
			fontPublisher.fontProfile = fontProfile;
			Assert.assertEquals(fontProfile, fontPublisher.fontProfile);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontProfile():void
		{
			oldFontProfile = fontPublisher.fontProfile;
			newFontProfile = new FontProfile();
			
			Async.handleEvent(this, fontPublisher, FontProfileChangeEvent.FONT_PROFILE_CHANGE, fontProfileChange);			
			fontPublisher.fontProfile = newFontProfile;	
		}
		private function fontProfileChange(event:FontProfileChangeEvent, params:*):void
		{
			Assert.assertEquals(oldFontProfile, event.prevFontProfile);
			Assert.assertEquals(newFontProfile, event.fontProfile);
			Assert.assertEquals(newFontProfile, fontPublisher.fontProfile);
		}
		
		[Test]
		public function testSetFontProfile():void
		{
			var object:Object = new Object();
			fontPublisher.setFontProfile(object);
			Assert.assertTrue(object != fontPublisher.fontProfile);
			
			var fontProfile:FontProfile = new FontProfile();
			fontPublisher.fontProfile = fontProfile;
			Assert.assertEquals(fontProfile, fontPublisher.fontProfile);
		}
		
		[Test]
		public function testGet_fontProfiles():void
		{
			var fontProfiles:ArrayCollection = new ArrayCollection(new Array());
			fontPublisher.fontProfiles = fontProfiles;
			Assert.assertEquals(fontProfiles, fontPublisher.fontProfiles);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontProfiles():void
		{
			fontProfiles = new ArrayCollection(new Array());
			
			Async.handleEvent(this, fontPublisher, FontPublisherModel.PROFILES_CHANGE, fontProfilesChange);			
			fontPublisher.fontProfiles = fontProfiles;
		}
		private function fontProfilesChange(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.PROFILES_CHANGE, event.type);
			Assert.assertEquals(fontProfiles, fontPublisher.fontProfiles);
		}
		
		
		[Test]
		public function testGet_fontReady():void
		{
			Assert.assertFalse(fontPublisher.fontReady);
			fontPublisher.fontReady = true;
			Assert.assertTrue(fontPublisher.fontReady);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_fontReady():void
		{
			Async.handleEvent(this, fontPublisher, FontPublisherModel.FONT_READY, fontReadyChange);			
			fontPublisher.fontReady = true;
		}
		private function fontReadyChange(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.FONT_READY, event.type);
			Assert.assertTrue(fontPublisher.fontReady);
		}
		
		[Test]
		public function testGet_publishReady():void
		{
			Assert.assertFalse(fontPublisher.publishReady);
			fontPublisher.publishReady = true;
			Assert.assertTrue(fontPublisher.publishReady);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_publishReady():void
		{
			Async.handleEvent(this, fontPublisher, FontPublisherModel.PUBLISH_READY, publishReadyChange);			
			fontPublisher.publishReady = true;
		}
		private function publishReadyChange(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.PUBLISH_READY, event.type);
			Assert.assertTrue(fontPublisher.publishReady);
		}
		
		[Test]
		public function testGet_unicodeRanges():void
		{
			var unicodeTable:XML = <glyphRange name="Lowercase [a..z] " id="2" >
									<range min="0x0020" max ="0x0020" />
									<range min="0x0061" max ="0x007A" />
									</glyphRange>
			
			var ranges:XMLListCollection = new XMLListCollection(unicodeTable..glyphRange);
			fontPublisher.unicodeRanges = ranges;
			Assert.assertTrue(fontPublisher.unicodeRanges);
		}
		
		[Test(async,timeout='1000')]
		public function testSet_unicodeRanges():void
		{
			var unicodeTable:XML = <glyphRange name="Lowercase [a..z] " id="2" >
									<range min="0x0020" max ="0x0020" />
									<range min="0x0061" max ="0x007A" />
									</glyphRange>
				
			var ranges:XMLListCollection = new XMLListCollection(unicodeTable..glyphRange);
			Async.handleEvent(this, fontPublisher, FontPublisherModel.UNICODE_RANGES_CHANGE, unicodeRangesChange);	
			fontPublisher.unicodeRanges = ranges;
		}
		private function unicodeRangesChange(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.UNICODE_RANGES_CHANGE, event.type);
			Assert.assertTrue(fontPublisher.unicodeRanges);
		}
		
		[Test]
		public function testGet_fontSubfamilies():void
		{
			var arrayCollection:ArrayCollection = new ArrayCollection();
			fontPublisher.fontSubfamilies = arrayCollection;
			Assert.assertEquals(arrayCollection, fontPublisher.fontSubfamilies);
		}
		[Test(async,timeout='1000')]
		public function testSet_fontSubfamilies():void
		{
			fontSubfamilies = new ArrayCollection();
			Async.handleEvent(this, fontPublisher, FontPublisherModel.FONT_SUBFAMILIES_CHANGE, fontSubfamiliesChange);			
			fontPublisher.fontSubfamilies = fontSubfamilies;
		}
		private function fontSubfamiliesChange(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.FONT_SUBFAMILIES_CHANGE, event.type);
			Assert.assertTrue(fontPublisher.fontSubfamilies);
			Assert.assertEquals(fontSubfamilies, fontPublisher.fontSubfamilies);
		}
		
		[Test(async,timeout='10000')]
		public function testFontSubfamilies_from_fontProfileSourceFont_valid_path():void
		{
			Async.handleEvent(this, fontPublisher, FontPublisherModel.FONT_SUBFAMILIES_CHANGE, fontSubfamilies_fontProfileSourceFont_valid_path);
			fontPublisher.fontProfile.sourceFont = "../etc/test/Chunkfive.otf";
		}
		private function fontSubfamilies_fontProfileSourceFont_valid_path(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.FONT_SUBFAMILIES_CHANGE, event.type);
		}
		
		[Test(async,timeout='10000')]
		public function testFontSubfamilies_from_fontProfileSourceFont_invalid_path():void
		{
			Async.handleEvent(this, fontPublisher, FontPublisherModel.FONT_SUBFAMILIES_CHANGE, fontSubfamilies_fontProfileSourceFont_invalid_path);
			fontPublisher.fontProfile.sourceFont = '';
		}
		private function fontSubfamilies_fontProfileSourceFont_invalid_path(event:Event, params:*):void
		{
			Assert.assertEquals(FontPublisherModel.FONT_SUBFAMILIES_CHANGE, event.type);
			Assert.assertNull(fontPublisher.fontSubfamilies);
		}
	}
}