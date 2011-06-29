package  {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;
	import flash.net.LocalConnection;
	import flash.system.SecurityDomain;
	import flash.system.ApplicationDomain;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Engine extends Sprite {
		private static var dir:String = "fonts/";
		public function Engine() {
			var lc:LoadConfig = new LoadConfig(dir + "fonts.xml");
			lc.addEventListener(LoadConfig.FONT_LOADED, init);
		}
		private function init(e:Event = null):void
		{
			for each(var font:FontVO in LoadConfig.arrayFonts) {
				loadFont(dir + font.file);
			}
		}
		private function loadFont(url:String):void
		{
			var fontLoader:Loader = new Loader();
			fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontLoad);
			fontLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFontLoadError);
			trace(url);
			fontLoader.load(new URLRequest(url),context);
		}
		public static function get context():LoaderContext
		{
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain); 
			var domain:String = new LocalConnection().domain;
			if (domain!="localhost") context.securityDomain = SecurityDomain.currentDomain; 
			context.applicationDomain = ApplicationDomain.currentDomain;
			return context;
		}
		private function listFonts():void
		{
			trace('fontlist length: ' + getFontLength());
			for (var i:int=0;i<getFontLength();i++)
			{
				trace('font: ' + getFontName(i)+ ', style: '+getFontStyle(i));
			}
		}
		private function getFontLength():int
		{
			return Font.enumerateFonts().length;
		}
		private function getFontName(i:int):String
		{
			var fontList:Array = Font.enumerateFonts();
			fontList.sortOn(['fontName','fontStyle']);
			return fontList[i].fontName;
		}
		private function getFontStyle(i:int):String
		{
			var fontList:Array = Font.enumerateFonts();
			fontList.sortOn(['fontName','fontStyle']);
			return fontList[i].fontStyle;
		}
		private var fields:Array = new Array;
		private function show():void {
			var i:int;
			if (fields.length>0)
				for(i=0;i<fields.length;i++)
					removeChild(fields[i]);
			fields = new Array;
			for (i=0;i<getFontLength();i++) {
				var tf:TextField = new TextField();
				var format:TextFormat = tf.getTextFormat();
				//tf.width = 400;
				//tf.height = 100;
				tf.textColor = 0x000000;
				tf.embedFonts = true;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				format.font = getFontName(i);
				format.size = 15;
				switch(getFontStyle(i)) {
					case 'regular':
						format.italic = false;
						format.bold = false;
					break;
					case 'bold':
						format.italic = false;
						format.bold = true;
					break;
					case 'italic':
						format.italic = true;
						format.bold = false;
					break;
					case 'boldItalic':
						format.italic = true;
						format.bold = true;
					break;
				}
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.text = getFontName(i)+" "+getFontStyle(i)+" The quick brown fox jumps over the lazy dog. 1234567890";
				tf.setTextFormat(format);
				fields.push(tf);
				addChild(tf);
				tf.y = i*20;
			}
		}
		private function onFontLoad(e:Event):void 
		{
			listFonts();
			show();
		}
		private function onFontLoadError(e:IOErrorEvent):void 
		{
			trace('Font not loaded: '+e.text);
		}
	}
}
