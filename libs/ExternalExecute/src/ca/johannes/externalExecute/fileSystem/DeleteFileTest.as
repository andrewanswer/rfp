package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class DeleteFileTest
	{
		private var deleteFile:DeleteFile;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt';
			
			var createFile:CreateFile = new CreateFile(testURI, 'test');
			createFile.execute();
			
			deleteFile = new DeleteFile(testURI);
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
			
			this.deleteFile = null;
		}
		
		[Test]
		public function testDeleteFile():void
		{
			Assert.assertNotNull(deleteFile);
		}
		
		[Test]
		public function testExecute():void
		{
			var fileExists:URIExists = new URIExists(testURI);
			fileExists.execute();
			Assert.assertTrue(fileExists.result);
			
			deleteFile.execute();
			
			fileExists = new URIExists(testURI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, deleteFile.fileURI);
			deleteFile.execute();
			Assert.assertEquals(testURI, deleteFile.fileURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(deleteFile.result);
			deleteFile.execute();
			Assert.assertTrue(deleteFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(deleteFile.success);
			deleteFile.execute();
			Assert.assertTrue(deleteFile.success);
		}
	}
}