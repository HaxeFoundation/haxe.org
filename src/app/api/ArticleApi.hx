package app.api;

import app.model.Article;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import ufront.MVC;
using tink.CoreApi;
using haxe.io.Path;

class ArticleApi extends UFApi {

	@inject("scriptDirectory") public var scriptDir:String;

	inline function articleRepo():String return scriptDir + Config.app.siteContent.folder + '/' + Config.app.siteContent.articles.folder;
	inline function getArticleJsonPath(articleName:String):String return articleRepo()+'/$articleName/article.json';

	public function getArticleList():Array<Article> {
		var articleNames = FileSystem.readDirectory( articleRepo() );
		var articles = [];
		for (name in articleNames) {
			try {
				var jsonFile = getArticleJsonPath( name );
				var article:Article = Json.parse( File.getContent(jsonFile) );
				article.slug = name;
				if ( article.published )
					articles.push( article );
			}
			catch( e:Dynamic ) ufError('Failed to read article "$name": $e');
		}
		articles.sort(function(a1,a2) return -1 * Reflect.compare(a1.date,a2.date) );
		return articles;
	}

	public function getArticle( articleName:String ):Pair<Article,String> {
		var jsonFile = getArticleJsonPath( articleName );
		if ( FileSystem.exists(jsonFile)==false )
			throw HttpError.pageNotFound();
		var article:Article = Json.parse( File.getContent(jsonFile) );
		article.slug = articleName;
		var articleFile = articleRepo()+'/$articleName/${article.articleFile}';
		var content = File.getContent(articleFile);
		var html = switch articleFile.extension() {
			case "md": Markdown.markdownToHtml( content );
			case "html": content;
			default: throw 'Unknown extension ".${articleFile.extension()}" for article $articleFile';
		}
		return new Pair( article, html );
	}
}
