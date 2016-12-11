package generators;

import haxe.Json;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

import SiteMap.SitePage;

using Detox;
using StringTools;

typedef Flags = {
	@:optionnal var folded : Bool;
}

typedef Source = {
	file : String,
	lineMax : Int,
	lineMin : Int
}

typedef Section = {
	label : String,
	id : String,
	sub : Array<Section>,
	flags : Flags,
	state : Int,
	title : String,
	source : Source,
	index : Int
}

typedef Page = {
	file : String,
	page : SitePage
}

class Manual {

	public static function generate () {
		Sys.println("Generating manual ...");

		// Data
		var inPath = Path.join(["manual", "output", "HaxeManual", "website"]);
		var sections = processSections(Json.parse(File.getContent(Path.join([inPath, "sections.txt"]))), inPath);

		var sitemap = [];
		var pages = [];
		var titleToSection = new Map<String, Array<SitePage>>();
		for (section in sections) {
			addSection(section, sitemap, pages, titleToSection, inPath);
		}
		SiteMap.annotateGroup(sitemap);

		// Disambiguate pages with the same title
		for (sectionGroup in titleToSection) {
			if (sectionGroup.length > 1) {
				for (section in sectionGroup) {
					var disambiguation = [];

					var current = section;
					while ((current = current.parent) != null) {
						disambiguation.push(current.title);
					}
					disambiguation.reverse();

					if (disambiguation.length > 0) {
						section.title = " (" + disambiguation.join(" - ") + ")"; //TODO: before it was section.disambiguation instead of title, check that it works
					}
				}
			}
		}

		// Generate pages
		for (page in pages) {
			var content = processMarkdown(Utils.readContentFile(page.file));

			content = views.PageWithSidebar.execute({
				sideNav: SiteMap.sideBar(sitemap, page.page),
				prevNextLinks: SiteMap.prevNextLinks(sitemap, page.page),
				editLink: Config.manualBaseEditLink + page.page.editLink,
				content: content
			});

			Utils.save(Path.join([Config.outputFolder, page.page.url]), content, page.page, null);
		}

		// Copy images
		for (image in FileSystem.readDirectory(Config.manualImageDir)) {
			var inPath = Path.join([Config.manualImageDir, image]);
			var outPath = Path.join([Config.outputFolder, "manual", image]);

			File.copy(inPath, outPath);
		}
	}

	static function addSection (section:Section, sitemap:Array<SitePage>, pages:Array<Page>, titleToSection:Map<String, Array<SitePage>>, inPath:String) {
		var subs = [];

		for (subsection in section.sub) {
			addSection(subsection, subs, pages, titleToSection, inPath);
		}

		var sitePage = {
			url: 'manual/${section.label}.html',
			title: section.title,
			sub: subs,
			editLink: '${section.source.file}#L${section.source.lineMin}-${section.source.lineMax}'
		};
		sitemap.push(sitePage);

		pages.push({ file: Path.join([inPath, '${section.label}.md']), page: sitePage });

		var title = section.title.toLowerCase();

		if (!titleToSection.exists(title)) {
			titleToSection[title] = [sitePage];
		}
		else {
			titleToSection[title].push(sitePage);
		}
	}

	/**
		Return an array of sections, but only including those that exist, so that in our menu we only display those that exist.
	**/
	static function processSections (sections:Array<Section>, inPath:String) : Array<Section> {
		var validSections = [];

		for (section in sections) {
			if (FileSystem.exists(Path.join([inPath, '${section.label}.md']))) {
				validSections.push(section);
			}

			if (section.sub != null) {
				section.sub = processSections(section.sub, inPath);
			}
		}

		return validSections;
	}

	/**
		Read the markdown file, parse as XML, and do some filtering.
		The markdown lacks some markup we need, for example, classes on the "previous" and "next" links so we can style them appropriately.
		We also need to redirect links (if relative, change extension from `.md` to `.html`), and we need to process images.
	**/
	static function processMarkdown (markdown:String) : String {
		var html = Markdown.markdownToHtml(markdown);
		var xml = "div".create().setInnerHTML(html);

		var titleNode:DOMNode = null;
		var endOfContentNode:DOMNode = null;

		if (xml.children().length > 0) {
			for (node in xml.children()) {
				if (endOfContentNode == null) {
					switch (node.tagName()) {
						case "hr":
							// A "---" in the markdown signifies the end of the page content, and the beginning of the navigation links.
							endOfContentNode = node;

						case "h2":
							var text = node.text().trim();
							var id = text.substr(0, text.indexOf(" "));
							var title = text.substr(text.indexOf(" ") + 1);
							var h1 = "h1".create().setInnerHTML('<small>$id</small> $title');
							titleNode = h1;
							node.replaceWith(h1);

						case "h3", "h4", "h5", "h6":
							var bookmarkID = node.text().trim().toLowerCase().replace(" ", "-");
							var link = "a".create().setAttr("href", '#$bookmarkID');
							var anchor = "a".create().setAttr("id", bookmarkID).addClass("anch");
							link.append(node.children(false)).appendTo(node);
							node.beforeThisInsert(anchor);
							processNodes(link);

						case "blockquote":
							var firstElm = node.firstChildren();
							if (firstElm.tagName() == "h5") {
								if (firstElm.text().startsWith("Define")) {
									node.addClass("define");
								}
								else if (firstElm.text().startsWith("Trivia")) {
									node.addClass("trivia");
								}
							}
							processNodes( node );

						default:
							processNodes( node );
					}
				}
				else {
					node.removeFromDOM();
				}
			}

			html = xml.innerHTML();
		}

		return html;
	}

	/**
		Look through manual content for nodes that need markup transformation.

		So far:

		- Links, will need the `href="something.md"` transformed into `href="something.html"`
		- Tables will have "table table-bordered" classes added for styling.
		- Images, will need paths altered.
	**/
	static function processNodes (top:DOMNode) {
		var thisAndDescendants = top.descendants(true).add(top);

		for (node in thisAndDescendants) {
			if (node.isElement()) {
				switch (node.tagName()) {
					case "a":
						node.setAttr("href", node.attr("href").replace(".md", ".html"));

					case "table":
						node.addClass("table table-bordered");

					case "img":
						var src = node.attr("src");
						src = "/manual/" + Path.withoutDirectory(src);
						node.setAttr("src", src);

					default:
				}
			}
		}
	}

}
