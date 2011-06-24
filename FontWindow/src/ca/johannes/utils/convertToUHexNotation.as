package ca.johannes.utils
{
	public function convertToUHexNotation(value:String, delimiter:String=","):String 
	{		
			if (!value || value == ''){
				return null;
			}
		
			var convertCharacter:Function = function(character:String):String 
			{
				var hex:String = character.charCodeAt().toString(16).toUpperCase();
				var leadingZeros:int = 4 - hex.length;
				for (var j:int = 0; j<=leadingZeros - 1; j++) {
					hex = "0" + hex;
				}
				return "U+" + hex;
			}
			var tokens:Array = value.split('');
			var len:int = tokens.length;
			
			value = convertCharacter(tokens[0]);
			for (var i:int = 1; i<len; i++) {
				value += delimiter + convertCharacter(tokens[i]);
			}
					
			return value;
	}
}