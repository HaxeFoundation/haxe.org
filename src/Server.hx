import ufront.MVC;
import app.*;
import ufblog.*;

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
		var cnx = sys.db.Mysql.connect( Config.db );
		sys.db.Transaction.main( cnx, function() {
			ufrontApp.executeRequest();
		});
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
				errorHandlers: [oldSiteRedirectHandler,errorPageHandler],
				contentDirectory: "../uf-content/",
				defaultLayout: "layout.html",
				templatingEngines: [TemplatingEngines.haxe,TemplatingEngines.erazorHtml]
			})
			.loadApiContext( Api )
			.loadApiContext( BlogRemotingApiContext );

			ufrontApp.injector.map( String, "disqusShortName" ).toValue( 'haxe' );
		}
	}
}
