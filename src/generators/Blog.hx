package generators;

import haxe.crypto.Md5;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import yaml.Yaml;

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
	title : String
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
			var content = File.getContent(path);

			// separate yaml header and real content
			var sep = content.indexOf("---");
			var header = Yaml.parse(content.substring(0, sep).trim());
			//trace(header);
			content = content.substring(sep + 4).trim();
			var author:String = header.get("author");
			var tags = header.get("tags").split(",").map(StringTools.trim);

			if (header.get("published") != "true") {
				//TODO: doesn't work
				//continue; // Unpublished posts are neither in the list nor rss feed and aren't generated.
			}

			var postData:Post = {
				author: author,
				authorID: getAuthorID(author),
				background: header.get("background"),
				content: Markdown.markdownToHtml(content), //TODO change base folder of images
				description: header.get("description"),
				disqusID: header.get("disqusID"),
				date: post.substr(0, 10),
				gravatarID: Md5.encode(header.get("gravatarEmail")),
				name: Path.withoutExtension(post.substr(11)),
				tags: [for (tag in tags) { name: tag }],
				title: header.get("title")
			};
			posts.push(postData);

			if (!authorsPages.exists(author)) {
				authorsPages.set(author, [postData]);
			}
			else {
				authorsPages.get(author).push(postData);
			}

			for (tag in tags) {
				if (!tagsPages.exists(tag)) {
					tagsPages.set(tag, [postData]);
				}
				else {
					tagsPages.get(tag).push(postData);
				}
			}
		}

		// Sort posts by date
		var postSorter = function (a, b) {
			return Reflect.compare(b.date, a.date);
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

}
