package app.controller;

import app.api.*;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.ViewResult;
import ufront.view.TemplateData;
using StringTools;
using tink.CoreApi;
using haxe.io.Path;

class UpdateController extends Controller {
	
	@inject("contentDirectory") public var contentDir:String;
	@inject public var apiSite:SiteApi;
	@inject public var apiManual:ManualApi;
	@inject public var apiDox:DoxApi;
	@inject public var apiDownload:DownloadApi;

	public function doDefault() {
		var gitRepo = Config.app.siteContent.repo;
		var siteContentDir = contentDir+Config.app.siteContent.folder;
		var manualLatexFile = siteContentDir+'/'+Config.app.siteContent.manual.file;
		var manualOutDir = siteContentDir+'/'+Config.app.siteContent.manual.out;
		var versionsDir = siteContentDir+'/'+Config.app.siteContent.versions.folder;

		var result = 
			apiSite
				.cloneRepo( gitRepo, siteContentDir )
				.flatMap( function (_) return apiManual.convertLatexToHtml(manualLatexFile,manualOutDir) )
				.flatMap( function (_) return apiDownload.prepareDownloadJson(versionsDir) )
				.flatMap( function (_) return apiDox.convertDoxForAllVersions(versionsDir) )
				.map( function(_) return "Updated website content successfully" )
		;

		return switch result {
			case Success(out): 
				ViewResult.create({
					title: 'Updated the website content succesfully', 
					content: 'Updated the website content successfully.'
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