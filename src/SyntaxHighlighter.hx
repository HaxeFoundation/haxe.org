import haxe.Json;
import highlighter.Highlighter;
import sys.io.File;

class SyntaxHighlighter
{
	public static function patch () {
		Sys.println("Applying syntax highlighting ...");

		// Convert CSON grammar to json for vscode-textmate
		File.saveContent("bin/javascript.json", Json.stringify(CSON.parse(File.getContent("grammars/language-javascript/grammars/javascript.cson"))));
		File.saveContent("bin/shell-unix-bash.json", Json.stringify(CSON.parse(File.getContent("grammars/language-shellscript/grammars/shell-unix-bash.cson"))));

		var haxeGrammar = new Highlighter("grammars/haxe-TmLanguage/haxe.tmLanguage");
		var hxmlGrammar = new Highlighter("grammars/haxe-TmLanguage/hxml.tmLanguage");
		var luaGrammar = new Highlighter("grammars/lua.tmbundle/Syntaxes/Lua.plist");
		var xmlGrammar = new Highlighter("grammars/xml.tmbundle/Syntaxes/XML.plist");
		var cppGrammar = new Highlighter("grammars/c.tmbundle/Syntaxes/C++.plist");
		var as3Grammar = new Highlighter("grammars/actionscript3-tmbundle/Syntaxes/ActionScript 3.tmLanguage");
		var jsGrammar = new Highlighter("bin/javascript.json");
		var shGrammar = new Highlighter("bin/shell-unix-bash.json");

		var grammars = [
			"haxe" => haxeGrammar,
			"hxml" => hxmlGrammar,
			"lua" => luaGrammar,
			"xml" => xmlGrammar,
			"cpp" => cppGrammar,
			"as3" => as3Grammar,
			"js" => jsGrammar,
			"javascript" => jsGrammar,
			"sh" => shGrammar,
		];

		// Go over the generated HTML file and apply syntax highlighting
		var missingGrammars = Highlighter.patchFolder(Config.outputFolder, grammars, function (classList) {
			return classList.substr(12);
		});

		for (g in missingGrammars) {
			Sys.println('Missing grammar for "${g}"');
		}

		// Add CSS rules for highlighting
		var path = Config.outputFolder + "/css/style.css";
		var baseStyle = File.getContent(path);
		var syntaxStyle = haxeGrammar.runCss();
		File.saveContent(path, baseStyle + syntaxStyle);
	}
}

@:jsRequire("cson-parser")
extern class CSON {
	static function parse (content:String) : Dynamic;
}
