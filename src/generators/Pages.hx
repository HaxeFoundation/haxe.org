package generators;

import haxe.Json;
import haxe.io.Path;
import sys.io.File;
import tink.template.Html;

class Pages {

	public static function generate () {
		Sys.println("Generating pages ...");

		// Normal pages
		for (i in Utils.listDirectoryRecursive(Config.pagesPath)) {

			var path = i.split("/");

			path.shift();
			var folder = path.length > 1 ? path.shift() : "/";
			var file = path.join("/");
			if (Path.extension(file) == "scripts" || Path.extension(file) == "styles" || file.indexOf(".fragment.") >= 0) {
				Sys.println("\tSkipping script page '"+ file + "'");
				continue;
			}
			var inPath = Path.join([Config.pagesPath, folder, file]);
			var sitepage = SiteMap.pageForUrl(folder + "/" + file, false, false);
			var root = SiteMap.pageForUrl(folder, true, false);
			var content = Utils.readContentFile(inPath);
			var editLink = Config.baseEditLink + inPath;

			var fileName = file.split(".")[0];

			var stylesPath = Path.join([Config.pagesPath, folder, fileName + ".styles"]);
			var additionalStyles = Utils.readContentFile(stylesPath);

			var scriptsPath = Path.join([Config.pagesPath, folder, fileName + ".scripts"]);
			var additionalScripts = Utils.readContentFile(scriptsPath);

			// include fragments, put the file content in place
			// ::fragment "pages/community.fragment.html"::
			var fragment = ~/::fragment ("|')(.+?)\1::/g;
			while (fragment.match(content)) {
				content = fragment.matchedLeft() + Utils.readContentFile(fragment.matched(2)) + fragment.matchedRight();
			}

			genPage(folder, root, sitepage, content, file, editLink, additionalStyles, additionalScripts);
		}

		genWhoIsWho();
	}

	static function genWhoIsWho () {
		// Auto generate the who is who page
		var authors:Array<Blog.Author> = Json.parse(File.getContent("people.json"));
		var name2author = new Map<String, Blog.Author>();
		for (author in authors) {
			name2author.set(author.username, author);
		}

		function add (ms:Array<String>, ds) {
			for (m in ms) {
				var i = name2author.get(m);

				if (i == null) {
					Sys.println('Warning: member "$m" should be added to who is who page but isn\'t in people.json');
				} else if (i.since == null) {
					Sys.println('Warning: member "$m" should be added to who is who page but doesn\'t have a since date, blog guest author?');
				} else {
					ds.push(i);
				}
			}
		}

		var members = ["nicolas", "simn", "waneck", "hugh", "andyli", "nadako", "frabbit", "markknol", "ibilon", "fiene", "alexanderkuzmenko", "jdonaldson"];
		var membersData = [];
		var formers = ["brunogarcia", "jasononeil", "francoponticelli"];
		var formersData = [];

		add(members, membersData);
		add(formers, formersData);

		var content = Views.WhoIsWho(membersData, formersData);
		var root = SiteMap.pageForUrl("foundation", true, false);
		var sitepage = SiteMap.pageForUrl("foundation/people.md", false, false);
		genPage("foundation", root, sitepage, content, "people.md", null, null,null);
	}

	static function genPage (folder, root, sitepage, content, file, editLink,additionalStyles,additionalScripts) {
		if (folder != "/") { // Not top level
			if (root != null && sitepage != null) {
				content = Views.PageWithSidebar(
					SiteMap.prevNextLinks(root.sub, sitepage),
					new Html(SiteMap.sideBar(root.sub, sitepage)),
					new Html(content),
					editLink,
					null
				);
			} else { // Not in sitemap, so can't make sidebar
				content = Views.PageWithoutSidebar(new Html(content), editLink);
			}
		}

		Utils.save(Path.join([Config.outputFolder, folder, file]), content, sitepage, editLink,null,null,additionalStyles,additionalScripts);
	}
}
