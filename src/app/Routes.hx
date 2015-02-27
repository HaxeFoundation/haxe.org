package app;

import app.api.PageApi;
import ufront.web.Dispatch;
import ufront.web.Controller;
import ufront.web.result.ViewResult;
import app.controller.*;
using app.model.SiteMap;

class Routes extends Controller
{
	@inject public var pageApi:PageApi;
	
	// Perform init() after dependency injection has occured.
	@post public function init() {
		// All MVC actions come through Routes (our index controller) first, so this is a good place to set global template variables.
		var repo = context.request.scriptDirectory+Config.app.siteContent.folder;
		var sitemap = pageApi.getSitemap( repo );
		var r = context.request;
		var url = 'http://'+r.hostName+r.uri;
		if ( r.queryString!="" ) {
			url += '?'+r.queryString;
		}
		ViewResult.globalValues.set( "navBar", sitemap.printSitemap(NavBar,"/",r.uri) );
		ViewResult.globalValues.set( "siteMap", sitemap.printSitemap(Footer,"/",r.uri) );
		ViewResult.globalValues.set( "pageUrl", url );
		ViewResult.globalValues.set( "todaysDate", Date.now() );
		ViewResult.globalValues.set( "description", "Haxe is an open source toolkit based on a modern, high level, strictly typed programming language." );
	}

	@:route("/download/*") var download:DownloadController;
	@:route("/update/*") var update:UpdateController;
	@:route("/search/*") var search:SearchController;
	@:route("/*") var pages:PageController;
}
