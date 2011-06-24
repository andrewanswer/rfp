package ca.johannes.externalExecute.fileSystem
{
	public class BrowseForDirectory extends AbstractFileSystemExecute
	{
		protected static const FUNCTION_NAME:String = "browseForDirectory";
		
		protected var _selectPrompt:String
		
		public function BrowseForDirectory(selectPrompt:String = "")
		{
			super();
			_selectPrompt = selectPrompt;
		}
		
		override public function execute():void
		{
			super.result = callMethod(FUNCTION_NAME, selectPrompt);
		}
		
		public function get result():String
		{
			return _result as String;
		}
		
		public function get selectPrompt():String
		{
			return _selectPrompt;
		}
	}
}