package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.CreateFile;
	import ca.johannes.externalExecute.fileSystem.DeleteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class CreateFileTest
	{
		private var createFile:CreateFile;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt'; 
			
			createFile = new CreateFile(testURI, 'test');
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
			createFile = null;
		}
		
		[Test]
		public function testCreateFile():void
		{
			Assert.assertNotNull(createFile);
		}
		
		[Test]
		public function testExecute():void
		{
			createFile.execute();
			
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			
			Assert.assertTrue(fileExists.result);
			
			var readFile:ReadFile = new ReadFile(testURI);
			readFile.execute();
			
			Assert.assertEquals('test', readFile.result);
		}
		
		[Test]
		public function testGet_data():void
		{
			Assert.assertEquals('test', createFile.data);
			createFile.execute();
			Assert.assertEquals('test', createFile.data);
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, createFile.fileURI);
			createFile.execute();
			Assert.assertEquals(testURI, createFile.fileURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			createFile.execute();
			Assert.assertTrue(createFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(createFile.success);
			createFile.execute();
			Assert.assertTrue(createFile.success);
		}
	}
}