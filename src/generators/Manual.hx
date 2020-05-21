package generators;

import haxe.Json;
import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import sys.FileSystem;
import sys.io.File;
import tink.template.Html;

import SiteMap.SitePage;

using StringTools;

typedef Source = {
	file : String,
	lineMax : Int,
	lineMin : Int
}

typedef Section = {
	label : String,
	id : String,
	sub : Array<Section>,
	depth : Int,
	title : String,
	file : String,
	startLine : Int,
	endLine : Int,
	content : String,
	page : SitePage
}

typedef Page = {
	file : String,
	page : SitePage
}

class Manual {
	static var inPath = Path.join(["manual", "content"]);
	static var labelMap:Map<String, Section> = [];
	static var subLabelMap:Map<String, Section> = [];

	static function getFile(name:String):String {
		return File.getContent(Path.join([inPath, name]));
	}

	static function slug(name:String):String {
		return name.toLowerCase()
			.replace(" ", "-")
			.replace("\"", "")
			.replace(":", "")
			.replace("<", "")
			.replace(">", "")
			.replace("$", "");
	}

	public static function generate () {
		Sys.println("Generating manual ...");

		if (!FileSystem.exists(inPath)) {
			Sys.println("Manual content not found!");
			Sys.println("Please clone the manual with: git clone https://github.com/HaxeFoundation/HaxeManual.git manual");
			return;
		}

		// Parse sections
		var chapterFiles = FileSystem.readDirectory(inPath).filter(~/^[0-9]{2}-([^\.]+)\.md$/.match);
		chapterFiles.sort(Reflect.compare);
		var allSections = [];
		var sections = [for (chapter in 0...chapterFiles.length) {
			processChapter(allSections, chapter + 1, chapterFiles[chapter]);
		}];

		// Process special commands once the tree is complete
		for (section in allSections) {
			processSection(section);
		}

		// Create pages from sections
		var sitemap = [];
		var titleToSection = new Map<String, Array<SitePage>>();
		for (section in sections) {
			generatePages(section, sitemap, titleToSection, inPath);
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
						section.disambiguation = section.title + " (" + disambiguation.join(" - ") + ")";
					}
				}
			}
		}

		var menuRoot = SiteMap.pageForUrl("/manual/introduction.html", true, false);

		// Output pages
		for (section in allSections) {
			var content = processMarkdown(section);

			content = Views.PageWithSidebar(
				SiteMap.prevNextLinks(sitemap, section.page),
				new Html(SiteMap.sideBar(sitemap, section.page)),
				new Html(content),
				Config.manualBaseEditLink + section.page.editLink, {
					repo: '${Config.repoOrganisation}/haxe.org-comments',
					branch: Config.manualRepoBranch,
					title: '[haxe.org/manual] ${section.page.disambiguation != null ? section.page.disambiguation : section.page.title}',
				}
			);

			Utils.save(
				Path.join([Config.outputFolder, section.page.url]),
				content,
				menuRoot,
				Config.manualBaseEditLink + section.page.editLink,
				section.page.disambiguation != null ? section.page.disambiguation : section.page.title
			);
		}

		// Copy svg images and make fallback svg
		for (image in FileSystem.readDirectory(Config.manualImageDir)) {
			var inPath = Path.join([Config.manualImageDir, image]);
			var outPath = Path.join([Config.outputFolder, "manual", image]);

			Sys.command("inkscape", [inPath, '--export-png=$outPath.png']);

			// Path the svg figure to include the link to the font css
			var xml = Xml.parse(File.getContent(inPath));

			for (el in xml.firstElement())
			{
				if (el.nodeType == Element && el.nodeName == "defs")
				{
					el.addChild(Xml.parse('<style type="text/css">@import url(/css/noto_sans.css);</style>'));
				}
			}

			File.saveContent(outPath, xml.toString());
		}
	}

	static function generatePages(
		section:Section,
		sitemap:Array<SitePage>,
		titleToSection:Map<String, Array<SitePage>>,
		inPath:String
	):Void {
		var subs = [];

		for (subsection in section.sub) {
			generatePages(subsection, subs, titleToSection, inPath);
		}

		var sitePage = {
			url: '/manual/${section.label.replace("../", "")}.html',
			title: section.title,
			sub: subs,
			editLink: section.file == null ? null : '${section.file}#L${section.startLine}-L${section.endLine}'
		};
		sitemap.push(sitePage);
		section.page = sitePage;

		var title = section.title.toLowerCase();

		if (!titleToSection.exists(title)) {
			titleToSection[title] = [sitePage];
		} else {
			titleToSection[title].push(sitePage);
		}
	}

	/**
		Processes raw .md files into sections.
	**/
	static function processChapter(allSections:Array<Section>, chapterNum:Int, chapterPath:String):Section {
		var markdown = getFile(chapterPath);

		// Split into sections and subsections
		var labelRE = ~/<!--label:([a-zA-Z0-9_-]+)-->\n(#+) ([^\n]+)\n/;
		var currentSection:Section = null;
		var chapter:Section = null;
		var sectionStack = [];
		var currentLine = 1;
		while (labelRE.match(markdown)) {
			var matchedLeft = labelRE.matchedLeft();
			currentLine += matchedLeft.split("\n").length + 1;
			if (currentSection != null) {
				currentSection.content = matchedLeft;
				currentSection.endLine = currentLine - 3;
			}

			// ## is a chapter (depth 0)
			var depth = labelRE.matched(2).length - 2;
			while (sectionStack.length > depth) sectionStack.pop();
			var parent = null;
			if (depth > 0) {
				parent = sectionStack[sectionStack.length - 1];
			}

			currentSection = {
				label: labelRE.matched(1),
				id: null,
				sub: [],
				depth: depth,
				title: labelRE.matched(3),
				file: chapterPath,
				startLine: currentLine - 2,
				endLine: -1,
				content: null,
				page: null
			};
			labelMap[currentSection.label] = currentSection;
			allSections.push(currentSection);

			if (depth == 0) {
				if (chapter != null) throw "multiple chapters in md file";
				currentSection.id = '$chapterNum';
				chapter = currentSection;
			} else {
				currentSection.id = '${parent.id}.${parent.sub.length + 1}';
				parent.sub.push(currentSection);
			}
			sectionStack.push(currentSection);

			markdown = labelRE.matchedRight();
		}
		if (currentSection != null) {
			currentSection.content = markdown;
			currentSection.endLine = currentSection.startLine + markdown.split("\n").length;
		}

		return chapter;
	}

	/**
		Add header, process special Markdown commands
	**/
	static function processSection(section:Section):Void {
		// Add header
		section.content = '## ${section.id} ${section.title}\n${section.content}';

		// Include generated files
		section.content = ~/<!--include:([^-]+)-->/g.map(section.content, re -> getFile(re.matched(1)));

		// Include Haxe code assets
		section.content = ~/\[code asset\]\(([^#]+)#L([0-9]+)-L([0-9]+)\)\n/g.map(section.content, re ->
			"```haxe\n" +
			getFile("../" + re.matched(1))
				.split("\n")
				.slice(Std.parseInt(re.matched(2)) - 1, Std.parseInt(re.matched(3)))
				.join("\n") +
			"\n```\n"
		);
		section.content = ~/\[code asset\]\(([^\)]+)\)\n/g.map(section.content, re ->
			"```haxe\n" +
			getFile("../" + re.matched(1)) +
			"\n```\n"
		);

		// Identify definition labels
		~/> ##### Define: ([^\n]+)/g.map(section.content, re -> {
			subLabelMap["define-" + slug(re.matched(1))] = section;
			"";
		});

		// Include a ToC of subsections
		section.content = ~/<!--subtoc-->/g.map(section.content, re ->
			section.sub.map(sub -> '${sub.id}: [${sub.title}](${sub.label})').join("\n\n")
		);
	}

	/**
		Read the markdown file, parse as XML, and do some filtering:
		* Change h2 to h1 with styling
		* Add anchor link to h3...h6
		* Style for "Triva" or "Define" blockquote
		* Class for tables
		* Relative url for links (and changing .md to .html) and images
	**/
	static function processMarkdown(section:Section):String {
		// Get html from markdown and post process it
		try {
			var xml = Xml.parse(Markdown.markdownToHtml(section.content));
			processNode(xml);
			return xml.toString();
		} catch (e:Dynamic) {

			if (Std.is(e, XmlParserException)) {
				var e = cast(e, XmlParserException);
				Sys.println('${e.message} at line ${e.lineNumber} char ${e.positionAtLine}');
				Sys.println(e.xml.substr(e.position - 20, 40));
			} else {
				Sys.println(e);
			}

			Sys.println(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
			throw('Error when parsing ${section.label}');
			return "Couldn't parse manual file";
		}
	}

	static function processNode(xml:Xml):Void {
		if (xml.nodeType == Xml.Element) {
			switch (xml.nodeName) {
				case "a":
					if (xml.exists("href")) {
						var href = xml.get("href");
						var splitHref = href.split("#");
						if (labelMap.exists(href)) {
							xml.set("href", labelMap[href].page.url);
						} else if (subLabelMap.exists(href)) {
							xml.set("href", '${subLabelMap[href].page.url}#${href}');
						} else if (splitHref.length == 2 && labelMap.exists(splitHref[0])) {
							xml.set("href", '${labelMap[splitHref[0]].page.url}#${splitHref[1]}');
						} else if (!href.startsWith("http:") && !href.startsWith("https:")) {
							trace('invalid reference to ${href}');
						}
					}

				case "table":
					addClass(xml, "table table-bordered");
					processChildren(xml);

				case "img":
					var src = "/manual/" + Path.withoutDirectory(xml.get("src"));
					insertBefore(Xml.parse('<object data="$src" type="image/svg+xml"><img src="$src.png" /></object>').firstElement(), xml);
					xml.parent.removeChild(xml);

				case "h2":
					var text = xml.firstChild().nodeValue.trim();
					var id = text.substr(0, text.indexOf(" "));
					var title = text.substr(text.indexOf(" ") + 1);
					insertBefore(Xml.parse('<h1><small>$id</small> $title</h1>').firstElement(), xml);
					xml.parent.removeChild(xml);

				case "h3", "h4", "h5", "h6":
					var bookmarkID = slug(getText(xml));
					var link = Xml.parse('<a id="$bookmarkID" class="anch" />').firstElement();
					var content = [ for (child in xml) child.toString() ].join("");
					var h = Xml.parse('<${xml.nodeName}><a href="#$bookmarkID">${content}</a></${xml.nodeName}>').firstElement();
					insertBefore(link, xml);
					insertBefore(h, xml);
					xml.parent.removeChild(xml);

				case "blockquote":
					var firstElm = xml.firstElement();
					if (firstElm.nodeName == "h5") {
						var text = firstElm.firstChild().nodeValue.trim();
						if (text.startsWith("Define")) {
							addClass(xml, "define");
						} else if (text.startsWith("Trivia")) {
							addClass(xml, "trivia");
						}
					}
					processChildren(xml);

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
		} else {
			text += xml.nodeValue;
		}

		return text;
	}

}
