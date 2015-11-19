package app.controller;

import app.api.ArticleApi;
import app.Config;
import ufront.MVC;
using tink.CoreApi;
using haxe.io.Path;
using StringTools;

class ArticleController extends Controller {

	@inject public var api:ArticleApi;
	@inject("scriptDirectory") public var scriptDir:String;

	static inline function baseEditUrl() return Config.app.siteContent.editBaseUrl+Config.app.siteContent.articles.folder+'/';

	@:route("/")
	public function list() {
		var articles = api.getArticleList();
		return new ViewResult({
			title: "Haxe Articles",
			description: "A collection of articles and posts published by the Haxe foundation",
			articles: articles
		});
		return new ViewResult();
	}

	@:route("/$articleURL/$asset/")
	public function article( articleURL:String, ?asset:String=null ):ActionResult {
		if ( asset==null ) {
			var pair = api.getArticle( articleURL );
			var articleInfo = pair.a;
			var articleHTML = pair.b;
			var url = 'http://${context.request.hostName}${context.request.uri}';
			return new ViewResult().setVars( articleInfo ).setVars({
				content: articleHTML,
				hackerNewsLink: 'https://news.ycombinator.com/submitlink?u=${url.urlEncode()}&t=${articleInfo.title.urlEncode()}'
			});
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
