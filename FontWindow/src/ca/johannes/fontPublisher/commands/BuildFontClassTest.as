package ca.johannes.fontPublisher.commands
{
	import ca.johannes.fontPublisher.publish.FontProfile;
	
	import flash.text.FontStyle;
	
	import flexunit.framework.Assert;
	
	public class BuildFontClassTest
	{
		[Embed(source="../../../../../etc/test/RSFont0.txt", mimeType="application/octet-stream")]
		private static const FontClass0:Class
		
		private var buildFontClass:BuildFontClass;
		
		[After]
		public function destroyBuildFontClass():void
		{
			buildFontClass = null;
		}
		
		[Test]
		public function testGet_fontClass_Default_TTF():void
		{
			var fontProfile:FontProfile = new FontProfile();
			fontProfile.fontName = "My Font";
			fontProfile.sourceFont = "c:/font.ttf";
			fontProfile.embeddedCharacters = "abc";
			
			buildFontClass = new BuildFontClass(fontProfile, 0, "/");
			buildFontClass.execute();
			
			var fontClassTestResults:String = (new FontClass0()).toString();
			var fontClass:String = buildFontClass.fontClass;
			Assert.assertEquals(fontClassTestResults, fontClass);
		}
	}
}