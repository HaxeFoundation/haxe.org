package app.controller;

import app.api.ManualApi;
import app.api.PageApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.ViewResult;
import ufront.view.TemplateData;
using StringTools;
using tink.CoreApi;
using haxe.io.Path;

class UpdateController extends Controller {
	
	@inject public var pageApi:PageApi;
	@inject public var manualApi:ManualApi;
	@inject("contentDirectory") public var contentDir:String;

	public function doPages() {
		return switch pageApi.cloneRepo( Config.app.manual.repo, Config.app.manual.name+"-repo" ) {
			case Success(out): 
				ViewResult.create({
					title: 'Updated the site pages', 
					content: out
				}, "page/default.html");
			case Failure(err): 
				ViewResult.create({
					title: 'Failed to update the site pages', 
					content: err
				}, "page/default.html");
		}
	}

	public function doManual() {
		var gitRepo = Config.app.manual.repo;
		var latex = contentDir+Config.app.manual.name+'-repo/'+Config.app.manual.latex;
		var outDir = contentDir+Config.app.manual.name;
		var result = 
			pageApi
				.cloneRepo( gitRepo, Config.app.manual.name+'-repo' )
				.flatMap( function (_) return manualApi.convertLatex(latex,outDir) )
				.map( function(_) return "Updated manual successfully" )
		;

		return switch result {
			case Success(out): 
				ViewResult.create({
					title: 'Updated the manual', 
					content: out
				}, "page/default.html");
			case Failure(err): 
				trace (err);
				ViewResult.create({
					title: 'Failed to update the manual', 
					content: err
				}, "page/default.html");
		}
	}
}