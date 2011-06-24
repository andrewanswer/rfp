package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class ListDirectoryContentsTest
	{
		private var listDirectoryContents:ListDirectoryContents;
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
			
			listDirectoryContents = new ListDirectoryContents(testURI);
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
			
			listDirectoryContents = null;
		}
		
		[Test]
		public function testExecute():void
		{
			listDirectoryContents.execute();
			Assert.assertNotNull(listDirectoryContents.result);
		}
		
		[Test]
		public function testGet_folderURI():void
		{
			Assert.assertEquals(testURI, listDirectoryContents.folderURI);
			listDirectoryContents.execute();
			Assert.assertEquals(testURI, listDirectoryContents.folderURI);
		}
		
		[Test]
		public function testListDirectoryContents():void
		{
			Assert.assertNotNull(listDirectoryContents);
		}
		
		[Test]
		public function testGet_result():void
		{
			listDirectoryContents.execute();
			var len:int = listDirectoryContents.result.length;
			Assert.assertEquals(2, len);
			
			for (var i:int = 0; i<len; i++) {
				var fileURI:String = listDirectoryContents.result[i];
				Assert.assertTrue((file1URI == fileURI || file2URI == fileURI));
			}
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(listDirectoryContents.success);
			listDirectoryContents.execute();
			Assert.assertTrue(listDirectoryContents.success);
		}
	}
}