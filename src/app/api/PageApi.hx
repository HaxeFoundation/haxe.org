package app.api;

#if server
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end
import app.Config;
import haxe.Json;
import app.model.Manual;
import ufront.web.HttpError;
using haxe.io.Path;
using tink.CoreApi;
using StringTools;
using Detox;

class PageApi extends ufront.api.UFApi
{
	@inject("contentDirectory") public var contentDir:String;

	/**
		Given a page path (which does not contain an extension), find the appropriate page, and prepare it's HTML.

		Return `Success( Pair(html,filename) )` if found, or `Failure(HttpError)` if not
	**/
	public function getPage( path:String ):Outcome<Pair<String, String>,HttpError> {
		var repo = contentDir+Config.app.pages.name;
		var filename:String = '$repo/$path.html';

		return
			readFile( filename )
			.map( function (html) return new Pair(html, filename.substr(repo.length+1)) )
		;
	}

	public function getManualPage( path:String ):Outcome<{ title:String, html:String, nextPage:Null<ManualPage>, prevPage:Null<ManualPage>, editLink:String },HttpError> {
		var repo = contentDir+Config.app.manual.name+'/';
		var mdFiles = repo+Config.app.manual.subdir;
		var infoFile = repo+Config.app.manual.contents;
		
		var manual:Manual = null;
		var page:ManualPage = null;
		var prevPage:Null<ManualPage> = null;
		var nextPage:Null<ManualPage> = null;

		return
			getManualInfo( infoFile )
			.flatMap( function ( manualInfo ) {
				
				manual = manualInfo;
				page = 
					try manualInfo.pageFromUrl( path ).sure() 
					catch (e:HttpError) return Failure(e);
				prevPage = manualInfo.pageBefore( page ).toOutcome().orUse( null );
				nextPage = manualInfo.pageAfter( page ).toOutcome().orUse( null );

				return Success( mdFiles+'/'+page.filename );
			})
			.flatMap( readFile )
			.flatMap( markdownToHtml )
			.map( transformHtml.bind(manual) )
			.map( function(html) return {
				"title": page.title,
				"html": html,
				"nextPage": nextPage,
				"prevPage": prevPage,
				"editLink": Config.app.manual.editLink
			})
		;
	}

	public function cloneRepo( gitPath:String, intoDir:String ):Outcome<String,String> {
		
		var oldCwd = Sys.getCwd();
		try Sys.setCwd( contentDir ) catch(e:String) return Failure(e);
		
		// git clone https://github.com/Simn/HaxeManual.git manual
		var p = new Process( "git", ["clone",gitPath,intoDir] );
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
		Takes a path, and returns `Success( content )`, or `Failure( HttpError )` if it could not be read.
	**/
	function readFile( path:String ):Outcome<String,HttpError> {
		return 
			if ( !FileSystem.exists(path) ) 
				Failure( HttpError.pageNotFound() );
			else
				try Success( File.getContent(path) )
				catch (e:Dynamic) Failure( HttpError.internalServerError('Could not read $path', e) );
	}

	/**
		Will convert markdown to HTML.  Returns a `Success( html )`, or `Failure( err )`
	**/
	function markdownToHtml( md:String ):Outcome<String,HttpError> {
		return
			try Success( Markdown.markdownToHtml( md ) ) 
			catch (e:Dynamic) Failure( HttpError.internalServerError('Unable to parse markdown into HTML',e) );
	}

	/**
		Will take the HTML, change the 
	**/
	function transformHtml( manual:Manual, html:String ):String {
		var page = ('<div id="content">$html</div>').parse();
		page.find("h2").removeFromDOM();
		for ( link in page.find("a") ) {
			var newHref = manual.urlFromFilename( link.attr('href') ).orUse("#");
			if (newHref!="#") newHref = '/manual/$newHref';
			link.setAttr( 'href', newHref );
		}
		return page.html();
	}

	/**
		Fetch the JSON info containing all the manual pages
	**/
	function getManualInfo( infoFile:String ):Outcome<Manual,HttpError> {
		if ( manual==null ) {
			if ( !FileSystem.exists(infoFile) ) return Failure( HttpError.internalServerError('Manual info file $infoFile does not exist') );
			var json = 
				try File.getContent(infoFile)
				catch (e:Dynamic) return Failure( HttpError.internalServerError('Could not read manual info at $infoFile', e) );
			manual = 
				try Json.parse( json )
				catch (e:Dynamic) return Failure( HttpError.internalServerError('Could not parse JSON file $infoFile', e) );
		}
		return Success( manual );
	}

	/**
		Keep the manual cached in a static var for future requests
	**/
	static var manual:Manual;
}