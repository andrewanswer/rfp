package flexUnitTests
{
	import ca.johannes.fontPublisher.commands.BuildFontClassTest;
	import ca.johannes.fontPublisher.commands.BuildFontRegisterTest;
	import ca.johannes.fontPublisher.model.FontPublisherTest;
	import ca.johannes.fontPublisher.publish.FontProfileTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FontWindowTestSuite
	{
		public var fontProfileTest:FontProfileTest;
		public var fontPublisherTest:FontPublisherTest;
		public var buildFontClassTest:BuildFontClassTest
		public var buildFontRegisterTest:BuildFontRegisterTest
	}
}