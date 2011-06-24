package ca.johannes.utils
{
	public function removeDuplicates(value:String):String  
	{
		if (value){
			return value.split('').sort().join('').replace(/(.)\1+/g,'$1');
		}
	    return null;
	}
}