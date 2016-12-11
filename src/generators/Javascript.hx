package generators;

import haxe.io.Path;
import sys.FileSystem;

class Javascript {

	public static function generate () {
		// Generating javascript file for syntax highlight, menu and styling
		// See src/Client.hx
		Sys.println("Generating javascript ...");

		var outPath = Path.join([Config.outputFolder, "js"]);
		if (!FileSystem.exists(outPath)) {
			FileSystem.createDirectory(outPath);
		}

		Sys.command("haxe", ["client.hxml"]);
		var filename = "client.min.js";
		FileSystem.rename(filename, Path.join([outPath, filename]));
		FileSystem.deleteFile("client.js");
	}

}
