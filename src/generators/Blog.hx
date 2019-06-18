package generators;

import haxe.Json;
import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import sys.FileSystem;
import sys.io.File;
import tink.template.Html;

using StringTools;

typedef Post = {
	var authors : Array<Author>;
	var background : String;
	var content : String;
	var description : String;
	var disqusID : String; // Used in post from old website code, to keep comments
	var date : String;
	var name : String;
	var tags : Array<{ name:String }>;
	var title : String;
	var published : Bool;
}

typedef Tag = {
	tag : String,
	name : String,
	description : String
}

typedef Author = {
	username : String,
	name : String,
	avatar : String,
	?since : Int,
	?bio : String,
	?country : String
}

class Blog {
	public static var posts:Array<Post> = [];

	static function getAuthorID (author:String) : String {
		return author.replace(" ", "");
	}

	public static function generate () {
		Sys.println("Generating posts ...");

		// The data
		var tags:Array<Tag> = Json.parse(File.getContent(Path.join([Config.postsPath, "tags.json"])));
		var name2tag = new Map<String, Tag>();
		for (tag in tags) {
			name2tag.set(tag.tag, tag);
		}

		var authors:Array<Author> = Json.parse(File.getContent("people.json"));
		var name2author = new Map<String, Author>();
		for (author in authors) {
			name2author.set(author.username, author);
		}

		var authorsPages = new Map<String, Array<Post>>();
		var tagsPages = new Map<String, Array<Post>>();

		for (post in FileSystem.readDirectory(Config.postsPath)) {
			if (Path.extension(post) != "md") {
				continue;
			}

			var path = Path.join([Config.postsPath, post]);
			var data = parse(name2author, post, File.getContent(path));

			if (data == null || !data.published) {
				continue;
			}

			posts.push(data);

			for (author in data.authors) {
				if (!authorsPages.exists(author.username)) {
					authorsPages.set(author.username, [data]);
				} else {
					authorsPages.get(author.username).push(data);
				}
			}

			for (tag in data.tags) {
				if (!tagsPages.exists(tag.name)) {
					tagsPages.set(tag.name, [data]);
				} else {
					tagsPages.get(tag.name).push(data);
				}
			}
		}

		// Sort posts by date, if identical date sort by name
		var postSorter = function (a, b) : Int {
			var v = Reflect.compare(b.date, a.date);
			if (v == 0) {
				return Reflect.compare(b.name, a.name);
			} else {
				return v;
			}
		};
		posts.sort(postSorter);

		// The posts
		for (post in posts) {
			Utils.save(Path.join([Config.outputFolder, Config.blogOutput, post.name, Config.index]), Views.BlogPost(
				post.background,
				post.title,
				post.description,
				post.authors,
				post.name,
				post.date,
				post.disqusID,
				new Html(post.content),
				post.tags
			), null, null, post.title, post.description);
		}

		// The rss feed
		genRss(posts);

		// The list
		var path = Path.join([Config.outputFolder, Config.blogOutput, Config.index]);
		list(Config.blogTitle, posts, Config.blogDescription, path);

		var posts = posts;
		// Author pages
		for (author in authorsPages.keys()) {
			var path = Path.join([Config.outputFolder, Config.blogOutput, "author", getAuthorID(author), Config.index]);
			posts = authorsPages.get(author);
			posts.sort(postSorter);

			var authorInfo = name2author.get(author);
			if (authorInfo == null) {
				Sys.println('Warning: author "$author" is used in a post but isn\'t in people.json');
				authorInfo = { username: author, name: author, avatar: "" };
			}

			list('Posts by ${authorInfo.name}', posts, authorInfo.bio, path, authorInfo.avatar);
		}

		// Tag pages
		for (tag in tagsPages.keys()) {
			var path = Path.join([Config.outputFolder, Config.blogOutput, "tag", tag, Config.index]);
			posts = tagsPages.get(tag);
			posts.sort(postSorter);

			var tagInfo = name2tag.get(tag);
			if (tagInfo == null) {
				Sys.println('Warning: tag "$tag" is used in a post but isn\'t in tags.json');
				tagInfo = { tag: tag, name: "", description: "" };
			}

			list('Posts tagged ${tagInfo.name}', posts, tagInfo.description, path);
		}
	}

