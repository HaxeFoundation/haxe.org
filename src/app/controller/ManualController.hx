package app.controller;

import app.api.SiteApi;
import app.api.ManualApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.*;
import ufront.view.TemplateData;
using Strings;
using tink.CoreApi;
using haxe.io.Path;

class ManualController extends Controller {
	
	@inject public var manualApi:ManualApi;
	@inject public var siteApi:SiteApi;
	@inject("contentDirectory") public var contentDir:String;

	public function doDefault( d:Dispatch ) {
		var repo = contentDir+Config.app.manual.dir+"/"+Config.app.manual.out;

		var path = d.parts.join("/");
		if ( path=="" ) path = "introduction.html";

		var result = manualApi.getPage( repo, path ).sure();
		var content = result.a;
		var nav = result.b;

		return ViewResult.create({
			topNav: '/manual/',
			manualTOC: nav,
			editLink: Config.app.manual.editLink
		}).setVars( content );
	}

	function getTopNavName( d:Dispatch ) {
		var name = (d!=null && d.parts.length>0) ? d.parts[0] : '';
		return "/" + name;
	}
}