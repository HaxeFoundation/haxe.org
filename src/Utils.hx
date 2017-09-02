import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import tink.template.Html;

using StringTools;

class Utils {

	public static function listDirectoryRecursive (path:String) : Array<String> {
		var list = [];

		for (entry in FileSystem.readDirectory(path)) {
			var entryPath = Path.join([path, entry]);

			if (FileSystem.isDirectory(entryPath)) {
				list = list.concat(listDirectoryRecursive(entryPath));
			} else {
				list.push(entryPath);
			}
		}

		return list;
	}

	public static function readContentFile (path:String) : String {
		var content = File.getContent(path);

		if (Path.extension(path) == "md") {
			content = Markdown.markdownToHtml(content);
		}

		return content;
	}

	public static function save(outPath:String, content:String, current:SiteMap.SitePage, editLink:String, title:String = null, description:String = null) {
		var dir = Path.directory(outPath);
		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		if (Path.extension(outPath) == "md") {
			outPath = Path.withoutExtension(outPath) + ".html";
		}

		File.saveContent(outPath, Views.MainLayout(
			current != null ? current.title : title,
			description != null ? description : Config.description,
			new Html(SiteMap.navbar(current != null ? current : SiteMap.pageForUrl(urlNormalize(outPath), false, true))),
			new Html(content),
			new Html(SiteMap.footer()),
			Std.string(Date.now().getFullYear()),
			current != null && current.editLink != null ? current.editLink : editLink
		));
	}

	public static function copy (src:String, dest:String) {
		var dir = Path.directory(dest);
		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		File.copy(src, dest);
	}

	public static function urlNormalize (url:String, mdToHtml:Bool = true) : String {
		url = url.replace("//", "/");

		if (url.startsWith(Config.outputFolder)) {
			url = url.substr(Config.outputFolder.length);
		}

		if (url.endsWith(Config.index)) {
			url = Path.directory(url);
		}

		if (Path.extension(url) == "" && url.charAt(url.length - 1) != "/") {
			url = url + "/";
		}

		if (mdToHtml && Path.extension(url) == "md") {
			url = Path.withoutExtension(url) + ".html";
		}

		if (url.charAt(0) != "/") {
			url = "/" + url;
		}

		if (new Path(url).file == "" && url.charAt(url.length - 1) != "/") {
			url = url + "/";
		}

		return url;
	}

}
