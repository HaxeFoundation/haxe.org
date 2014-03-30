package app.api;

#if server
	import haxe.Json;
	import sys.FileSystem;
	import sys.io.File;
#end

import app.model.Manual;
import ufront.web.HttpError;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;
using Strings;

class ManualApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Load a given manual page from the given repo.

		@param `repo` absolute path to page repo.  Should not include trailing slash
		@param `path` no leading slash, should include extension
		@return `Pair(content,navigation)`
		@throw HttpError if not found
	**/
	public function getPage( repo:String, path:String ):Pair<ManualPage,String> {

		var content:ManualPage = null;
		
		var filePath = '$repo/$path'.withoutExtension().withExtension("json");
		if ( FileSystem.exists(filePath) ) {
			var json = 
				try File.getContent( filePath ) 
				catch ( e:Dynamic ) throw 'Failed to read manual page $filePath: $e';
			content = 
				try Json.parse( json )
				catch ( e:Dynamic ) throw 'Failed to parse manual json $filePath: $e';
		}

		var navPath = '$repo/navigation.html';
		var nav = 
			try File.getContent( navPath ) 
			catch ( e:Dynamic ) throw 'Failed to read manual nav $navPath: $e';

		if ( content==null ) {
			ufError('Could not find manual page $path');
			throw HttpError.pageNotFound();
		}
		return new Pair(content,nav);
	}
	
}