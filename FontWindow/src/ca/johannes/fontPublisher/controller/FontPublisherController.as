package ca.johannes.fontPublisher.controller
{
	import ca.johannes.fontPublisher.events.FontProfileChangeEvent;
	import ca.johannes.fontPublisher.model.FontPublisherModel;
	import ca.johannes.fontPublisher.publish.FontProfile;
	import ca.johannes.fontPublisher.view.FontPublisherView;
	import ca.johannes.utils.parseFileExtension;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.FontStyle;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.XMLListCollection;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;

	public class FontPublisherController extends EventDispatcher
	{
		public static const REMOVE_READY:String = "removeReady";
		
		protected var _removeReady:Boolean = false;
		protected var _fontWindow:FontPublisherView;		
		protected var _fontPublisher:FontPublisherModel;
		protected var fontProfile:FontProfile;
		
		
		public function initialize():void
		{	
			addListeners();
		}
		
		public function get fontWindow():FontPublisherView
		{
			return _fontWindow;
		}
		
		public function set fontWindow(value:FontPublisherView):void
		{
			_fontWindow = value;
			if (fontWindow.initialized) {
				initialize();
			} else {
				fontWindow.addEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
			}
		}
		
		public function get fontPublisher():FontPublisherModel
		{
			return _fontPublisher;
		}
		public function set fontPublisher(value:FontPublisherModel):void
		{
			_fontPublisher = value;			
			fontPublisher.addEventListener(FontProfileChangeEvent.FONT_PROFILE_CHANGE, onProfileChange);
			fontPublisher.addEventListener(FontPublisherModel.FONT_FILE_CHANGE, onFontFileChange);
			fontPublisher.addEventListener(FontPublisherModel.FONT_SUBFAMILIES_CHANGE, onFontSubfamiliesChange);
			fontPublisher.addEventListener(FontPublisherModel.OUTPUT_FOLDER_CHANGE, onOutputFolderChange);
			
			fontProfile = fontPublisher.fontProfile;
			fontProfile.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onProfilePropertyChange);
		}
		
		[Bindable(event="removeReady")]
		public function get removeReady():Boolean {
			return _removeReady;
		}
		public function set removeReady(value:Boolean):void {
			_removeReady = value;
			dispatchEvent(new Event(REMOVE_READY));
		}	
		
		protected function onApplicationComplete(event:FlexEvent):void
		{
			initialize();
		}
		
		protected function addListeners():void
		{
			fontWindow.newFont.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.sourceSelect.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.uHexNotation.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.aaa.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.cff.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.addFont.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.removeFont.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.fontList.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.outputSelect.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.publish.addEventListener(MouseEvent.CLICK, onClick);
			fontWindow.export.addEventListener(MouseEvent.CLICK, onClick);
			
			fontWindow.fontName.addEventListener(TextOperationEvent.CHANGE, onChange);
			fontWindow.sourceFont.addEventListener(TextOperationEvent.CHANGE, onChange);
			fontWindow.output.addEventListener(TextOperationEvent.CHANGE, onChange);
			fontWindow.fileName.addEventListener(FocusEvent.FOCUS_OUT, onChange);
			fontWindow.fontSubfamilies.addEventListener(IndexChangeEvent.CHANGE, onChange);
			fontWindow.embeddedRanges.addEventListener(IndexChangeEvent.CHANGE, onChange);
			fontWindow.embeddedCharacters.addEventListener(TextOperationEvent.CHANGE, onChange);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			switch(event.currentTarget){
				case fontWindow.newFont:
					fontWindow.fontList.selectedIndex = -1;
					fontPublisher.createFontProfile();
					break;
				case fontWindow.sourceSelect:
					fontProfile.sourceFont = fontPublisher.browseForFontFile();
					break;
				case fontWindow.uHexNotation:
					fontProfile.embeddedCharactersUHex = null;
					fontProfile.embeddedCharacters = null;
					break;
				case fontWindow.aaa:
					fontProfile.advancedAntiAliasing = fontWindow.aaa.selected;
					break;
				case fontWindow.cff:
					fontProfile.cff = fontWindow.cff.selected;
					fontWindow.aaa.enabled = !fontProfile.cff;
					if (fontWindow.cff.selected) {
						fontWindow.aaa.selected = false;
					}
					break;
				case fontWindow.addFont:
					fontPublisher.addFontProfile(fontProfile);
					break;
				case fontWindow.removeFont:
					fontPublisher.removeFontProfile(fontProfile);
					break;
				case fontWindow.fontList:
					fontPublisher.setFontProfile(fontWindow.fontList.selectedItem);
					break;
				case fontWindow.outputSelect:
					fontPublisher.outputFolder = fontPublisher.browseForOutputFolder();
					break;
				case fontWindow.publish:
					fontPublisher.publish();
					break;
				case fontWindow.export:
					fontPublisher.export();
				default:
					break;
			}
		}
		
		protected function onChange(event:Event):void
		{
			switch(event.currentTarget){
				case fontWindow.fontName:
					fontProfile.fontName = fontWindow.fontName.text;
					break;
				case fontWindow.sourceFont:
					fontProfile.sourceFont = fontWindow.sourceFont.text;
					break;
				case fontWindow.fontSubfamilies:
					fontProfile.fontSubfamily = fontWindow.fontSubfamilies.selectedItem;
					break;
				case fontWindow.embeddedCharacters:
					if (fontWindow.uHexNotation.selected) {
						fontProfile.embeddedCharactersUHex = fontWindow.embeddedCharacters.text;
					} else {
						fontProfile.embeddedCharacters = fontWindow.embeddedCharacters.text;
					}
					break;
				case fontWindow.output:
					fontPublisher.outputFolder = fontWindow.output.text;
					break;
				case fontWindow.fileName:
					fontPublisher.fileName = fontWindow.fileName.text;
					break;
				case fontWindow.embeddedRanges:
					fontProfile.setEmbeddedRanges(fontWindow.embeddedRanges.selectedItems);
					break;
				default:
					break;
			}
		}
		
		protected function onProfilePropertyChange(event:PropertyChangeEvent):void
		{
			switch (event.property) {
				case "sourceFont":
					if (fontProfile.sourceFont) {
						fontWindow.sourceFont.text = fontProfile.sourceFont;
					} else {
						fontWindow.sourceFont.text = '';
					}
					break;
				
				case "embeddedCharactersUHex":
				case "embeddedCharacters":
					var text:String;
					if (fontWindow.uHexNotation.selected) {
						text = fontProfile.embeddedCharactersUHex;
					} else {
						text = fontProfile.embeddedCharacters;
					}
					if (!text) {
						text = '';
					}
					fontWindow.embeddedCharacters.text = text;
					break;
				
				case "cff":
					fontWindow.cff.selected = fontProfile.cff;
					if (!fontProfile.cff) {
						fontWindow.aaa.enabled = true;
					}
					break;
										
				default:
					break;
			}
			
			if (fontWindow.fontList.selectedIndex > -1) {
				fontWindow.newFont.enabled = fontProfile.publishReady;
			}
		}
		
		protected function onFontFileChange(event:Event):void
		{
			var fileInfo:String = "";
			
			if (fontPublisher.fontFile) {
				fileInfo =  "Font Family Name: " + fontPublisher.fontFile.familyName() + "\n";
				fileInfo += "Font Subfamily Name: " + fontPublisher.fontFile.subfamilyName() + "\n";
				fileInfo += fontPublisher.fontFile.copyrightNotice();
			}
			
			fontWindow.fileInfo.text = fileInfo;
		}
		
		protected function onFontSubfamiliesChange(event:Event):void
		{
			if (fontPublisher.fontSubfamilies) {
				
				var newIndex:int = 0;
				var oldIndex:int = fontWindow.fontSubfamilies.selectedIndex;
				
				if (fontProfile.fontSubfamily && fontWindow.fontSubfamilies.dataProvider.getItemIndex(fontProfile.fontSubfamily) > -1) {
					newIndex = fontWindow.fontSubfamilies.dataProvider.getItemIndex(fontProfile.fontSubfamily);
				}
				
				fontWindow.fontSubfamilies.selectedIndex = newIndex;
				var changeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE, false, false, oldIndex, newIndex);
				fontWindow.fontSubfamilies.dispatchEvent(changeEvent);
			}
		}
		
		protected function onOutputFolderChange(event:Event):void
		{
			if (fontPublisher.outputFolder) {
				fontWindow.output.text = fontPublisher.outputFolder;
			} else {
				fontWindow.output.text = '';
			}
		}
		
		protected function onProfileChange(fontProfileChange:FontProfileChangeEvent = null):void
		{
			if (fontProfileChange) {
				fontProfile.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onProfilePropertyChange);
			}
			
			fontProfile = fontPublisher.fontProfile;
			fontProfile.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onProfilePropertyChange);
			
			fontWindow.fontName.text = fontProfile.fontName;
			
			if (fontProfile.sourceFont) {
				fontWindow.sourceFont.text = fontProfile.sourceFont;
			} else {
				fontWindow.sourceFont.text = '';
			}
			
			var text:String;
			if (fontProfile.embeddedCharactersUHex && !fontProfile.embeddedCharacters) {
				fontWindow.uHexNotation.selected = true;
				text = fontProfile.embeddedCharactersUHex;
			} else {
				fontWindow.uHexNotation.selected = false;
				text = fontProfile.embeddedCharacters;
			}
			if (!text) {
				text = '';
			}
			fontWindow.embeddedCharacters.text = text;
			
			fontWindow.embeddedRanges.selectedIndices = getSelectedIndices(fontPublisher.unicodeRanges, fontProfile.embeddedRangeIds);
			
			fontWindow.aaa.selected = fontProfile.advancedAntiAliasing;
			
			fontWindow.aaa.enabled = !fontProfile.cff;
			
			fontWindow.cff.selected = fontProfile.cff;
			
			removeReady = (fontPublisher.fontProfiles.length > 0);
		}
		
		protected function getSelectedIndices(list:XMLListCollection, ids:Array):Vector.<int>
		{
			var indices:Vector.<int> = new Vector.<int>();
			var matchId:Function = function (item:*, ids:Array):Boolean {
				var match:Boolean = false;
				var id:String = item.@id.toString();
				var len:int = ids.length;
				for (var i:int; i<len; i++){
					if (id == ids[i]){
						match = true;
						break;
					}
				}
				return match;
			}
			
			var len:int = list.length;
			for (var i:int; i<len; i++){
				if (matchId(list.getItemAt(i), ids)){
					indices.push(i);
				}
			}
			
			return indices;
		}
	}
}