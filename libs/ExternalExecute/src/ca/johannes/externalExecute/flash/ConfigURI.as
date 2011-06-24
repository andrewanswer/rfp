package ca.johannes.externalExecute.flash
{
	public class ConfigURI extends AbstractFlashExecute
	{
		protected static const FUNCTION_NAME:String = "configURI";
		
		public function ConfigURI()
		{
			super();
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME);
		}
		
		public function get result():String
		{
			return _result as String;
		}
	}
}