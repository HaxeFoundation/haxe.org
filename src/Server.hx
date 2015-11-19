import ufront.MVC;
import app.*;

class Server
{
	public static var ufrontApp:UfrontApplication;

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

			// Set up the app
			ufrontApp = new UfrontApplication({
				indexController: Routes,
				remotingApi: Api,
				errorHandlers: [oldSiteRedirectHandler,errorPageHandler],
				contentDirectory: "../uf-content/",
				defaultLayout: "layout.html",
			});
		}
	}
}
