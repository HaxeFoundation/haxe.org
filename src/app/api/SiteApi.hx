package app.api;

#if server
	import haxe.Json;
	import neko.Web;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end
import ufront.MVC;
import app.model.Download;
using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class SiteApi extends UFApi {

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
		var contentDir = haxe.io.Path.normalize(contentDir);
		try Sys.setCwd( contentDir ) catch(e:String) throw Error.withData( 'Failed to setCwd into $contentDir before cloning $gitPath', e );

		if ( FileSystem.exists(intoDir) ) {
			ufTrace('Already existed');
			if ( removeFirst ) {
				ufTrace('Remove');
				try unlink(intoDir) catch(e:Dynamic) throw Error.withData( 'Failed to delete existing directory $intoDir', e );
			}
			else {
				ufTrace('We will try update it');
				if ( !FileSystem.exists(intoDir.addTrailingSlash()+'.git') ) {
					// File exists, but isn't git.
					return "Not a git repo, no need to update";
				}

				// Pull update
				ufTrace( 'Currently in $contentDir, changing to $intoDir before running `git checkout $branch`' );
				try Sys.setCwd( intoDir ) catch(e:String) throw Error.withData( 'Failed to setCwd into $intoDir before doing git pull', e );
				try process( "git", ["checkout",branch] ) catch(e:String) throw Error.withData( 'Failed to checkout branch $branch', e );
				try process( "git", ["pull"] ) catch(e:String) throw Error.withData( 'Failed to run `git pull` in $intoDir', e );
			}
		}

		if ( FileSystem.exists(intoDir)==false ) {
			ufTrace("Did not exist, let's clone it");
			// Clone
			try process( "git", ["clone",gitPath,intoDir] ) catch(e:String) throw Error.withData( 'Failed to run `git clone $gitPath $intoDir`', e );
			try Sys.setCwd( intoDir ) catch(e:String) throw Error.withData( 'Failed to setCwd into $intoDir after doing git pull', e );
			try process( "git", ["checkout",branch] ) catch(e:String) throw Error.withData( 'Failed to checkout branch $branch', e );
		}

		try Sys.setCwd( oldCwd ) catch(e:String) throw Error.withData( 'Failed to setCwd back to $oldCwd after cloning $gitPath', e );

		return "Repository cloned successfully";
	}

	function process( cmd:String, args:Array<String> ):String {
		var p = new Process( cmd, args );
		var exitCode = p.exitCode();
		if (exitCode!=0) {
			var stdErr = p.stderr.readAll().toString();
			var failureMessage = [
				'cloneRepo failed:',
				'Command: $cmd ' + args.join(' '),
				'CWD: ${Sys.getCwd()}',
				'ExitCode: $exitCode',
				'Stderr:\n$stdErr'
			].join("\n<br/>  ");
			throw failureMessage;
		}
		return p.stdout.readAll().toString();
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
	public function getVersions( versionDir:String ):Array<Download> {
		return getVersionInfo( versionDir ).versions;
	}

	/**
		Get a list of all the download versions with API documentation available
	**/
	public function getApiDocVersions( versionDir:String ):Array<Download> {
		return getVersionInfo( versionDir ).versions.filter( function (v) return v.api );
	}

	function getVersionInfo( versionDir:String ):CurrentVersionAndList {
		return CompileTime.parseJsonFile( 'www/website-content/downloads/versions.json' );
	}

	public static function unlink( path:String ):Void {
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
