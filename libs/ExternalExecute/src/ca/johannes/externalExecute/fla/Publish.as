package ca.johannes.externalExecute.fla
{
	public class Publish extends AbstractFLAExecute
	{
		protected static const FUNCTION_NAME:String = "publish";
		
		protected var _fileURI:String;
		protected var _className:String;

		public function Publish(fileURI:String, className: String)
		{
			super();
			_fileURI = fileURI;
			_className = className;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, fileURI, className);
		}
		
		public function get result():Boolean
		{
			return _result as Boolean;
		}
		
		public function get fileURI():String
		{
			return _fileURI;
		}

		public function get className():String
		{
			return _className;
		}
	}
}