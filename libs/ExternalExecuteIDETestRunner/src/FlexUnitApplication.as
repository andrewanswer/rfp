package
{
	import Array;
	
	import ca.johannes.externalExecute.fileSystem.CopyFileTest;
	import ca.johannes.externalExecute.fileSystem.CreateDirectoryTest;
	import ca.johannes.externalExecute.fileSystem.CreateFileTest;
	import ca.johannes.externalExecute.fileSystem.DeleteDirectoryContentsTest;
	import ca.johannes.externalExecute.fileSystem.DeleteDirectoryTest;
	import ca.johannes.externalExecute.fileSystem.DeleteFileTest;
	import ca.johannes.externalExecute.fileSystem.ListDirectoryContentsTest;
	import ca.johannes.externalExecute.fileSystem.MoveFileTest;
	import ca.johannes.externalExecute.fileSystem.ReadFileTest;
	import ca.johannes.externalExecute.fileSystem.WriteFileTest;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "ExternalExecuteIDETestRunner");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(ca.johannes.externalExecute.fileSystem.CopyFileTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.CreateDirectoryTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.CreateFileTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.DeleteDirectoryContentsTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.DeleteDirectoryTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.DeleteFileTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.ListDirectoryContentsTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.MoveFileTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.ReadFileTest);
			testsToRun.push(ca.johannes.externalExecute.fileSystem.WriteFileTest);
			return testsToRun;
		}
	}
}