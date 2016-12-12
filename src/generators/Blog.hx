package generators;

import haxe.crypto.Md5;
import haxe.io.Path;
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

class Blog {

	static function getAuthorID (author:String) : String {
		return author.replace(" ", "");
	}

	public static function generate () {
		Sys.println("Generating posts ...");

		// The data
		var posts = [];
		var authorsPages = new Map<String, Array<Post>>();
		var tagsPages = new Map<String, Array<Post>>();

		for (post in FileSystem.readDirectory(Config.postsPath)) {
			var path = Path.join([Config.postsPath, post]);
			var data = parse(post, File.getContent(path));

			if (data == null || !data.published) {
				continue;
			}

			posts.push(data);

			if (!authorsPages.exists(data.author)) {
				authorsPages.set(data.author, [data]);
			}
			else {
				authorsPages.get(data.author).push(data);
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
			list('${Config.blogTitle} - $author', posts, author, path);
		}

		// Tag pages
		for (tag in tagsPages.keys()) {
			//TODO: tag description
			var path = Path.join([Config.outputFolder, "blog", "tag", tag, "index.html"]);
			var posts = tagsPages.get(tag);
			posts.sort(postSorter);
			list('${Config.blogTitle} - $tag', posts, "", path);
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

	static function parse (post:String, content:String) : Post {
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
						data.author = value;
						data.authorID = value.replace(" ", "");

					case "background":
						data.background = value;

					case "description":
						data.description = value;

					case "disqusID":
						data.disqusID = value;

					case "gravatarEmail":
						data.gravatarID = Md5.encode(value);

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
		
		var xml = Xml.parse(Markdown.markdownToHtml(contentBuffer.toString()));
		changeImg('${data.date}-${data.name}', xml);
		data.content = xml.toString();
		
		return data;
	}

	static function changeImg (postID:String, xml:Xml) {
		if (xml.nodeType == Xml.Element && xml.nodeName == "img" && xml.exists("src")) {
			xml.set("src", '/img/blog/$postID/${xml.get("src")}');
		}

		if (xml.nodeType == Xml.Document || xml.nodeType == Xml.Element) {
			for (element in xml) {
				changeImg(postID, element);
			}
		} 
	}

}
