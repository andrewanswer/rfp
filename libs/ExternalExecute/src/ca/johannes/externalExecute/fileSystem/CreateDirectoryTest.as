package ca.johannes.externalExecute.fileSystem
{
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.flash.ConfigURI;
	
	import flexunit.framework.Assert;
	
	public class CreateDirectoryTest
	{	
		private var createDirectory:CreateDirectory;
		private var testURI:String;
		
		[Before]
		public function setUp():void
		{
			var configURI:ConfigURI = new ConfigURI();
			configURI.execute();
			testURI = configURI.result + 'test_dir/';
			
			createDirectory = new CreateDirectory(testURI);
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
			
			createDirectory = null;
		}
		
		[Test]
		public function testCreateDirectory():void
		{
			Assert.assertNotNull(createDirectory);
		}
		
		[Test]
		public function testExecute():void
		{
			createDirectory.execute();
			
			var directoryExists:URIExists = new URIExists(testURI);
			directoryExists.execute();
			
			Assert.assertTrue(directoryExists.result);
		}
		
		[Test]
		public function testGet_folderURI():void
		{
			Assert.assertEquals(testURI, createDirectory.folderURI);
			createDirectory.execute();
			Assert.assertEquals(testURI, createDirectory.folderURI);
		}
		
		[Test]
		public function testGet_result():void
		{
			Assert.assertFalse(createDirectory.result);
			createDirectory.execute();
			Assert.assertTrue(createDirectory.result);
		}
		
		[Test]
		public function testGet_success():void
		{
			Assert.assertFalse(createDirectory.success);
			createDirectory.execute();
			Assert.assertTrue(createDirectory.success);
		}
	}
}