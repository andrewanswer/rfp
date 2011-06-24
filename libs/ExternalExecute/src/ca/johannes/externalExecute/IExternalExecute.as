package ca.johannes.externalExecute
{
	import ca.johannes.commands.ICommand;
	
	public interface IExternalExecute extends ICommand
	{
		function get success():Boolean
	}
}