	static function list (title:String, posts:Array<Post>, description:String, path:String, ?avatar:String) {
		var content = Views.BlogList(title, description, posts, avatar);

		Utils.save(path, content, null, null);
	}

	static function genRss (posts:Array<Post>) {
		var rssPosts = [];

		for (i in 0...Std.int(Math.min(posts.length, 20))) {
			var post = posts[i];

			rssPosts.push({
				title: post.title,
				name: post.name,
				description: post.description,
				date: DateTools.format(Date.fromString('${post.date} 00:00:00'), "%a,%e %b %Y %H:%M:%S +0000"),
				authors: post.authors
			});
		}

		var path = Path.join([Config.outputFolder, Config.blogOutput, "rss", Config.index]);
		var dir = Path.directory(path);

		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		File.saveContent(path, Views.BlogRss(rssPosts));
	}

	static function parse (name2author:Map<String, Author>, post:String, content:String) : Post {
		var data:Post = {
			authors: [],
			background: null,
			content: null,
			description: null,
			disqusID: null,
			date: post.substr(0, 10),
			name: Path.withoutExtension(post.substr(11)),
			tags: [],
			title: null,
			published: null
		};

		var delimiter = "---";
		var splitted = content.split(delimiter);
		var header = splitted.shift();
		var blogContent = splitted.join(delimiter);

		for (line in header.split("\n")) {
			var tmp = line.split(":");
			var key = tmp.shift().trim();
			var value = tmp.join(":").trim();

			switch (key) {
				case "author":
					var authorInfo = name2author.get(value);
					if (authorInfo == null) {
						Sys.println('Warning: author "$value" is used in a post but isn\'t in people.json');
					} else {
						data.authors.push({ name: authorInfo.name, username: authorInfo.username, avatar: authorInfo.avatar });
					}

				case "background":
					data.background = value;

				case "description":
					data.description = value;

				case "disqusID":
					data.disqusID = value;

				case "tags":
					for (tag in value.split(",")) {
						data.tags.push({ name: tag.trim() });
					}

				case "title":
					data.title = value;

				case "published":
					data.published = value == "true";

				default:
					//Sys.println('Unknown blog post header key "$key" in "$post"');
			}
		}


		try {
			var xml = Xml.parse(Markdown.markdownToHtml(blogContent));
			changeHtml('${data.date}-${data.name}', xml);
			data.content = xml.toString();
		} catch (e:Dynamic) {

			if (Std.is(e, XmlParserException)) {
				var e = cast(e, XmlParserException);
				Sys.println('${e.message} at line ${e.lineNumber} char ${e.positionAtLine}');
				Sys.println(e.xml.substr(e.position - 20, 40));
			} else {
				Sys.println(e);
			}
			throw('Error when parsing "$post"');
		}

		return data;
	}

	static function changeHtml (postID:String, xml:Xml) {
		var srcAttr = "src";
		var hrefAttr = "href";

		if (xml.nodeType == Xml.Element && xml.nodeName == "img" && xml.exists(srcAttr) && !xml.get(srcAttr).startsWith("http")) {
			xml.set(srcAttr, '/img/blog/$postID/${xml.get(srcAttr)}');
		}

		if (xml.nodeType == Xml.Element && xml.nodeName == "a" && xml.exists(hrefAttr) && xml.get(hrefAttr).startsWith("!/")) {
			xml.set(hrefAttr, '/img/blog/$postID/${xml.get(hrefAttr).substr(2)}');
		}

		if (xml.nodeType == Xml.Element && xml.nodeName == "table") {
			xml.set("class", 'table');
		}

		if (xml.nodeType == Xml.Document || xml.nodeType == Xml.Element) {
			for (element in xml) {
				changeHtml(postID, element);
			}
		}
	}
}
