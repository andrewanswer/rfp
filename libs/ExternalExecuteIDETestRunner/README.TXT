How to run tests within the Flash IDE.

1. In the project settings for this project modify the output folder in the Actionscript Build Path to the WindowSWF directory of your local installation of the Flash IDE.
On a Mac:
/Users/{username}/Library/Application Support/Adobe/Flash CS4/en/Configuration/WindowSWF/
On a PC:
\Documents and Settings\{username}\Local Settings\Application Data\Adobe\Flash CS4\en\Configuration\WindowSWF\
2. The bin-debug directory will now link to the above directory on your local system.
3. In the run dialogue of Flash Builder, run "ExternalExecuteIDETestRunner." This step is to make sure that the ExternalExecuteIDETestRunner.swf has been compiled.
4. In the run dialogue of Flash Builder, run "FlexUnit Tests." Ignore the results. This step is to make sure that the FlexUnitApplication.swf has been compiled.
4. Restart your Flash IDE. This step makes sure that the Flash IDE recognizes the new ExternalExecuteIDETestRunner WindowSWF.
5. In the Flash IDE select Window > Other Panels > ExternalExecuteIDETestRunner. This loads and executes the test runner within the Flash IDE.
6. To see the results of the tests, view the FlexUnit Results panel within Flash Builder. 
7. Click anywhere inside the EXTERNALEXECUTEIDETESTRUNNER window inside the Flash IDE to re-run all the tests and report the results back to Flash Builder.
8. When adding or modifying tests repeat step 4 then step 7. It's not necessary to restart the Flash IDE everytime you add or modify a test. 