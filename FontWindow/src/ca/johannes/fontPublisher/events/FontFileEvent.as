package ca.johannes.fontPublisher.events
{
	import ca.johannes.fontPublisher.fileReader.FontFile;
	
	import flash.events.Event;
	
	public class FontFileEvent extends Event
	{
		public static const LOADED:String = "Loaded";
		
		public var fontFile:FontFile;
		
		public function FontFileEvent(type:String, fontFile:FontFile)
		{
			this.fontFile = fontFile;
			super(type);
		}
		
		override public function clone():Event
		{
			return new FontFileEvent(type, fontFile);
		}
	}
}