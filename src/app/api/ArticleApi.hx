package app.api;

import app.model.Article;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import ufront.web.HttpError;
using tink.CoreApi;
using haxe.io.Path;

class ArticleApi extends ufront.api.UFApi {

	@inject("scriptDirectory") public var scriptDir:String;

	inline function articleRepo():String return scriptDir + Config.app.siteContent.folder + '/' + Config.app.siteContent.articles.folder + "/";

	public function getArticleList():Array<Article> {
		return [];
	}

	public function getArticle( articleName:String ):Pair<Article,String> {
		var jsonFile = articleRepo()+'$articleName/article.json';
		if ( FileSystem.exists(jsonFile)==false )
			throw HttpError.pageNotFound();
		var article:Article = Json.parse( File.getContent(jsonFile) );
		var articleFile = articleRepo()+'$articleName/${article.articleFile}';
		var content = File.getContent(articleFile);
		var html = switch articleFile.extension() {
			case "md": Markdown.markdownToHtml( content );
			case "html": content;
			default: throw 'Unknown extension ".${articleFile.extension()}" for article $articleFile';
		}
		return new Pair( article, html );
	}
}
