import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import highlighter.Highlighter;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class SyntaxHighlighter
{
	static var haxeGrammar = new Highlighter("grammars/haxe-TmLanguage/haxe.tmLanguage");
	static var hxmlGrammar = new Highlighter("grammars/haxe-TmLanguage/hxml.tmLanguage");
	static var grammars : Map<String, Highlighter>;

	public static function patch () {
		Sys.println("Applying syntax highlighting ...");

		grammars = ["haxe" => haxeGrammar, "hxml" => hxmlGrammar];

		// Go over the generated HTML file and apply syntax highlighting
		patchFolder(Config.outputFolder);

		// Add CSS rules for highlighting
		var path = Config.outputFolder + "/css/style.css";
		var baseStyle = File.getContent(path);
		var syntaxStyle = haxeGrammar.runCss();
		File.saveContent(path, baseStyle + syntaxStyle);
	}

	static function patchFolder (path:String) {
		for (entry in FileSystem.readDirectory(path)) {
			var entry_path = Path.join([path, entry]);

			if (FileSystem.isDirectory(entry_path)) {
				patchFolder(entry_path);
			} else if (Path.extension(entry_path) == "html") {
				patchFile(entry_path);
			}
		}
	}

	static function patchFile (path:String) {
		try
		{
			var xml = Xml.parse(File.getContent(path));
			processNode(xml);
			File.saveContent(path, xml.toString());
		} catch (e:Dynamic) {
			if (Std.is(e, XmlParserException)) {
				var e = cast(e, XmlParserException);
				Sys.println('${e.message} at line ${e.lineNumber} char ${e.positionAtLine}');
				Sys.println(e.xml.substr(e.position - 20, 40));
			} else {
				Sys.println(e);
			}

			Sys.println(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
			throw('Error when parsing "$path"');
		}
	}

	static function processNode (xml:Xml) {
		if (xml.nodeType == Xml.Element) {
			switch (xml.nodeName) {
				case "pre":
					var code = xml.firstChild();

					if (code.nodeType != Xml.Element)
					{
						return;
					}

					var lang = code.exists("class") ? code.get("class").substr(12) : ""; // in the form class="prettyprint lang"

					if (grammars.exists(lang))
					{
						var original = code.firstChild().toString().htmlUnescape();
						var highlighted = grammars.get(lang).runContent(original);
						var new_xml = Xml.parse(highlighted);
						var siblings = [for (n in xml.parent) n];
						xml.parent.insertChild(new_xml, siblings.indexOf(xml));
						xml.parent.removeChild(xml);
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
}
