import sys.FileSystem;
import sys.io.File;

class RunDocs {
	static function main() {
		Helpers.makeDir( "dox/api" );
		Sys.setCwd( "dox" );
		Sys.command( "haxelib", [
			"run","dox",
			"-r","/api",
			"-i",".",
			"-o","api/",
			"--title","'haxe.org API'",
			"-in",".",
			"-ex","Tests"
		] );
		Sys.command( "nekotools", ["server", "-rewrite", "-p", "2001"] );
	}
}

class Helpers {
	public static function makeDir( file:String ) {
		var originalCwd = Sys.getCwd();
		var currentName = null;
		for ( part in file.split("/") ) {
			currentName = (currentName==null) ? part : '$currentName/$part';
			if ( !FileSystem.exists(currentName) ) {
				FileSystem.createDirectory(currentName);
			}
		}
		Sys.setCwd( originalCwd );
	}

	public static function copyFile(inFile,outFile) {

	}
}