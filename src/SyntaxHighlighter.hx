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

		var grammarFiles = [
			"haxe" => "grammars/haxe-TmLanguage/haxe.tmLanguage",
			"hxml" => "grammars/haxe-TmLanguage/hxml.tmLanguage",
			"lua" => "grammars/lua.tmbundle/Syntaxes/Lua.plist",
			"xml" => "grammars/xml.tmbundle/Syntaxes/XML.plist",
			"cpp" => "grammars/c.tmbundle/Syntaxes/C++.plist",
			"as3" => "grammars/actionscript3-tmbundle/Syntaxes/ActionScript 3.tmLanguage",
			"python" => "grammars/python.tmbundle/Syntaxes/Python.tmLanguage",
			"js" => "bin/javascript.json",
			"javascript" => "bin/javascript.json",
			"java" => "grammars/Java.plist", // from https://github.com/textmate/java.tmbundle
			"ocaml" => "grammars/OCaml.plist", // from https://github.com/textmate/ocaml.tmbundle
			"sh" => "bin/shell-unix-bash.json",
		];

		Highlighter.loadHighlighters(grammarFiles, function(highlighters) {
			// Go over the generated HTML file and apply syntax highlighting
			var missingGrammars = Highlighter.patchFolder(Config.outputFolder, highlighters, function(classList) {
				return classList.substr(12);}
			);

			for (g in missingGrammars) {
				Sys.println('Missing grammar for "${g}"');
			}

			// Add CSS rules for highlighting
			var path = Config.outputFolder + "/css/style.css";
			var baseStyle = File.getContent(path);
			var syntaxStyle = highlighters["haxe"].runCss();
			File.saveContent(path, baseStyle + syntaxStyle);
		});
	}
}

@:jsRequire("cson-parser")
extern class CSON {
	static function parse (content:String) : Dynamic;
}
