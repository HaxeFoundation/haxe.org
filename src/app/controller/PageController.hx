package app.controller;

import app.api.PageApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.ViewResult;
import ufront.view.TemplateData;
using StringTools;
using tink.CoreApi;
using haxe.io.Path;

class PageController extends Controller {
	
	@inject public var api:PageApi;

	public function doDefault( d:Dispatch ) {
		var page = (d.parts.length>0) ? d.parts.join("/") : "index";

		var result = api.getPage( page ).sure();
		var content = result.a;
		var filename = result.b;

		return ViewResult.create({
			title: page,
			content: content,
			topNav: getTopNavName( d ),
			editLink: 'http://github.com/${Config.app.pages.name}$filename'
		}).withLayout( "layout.html" );
	}

	public function doManual( d:Dispatch ) {
		var path = (d.parts.length>0) ? d.parts.join("/") : "introduction";
		var result = api.getManualPage( path ).sure();

		return ViewResult.create({
			title: result.title,
			content: result.html,
			topNav: '/manual'+getTopNavName( d ),
			manualTOC: "Manual Table of Contents"
		});
	}

	public function doManualUpdate() {
		return switch api.cloneRepo( Config.app.manual.repo, Config.app.manual.name ) {
			case Success(out): 
				ViewResult.create({
					title: 'Updated the manual', 
					content: out
				});
			case Failure(err): 
				ViewResult.create({
					title: 'Failed to update the manual', 
					content: err
				});
		}
	}

	function getTopNavName( d:Dispatch ) {
		var name = (d!=null && d.parts.length>0) ? d.parts[0] : '';
		return "/" + name;
	}
}