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
		var siteUfContentDir = contentDir+Config.app.siteContent.folder;
		var siteContentDir = context.request.scriptDirectory+Config.app.siteContent.folder;
		var manualLatexFile = siteUfContentDir+'/'+Config.app.siteContent.manual.file;
		var manualOutDir = siteUfContentDir+'/'+Config.app.siteContent.manual.out;
		var downloadInDir = siteContentDir+'/'+Config.app.siteContent.versions.folder;
		var downloadOutDir = siteUfContentDir+'/'+Config.app.siteContent.versions.folder;
		ufTrace( downloadInDir );
		ufTrace( downloadOutDir );

		var result = 
			apiSite
				.cloneRepo( gitRepo, siteUfContentDir )
				.flatMap( function (_) return apiManual.convertLatexToHtml(manualLatexFile,manualOutDir) )
				.flatMap( function (_) return apiDownload.prepareDownloadJson(downloadInDir,downloadOutDir) )
				.flatMap( function (_) return apiDox.convertDoxForAllVersions(downloadInDir,downloadOutDir) )
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