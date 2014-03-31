package app.api;

#if server
	import haxe.Json;
	import neko.Web;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end

using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class SiteApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;
	@inject("scriptDirectory") public var scriptDir:String;

	/**
		Clone a repo from a git address into our `contentDirectory`, with a given name

		If the folder already exists, `git pull` will be attempted.  Otherwise, `git clone` will be attempted.
		
		@param `gitPath` the path of the git repo to clone. 
		@param `intoDir` the name of the folder to name the clone.
		@return String outputOfCommand
		@throws Error with error message / data
	**/
	public function cloneRepo( gitPath:String, intoDir:String, branch:String, ?removeFirst:Bool=false ):String {
		
		ufTrace( 'Clone $gitPath into $intoDir' );

		var oldCwd = Web.getCwd();
		try Sys.setCwd( contentDir ) catch(e:String) throw 'Failed to setCwd into $contentDir before cloning $gitPath'.withData(e);

		var p:Process;

		if ( FileSystem.exists(intoDir) ) {
			if ( removeFirst ) {
				try unlink(intoDir) catch(e:Dynamic) throw 'Failed to delete existing directory $intoDir'.withData(e);
			}
			else {
				if ( !FileSystem.exists(intoDir.addTrailingSlash()+'.git') ) {
					// File exists, but isn't git.
					return "Not a git repo, no need to update";
				}

				// Pull update
				try Sys.setCwd( intoDir ) catch(e:String) throw 'Failed to setCwd into $intoDir before doing git pull'.withData(e);
				try process( "git", ["checkout",branch] ) catch(e:String) throw 'Failed to checkout branch $branch'.withData(e);
				try process( "git", ["pull"] ) catch(e:String) throw 'Failed to run `git pull` in $intoDir'.withData(e);
			}
		}

		if ( FileSystem.exists(intoDir)==false ) {
			// Clone
			try process( "git", ["clone",gitPath,intoDir] ) catch(e:String) throw 'Failed to run `git clone $gitPath $intoDir`'.withData(e);
			try Sys.setCwd( intoDir ) catch(e:String) throw 'Failed to setCwd into $intoDir after doing git pull'.withData(e);
			try process( "git", ["checkout",branch] ) catch(e:String) throw 'Failed to checkout branch $branch'.withData(e);
		}

		try Sys.setCwd( oldCwd ) catch(e:String) throw 'Failed to setCwd back to $oldCwd after cloning $gitPath'.withData(e);

		return "Repository cloned successfully";
	}

	function process( cmd:String, args:Array<String> ) {
		var p = new Process( cmd, args );
		var exitCode = p.exitCode();
		if (exitCode!=0) {
			var stdErr = p.stderr.readAll().toString();
			var failureMessage = [
				'cloneRepo failed:',
				'Command: $cmd ' + args.join(' '),
				'CWD: ${Web.getCwd()}',
				'ExitCode: $exitCode',
				'Stderr:\n$stdErr'
			].join("\n<br/>  ");
			throw failureMessage;
		}
	}

	/**
		Out of the download/API versions available on the site, get the version string of the current version
	**/
	public function getCurrentVersion( versionDir:String ):String {
		return getVersionInfo( versionDir ).current;
	}

	/**
		Get a list of all the download versions available on the site
	**/
	public function getVersions( versionDir:String ):Array<{ version:String, api:Bool, tag:String }> {
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
			var versionsFile = scriptDir + versionDir.addTrailingSlash() + 'versions.json';
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