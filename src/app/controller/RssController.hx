package app.controller;

import ufblog.posts.BlogPost;
import ufblog.posts.BlogPostApi;
import ufront.MVC;

using DateTools;
using ufront.db.DBSerializationTools;

@cacheRequest
class RssController extends Controller {

	@inject public var blogPostApi:BlogPostApi;

	@:route("/")
	public function rss() {
		var number = 20;
		var posts = blogPostApi.getPostList({ pos: 0, length: number });
		var rss = buildRss( posts );
		var content = '<?xml version="1.0" encoding="UTF-8"?>'+rss.toString();
		return new ContentResult( content, "text/xml" );
	}

	function buildRss( posts:Array<BlogPost> ):Xml {
		// Helpers for building the XML
		var createChild = function(root:Xml, name:String){
			var c = Xml.createElement( name );
			root.addChild( c );
			return c;
		}
		var createChildWithContent = function(root:Xml, name:String, content:String){
			var e = Xml.createElement( name );
			var c = Xml.createPCData( if (content != null) content else "" );
			e.addChild( c );
			root.addChild( e );
			return e;
		}
		var createChildWithCdata = function(root:Xml, name:String, content:String){
			var e = Xml.createElement( name );
			var c = Xml.createCData( if (content != null) content else "" );
			e.addChild( c );
			root.addChild( e );
			return e;
		}

		// Set some variables we'll use.
		Sys.setTimeLocale( "en_US.UTF8" );
		var hostName = context.request.hostName;
		var url = "http://"+hostName;
		var num = posts.length;

		// Create the RSS document and headers.
		var rss = Xml.createElement( "rss" );
		rss.set( "version", "2.0" );
		rss.set( "xmlns:atom", "http://www.w3.org/2005/Atom" );
		rss.set( "xmlns:dc", "http://purl.org/dc/elements/1.1/" );
		var channel = createChild( rss, "channel" );
		var link = createChild( channel, "atom:link" );
		link.set( "href", 'https://$hostName/blog/rss/' );
		link.set( "rel", "self" );
		link.set( "type", "application/rss+xml" );
		createChildWithContent( channel, "title", 'Latest Haxe Blog Posts ($hostName)' );
		createChildWithContent( channel, "link", url );
		createChildWithContent( channel, "description", 'The latest $num blog posts on $hostName' );
		createChildWithContent( channel, "generator", "haxe" );
		createChildWithContent( channel, "language", "en" );

		// Create the various RSS entries.
		for ( post in posts ) {
			var item = createChild(channel, "item");
			createChildWithContent( item, "title", post.title );
			var url = 'https://$hostName/blog/${post.url}';
			createChildWithContent( item, "link", url );
			createChildWithContent( item, "guid", url );
			var date = (post.publishDate:Date).format( "%a,%e %b %Y %H:%M:%S %z" ); // No draft in rss == no null publishDate
			createChildWithContent( item, "pubDate", date );
			createChildWithContent( item, "dc:creator", post.author.name );
			createChildWithContent( item, "description", post.introduction );
		}

		return rss;
	}
}
