package app.controller;

import app.api.ManualApi;
import app.api.PageApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.ViewResult;
import ufront.view.TemplateData;
using Strings;
using tink.CoreApi;
using haxe.io.Path;

class PageController extends Controller {
	
	@inject public var api:PageApi;
	@inject public var manualApi:ManualApi;
	@inject("contentDirectory") public var contentDir:String;

	public function doDefault( d:Dispatch ) {

		var page = (d.parts.length>0) ? d.parts.join("/") : "index.html";
		var repo = contentDir+Config.app.pages.name;
		var content = api.getPage( repo, page ).sure();

		return ViewResult.create({
			title: guessTitle( page ),
			content: content,
			topNav: getTopNavName( d ),
			editLink: 'http://github.com/HaxeFoundation/WebsiteContent/${Config.app.pages.name}/$page'
		});
	}

	public function doManual( d:Dispatch ) {
		var path = (d.parts.length>1 || d.parts[0]!="") ? d.parts.join("/") : "introduction.html";
		var repo = contentDir+Config.app.manual.name;

		var result = api.getPage( repo, path ).sure();
		var nav = manualApi.getNavigation( repo ).sure();

		return ViewResult.create({
			title: guessTitle( path ) + " - Manual",
			content: result,
			topNav: '/manual/',
			manualTOC: nav,
			editLink: Config.app.manual.editLink
		});
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