package app;

#if server

import sys.io.File;
import ufront.app.UFErrorHandler;
import ufront.core.Sync;
import ufront.web.context.HttpContext;
using tink.CoreApi;
using haxe.io.Path;
using StringTools;

class OldSiteRedirectHandler implements UFErrorHandler {

	static var redirects:String;

	public function new() {}

	public function handleError( err:Error, ctx:HttpContext ):Surprise<Noise,Error> {
		loadRedirects( ctx );

		if ( !ctx.completion.has(CRequestHandlersComplete) && err.code==404 ) {

			var oldDomain = 'http://old.haxe.org';
			var uri = removeTrailingSlash( ctx.request.uri );
			var queryString = ctx.request.queryString;

			var csvSearchString = '\n"$uri"\t"';
			var indexOfHit = redirects.indexOf( csvSearchString );

			var newUrl = null;
			var straightRedirect = false;

			if ( indexOfHit>-1 ) {
				var tabPos = indexOfHit+csvSearchString.length;
				var endOfLine = redirects.indexOf( '"\n', tabPos );
				newUrl = redirects.substring( tabPos, endOfLine );
				// If no specific redirect is specified, point to the same document, but on old.haxe.org
				straightRedirect = newUrl.length==0;
			}
			else if ( uri.startsWith("/forum") || uri.startsWith("/wiki") || uri.startsWith("/api") || uri.startsWith("/file") ) {
				straightRedirect = true;
			}

			if ( straightRedirect ) {
				newUrl = '$oldDomain$uri';
				if ( queryString!="" ) newUrl += '?$queryString';
			}

			if ( newUrl!=null ) {
				ctx.response.permanentRedirect( newUrl );
				ctx.completion.set( CRequestHandlersComplete );
				ctx.completion.set( CErrorHandlersComplete );
			}
		}

		return Sync.success();
	}

	function loadRedirects( ctx:HttpContext ) {
		if ( redirects==null ) {
			var csvFile = ctx.request.scriptDirectory+'website-content/oldwiki.csv';
			try {
				redirects = File.getContent( csvFile );
			}
			catch ( e:Dynamic ) {
				ctx.ufLog( "Unable to load redirect CSV File" );
			}
		}
	}

	static function removeTrailingSlash ( path : String ) : String {
		return switch(path.charCodeAt(path.length - 1)) {
			case '/'.code | '\\'.code: path.substr(0, -1);
			case _: path;
		}
	}
}

#end
