import app.OldSiteRedirectHandler;
import ufront.app.UfrontApplication;
import ufront.handler.ErrorPageHandler;
import ufront.view.TemplatingEngines;
import ufront.view.UFTemplate;
import ufront.cache.MemoryCache;
import ufront.cache.UFCache;
import ufront.middleware.RequestCacheMiddleware;
import ufront.web.result.ViewResult;
import ufront.ufadmin.controller.*;
import ufront.auth.*;
import ufront.web.*;
import app.*;

class Server
{
	public static var ufrontApp:UfrontApplication;
	/*public static var requestCache:RequestCacheMiddleware;*/

	static function main() {
		// enable caching if using mod_neko or mod_tora
		#if (neko && !debug) neko.Web.cacheModule(run); #end

		run();
	}

	static function run() {
		init(); // If caching is enabled, init() will only need to run once
		ufrontApp.executeRequest(); // execute the current request
	}

	static function init() {
		if ( ufrontApp==null ) {
			// Set up the error handlers

			var errorPageHandler = new ErrorPageHandler();
			errorPageHandler.renderErrorPage = function( title, content ) return CompileTime.interpolateFile( 'app/view/error.html' );

			var oldSiteRedirectHandler = new OldSiteRedirectHandler();

			// Set up cache middleware
			// requestCache = new RequestCacheMiddleware();

			// Set up the dispatcher and routing

			ufrontApp =
				new UfrontApplication({
					indexController: Routes,
					remotingApi: Api,
					#if debug
						logFile: "log/haxeorg.log",
					#end
					errorHandlers: [oldSiteRedirectHandler,errorPageHandler],
					contentDirectory: "../uf-content/",
					defaultLayout: "layout.html",
				})
				.injectValue( UFCacheConnection, new MemoryCacheConnection() )
				.addTemplatingEngine( TemplatingEngines.haxe )
				.injectValue( String, "layout.html", "defaultLayout" )
			;
			// ufrontApp.addRequestMiddleware( requestCache );
			// ufrontApp.addResponseMiddleware( requestCache );
		}
	}
}
