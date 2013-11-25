package app.api;

#if server
	import haxe.Json;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
	import latexparser.LatexParser;
#end

using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class SiteApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Clone a repo from a git address into our `contentDirectory`, with a given name

		If the folder already exists, `git pull` will be attempted.  Otherwise, `git clone` will be attempted.
		
		@param `gitPath` the path of the git repo to clone. 
		@param `intoDir` the name of the folder to name the clone.
		@return Success( outputOfCommand ) or Failure( outputOfCommand )
	**/
	public function cloneRepo( gitPath:String, intoDir:String ):Outcome<String,String> {
		
		ufTrace( 'Clone $gitPath into $intoDir' );

		var oldCwd = Sys.getCwd();
		try Sys.setCwd( contentDir ) catch(e:String) return Failure(e);

		var p:Process;

		if ( FileSystem.exists(intoDir) ) {
			if ( !FileSystem.exists(intoDir.addTrailingSlash()+'.git') ) {
				// File exists, but isn't git.
				return Success( "Not a git repo, no need to update" );
			}

			// Pull update
			try Sys.setCwd( intoDir ) catch(e:String) return Failure(e);
			p = new Process( "git", ["pull"] );
		}
		else {
			// Clone
			p = new Process( "git", ["clone",gitPath,intoDir] );
		}

		var result = switch p.exitCode() {
			case 0: Success( p.stdout.readAll().toString() );
			case exitCode:
				var msg = 'Failed to clone git clone $gitPath $intoDir, exited with $exitCode.';
				var stdErr = p.stderr.readAll().toString();
				Failure([
					'cloneRepo failed:',
					'Command: git clone $gitPath $intoDir',
					'CWD: ${Sys.getCwd()}',
					'ExitCode: $exitCode',
					'Stderr:\n$stdErr'
				].join("\n<br/>  "));
		}

		try Sys.setCwd( oldCwd ) catch(e:String) return Failure(e);

		return result;
	}

	/**
		Out of the download/API versions available on the site, get the version string of the current version
	**/
	public function getCurrentVersion( versionDir:String ) {
		return getVersionInfo( versionDir ).current;
	}

	/**
		Get a list of all the download versions available on the site
	**/
	public function getVersions( versionDir:String ) {
		return getVersionInfo( versionDir ).versions;
	}

	/**
		Get a list of all the download versions with API documentation available
	**/
	public function getApiDocVersions( versionDir:String ) {
		return getVersionInfo( versionDir ).versions.filter( function (v) return v.api );
	}

	static var versionInfo:Map<String,{ current:String, versions:Array<{ version:String, api:Bool, tag:String }> }> = new Map();
	function getVersionInfo( versionDir:String ) {
		if ( versionInfo.exists(versionDir)==false ) {
			var versionsFile = contentDir + versionDir.addTrailingSlash() + 'versions.json';
			var version = 
				try Json.parse( File.getContent(versionsFile) )
				catch ( e:Dynamic ) { 
					ufError('Was an error: $e');
					{ current: "", versions:[] };
				}
			
			versionInfo[versionDir] = version;
		}
		return versionInfo[versionDir];
	}
	
	public static function unlink( path:String ) {
		if(sys.FileSystem.exists(path)) {
			if(sys.FileSystem.isDirectory(path)) {
				for(entry in sys.FileSystem.readDirectory(path))  {
					unlink( path + "/" + entry );
				}
				sys.FileSystem.deleteDirectory(path);
			}
			else {
				sys.FileSystem.deleteFile(path);
			}
		}
	}
}