package generators;

import haxe.io.Path;
import tink.template.Html;

class Pages {

	public static function generate () {
		Sys.println("Generating pages ...");

		for (i in Utils.listDirectoryRecursive(Config.pagesPath)) {
			var path = i.split("/");
			path.shift();
			var folder = path.length > 1 ? path.shift() : "/";
			var file = path.join("/");

			var inPath = Path.join([Config.pagesPath, folder, file]);
			var sitepage = SiteMap.pageForUrl(folder + "/" + file, false, false);
			var root = SiteMap.pageForUrl(folder, true, false);
			var content = Utils.readContentFile(inPath);
			var editLink = Config.baseEditLink + inPath;

			if (folder != "/") { // Not top level
				if (root != null && sitepage != null) {
					content = Views.PageWithSidebar(
						SiteMap.prevNextLinks(root.sub, sitepage),
						new Html(SiteMap.sideBar(root.sub, sitepage)),
						new Html(content),
						editLink
					);
				} else { // Not in sitemap, so can't make sidebar
					content = Views.PageWithoutSidebar(new Html(content), editLink);
				}
			}

			Utils.save(Path.join([Config.outputFolder, folder, file]), content, sitepage, editLink);
		}
	}
}
