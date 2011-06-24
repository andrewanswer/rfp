package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.CreateFile;
	import ca.johannes.externalExecute.fileSystem.DeleteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class ReadFileTest
	{
		private var readFile:ReadFile;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt'; 
			
			var createFile:CreateFile = new CreateFile(testURI, 'test');
			createFile.execute();
			
			readFile = new ReadFile(testURI);
		}
		
		[After]
		public function tearDown():void
		{
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			
			if (fileExists.result) {
				var deleteFile:DeleteFile = new DeleteFile(testURI);
				deleteFile.execute();
			}
		}
		
		[Test]
		public function testExecute():void
		{
			readFile.execute();
			Assert.assertTrue(readFile.success);
			Assert.assertEquals('test', readFile.result);
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, readFile.fileURI);
			readFile.execute();
			Assert.assertEquals(testURI, readFile.fileURI);
		}
		
		[Test]
		public function testReadFile():void
		{
			Assert.assertNotNull(readFile);
		}
		
		[Test]
		public function testGet_result():void
		{
			readFile.execute();
			Assert.assertEquals('test', readFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(readFile.success);
			readFile.execute();
			Assert.assertTrue(readFile.success);
		}
	}
}