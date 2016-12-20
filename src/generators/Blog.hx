package generators;

import haxe.Json;
import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef Post = {
	author : String,
	authorID : String,
	background : String,
	content : String,
	description : String,
	disqusID : String, // Used in post from old website code, to keep comments
	date : String,
	gravatarID : String,
	name : String,
	tags : Array<{ name:String }>,
	title : String,
	published : Bool
}

typedef Tag = {
	tag : String,
	name : String,
	description : String
}

typedef Author = {
	username : String,
	name : String,
	md5email : String
}

class Blog {

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

		var authors:Array<Author> = Json.parse(File.getContent(Path.join([Config.postsPath, "authors.json"])));
		var name2author = new Map<String, Author>();
		for (author in authors) {
			name2author.set(author.username, author);
		}

		var posts = [];
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

			if (!authorsPages.exists(data.authorID)) {
				authorsPages.set(data.authorID, [data]);
			}
			else {
				authorsPages.get(data.authorID).push(data);
			}

			for (tag in data.tags) {
				if (!tagsPages.exists(tag.name)) {
					tagsPages.set(tag.name, [data]);
				}
				else {
					tagsPages.get(tag.name).push(data);
				}
			}
		}

		// Sort posts by date, if identical date sort by name
		var postSorter = function (a, b) : Int {
			var v = Reflect.compare(b.date, a.date);
			if (v == 0) {
				return Reflect.compare(b.name, a.name);
			}
			else {
				return v;
			}
		};
		posts.sort(postSorter);

		// The posts
		for (post in posts) {
			Utils.save(Path.join([Config.outputFolder, "blog", post.name, "index.html"]), views.BlogPost.execute(post), null, null);
		}

		// The rss feed
		genRss(posts);

		// The list
		var path = Path.join([Config.outputFolder, "blog", "index.html"]);
		list(Config.blogTitle, posts, Config.blogDescription, path);

		// Author pages
		for (author in authorsPages.keys()) {
			var path = Path.join([Config.outputFolder, "blog", "author", getAuthorID(author), "index.html"]);
			var posts = authorsPages.get(author);
			posts.sort(postSorter);

			var authorInfo = name2author.get(author);
			if (authorInfo == null) {
				Sys.println('Warning: author "$author" is used in a post but isn\'t in authors.json');
				authorInfo = { username: author, name: author, md5email: "" };
			}

			list('${Config.blogTitle} - ${authorInfo.name}', posts, authorInfo.name, path);
		}

		// Tag pages
		for (tag in tagsPages.keys()) {
			//TODO: tag description
			var path = Path.join([Config.outputFolder, "blog", "tag", tag, "index.html"]);
			var posts = tagsPages.get(tag);
			posts.sort(postSorter);

			var tagInfo = name2tag.get(tag);
			if (tagInfo == null) {
				Sys.println('Warning: tag "$tag" is used in a post but isn\'t in tags.json');
				tagInfo = { tag: tag, name: "", description: "" };
			}

			list('${Config.blogTitle} - ${tagInfo.name}', posts, tagInfo.description, path);
		}
	}

	static function list (title:String, posts:Array<Post>, description:String, path:String) {
		var content = views.BlogList.execute({
			title: title,
			posts: posts,
			description: description,

			//TODO need a better template engine or something, having the result of foreach in the global scope is not good
			name: null,
			disqusID: null,
			date: null,
			background: null,
			authorID: null,
			author: null
		});

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
				author: post.author
			});
		}

		var path = Path.join([Config.outputFolder, "blog", "rss", "index.html"]);
		var dir = Path.directory(path);

		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		File.saveContent(path, views.BlogRss.execute({
			posts: rssPosts,

			//TODO need a better template engine or something, having the result of foreach in the global scope is not good
			title: null,
			name: null,
			description: null,
			date: null,
			author: null
		}));
	}

	static function parse (name2author:Map<String, Author>, post:String, content:String) : Post {
		var data:Post = {
			author: null,
			authorID: null,
			background: null,
			content: null,
			description: null,
			disqusID: null,
			date: post.substr(0, 10),
			gravatarID: null,
			name: Path.withoutExtension(post.substr(11)),
			tags: [],
			title: null,
			published: null
		};

		var inHeader = true;
		var contentBuffer = new StringBuf();

		for (line in content.split("\n")) {
			if (line == "---") {
				// end of header and start of content
				inHeader = false;
				continue;
			}

			if (inHeader) {
				var tmp = line.split(":");
				var key = tmp.shift().trim();
				var value = tmp.join(":").trim();

				switch (key) {
					case "author":
						var authorInfo = name2author.get(value);
						if (authorInfo == null) {
							Sys.println('Warning: author "$value" is used in a post but isn\'t in authors.json');
						}
						else {
							data.author = authorInfo.name;
							data.authorID = authorInfo.username;
							data.gravatarID = authorInfo.md5email;
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
						Sys.println('Unknown blog post header key "$key" in "$post"');
				}
			}
			else {
				contentBuffer.add(line);
				contentBuffer.add("\n");
			}
		}
		
		try {
			var xml = Xml.parse(Markdown.markdownToHtml(contentBuffer.toString()));
			changeImg('${data.date}-${data.name}', xml);
			data.content = xml.toString();
		} catch (e:Dynamic) {
			Sys.println('Error when parsing "$post"');

			if (Std.is(e, XmlParserException)) {
				var e = cast(e, XmlParserException);
				Sys.println('${e.message} at line ${e.lineNumber} char ${e.positionAtLine}');
				Sys.println(e.xml.substr(e.position-20, 40));
			}
			else {
				Sys.println(e);
			}
		}
		
		return data;
	}

	static function changeImg (postID:String, xml:Xml) {
		if (xml.nodeType == Xml.Element && xml.nodeName == "img" && xml.exists("src") && !xml.get("src").startsWith("http")) {
			xml.set("src", '/img/blog/$postID/${xml.get("src")}');
		}

		if (xml.nodeType == Xml.Document || xml.nodeType == Xml.Element) {
			for (element in xml) {
				changeImg(postID, element);
			}
		} 
	}

}
