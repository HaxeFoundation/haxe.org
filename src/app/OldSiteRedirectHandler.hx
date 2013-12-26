package app;

import sys.io.File;
import ufront.app.UFErrorHandler;
import ufront.core.Sync;
import ufront.web.context.HttpContext;
import ufront.web.HttpError;
using tink.CoreApi;
using haxe.io.Path;
using StringTools;

class OldSiteRedirectHandler implements UFErrorHandler {

	static var redirects:String;

	public function new() {}

	public function handleError( err:HttpError, ctx:HttpContext ):Surprise<Noise,HttpError> {
		loadRedirects( ctx );

		if ( !ctx.completion.has(CRequestHandlersComplete) && err.code==404 ) {
			
			var oldDomain = 'http://old.haxe.org';
			var uri = ctx.request.uri.removeTrailingSlash();
			var queryString = ctx.request.queryString;
			
			var csvSearchString = '\n$uri,';
			var indexOfHit = redirects.indexOf( csvSearchString );

			var newUrl = null;
			var straightRedirect = false;

			if ( indexOfHit>-1 ) {
				var commaPos = indexOfHit+csvSearchString.length;
				var endOfLine = redirects.indexOf( '\n', commaPos );
				newUrl = redirects.substring( commaPos, endOfLine );
				straightRedirect = newUrl.length==0; // No specific redirect specified, point to same address old.haxe.org
			}
			else if ( uri.startsWith("/forum") || uri.startsWith("/wiki") || uri.startsWith("/api") ) {
				straightRedirect = true;
			}

			if ( straightRedirect ) {
				newUrl = '$oldDomain$uri';
				if ( queryString!="" ) newUrl += '?$queryString';
			}
			
			if ( newUrl!=null ) {
				ctx.response.permanentRedirect( newUrl );
				ctx.completion.set( CRequestHandlersComplete );
			}
		}

		return Sync.success();
	}

	function loadRedirects( ctx:HttpContext ) {
		if ( redirects==null ) {
			var csvFile = ctx.contentDirectory+'website-content/oldwiki.csv';
			try {
				redirects = File.getContent( csvFile );
			}
			catch ( e:Dynamic ) {
				ctx.ufLog( "Unable to load redirect CSV File" );
			}
		}
	}
}