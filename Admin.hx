import sys.FileSystem;
import sys.io.File;
using haxe.io.Path;

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

class RunSync {
	static function main() {
		Helpers.makeDir( "out/js" );
		Helpers.makeDir( "out/css" );
		Helpers.copyDir( "assets", "out" );
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

	public static function isFileSame(file1,file2) {
		if ( FileSystem.exists(file1) && FileSystem.exists(file2) ) {
			var stat1 = FileSystem.stat( file1 );
			var stat2 = FileSystem.stat( file2 );
			return stat1.size==stat2.size && stat1.mtime.getTime()==stat2.mtime.getTime();
		}
		return false;
	}

	public static function copyDir(inDir,outDir) {
		var inDir = Path.removeTrailingSlash(inDir);
		var outDir = Path.removeTrailingSlash(outDir);
		makeDir( outDir );

		var files = FileSystem.readDirectory(inDir);
		var filesCopied = 0;
		for ( file in files ) {
			var fullInPath = '$inDir/$file';
			var fullOutPath = '$outDir/$file';
			
			if ( FileSystem.isDirectory(fullInPath) ) {
				copyDir( fullInPath, fullOutPath );
				filesCopied++;
			}
			else if ( !isFileSame(fullInPath,fullOutPath) ) {
				File.copy( fullInPath, fullOutPath );
				filesCopied++;
			}
		}
		Sys.println( 'Copied $filesCopied/${files.length} files from $inDir to $outDir' );
	}
}