package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class DeleteDirectoryTest
	{	
		private var deleteDirectory:DeleteDirectory;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test_dir/';
			
			var createDirectory:CreateDirectory = new CreateDirectory(testURI);
			createDirectory.execute();
			
			deleteDirectory = new DeleteDirectory(testURI);
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
			
			this.deleteDirectory = null;
		}
		
		[Test]
		public function testDeleteDirectory():void
		{
			Assert.assertNotNull(deleteDirectory);
		}
		
		[Test]
		public function testExecute():void
		{	
			var directoryExists:URIExists = new URIExists(testURI);
			directoryExists.execute();
			Assert.assertTrue(directoryExists.result);
			
			deleteDirectory.execute();
			
			directoryExists = new URIExists(testURI);
			directoryExists.execute();
			Assert.assertFalse(directoryExists.result);
		}
		
		[Test]
		public function testGet_folderURI():void
		{
			Assert.assertEquals(testURI, deleteDirectory.folderURI);
			deleteDirectory.execute();
			Assert.assertEquals(testURI, deleteDirectory.folderURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(deleteDirectory.result);
			deleteDirectory.execute();
			Assert.assertTrue(deleteDirectory.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(deleteDirectory.success);
			deleteDirectory.execute();
			Assert.assertTrue(deleteDirectory.success);
		}
	}
}