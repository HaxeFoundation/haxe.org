import highlighter.Highlighter;
import sys.io.File;

class SyntaxHighlighter
{
	public static var haxe = new Highlighter("haxe-TmLanguage/haxe.tmLanguage", "light");
	public static var hxml = new Highlighter("haxe-TmLanguage/hxml.tmLanguage", "light");

	public static function patchStyle ()
	{
		var path = Config.outputFolder + "/css/style.css";
		var baseStyle = File.getContent(path);
		var syntaxStyle = haxe.run(Style);
		File.saveContent(path, baseStyle + syntaxStyle);
	}
}
