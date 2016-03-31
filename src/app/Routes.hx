package app;

import ufront.MVC;
import app.api.PageApi;
import app.controller.*;
import ufblog.BlogRoutes;
using app.model.SiteMap;
using StringTools;

class Routes extends Controller
{
	@inject public var pageApi:PageApi;

	// Perform init() after dependency injection has occured.
	@post public function init() {
		// All MVC actions come through Routes (our index controller) first, so this is a good place to set global template variables.
		#if server
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
		#end
		ViewResult.globalValues.set( "todaysDate", Date.now() );
		ViewResult.globalValues.set( "currentYear", Date.now().getFullYear() );
		ViewResult.globalValues.set( "description", "Haxe is an open source toolkit based on a modern, high level, strictly typed programming language." );
	}

	#if server
		@:route("/blog/rss/") var rss:RssController;
	#end
	@:route("/blog/*") var blog:BlogRoutes;
	#if server
		@:route("/update/*") var update:UpdateController;
		@:route("/download/*") var download:DownloadController;
		@:route("/search/*") var search:SearchController;
		@:route("/articles/*") var articles:ArticleController;
		@:route("/*") var pages:PageController;
	#end
}
