import ufront.MVC;
import ufblog.posts.*;
import app.*;

class Client {
	static var jsApp:ClientJsApplication;

	static function main() {
		// Set up the error handlers
		var errorPageHandler = new ErrorPageHandler();
		errorPageHandler.renderErrorPage = function( title, content ) return CompileTime.interpolateFile( 'app/view/error.html' );

		jsApp = new ClientJsApplication({
			indexController: Routes,
			errorHandlers: [errorPageHandler],
			defaultLayout: "layout.html",
			clientActions: [SavePostAction,SetupEditFormAction,LoadCommentsAction],
			templatingEngines: [TemplatingEngines.haxe,TemplatingEngines.erazorHtml]
		});
		jsApp.injector.map( String, "disqusShortName" ).toValue( 'haxe' );

		jsApp.listen();
	}
}
