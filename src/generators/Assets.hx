package generators;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class Assets {

	public static function generate () {
		Sys.println('Copying assets from "www" to "${Config.outputFolder}" ...');

		for (entry in FileSystem.readDirectory("www")) {
			copyFromDataFolder(entry, Config.outputFolder);
		}
	}

	static function copyFromDataFolder (path:String, to:String) {
		var inPath = Path.join(["www", path]);
		var outPath = Path.join([to, path]);

		if (FileSystem.isDirectory(inPath)) {
			if (!FileSystem.exists(outPath)) {
				FileSystem.createDirectory(outPath);
			}
			for (entry in FileSystem.readDirectory(inPath)) {
				copyFromDataFolder(Path.join([path, entry]), to);
			}
		} else {
			File.copy(inPath, outPath);
		}
	}

}
