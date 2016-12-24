package generators;

import haxe.Json;
import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import sys.FileSystem;
import sys.io.File;

import SiteMap.SitePage;

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
						section.title += " (" + disambiguation.join(" - ") + ")"; //TODO: before it was section.disambiguation instead of title, check that it works
					}
				}
			}
		}

		// Generate pages
		for (page in pages) {
			var content = processMarkdown(page.file, File.getContent(page.file));

			content = views.PageWithSidebar.execute({
				sideNav: SiteMap.sideBar(sitemap, page.page),
				prevNextLinks: SiteMap.prevNextLinks(sitemap, page.page),
				editLink: Config.manualBaseEditLink + page.page.editLink,
				content: content
			});

			Utils.save(Path.join([Config.outputFolder, page.page.url]), content, null, null);
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
			url: '/manual/${section.label}.html',
			title: section.title,
			sub: subs,
			editLink: '${section.source.file}#L${section.source.lineMin}-L${section.source.lineMax}'
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
		Read the markdown file, parse as XML, and do some filtering:
		* Change h2 to h1 with styling
		* Add anchor link to h3...h6
		* Style for "Triva" or "Define" blockquote
		* Class for tables
		* Relative url for links (and changing .md to .html) and images
	**/
	static function processMarkdown (filename:String, markdown:String) : String {
		// Remove the footer
		var sb = new StringBuf();
		for (line in markdown.split("\n")) {
			if (line == "---") {
				break;
			}

			sb.add(line);
			sb.add("\n");
		}

		// Get html from markdown and post process it
		try {
			var xml = Xml.parse(Markdown.markdownToHtml(sb.toString()));
			processNode(xml);
			return xml.toString();
		}
		catch (e:Dynamic) {
			Sys.println('Error when parsing "$filename"');

			if (Std.is(e, XmlParserException)) {
				var e = cast(e, XmlParserException);
				Sys.println('${e.message} at line ${e.lineNumber} char ${e.positionAtLine}');
				Sys.println(e.xml.substr(e.position-20, 40));
			}
			else {
				Sys.println(e);
			}

			trace(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));

			return "Couldn't parse manual file";
		}
	}

	static function processNode (xml:Xml) {
		if (xml.nodeType == Xml.Element) {
			switch (xml.nodeName) {
				case "a":
					if (xml.exists("href")) {
						xml.set("href", xml.get("href").replace(".md", ".html"));
					}

				case "table":
					addClass(xml, "table table-bordered");

				case "img":
					var src = xml.get("src");
					src = "/manual/" + Path.withoutDirectory(src);
					xml.set("src", src);

				case "h2":
					var text = xml.firstChild().nodeValue.trim();
					var id = text.substr(0, text.indexOf(" "));
					var title = text.substr(text.indexOf(" ") + 1);
					insertBefore(Xml.parse('<h1><small>$id</small> $title</h1>').firstElement(), xml);
					xml.parent.removeChild(xml);

				case "h3", "h4", "h5", "h6":
					var bookmarkID = getText(xml).toLowerCase().replace(" ", "-");
					var link = Xml.parse('<a id="$bookmarkID" class="anch" />').firstElement();
					var h = Xml.parse('<${xml.nodeName}><a href="#$bookmarkID"></a></${xml.nodeName}>').firstElement();
					for (child in xml) {
						h.firstElement().addChild(child);
					}
					insertBefore(link, xml);
					insertBefore(h, xml);
					xml.parent.removeChild(xml);

				case "blockquote":
					var firstElm = xml.firstElement();
					if (firstElm.nodeName == "h5") {
						var text = firstElm.firstChild().nodeValue.trim();
						if (text.startsWith("Define")) {
							addClass(xml, "define");
						}
						else if (text.startsWith("Trivia")) {
							addClass(xml, "trivia");
						}
					}

				default:
					processChildren(xml);
			}
		}

		if (xml.nodeType == Xml.Document) {
			processChildren(xml);
		}
	}

	static function processChildren (xml:Xml) {
		var children = [for (n in xml) n];

		for (element in children) {
			processNode(element);
		}
	}

	static function addClass (xml:Xml, classesName:String) {
		var classes = "";

		if (xml.exists("class")) {
			classes = xml.get("class");
		}

		xml.set("class", '$classes $classesName');
	}

	static function insertBefore (xml:Xml, before:Xml) {
		var siblings = [for (n in before.parent) n];
		before.parent.insertChild(xml, siblings.indexOf(before));
	}

	static function getText (xml:Xml) : String {
		var text = "";

		if (xml.nodeType == Xml.Element) {
			for (child in xml) {
				text += getText(child);
			}
		}
		else {
			text += xml.nodeValue;
		}

		return text;
	}

}
