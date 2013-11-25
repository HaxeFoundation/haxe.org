package app.api;

#if server
	import haxe.ds.Option;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end
import app.Config;
import haxe.Json;
import ufront.web.HttpError;
using haxe.io.Path;
using tink.CoreApi;
using StringTools;
using Lambda;

class PageApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Load a given page from the given repo.

		Will ignore the provided extension, and check instead for each extension provided in `Config.app.siteContent.pages.extensions`, in order, and take the first match.

		@param `repo` absolute path to page repo.  Should not include trailing slash
		@param `path` no leading slash, extension will be ignored.
		@return `Success( Pair(filename,html) )` if found, or `Failure(HttpError)` if not
	**/
	public function getPage( repo:String, path:String ):Outcome<Pair<String,String>,HttpError> {

		var extensions = Config.app.siteContent.pages.extensions;

		for ( ext in extensions ) {
			var fileName = path.withoutExtension().withExtension( ext );
			var filePath = '$repo/$fileName';
			if ( FileSystem.exists(filePath) ) {
				return 
					try Success( new Pair(fileName,File.getContent(filePath)) )
					catch (e:Dynamic) Failure( HttpError.internalServerError('Could not read $filePath', e) );
			}
		}
		
		ufError('Could not find page $repo/${path.withoutExtension()}.$extensions');
		return Failure( HttpError.pageNotFound() );
	}

	/**
		Check if a file exists, and is not one of the files we would normally process (markdown, html etc)

		This is probably an image or other kind of attachment.  

		This just checks it exists and returns the file path if it does

		@param `repo` absolute path to page repo.  Should not include trailing slash
		@param `path` no leading slash, should include extension
		@return `Some( filepath )` if found, or `None` if not
	**/
	public function attachmentExists( repo:String, path:String ):Option<String> {
		var extensions = Config.app.siteContent.pages.extensions;
		var fileName = '$repo/$path';
		if ( FileSystem.exists(fileName) && extensions.has(fileName.extension())==false ) {
			return Some( fileName );
		}
		return None;
	}
}