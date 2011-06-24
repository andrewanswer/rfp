package ca.johannes.fontPublisher.model
{	
	import adobe.utils.MMExecute;
	
	import ca.johannes.externalExecute.fileSystem.BrowseForDirectory;
	import ca.johannes.externalExecute.fileSystem.BrowseForFile;
	import ca.johannes.externalExecute.fileSystem.DeleteDirectoryContents;
	import ca.johannes.externalExecute.fileSystem.utils.PlatformPathToURI;
	import ca.johannes.externalExecute.fileSystem.utils.URIExists;
	import ca.johannes.externalExecute.fileSystem.utils.URItoPlatformPath;
	import ca.johannes.externalExecute.flash.ConfigURI;
	import ca.johannes.fontPublisher.commands.BuildFontClass;
import ca.johannes.fontPublisher.commands.BuildFontRegister;
import ca.johannes.fontPublisher.commands.BuildFontRegister;
	import ca.johannes.fontPublisher.commands.PublishFontFile;
	import ca.johannes.fontPublisher.events.FontFileEvent;
	import ca.johannes.fontPublisher.events.FontProfileChangeEvent;
	import ca.johannes.fontPublisher.fileReader.BasicSubfamiliesFontFile;
	import ca.johannes.fontPublisher.fileReader.FontFile;
	import ca.johannes.fontPublisher.fileReader.FontReader;
	import ca.johannes.fontPublisher.publish.FontProfile;
	import ca.johannes.utils.parseFileExtension;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.FontType;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.XMLListCollection;
	import mx.events.PropertyChangeEvent;
	
	public class FontPublisherModel extends EventDispatcher
	{	
		public static const PROFILES_CHANGE:String = "profilesChange";
		public static const OUTPUT_FOLDER_CHANGE:String = "outputFolderChange";
		public static const FONT_SUBFAMILIES_CHANGE:String = "fontSubfamiliesChange";
		public static const FONT_FILE_CHANGE:String = "fontFileChange";
		public static const FILE_NAME_CHANGE:String = "fileNameChange";
		public static const DEVICE_FONTS_CHANGE:String = "deviceFontsChange";
		public static const UNICODE_RANGES_CHANGE:String = "unicodeRangesChange";
		
		public static const ENABLE_CFF:String = "enableCFF";
		public static const PUBLISH_READY:String = "publishReady";
		public static const FONT_READY:String = "fontReady";
		
		protected static var profileCounter:int = 0;
		
		protected var configURI:String;
		protected var windowSWFURI:String = "WindowSWF/";
		protected var extensionURI:String = "RSFontPublisher/";
		protected var binURI:String = "bin/";
		protected var srcURI:String = "src/";
		protected var flaURI:String = "fla/";
		
		protected var _fontProfiles:ArrayCollection = new ArrayCollection();
		protected var _fontProfile:FontProfile;
		protected var _publishReady:Boolean = false;
		protected var _fontReady:Boolean = false;
		protected var _outputFolder:String;
		protected var _fileName:String;
		protected var _unicodeTableURI:String = "FontEmbedding/UnicodeTable.xml";
		protected var _deviceFonts:IList;
		protected var _unicodeRanges:XMLListCollection;
		protected var _enableCFF:Boolean = false;
		protected var _fontSubfamilies:ArrayCollection = new ArrayCollection();
		protected var _fontFile:FontFile;
		protected var fontFiles:Array = new Array();
		protected var fontReader:FontReader;
		protected var fontRegister:BuildFontRegister;

		public function FontPublisherModel():void
		{				
			initialize();
		}
		
		public function initialize():void
		{	
			//this.configURI = "file:///C|/Documents%20and%20Settings/Johannes%20Tacskovics/Local%20Settings/Application%20Data/Adobe/Flash%20CS4/en/Configuration/";
			//this.configURI = "file:///Users/jtacskov/Library/Application%20Support/Adobe/Flash%20CS4/en/Configuration/"
			//this.configURI = "file:///Users/jtacskov/Library/Application%20Support/Adobe/Flash%20CS5/en_US/Configuration/"
			//this.configURI = "file:///Macintosh%20HD/Users/jtacskov/Library/Application%20Support/Adobe/Flash%20CS5/en_US/Configuration/"
			
			var config:ConfigURI = new ConfigURI();
			config.execute();
			configURI = config.result;
			
			_unicodeTableURI = configURI + _unicodeTableURI;
			windowSWFURI = configURI + windowSWFURI;
			extensionURI = configURI + extensionURI;
			binURI = extensionURI + binURI;
			srcURI = extensionURI + srcURI;
			flaURI = extensionURI + flaURI;
			
			setUnicodeRanges();
			createFontProfile();
		}
		
		public function publish():void
		{
			if (!outputFolder) {
				outputFolder = browseForOutputFolder();
			}
			
			if (outputFolder) {
				clean();
				addFontProfile(fontProfile);
				publishReady = false;
				buildActionScript(srcURI);
				publishSWF();
			}
		}
		
		public function export():void
		{
			if (!outputFolder) {
				outputFolder = browseForOutputFolder();
			}
			
			if (outputFolder) {
				addFontProfile(fontProfile);
				
				var pathToURI:PlatformPathToURI = new PlatformPathToURI(outputFolder +"/");
				pathToURI.execute();
				var buildURI:String = pathToURI.result;
				
				buildActionScript(buildURI);
			}
		}
		
		public function addFontProfile(value:FontProfile):void
		{
			if (fontProfiles.getItemIndex(value) == -1 && isValidFontName(value) && value.publishReady){
				fontProfiles.addItem(value);
				createFontProfile();
			}
		}
		
		public function removeFontProfile(value:FontProfile):void
		{
			var index:int = fontProfiles.getItemIndex(value);
			if (index > -1){
				fontProfiles.removeItemAt(index);
				createFontProfile();
			}
		}
		
		public function setFontProfile(value:Object):void
		{
			if (value is FontProfile) {
				fontProfile = value as FontProfile;
			}
		}
		
	    public function get fontProfile():FontProfile 
	    {
	        return _fontProfile;
	    }
	    public function set fontProfile(value:FontProfile):void 
	    {
	    	if (value != fontProfile && fontProfile) {
				fontProfile.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onProfileChange);
	    	}
	    	if (value != fontProfile) {
	    		var fontProfileChange:FontProfileChangeEvent = new FontProfileChangeEvent(FontProfileChangeEvent.FONT_PROFILE_CHANGE, value, _fontProfile);
	    		_fontProfile = value;
	    		
				fontProfile.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onProfileChange);
				dispatchEvent(fontProfileChange);
				
				profileChange();
				sourceFontChange();
	    	}
	    }
	    
	    public function createFontProfile():void
	    {
	    	var profile:FontProfile = new FontProfile();
	    	profile.uid = "FontProfile" + profileCounter++;
			if (fontProfiles.length>0) profile.fontName = (fontProfiles.getItemAt(0) as FontProfile).fontName;
			fontProfile = profile;
			fontFile = null;
			fontSubfamilies = null;
			//return fontProfile;
	    }
		
		public function browseForOutputFolder():String
		{
			var browseForDirectory:BrowseForDirectory = new BrowseForDirectory();
			browseForDirectory.execute();
			var folderURI:String = browseForDirectory.result;
			
			var uriToPlatformPath:URItoPlatformPath = new URItoPlatformPath(folderURI);
			uriToPlatformPath.execute();
			
			var folder:String = uriToPlatformPath.result;
			
			return folder;
		}		
		public function browseForFontFile():String
		{
			var browseForFile:BrowseForFile = new BrowseForFile();
			browseForFile.execute();
			var fileURI:String = browseForFile.result;
			
			var uriToPlatformPath:URItoPlatformPath = new URItoPlatformPath(fileURI);
			uriToPlatformPath.execute();
			
			var file:String = uriToPlatformPath.result;
			if(!file){
				file = '';
			}
			
			return file;
		}
		public function clean():void
		{		
			var deleteSrcDirectoryContents:DeleteDirectoryContents = new DeleteDirectoryContents(srcURI);
			deleteSrcDirectoryContents.execute();
			
			var deleteBinDirectoryContents:DeleteDirectoryContents = new DeleteDirectoryContents(binURI);
			deleteBinDirectoryContents.execute();
		}
		
		[Bindable(event="fontSubfamiliesChange")]
		public function get fontSubfamilies():ArrayCollection {
			return _fontSubfamilies;
		}
		public function set fontSubfamilies(value:ArrayCollection):void {
			_fontSubfamilies = value;
			dispatchEvent(new Event(FONT_SUBFAMILIES_CHANGE));
		}
		
		[Bindable(event="fontFileChange")]
		public function get fontFile():FontFile {
			return _fontFile;
		}
		public function set fontFile(value:FontFile):void {
			_fontFile = value;
			dispatchEvent(new Event(FONT_FILE_CHANGE));
		}
		
		[Bindable(event="enableCFF")]
		public function get enableCFF():Boolean {
			return _enableCFF;
		}
		public function set enableCFF(value:Boolean):void {
			if (!value) {
				fontProfile.cff = value;
			}
			_enableCFF = value;
			dispatchEvent(new Event(ENABLE_CFF));
		}
		
		[Bindable(event="profilesChange")]
		public function get fontProfiles():ArrayCollection {
			return _fontProfiles;
		}
		public function set fontProfiles(value:ArrayCollection):void {
			_fontProfiles = value;
			dispatchEvent(new Event(PROFILES_CHANGE));
		}
		
		[Bindable(event="outputFolderChange")]
		public function get outputFolder():String
		{
			return _outputFolder;
		}
		public function set outputFolder(value:String):void
		{
			_outputFolder = value;
			dispatchEvent(new Event(OUTPUT_FOLDER_CHANGE));
		}
		
		[Bindable(event="fileNameChange")]
		public function get fileName():String
		{
			return _fileName;
		}
		public function set fileName(value:String):void
		{
			var extension:String = parseFileExtension(value);
			if ((!extension || extension.toLocaleLowerCase() != "swf") && value != '') {
				value = value + ".swf";
			}
			_fileName = value;
			dispatchEvent(new Event(FILE_NAME_CHANGE));
		}
	    
		[Bindable(event="publishReady")]
	    public function get publishReady():Boolean {
	        return _publishReady;
	    }
	    public function set publishReady(value:Boolean):void {
			_publishReady = value;
	        dispatchEvent(new Event(PUBLISH_READY));
	    }
	    
		[Bindable(event="fontReady")]
	    public function get fontReady():Boolean {
	        return _fontReady;
	    }
	    public function set fontReady(value:Boolean):void {
			_fontReady = value;
	        dispatchEvent(new Event(FONT_READY));
	    }
		
		[Bindable(event="deviceFontsChange")]
		public function get deviceFonts():IList {
			return _deviceFonts;
		}
		public function set deviceFonts(value:IList):void {
			_deviceFonts = value;
			dispatchEvent(new Event(DEVICE_FONTS_CHANGE));
		}
		
		[Bindable(event="unicodeRangesChange")]
		public function get unicodeRanges():XMLListCollection {
			return _unicodeRanges;
		}
		public function set unicodeRanges(value:XMLListCollection):void {
			_unicodeRanges = value;
			dispatchEvent(new Event(UNICODE_RANGES_CHANGE));
		}
		
		public function get unicodeTableURI():String {
			return _unicodeTableURI;
		}
		
		protected function onProfileChange(event:PropertyChangeEvent):void
		{
			if (event.property == "sourceFont") {
				sourceFontChange();
			}
			
			profileChange();
		}
		
		protected function profileChange():void
		{
			publishReady = fontProfile.publishReady || (!fontProfile.fontName && fontProfiles.length > 0);
			fontReady = fontProfile.publishReady && isValidFontName(fontProfile) && (fontProfiles.getItemIndex(fontProfile) == -1);
		}
		
		protected function sourceFontChange():void
		{
			var file:FontFile = getFontFileByURI(fontProfile.sourceFont);
			
			if (file) {
				fontFile = file;
				setFontSubfamilies(file);
			} else {
				var fileExists:Boolean = false;
				
				var platformPathToURI:PlatformPathToURI = new PlatformPathToURI(fontProfile.sourceFont);
				platformPathToURI.execute();
				
				var platformPathExists:URIExists = new URIExists(platformPathToURI.result);
				platformPathExists.execute();
				
				var sourceFontExists:URIExists = new URIExists(fontProfile.sourceFont);
				sourceFontExists.execute();
				
				fileExists = (platformPathExists.result || sourceFontExists.result);
				
				//if (fontProfile.fontFileType) { //For testing outside of IDE.
				if (fontProfile.fontFileType && fileExists) {
					if (fontReader) {
						fontReader.removeEventListener(FontFileEvent.LOADED, onFontFileLoaded);
						fontReader.close();
						fontReader = null;
					}
					
					fontReader = new FontReader();
					fontReader.addEventListener(IOErrorEvent.IO_ERROR, onFontFileError);
					fontReader.addEventListener(FontFileEvent.LOADED, onFontFileLoaded);
					fontReader.load(fontProfile.sourceFont);
				} else {
					fontFile = null;
					fontSubfamilies = null;
				}
			}
		}
		
		protected function onFontFileError(event:IOErrorEvent):void
		{
			fontReader.removeEventListener(IOErrorEvent.IO_ERROR, onFontFileError);
			fontReader.removeEventListener(FontFileEvent.LOADED, onFontFileLoaded);
			fontReader.close();
			fontReader = null;
			
			if (fontProfile.fontFileType == FontProfile.TRUE_TYPE_COLLECTION) {
				/*
				Current font reading library does not read true type collections well. Adding a limited functionality font file object
				that's prepopulated with the Regular, Bold, Italic, and Bold Italic subfamilies under the false assumption that all 
				true type collections contain those subfamilies. 
				*/
				var file:FontFile = new BasicSubfamiliesFontFile(null, null);
				fontFile = file;
				fontFiles.push(file);
				setFontSubfamilies(file);
			} else {
				fontSubfamilies = null;
			}
		}
		
		protected function onFontFileLoaded(event:FontFileEvent):void
		{
			fontFile = event.fontFile;
			
			fontReader.removeEventListener(IOErrorEvent.IO_ERROR, onFontFileError);
			fontReader.removeEventListener(FontFileEvent.LOADED, onFontFileLoaded);
			fontReader.close();
			fontReader = null;
			
			fontFiles.push(event.fontFile);
			
			setFontSubfamilies(fontFile);
		}
		
		protected function getFontFileByURI(uri:String):FontFile
		{
			var fontFileByURI:FontFile;
			var len:int = fontFiles.length;
			for (var i:uint = 0; i<len; i++){
				var fontFile:FontFile = fontFiles[i];
				if (uri == fontFile.url) {
					fontFileByURI = fontFile;
					break;
				}
			}
			return fontFileByURI;
		}
	    
	    protected function isValidFontName(fontProfile:FontProfile):Boolean
	    {
	    	var valid:Boolean = true;
	    	
			/*
			//TODO: REWRITE
	    	var len:int = fontProfiles.length;
	    	for (var i:int = 0; i<len; i++) {
	    		var profile:FontProfile = fontProfiles.getItemAt(i) as FontProfile;
	    		if (profile.fontName == fontProfile.fontName && 
					profile.fontWeight != fontProfile.fontWeight &&
					profile.fontStyle != fontProfile.fontStyle && 
					profile.cff != fontProfile.cff) {
	    			valid = false;
	    			break;
	    		}
	    	} */
			
	    	return valid;
	    }
		
		protected function setFontSubfamilies(fontFile:FontFile):void
		{
			var arrayCollection:ArrayCollection = new ArrayCollection();

			var len:uint = fontFile.length;
			for (var i:uint = 0; i<len; i++) {
				arrayCollection.addItem(fontFile.subfamilyName(i));
			}
			
			fontSubfamilies = arrayCollection;
		}
		
		protected function setUnicodeRanges():void
		{
			var request:URLRequest = new URLRequest(unicodeTableURI);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onUnicodeTableComplete);
			loader.load(request);
		}
		
		protected function onUnicodeTableComplete(event:Event):void
		{
			var unicodeTable:XML = new XML(event.target.data);
			var ranges:XMLListCollection = new XMLListCollection(unicodeTable..glyphRange);
			unicodeRanges = ranges;
		}
	    
		protected function buildActionScript(buildURI:String):void
		{	
			var len:int = fontProfiles.length;			
			for (var i:int = 0; i<len; i++) {				
				var profile:FontProfile = fontProfiles.getItemAt(i) as FontProfile;
				var buildFontClass:BuildFontClass = new BuildFontClass(profile, i, buildURI);
				buildFontClass.execute();
			}
			fontRegister = new BuildFontRegister(fontProfiles, buildURI);
			fontRegister.execute();
		}
		
		protected function publishSWF():void
		{
			var pattern:RegExp = /\\/g
			var output:String = outputFolder.replace(pattern,"/");
			if (!fileName) {
				fileName = PublishFontFile.FONT_FILE_NAME;
			}
			
			var publishedPath:String = output + "/" + fileName;
			var pathToURI:PlatformPathToURI = new PlatformPathToURI(publishedPath);
			pathToURI.execute();
			var publishedURI:String = pathToURI.result;
			
			// First font name used for extending FontRegister class name
			var profile:FontProfile = fontProfiles.getItemAt(0) as FontProfile;
			var publishFontFile:PublishFontFile = new PublishFontFile(flaURI, binURI, publishedURI, fontRegister.className);
			publishFontFile.execute();
		}
	}
}