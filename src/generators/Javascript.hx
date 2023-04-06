package generators;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import Cmd.cmd;

class Javascript {

	public static function generate () {
		// Generating javascript file for syntax highlight, menu and styling
		// See src/Client.hx
		Sys.println("Generating javascript ...");

		var outPath = Path.join([Config.outputFolder, "js"]);
		if (!FileSystem.exists(outPath)) {
			FileSystem.createDirectory(outPath);
		}

		var filename = "client.min.js";
		var outFile = Path.join([outPath, filename]);
		if (FileSystem.exists(outFile)) {
			Sys.println('$outFile exists, skip compilation');
			return;
		}
		cmd("haxe", ["client.hxml"]);
		File.copy(filename, outFile);
		FileSystem.deleteFile(filename);
		FileSystem.deleteFile("client.js");
	}

}
