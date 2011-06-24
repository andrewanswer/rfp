package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class MoveFileTest
	{
		private var moveFile:MoveFile;
		private var testURI:String;
		private var moveURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test.txt';
			moveURI = configURI.result + 'move.txt';
			
			var createFile:CreateFile = new CreateFile(testURI, 'test');
			createFile.execute();
			
			moveFile = new MoveFile(testURI, moveURI);
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
			
			fileExists = new URIExists(moveURI);
			fileExists.execute();
			
			if (fileExists.result) {
				deleteFile = new DeleteFile(moveURI);
				deleteFile.execute();
			}
			
			moveFile = null;
		}
		
		[Test]
		public function testExecute():void
		{
			var fileExists:URIExists = new URIExists(moveURI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
			
			moveFile.execute();
			
			fileExists = new URIExists(moveURI);
			fileExists.execute();
			Assert.assertTrue(fileExists.result);
			
			fileExists = new URIExists(testURI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
			
			var readFile:ReadFile = new ReadFile(moveURI);
			readFile.execute();
			Assert.assertEquals("test", readFile.result);
		}
		
		[Test]
		public function testGet_fileURI():void
		{
			Assert.assertEquals(testURI, moveFile.fileURI);
			moveFile.execute();
			Assert.assertEquals(testURI, moveFile.fileURI);
		}
		
		[Test]
		public function testMoveFile():void
		{
			Assert.assertNotNull(moveFile);
		}
		
		[Test]
		public function testGet_newURI():void
		{
			Assert.assertEquals(moveURI, moveFile.newURI);
			moveFile.execute();
			Assert.assertEquals(moveURI, moveFile.newURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(moveFile.result);
			moveFile.execute();
			Assert.assertTrue(moveFile.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(moveFile.success);
			moveFile.execute();
			Assert.assertTrue(moveFile.success);
		}
	}
}