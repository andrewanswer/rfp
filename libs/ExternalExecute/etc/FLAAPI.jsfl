FLAAPI = {
	publish: function(fileURI, className){
		var doc = fl.openDocument(fileURI);
		if (doc) {
			var dom = fl.getDocumentDOM();
			dom.docClass = className;
			doc.publish();
			doc.close(false);
			return true;
		} else {		
			return false;
		}
	}
}