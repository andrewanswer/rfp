package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class CopyFileTest
	{
		private var copyFile:CopyFile;
		private var testURI:String;
		private var copyURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt';
			copyURI = configURI.result + 'copy.txt';
			
			var createFile:CreateFile = new CreateFile(testURI, 'test');
			createFile.execute();
			
			copyFile = new CopyFile(testURI, copyURI);
		}
		
		[After]
		public function tearDown():void
		{
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			
			var deleteFile:DeleteFile 
			if (fileExists.result) {
				deleteFile = new DeleteFile(testURI);
				deleteFile.execute();
			}
			
			fileExists = new URIExists(copyURI);
			fileExists.execute();
			
			if (fileExists.result) {
				deleteFile = new DeleteFile(copyURI);
				deleteFile.execute();
			}

			copyFile = null;
		}
		
		[Test]
		public function testCopyFile():void
		{
			Assert.assertNotNull(copyFile);
			copyFile.execute();
		}
		
		[Test]
		public function testGet_copyURI():void
		{
			Assert.assertEquals(copyURI, copyFile.copyURI);
			copyFile.execute();
			Assert.assertEquals(copyURI, copyFile.copyURI);
		}
		
		[Test]
		public function testExecute():void
		{
			var fileExists:URIExists = new URIExists(copyURI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
			
			copyFile.execute();
			
			fileExists = new URIExists(testURI);
			fileExists.execute();
			Assert.assertTrue(fileExists.result);
			
			fileExists = new URIExists(copyURI);
			fileExists.execute();
			Assert.assertTrue(fileExists.result);
			
			var readFile:ReadFile = new ReadFile(copyURI);
			readFile.execute();
			Assert.assertEquals("test", readFile.result);
			
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, copyFile.fileURI);
			copyFile.execute();
			Assert.assertEquals(testURI, copyFile.fileURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(copyFile.result);
			copyFile.execute();
			Assert.assertTrue(copyFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(copyFile.success);
			copyFile.execute();
			Assert.assertTrue(copyFile.success);
		}
	}
}