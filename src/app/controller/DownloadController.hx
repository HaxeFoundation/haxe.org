package app.controller;

import app.api.DownloadApi;
import app.api.SiteApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.FilePathResult;
import ufront.web.result.ViewResult;
import ufront.view.TemplateData;
using Strings;
using tink.CoreApi;
using haxe.io.Path;

class DownloadController extends Controller {
	
	@inject("contentDirectory") public var contentDir:String;
	@inject public var apiDownload:DownloadApi;
	@inject public var apiSite:SiteApi;

	static inline function versionRepo() return Config.app.siteContent.folder+'/'+Config.app.siteContent.versions.folder;

	public function doDefault(  ) {
		var currentVersion = apiSite.getCurrentVersion( versionRepo() );
		return doVersion( currentVersion );
	}

	public function doList() {
		var result = apiDownload.getDownloadList( contentDir+versionRepo() ).sure();
		result.versions.reverse();
		return ViewResult.create({
			title: 'Haxe Download List', 
			tagBaseUrl: Config.app.siteContent.versions.tagBaseUrl,
			editLink: Config.app.siteContent.versions.versionsBaseUrl
		}).setVars( result );
	}

	public function doVersion( version:String ) {
		var result = apiDownload.getDownloadVersion( contentDir+versionRepo(), version ).sure();
		return ViewResult.create({
			title: 'Haxe $version',
			tagBaseUrl: Config.app.siteContent.versions.tagBaseUrl,
			editLink: Config.app.siteContent.versions.versionsBaseUrl + '$version/'
		}).setVars( result );
	}

	public function doFile( version:String, file:String ) {
		version = version.replace( '.', ',' );
		return new FilePathResult( contentDir+versionRepo()+'/$version/downloads/$file', null, file );
	}
}