package app.controller;

import app.api.ArticleApi;
import app.Config;
import ufront.web.Controller;
import ufront.web.result.*;
using thx.Strings;
using tink.CoreApi;
using haxe.io.Path;

class ArticleController extends Controller {

	@inject public var api:ArticleApi;
	@inject("scriptDirectory") public var scriptDir:String;

	static inline function baseEditUrl() return Config.app.siteContent.editBaseUrl+Config.app.siteContent.articles.folder+'/';

	@:route("/")
	public function list() {
		// var result = api.getDownloadList();
		// var versions = result.versions;
		// versions.reverse();
		// return new ViewResult({
		// 	title: 'Haxe Download List',
		// 	topNav: '/download/',
		// 	tagBaseUrl: Config.app.siteContent.versions.tagBaseUrl,
		// 	editLink: baseEditUrl(),
		// 	versions: versions,
		// 	current: result.current,
		// 	description: 'A list of versions of Haxe available for download on Windows, Mac and Linux.'
		// });
		return new ViewResult();
	}

	@:route("/$articleURL/$asset/")
	public function article( articleURL:String, ?asset:String=null ):ActionResult {
		if ( asset==null ) {
			var pair = api.getArticle( articleURL );
			var articleInfo = pair.a;
			var articleHTML = pair.b;
			var url = 'http://${context.request.hostName}${context.request.uri}';
			return new ViewResult({
				title: articleInfo.title,
				author: articleInfo.author,
				description: articleInfo.description,
				background: articleInfo.background,
				date: articleInfo.date,
				content: articleHTML,
				hackerNewsLink: 'https://news.ycombinator.com/submitlink?u=${url.urlEncode()}&t=${articleInfo.title.urlEncode()}'
			});
			return new ViewResult();
		}
		else {
			var articleRepo = Config.app.siteContent.folder+'/'+Config.app.siteContent.articles.folder+"/";
			var assetPath = scriptDir+articleRepo+articleURL+"/"+asset;
			ufTrace( assetPath );
			return new DirectFilePathResult( assetPath );
		}
		return null;
	}
}
