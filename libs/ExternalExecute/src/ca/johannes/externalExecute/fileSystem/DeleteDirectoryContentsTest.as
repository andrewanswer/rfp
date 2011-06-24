package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class DeleteDirectoryContentsTest
	{
		private var deleteDirectoryContents:DeleteDirectoryContents;
		private var testURI:String;
		private var file1URI:String;
		private var file2URI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test_dir/';
			file1URI = testURI + "test1.txt";
			file2URI = testURI + "test2.txt";
			
			var createDirectory:CreateDirectory = new CreateDirectory(testURI);
			createDirectory.execute();
			
			var createFile:CreateFile = new CreateFile(file1URI, "test");
			createFile.execute();
			createFile = new CreateFile(file2URI, "test");
			createFile.execute();
			
			deleteDirectoryContents = new DeleteDirectoryContents(testURI);
		}
		
		[After]
		public function tearDown():void
		{
			var directoryExists:URIExists = new URIExists(testURI);
			directoryExists.execute();
			
			if (directoryExists.result) {
				var deleteDirectory:DeleteDirectory = new DeleteDirectory(testURI);
				deleteDirectory.execute();
			}
			
			deleteDirectoryContents = null;
		}
		
		[Test]
		public function testDeleteDirectoryContents():void
		{
			Assert.assertNotNull(deleteDirectoryContents);
		}
		
		[Test]
		public function testExecute():void
		{
			var fileExists:URIExists = new URIExists(file1URI);
			fileExists.execute();
			Assert.assertTrue(fileExists.result);
			
			fileExists = new URIExists(file2URI);
			fileExists.execute();
			Assert.assertTrue(fileExists);
			
			deleteDirectoryContents.execute();
			
			var directoryExists:URIExists = new URIExists(testURI);
			directoryExists.execute();
			Assert.assertTrue(directoryExists.result);
			
			fileExists = new URIExists(file1URI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
			
			fileExists = new URIExists(file2URI);
			fileExists.execute();
			Assert.assertFalse(fileExists.result);
		}
		
		[Test]
		public function testGet_folderURI():void
		{
			Assert.assertEquals(testURI, deleteDirectoryContents.folderURI);
			deleteDirectoryContents.execute();
			Assert.assertEquals(testURI, deleteDirectoryContents.folderURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(deleteDirectoryContents.result);
			deleteDirectoryContents.execute();
			Assert.assertTrue(deleteDirectoryContents.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(deleteDirectoryContents.success);
			deleteDirectoryContents.execute();
			Assert.assertTrue(deleteDirectoryContents.success);
		}
	}
}