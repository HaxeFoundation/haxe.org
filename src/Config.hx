import haxe.macro.Compiler;

class Config {

	public static inline var activeClass : String = "active";
	public static inline var baseEditLink : String = "https://github.com/HaxeFoundation/haxe.org/tree/staging/";
	public static inline var blogTitle : String = "The Haxe Blog";
	public static inline var blogDescription : String = "Announcements, Case Studies, and Tech Insights from the Haxe Foundation.";
	public static inline var blogOutput : String = "blog";
	public static inline var downloadOutput : String = "download";
	public static inline var compareBaseUrl : String = "https://github.com/HaxeFoundation/haxe/compare";
	public static inline var description : String = "Haxe is an open source toolkit based on a modern, high level, strictly typed programming language.";
	public static inline var disqusShortName : String = "haxe";
	public static inline var downloadBaseUrl : String = "https://github.com/HaxeFoundation/haxe/releases/download";
	public static inline var index : String = "index.html";
	public static inline var manualBaseEditLink : String = "https://github.com/HaxeFoundation/HaxeManual/tree/master/HaxeManual/";
	public static inline var manualImageDir : String = "manual/HaxeManual/assets/graphics/generated";
	public static inline var pagesPath : String = "pages";
	public static inline var postsPath : String = "posts";
	public static inline var downloadsPath : String = "downloads";
	public static inline var sitemapDividerUrl : String = "#divider";
	public static inline var tagBaseUrl : String = "https://github.com/HaxeFoundation/haxe/releases/tag";
	public static inline var title : String = "Haxe - The Cross-Platform Toolkit";
	public static inline var viewsPath : String = "views";

	public static var outputFolder : String = {
		if (Compiler.getDefine("out") != null) {
			Compiler.getDefine("out");
		} else {
			"out";
		}
	};
}
