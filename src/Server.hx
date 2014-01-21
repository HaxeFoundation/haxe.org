import app.OldSiteRedirectHandler;
import sys.db.Mysql;
import ufront.app.UfrontApplication;
import ufront.handler.ErrorPageHandler;
import ufront.view.TemplatingEngines;
import ufront.view.UFTemplate;
import ufront.ufadmin.controller.*;
import ufront.auth.*;
import ufront.web.*;
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
		ufrontApp.execute(); // execute the current request
	}

	static function init() {
		if ( ufrontApp==null ) {

			// Set up the error handlers

			var errorPageHandler = new ErrorPageHandler();
			errorPageHandler.renderErrorPage = function( title, content ) return CompileTime.interpolateFile( 'app/view/error.html' );

			var oldSiteRedirectHandler = new OldSiteRedirectHandler();

			// Set up the dispatcher and routing
			
			ufrontApp = 
				new UfrontApplication({
					logFile: "log/haxeorg.log",
					errorHandlers: [oldSiteRedirectHandler,errorPageHandler],
					contentDirectory: "../uf-content/",
					// authFactory: EasyAuth.getFactory( "haxe_org_user_id" )
				})
				.loadRoutesConfig( Dispatch.make(new Routes()) )
				.loadApi( Api )
				.addTemplatingEngine( TemplatingEngines.haxe )
				.inject( String, "layout.html", "defaultLayout" )
			;
		}
	}
}