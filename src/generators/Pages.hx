package generators;

import haxe.io.Path;

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
					content = views.PageWithSidebar.execute({
						sideNav: SiteMap.sideBar(root.sub, sitepage),
						prevNextLinks: SiteMap.prevNextLinks(root.sub, sitepage),
						editLink: editLink,
						content: content
					});
				} else { // Not in sitemap, so can't make sidebar
					content = views.PageWithoutSidebar.execute({
						editLink: editLink,
						content: content
					});
				}
			}

			Utils.save(Path.join([Config.outputFolder, folder, file]), content, sitepage, editLink);
		}
	}
}
