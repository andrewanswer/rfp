package ca.johannes.utils
{
	public function parseFileExtension(filePath:String):String
	{
		var extension:String;
		var index:int = filePath.lastIndexOf(".") + 1;
		extension = filePath.substring(index, filePath.length);
		if (extension.length >= 2 && extension.length <= 4){
			return extension.toLowerCase();
		} 
		return null;
	}
}