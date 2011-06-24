package ca.johannes.externalExecute.fileSystem.utils
{
	import ca.johannes.externalExecute.fileSystem.AbstractFileSystemExecute;
	
	public class PlatformPathToURI extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "platformPathToURI";
		
		protected var _platformPath:String
		
		public function PlatformPathToURI(platformPath:String)
		{
			super();
			_platformPath = platformPath;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, platformPath);
		}
		
		public function get result():String
		{
			return _result as String;
		}
		
		public function get platformPath():String
		{
			return _platformPath;
		}
	}
}