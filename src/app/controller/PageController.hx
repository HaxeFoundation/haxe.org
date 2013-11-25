package app.controller;

import app.api.SiteApi;
import app.api.PageApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.*;
import ufront.view.TemplateData;
using Strings;
using tink.CoreApi;
using haxe.io.Path;

class PageController extends Controller {
	
	@inject public var pageApi:PageApi;
	@inject public var siteApi:SiteApi;
	@inject("contentDirectory") public var contentDir:String;

	public function doDefault( d:Dispatch ):ActionResult {

		var repo = contentDir+Config.app.siteContent.folder+"/"+Config.app.siteContent.pages.folder;
		
		var page = d.parts.join("/");
		if ( page=="" ) page = "index.html";
		
		switch pageApi.getPage( repo, page ) {
			case Success( result ):
				var filename = result.a;
				var content = result.b;

				var viewFile = "page/default.html";
				if ( filename.extension()=="md" ) {
					content = Markdown.markdownToHtml( content );
					viewFile = "page/markdown.html";
				}

				return ViewResult.create({
					title: guessTitle( page ),
					content: content,
					topNav: getTopNavName( d ),
					editLink: '${Config.app.siteContent.editBaseUrl}$filename'
				}, viewFile);
			case Failure( error ):
				return switch pageApi.attachmentExists( repo,page ) {
					case Some(filePath): new FilePathResult( filePath );
					case None: error.throwSelf();
				}
		}
	}

	function guessTitle( fileName:String ) {
		if ( fileName=="index.html" ) return "";
		return fileName.withoutExtension().replace("-"," ").capitalize();
	}

	function getTopNavName( d:Dispatch ) {
		var name = (d!=null && d.parts.length>0) ? d.parts[0] : '';
		return "/" + name;
	}
}