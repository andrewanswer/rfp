package {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class LoadConfig extends EventDispatcher {
		public static var arrayFonts:Array;
		public static var FONT_LOADED:String = "FONT_LOADED";
		public function LoadConfig(url:String) {
			var loader:URLLoader = new URLLoader (new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onConfigComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onConfigError);
		}

		private function onConfigComplete(event:Event):void {
			var xml:XML = new XML(event.target.data);
			arrayFonts = new Array();
			var i:int = 0;
			for each(var object:* in xml.font) {
				var objFont:FontVO = new FontVO();
				objFont.id 				= i++;
				objFont.name 			= object.@name;
				objFont.icon 			= object.@icon;
				objFont.file			= object.@file;
				objFont.label			= object.@label;
				arrayFonts.push(objFont);
			}
			dispatchEvent(new Event(FONT_LOADED));
		}

		private function onConfigError(event:IOErrorEvent):void {
			trace('Config not loaded: '+event.text);
		}
	}
}
