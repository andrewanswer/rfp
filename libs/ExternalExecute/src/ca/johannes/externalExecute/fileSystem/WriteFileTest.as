package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.CreateFile;
	import ca.johannes.externalExecute.fileSystem.DeleteFile;
	import ca.johannes.externalExecute.fileSystem.WriteFile;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class WriteFileTest
	{
		protected var writeFile:WriteFile;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt'; 
			
			var createFile:CreateFile = new CreateFile(testURI, '');
			
			writeFile = new WriteFile(testURI, 'test');
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
			writeFile = null;
		}
		
		[Test]
		public function testWriteFile():void
		{
			Assert.assertNotNull(writeFile);
		}
		
		[Test]
		public function testExecute():void
		{
			writeFile.execute();
			
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			
			Assert.assertTrue(fileExists.result);
			
			var readFile:ReadFile = new ReadFile(testURI);
			readFile.execute();
			
			Assert.assertEquals('test', readFile.result);
		}
		
		[Test]
		public function testGet_append():void
		{
			Assert.assertFalse(writeFile.append);
			writeFile.execute();
			Assert.assertFalse(writeFile.append);
			
			writeFile = new WriteFile(testURI, '_test', true);
			
			Assert.assertTrue(writeFile.append);
			writeFile.execute();
			Assert.assertTrue(writeFile.append);
			
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			
			Assert.assertTrue(fileExists.result);
			
			var readFile:ReadFile = new ReadFile(testURI);
			readFile.execute();
			
			Assert.assertEquals('test_test', readFile.result);
		}
		
		[Test]
		public function testGet_data():void
		{
			Assert.assertEquals('test', writeFile.data);
			writeFile.execute();
			Assert.assertEquals('test', writeFile.data);
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, writeFile.fileURI);
			writeFile.execute();
			Assert.assertEquals(testURI, writeFile.fileURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(writeFile.result);
			writeFile.execute();
			Assert.assertTrue(writeFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(writeFile.success);
			writeFile.execute();
			Assert.assertTrue(writeFile.success);
		}
	}
}