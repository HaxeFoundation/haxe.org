package app.api;

#if server
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end
import haxe.io.Bytes;
import haxe.ds.Option;
import app.Config;
import haxe.Json;
import ufront.MVC;
import app.model.SiteMap;
using haxe.io.Path;
using tink.CoreApi;
using StringTools;
using Lambda;

class PageApi extends UFApi {

	/**
		Given a URL facing name (eg "support.html", look for the actual file (eg "support.md")

		@param repo - An absolute path to the repository of files to search in.
		@param path - The filename we are searching for.
		@return - An absolute url to the file if found.  Throws PageNotFound if not found...
		@throws - HttpError.pageNotFound()
	**/
	public function locatePage( repo:String, path:String ):String {
		var extensions = Config.app.siteContent.pages.extensions;

		for ( ext in extensions ) {
			var filename = path.withoutExtension().withExtension( ext );
			var filePath = '$repo/$filename';
			if ( FileSystem.exists(filePath) ) {
				return filePath;
			}
		}

		ufError('Could not find page $repo/${path.withoutExtension()}.$extensions');
		return throw HttpError.pageNotFound();
	}

	/**
		Given an exact filepath, return the content of that file.

		If the file is markdown, it will be converted to HTML before returning.

		@param filePath The absolute path to the file we are trying to load.
		@return String containing the html content
		@throws HttpError.internalServerError() if file could not be read.
	**/
	public function loadPage( filePath:String ):String {
		var content =
			try File.getContent(filePath)
			catch (e:Dynamic) throw HttpError.internalServerError('Could not read $filePath', e)
		;
		if ( filePath.extension()=="md" ) {
			content = Markdown.markdownToHtml( content );
		}
		return content;
	}

	/**
		Get the sitemap for a repo.

		This does not validate that the parsed JSON matches our typedef, just that the sitemap exists and is valid JSON.

		@param repo Absolute path to page repo.  Should not include trailing slash.
		@return The loaded and parsed SiteMap.
		@throws `HttpError.internalServerError` if an error occured.
	**/
	public function getSitemap( repo:String ):SiteMap {
		var filename = '$repo/sitemap.json';

		if ( !FileSystem.exists(filename) ) {
			return throw HttpError.internalServerError('The sitemap needed to render the menu for this page could not be found: $filename');
		}

		var content =
			try File.getContent(filename)
			catch (e:Dynamic) throw HttpError.internalServerError('The sitemap needed to render the menu for this page existed, but could not be read: $filename', e)
		;
		var sitemap:SiteMap =
			try Json.parse(content)
			catch (e:Dynamic) throw HttpError.internalServerError('The sitemap needed to render the menu for this page was not valid JSON', e)
		;
		return sitemap;
	}
}
