package ca.johannes.externalExecute.fileSystem
{	
	import adobe.utils.MMExecute;
	
	import com.adobe.serialization.json.JSON;
	
	import ca.johannes.externalExecute.AbstractExternalExecute;	
	
	public class AbstractFileSystemExecute extends AbstractExternalExecute
	{
		[Embed(source="../../../../../etc/FileSystemAPI.jsfl", mimeType="application/octet-stream")]
		protected static const EXTERNAL_API:Class;
		
		protected static const EXTERNAL_API_OBJECT_NAME:String = "FileSystemAPI";
		
		protected static var isAPIInitialized:Boolean;		
		
		/**
		 * An action run against the file system.
		 */
		public function AbstractFileSystemExecute()
		{
			if (!AbstractFileSystemExecute.isAPIInitialized) {
				AbstractFileSystemExecute.isAPIInitialized = initializeExternalAPI(EXTERNAL_API);
			}
		}
		
		protected function callMethod(inMethodName:String, ...inArgs):String
		{
			if (!AbstractFileSystemExecute.isAPIInitialized) {
				return null;
			}
			// http://cookbooks.adobe.com/post_Build_a_JavaScript_API_for_your_Fireworks_Flash_pa-16399.html
			// inArgs will be an array containing all of the arguments 
			// after the first one.  convert that array to a JSON 
			// string representation and then strip the [ ] from the 
			// string, since we'll be using it as a list of method 
			// parameters, not as an array.
			var argString:String = JSON.encode(inArgs).slice(1, -1);
			
			// include a semi-colon at the end so that the command 
			// history steps have them
			//MMExecute("fl.trace('"+AbstractFileSystemExecute.EXTERNAL_API_OBJECT_NAME + "." + inMethodName+"("+argString+ ")');");
			
			var js:String = AbstractFileSystemExecute.EXTERNAL_API_OBJECT_NAME + "." + inMethodName + "(" + argString + ");";
			return executeExternal(js);
		}
	}
}