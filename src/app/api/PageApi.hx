package app.api;

#if server
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end
import app.Config;
import haxe.Json;
import ufront.web.HttpError;
using haxe.io.Path;
using tink.CoreApi;
using StringTools;
using Detox;

class PageApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Load a given page from the given repo.

		@param `repo` absolute path to page repo.  Should not include trailing slash
		@param `path` no leading slash, should include extension

		Return `Success( html )` if found, or `Failure(HttpError)` if not
	**/
	public function getPage( repo:String, path:String ):Outcome<String,HttpError> {

		var filename:String = '$repo/$path';
		
		return 
			if ( !FileSystem.exists(filename) ) {
				ufError('Could not find page $filename');
				Failure( HttpError.pageNotFound() );
			}
			else
				try Success( File.getContent(filename) )
				catch (e:Dynamic) Failure( HttpError.internalServerError('Could not read $filename', e) );
	}

	/**
		Clone a repo from a git address into our `contentDirectory`, with a given name

		If the folder already exists, `git pull` will be attempted.  Otherwise, `git clone` will be attempted.
		
		@param `gitPath` the path of the git repo to clone. 
		@param `intoDir` the name of the folder to name the clone.
		@return Success( outputOfCommand ) or Failure( outputOfCommand )
	**/
	public function cloneRepo( gitPath:String, intoDir:String ):Outcome<String,String> {
		
		var oldCwd = Sys.getCwd();
		try Sys.setCwd( contentDir ) catch(e:String) return Failure(e);

		var p:Process;

		if ( FileSystem.exists(intoDir) ) {
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
}