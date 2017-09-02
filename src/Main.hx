import sys.FileSystem;

class Main {

	public static function main () {
		Sys.println("== haxe.org generation ==");
		Sys.println('Output folder: "${Config.outputFolder}"');
		var start = Date.now().getTime();

		// Make sure the output folder exists
		if (!FileSystem.exists(Config.outputFolder)) {
			FileSystem.createDirectory(Config.outputFolder);
		}

		// Generating the content
		SiteMap.init();
		generators.Assets.generate();
		generators.Blog.generate();
		generators.Downloads.generate();
		generators.Javascript.generate();
		generators.Manual.generate();
		generators.Pages.generate();
		generators.Redirections.generate();
		generators.RobotsTxt.generate();

		var end = Date.now().getTime();
		Sys.println('Generation complete, time ${(end - start)/1000}s');
	}

}
