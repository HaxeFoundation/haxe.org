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

	public function doSite() {
		var manualDir = contentDir+Config.app.siteContent.folder;
		var assetSiteContent = context.request.scriptDirectory+Config.app.siteContent.folder;
		var ufSiteContent = contentDir+Config.app.siteContent.folder;
		var downloadInDir = assetSiteContent+'/'+Config.app.siteContent.versions.folder;
		var downloadOutDir = ufSiteContent+'/'+Config.app.siteContent.versions.folder;

		var result = 
			apiDownload
				.prepareDownloadJson(downloadInDir,downloadOutDir)
				.flatMap( function (_) return apiDox.convertDoxForAllVersions(downloadInDir,downloadOutDir) )
				.map( function(_) return "Updated website content successfully" )
		;

		return switch result {
			case Success(out): 
				ViewResult.create({
					title: 'Updated the website content succesfully', 
					content: '<h1>Updated the website content successfully.</h1>'
				}, "page/markdown.html");
			case Failure(err): 
				trace (err);
				ViewResult.create({
					title: 'Failed to update the website content', 
					content: '<h1>$err</h1>'
				}, "page/markdown.html");
		}
	}

	public function doManual( ?forceDelete=false ) {
		var gitRepo = Config.app.manual.repo;
		var manualDir = contentDir+Config.app.manual.dir;
		var manualLatexFile = manualDir+'/'+Config.app.manual.file;
		var manualOutDir = manualDir+'/'+Config.app.manual.out;
		
		var result = 
			apiSite
				.cloneRepo( gitRepo, Config.app.manual.dir, Config.app.manual.branch, forceDelete )
				.flatMap( function (_) return apiManual.convertLatexToHtml(manualLatexFile,manualOutDir) )
				.map( function(_) return "Updated manual successfully" )
		;

		result.sure();
		return ViewResult.create({
			title: 'Updated the manual succesfully', 
			content: '<h1>Updated the manual successfully.</h1>'
		}, "page/markdown.html");
	}
}