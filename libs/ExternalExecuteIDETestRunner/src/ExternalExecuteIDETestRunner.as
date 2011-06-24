package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class ExternalExecuteIDETestRunner extends Sprite
	{
		private var url:String = "FlexUnitApplication.swf";
		
		public function ExternalExecuteIDETestRunner()
		{
			var ldr:Loader = new Loader();
			addChild(ldr);
			var urlReq:URLRequest = new URLRequest(url);
			ldr.load(urlReq);
			ldr.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void
		{
			var ldr:Loader = event.currentTarget as Loader;
			ldr.removeEventListener(MouseEvent.CLICK, onClick);
			ldr.unload();
			removeChild(ldr);
			
			ldr = null;
			
			ldr = new Loader();
			addChild(ldr);
			var urlReq:URLRequest = new URLRequest(url);
			ldr.load(urlReq);
			ldr.addEventListener(MouseEvent.CLICK, onClick);
		}
	}
}