package ca.johannes.fontPublisher.fileReader
{
	import ca.johannes.fontPublisher.events.FontFileEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	
	import org.sepy.fontreader.TFont;
	import org.sepy.fontreader.TFontCollection;
	import org.sepy.fontreader.table.DirectoryEntry;
	import org.sepy.fontreader.table.ID;
	import org.sepy.fontreader.table.Table;
	
	public class FontReader extends EventDispatcher
	{
		protected var urlStream:URLStream;
		protected var urlRequest:URLRequest;
		protected var fontCollection:TFontCollection;
		protected var _fontFile:FontFile;
		
		public function load(url:String):void
		{
			urlRequest = new URLRequest(url);
			
			urlStream = new URLStream();
			urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			urlStream.addEventListener(Event.COMPLETE, onComplete);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			urlStream.load(urlRequest);
		}
		
		public function close():void
		{
			urlStream.removeEventListener(Event.COMPLETE, onComplete);
			urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			urlStream.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			if (urlStream.connected) {
				urlStream.close();
			}
			
		}
		
		public function get fontFile():FontFile
		{
			return _fontFile;
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		protected function onComplete(event:Event):void
		{
			var ioErrorEvent:IOErrorEvent;
			try {
				fontCollection = TFontCollection.create(event.target as URLStream, urlRequest.url);
			} catch (error:Error) {
				ioErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
				dispatchEvent(ioErrorEvent);
			}
			
			if (!ioErrorEvent) {
				_fontFile = new FontFile(fontCollection, urlRequest.url);
				
				var fontFileEvent:FontFileEvent = new FontFileEvent(FontFileEvent.LOADED, fontFile);
				dispatchEvent(fontFileEvent);
			}
			
			urlStream.removeEventListener(Event.COMPLETE, onComplete);
			urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			urlStream.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		protected function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(event);
		}
	}
}