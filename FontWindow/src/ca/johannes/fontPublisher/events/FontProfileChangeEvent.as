package ca.johannes.fontPublisher.events
{
	import ca.johannes.fontPublisher.publish.FontProfile;
	
	import flash.events.Event;
	
	public class FontProfileChangeEvent extends Event
	{
		public static const FONT_PROFILE_CHANGE:String = "fontProfileChange";
		public var fontProfile:FontProfile;
		public var prevFontProfile:FontProfile;
		
		public function FontProfileChangeEvent(type:String, fontProfile:FontProfile, prevFontProfile:FontProfile)
		{
			this.fontProfile = fontProfile;
			this.prevFontProfile = prevFontProfile;
			super(type);
		}
		
		override public function clone():Event
		{
			return new FontProfileChangeEvent(FONT_PROFILE_CHANGE, fontProfile, prevFontProfile);
		}
	}
}