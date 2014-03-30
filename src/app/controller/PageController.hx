package app.controller;

import app.api.SiteApi;
import app.api.PageApi;
import app.Config;
import ufront.web.context.HttpContext;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.*;
import ufront.view.TemplateData;
import ufront.web.HttpError;
using Strings;
using tink.CoreApi;
using haxe.io.Path;
using app.model.SiteMap;

class PageController extends Controller {
	
	@inject public var pageApi:PageApi;
	@inject public var siteApi:SiteApi;

	@:route("/")
	public function doHomepage() {
		var siteContentDir = context.request.scriptDirectory+Config.app.siteContent.folder;
		var repo = siteContentDir+"/"+Config.app.siteContent.pages.folder;
		return showContent( null, "/", "index.html", repo, repo, null );
	}

	@:route( "/manual/$page" ) 
	public function doManual( ?page:String="introduction.html" ) {
		var repo = context.httpContext.contentDirectory+Config.app.manual.dir+"/"+Config.app.manual.htmlDir;
		var attachmentsRepo = context.httpContext.contentDirectory+Config.app.manual.dir+"/"+Config.app.manual.imagesDir;
		var sidebar = pageApi.getSitemap( repo );
		var title = sidebar.getPageForUrl( page ).title;
		return showContent( title, "/manual/", page, repo, attachmentsRepo, sidebar );
	}

	@:route( "/$folder/*" )
	public function doDefault( folder:String, rest:Array<String> ) {
		var siteContentDir = context.request.scriptDirectory+Config.app.siteContent.folder;
		var repo = siteContentDir+"/"+Config.app.siteContent.pages.folder+"/"+folder;

		// If it's not a top-level page, we will need to load a side-menu.
		var sitemap = pageApi.getSitemap( siteContentDir );
		var sidebar = 
			try sitemap.getPageForUrl( folder ).sub
			catch ( e:Dynamic ) null;

		var page = rest.join("/");

		var title = 
			try sitemap.getPageForUrl( '$folder/$page' ).title
			catch ( e:Dynamic ) null;

		if ( page=="" ) page = "index.html";
		if ( page.extension()=="" ) page += "/index.html";

		return showContent( title, "/", page, repo, repo, sidebar );
	}

	function showContent( title:String, baseUrl:String, file:String, repo:String, attachmentsRepo:String, sidebar:SiteMap ):ActionResult {
		if ( attachmentsRepo==null )
			attachmentsRepo = repo;

		switch file.extension() {
			case "html": 
				var filename = pageApi.locatePage( repo, file );	
				var content = pageApi.loadPage( filename );
				var nav:String = (sidebar!=null) ? sidebar.printSitemap( SideBar, baseUrl, context.request.uri ) : null;

				var viewFile = (sidebar!=null) ? "page/page-with-sidebar.html" : "page/raw.html";

				return ViewResult.create({
					title: title,
					content: content,
					sideNav: nav,
					editLink: Config.app.siteContent.editBaseUrl+filename
				}, viewFile);
			case _:
				var attachment = pageApi.getAttachment( attachmentsRepo, file );
				var bytes = attachment.a;
				var filename = attachment.b;
				var result = new BytesResult( bytes, filename );
				result.setContentTypeByFilename( filename );
				return result;
		}
	}
}