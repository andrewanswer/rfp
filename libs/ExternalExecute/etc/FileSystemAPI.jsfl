FileSystemAPI = {
	createFile: function(fileURI, textToWrite){
		return FLfile.write(fileURI, textToWrite)
	},
	readFile: function(fileURI){
		return FLfile.read(fileURI)
	},
	writeFile: function(fileURI, textToWrite, strAppendMode){
		if (strAppendMode) {
			return FLfile.write(fileURI, textToWrite, strAppendMode)
		} else {
			return FLfile.write(fileURI, textToWrite)
		}
	}, 
	copyFile: function(fileURI, copyURI){
		return FLfile.copy(fileURI, copyURI)
	},
	createDirectory: function(folderURI){
		return FLfile.createFolder(folderURI)
	},
	listDirectoryContents: function(folderURI){
		return FLfile.listFolder(folderURI)
	},
	remove: function(itemURI){
		return FLfile.remove(itemURI)
	},
	exists: function(fileURI){
		return FLfile.exists(fileURI)
	}, 
	browseForFile: function(selectPrompt){
		return fl.browseForFileURL("select", selectPrompt); 
	},
	browseForDirectory: function(selectPrompt){
		return fl.browseForFolderURL(selectPrompt);
	}, 
	platformPathToURI: function(platformPath){
		return FLfile.platformPathToURI(platformPath);
	},
	uriToPlatformPath: function(fileURI){
		return FLfile.uriToPlatformPath(fileURI)
	}
};