import ufront.MVC;
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
			defaultLayout: "layout.tpl",
		});

		jsApp.listen();
	}
}
