package app.controller;

import app.api.DownloadApi;
import app.api.SiteApi;
import app.Config;
import ufront.MVC;
using thx.Strings;
using tink.CoreApi;
using haxe.io.Path;

@cacheRequest
class DownloadController extends Controller {

	@inject("contentDirectory") public var contentDir:String;
	@inject public var apiDownload:DownloadApi;
	@inject public var apiSite:SiteApi;

	static inline function versionRepo() return Config.app.siteContent.folder+'/'+Config.app.siteContent.versions.folder;
    static inline function baseEditUrl() return Config.app.siteContent.editBaseUrl+Config.app.siteContent.versions.folder+'/';

	@:route("/")
	public function doDefault() {
		var currentVersion = apiSite.getCurrentVersion( versionRepo() );
		return doVersion( currentVersion );
	}

	@:route("/list/")
	public function doList() {
		var result = apiDownload.getDownloadList();
		var versions = result.versions;
		versions.reverse();
		return new ViewResult({
			title: 'Haxe Download List',
			topNav: '/download/',
			tagBaseUrl: Config.app.siteContent.versions.tagBaseUrl,
			editLink: baseEditUrl(),
			versions: versions,
			current: result.current,
			description: 'A list of versions of Haxe available for download on Windows, Mac and Linux.'
		});
	}

	@:route("/linux/")
	public function doLinux() {
		return new ViewResult({
			description: 'Linux packages officially maintained by the Haxe Foundation.'
		});
	}

	@:route("/version/$version")
	public function doVersion( version:String ) {
		var result = apiDownload.getDownloadVersion( contentDir+versionRepo(), version );
		return new ViewResult({
			title: 'Haxe $version',
			topNav: '/download/',
			tagBaseUrl: Config.app.siteContent.versions.tagBaseUrl,
			compareBaseUrl: Config.app.siteContent.versions.compareBaseUrl,
			editLink: baseEditUrl() + version + '/',
			description: 'Download Haxe $version for Windows, Mac or Linux.'
		}, "version.html" ).setVars( result );
	}

	@:route("/file/$version/$file")
	public function doFileDownload( version:String, file:String ) {
		var directDownloadLink = '/'+versionRepo()+'/$version/downloads/$file';
		var result = apiDownload.getDownloadVersion( contentDir+versionRepo(), version );
		return new ViewResult({
			title: 'Haxe $version',
			topNav: '/download/',
			directDownloadLink: directDownloadLink,
			editLink: null,
			description: 'Downloading Haxe $version: $file'
		} ).setVars( result );
	}

	@:route("/api/$version/api.zip")
	public function doApiDownload( version:String ) {
		var scriptDir = context.request.scriptDirectory;
		var file = 'api-$version.zip';
		return new DirectFilePathResult( scriptDir+versionRepo()+'/$version/$file' );
	}
}
