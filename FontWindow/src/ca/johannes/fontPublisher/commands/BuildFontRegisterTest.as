package ca.johannes.fontPublisher.commands
{
	import ca.johannes.fontPublisher.publish.FontProfile;
	import ca.johannes.fontPublisher.commands.BuildFontRegister;
	
	import mx.collections.ArrayCollection;
	
	import flexunit.framework.Assert;
	
	public class BuildFontRegisterTest
	{
		[Embed(source="../../../../../etc/test/FontRegister0.txt", mimeType="application/octet-stream")]
		private static const FontRegister0:Class;
		
		[Embed(source="../../../../../etc/test/FontRegister1.txt", mimeType="application/octet-stream")]
		private static const FontRegister1:Class;
		
		private var buildFontRegister:BuildFontRegister;
		
		[After]
		public function destroyBuildFontRegister():void
		{
			buildFontRegister = null;
		}
		
		[Test]
		public function testGet_fontRegister_1Profile():void
		{
			var fontProfile:FontProfile = new FontProfile();
			fontProfile.fontName = "My Font";
			fontProfile.sourceFont = "c:/font.ttf";
			fontProfile.embeddedCharacters = "abc";
			
			var fontProfiles:ArrayCollection = new ArrayCollection();
			fontProfiles.addItem(fontProfile);
			
			buildFontRegister = new BuildFontRegister(fontProfiles, "/");
			buildFontRegister.execute();
			
			var fontRegisterTestResults:String = (new FontRegister0()).toString();
			var fontRegister:String = buildFontRegister.fontRegister;
			Assert.assertEquals(fontRegisterTestResults, fontRegister);
		}
		
		[Test]
		public function testGet_fontRegister_2Profiles():void
		{
			var fontProfile0:FontProfile = new FontProfile();
			fontProfile0.fontName = "My Font";
			fontProfile0.sourceFont = "c:/font.ttf";
			fontProfile0.embeddedCharacters = "abc";
			
			var fontProfile1:FontProfile = new FontProfile();
			fontProfile1.fontName = "My Other Font";
			fontProfile1.sourceFont = "c:/fontB.ttf";
			fontProfile1.embeddedCharacters = "0123";
			
			var fontProfiles:ArrayCollection = new ArrayCollection();
			fontProfiles.addItem(fontProfile0);
			fontProfiles.addItem(fontProfile1);
			
			buildFontRegister = new BuildFontRegister(fontProfiles, "/");
			buildFontRegister.execute();
			
			var fontRegisterTestResults:String = (new FontRegister1()).toString();
			var fontRegister:String = buildFontRegister.fontRegister;
			Assert.assertEquals(fontRegisterTestResults, fontRegister);
		}
	}
}