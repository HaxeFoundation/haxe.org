import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class Utils {

	public static function listDirectoryRecursive (path:String) : Array<String> {
		var list = [];

		for (entry in FileSystem.readDirectory(path)) {
			var entryPath = Path.join([path, entry]);

			if (FileSystem.isDirectory(entryPath)) {
				list = list.concat(listDirectoryRecursive(entryPath));
			}
			else {
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

	public static function save(outPath:String, content:String, current:SiteMap.SitePage, editLink:String, ?title:String) {
		var dir = Path.directory(outPath);
		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		if (Path.extension(outPath) == "md") {
			outPath = Path.withoutExtension(outPath) + ".html";
		}

		File.saveContent(outPath, views.MainLayout.execute({
			viewContent: content,
			title: current != null ? current.title : title,
			siteMap: SiteMap.footer(),
			navBar: SiteMap.navbar(current),
			editLink: current != null && current.editLink != null ? current.editLink : editLink,
			description: Config.description,
			currentYear: Std.string(Date.now().getFullYear())
		}));
	}

	public static function copy (src:String, dest:String) {
		var dir = Path.directory(dest);
		if (!FileSystem.exists(dir)) {
			FileSystem.createDirectory(dir);
		}

		File.copy(src, dest);
	}

}
