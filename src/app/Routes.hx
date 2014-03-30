package app;

import app.api.PageApi;
import ufront.web.Dispatch;
import ufront.web.Controller;
import ufront.web.result.ViewResult;
import app.controller.*;
// import ufront.ufadmin.controller.UFAdminController;
using app.model.SiteMap;

class Routes extends Controller
{
	@inject public var pageApi:PageApi;

	public function new( context ) {
		super( context );

		// All MVC actions come through Routes (our index controller) first, so this is a good place to set global template variables.
		var repo = context.request.scriptDirectory+Config.app.siteContent.folder;
		var sitemap = pageApi.getSitemap( repo );
		ViewResult.globalValues.set( "navBar", sitemap.printSitemap(NavBar,"/",context.request.uri) );
		ViewResult.globalValues.set( "siteMap", sitemap.printSitemap(Footer,"/",context.request.uri) );
	}

	@:route("/download/*") var download:DownloadController;
	@:route("/update/*") var update:UpdateController;
	@:route("/search/*") var search:SearchController;
	@:route("/*") var pages:PageController;

	#if server
		// public function doUFAdmin( d:Dispatch ) return d.returnDispatch( new UFAdminController() );
	#end
}