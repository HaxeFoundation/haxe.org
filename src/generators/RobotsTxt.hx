package generators;

import haxe.io.Path;
import sys.io.File;

class RobotsTxt {

	public static function generate () {
		// Special case for the staging website
		// add a robots.txt to disallow crawling
		if (Sys.getEnv("EARTHLY_GIT_BRANCH") == "staging") {
			Sys.println("Generating robots.txt ...");
			File.saveContent(Path.join([Config.outputFolder, "robots.txt"]), "User-agent: *\nDisallow: /\n");
		}
	}

}
