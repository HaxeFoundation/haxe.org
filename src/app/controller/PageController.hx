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

@cacheRequest
class PageController extends Controller {
	
	@inject public var pageApi:PageApi;
	@inject public var siteApi:SiteApi;

	@:route("/")
	public function doHomepage() {
		var siteContentDir = context.request.scriptDirectory+Config.app.siteContent.folder;
		var repo = siteContentDir+"/"+Config.app.siteContent.pages.folder;
		return showContent({
			title: null,
			baseUrl: "/",
			file: "index.html",
			repo: repo,
			attachmentsRepo: repo,
			sidebar: null,
			editLink: null
		});
	}

	@:route("/documentation/")
	inline public function documentationRedirect() return new RedirectResult( "/documentation/introduction/" );

	@:route("/manual/")
	inline public function manualRedirect() return new RedirectResult( "/manual/introduction.html" );

	@:route("/community/")
	inline public function communityRedirect() return new RedirectResult( "/community/community-support.html" );

	@:route( "/manual/$page" ) 
	public function doManual( ?page:String="introduction.html" ) {
		var repo = context.contentDirectory+Config.app.manual.htmlDir;
		var attachmentsRepo = context.contentDirectory+Config.app.manual.imagesDir;
		var sitemap = pageApi.getSitemap( repo );
		var pageDetails =
			try sitemap.getPageForUrl( '$page' )
			catch ( e:Dynamic ) null;
		var title = (pageDetails!=null) ? pageDetails.title : null;
		var editLink = (pageDetails!=null) ? pageDetails.editLink : null;
		return showContent({
			title: title,
			baseUrl: "/manual/",
			file: page,
			repo: repo,
			attachmentsRepo: attachmentsRepo,
			sidebar: sitemap,
			editLink: editLink
		});
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

		return showContent({
			title: title,
			baseUrl: "/",
			file: page,
			repo: repo,
			attachmentsRepo: repo,
			sidebar: sidebar,
			editLink: null
		});
	}

	function showContent( params:{ title:String, baseUrl:String, file:String, repo:String, attachmentsRepo:String, sidebar:SiteMap, editLink:Null<String> } ):ActionResult {
		switch params.file.extension() {
			case "html": 

				var nav = null,
				    prevNextLinks = null,
				    viewFile:String;

				var filename = pageApi.locatePage( params.repo, params.file );
				var content = pageApi.loadPage( filename );

				if ( params.sidebar!=null ) {
					nav = params.sidebar.printSitemap( SideBar, params.baseUrl, context.getRequestUri() );
					prevNextLinks = params.sidebar.getPrevNextLinks( params.baseUrl, context.getRequestUri() );
					viewFile = "page/page-with-sidebar.html";
				}
				else {
					viewFile = "page/raw.html";
				}

				if ( params.editLink==null ) {
					var siteContentDir = context.request.scriptDirectory+Config.app.siteContent.folder+"/"+Config.app.siteContent.pages.folder;
					var relativeFilename = filename.substr( siteContentDir.length+1 );
					params.editLink = Config.app.siteContent.editBaseUrl+Config.app.siteContent.pages.folder+'/'+relativeFilename;
				}

				return ViewResult.create({
					title: params.title,
					content: content,
					sideNav: nav,
					prevNextLinks: prevNextLinks,
					editLink: params.editLink
				}, viewFile);

			case _:
				var filename = '${params.attachmentsRepo}/${params.file}';
				return new DirectFilePathResult( filename );
		}
	}
}
