package app.api;

#if server
	import haxe.Json;
	import neko.Web;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
	import latexparser.LatexParser;
	import latexparser.LatexLexer;
	import latexparser.FlowchartHandler;
#end

import app.model.Manual;
import ufront.web.HttpError;
using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class ManualApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Load a given manual page from the given repo.

		@param `repo` absolute path to page repo.  Should not include trailing slash
		@param `path` no leading slash, should include extension
		@return `Success( Pair(content,navigation) )` if found, or `Failure(HttpError)` if not
	**/
	public function getPage( repo:String, path:String ):Outcome<Pair<ManualPage,String>,HttpError> {

		var filePath = '$repo/$path'.withoutExtension().withExtension("json");
		var navPath = '$repo/navigation.html';
		return
			if ( FileSystem.exists(filePath) ) {
				var json = 
					try File.getContent( filePath ) 
					catch ( e:Dynamic ) return Failure( HttpError.internalServerError('Failed to read manual page $filePath: $e') );
				var content:ManualPage = 
					try Json.parse( json )
					catch ( e:Dynamic ) return Failure( HttpError.internalServerError('Failed to parse manual json $filePath: $e') );
				var nav = 
					try File.getContent( navPath ) 
					catch ( e:Dynamic ) return Failure( HttpError.internalServerError('Failed to read manual nav $navPath: $e') );
				return Success( new Pair(content,nav) );
			}
			else {
				ufError('Could not find manual page $filePath');
				Failure( HttpError.pageNotFound() );
			}
		
	}

	/**
		Convert Latex into HTML files.
		
		@param `inFile` the absolute path to the Latex file
		@param `outDir` the absolute path to the directory we should save our HTML to
		@param `linkBase` the absolute http path to use as the base for links.  Default "" (relative links)
		@return Success(Noise), or Failure(errorMsg)
	**/
	public function convertLatexToHtml( inFile:String, outDir:String, ?linkBase:String="" ):Outcome<Noise,Error> {

		ufTrace( 'Convert Latex manual $inFile into HTML at $outDir' );
		var tmpOutDir = removeTrailingSlash( outDir ) +'-tmp/';

		var oldCwd = Web.getCwd();
		var repo = inFile.directory();
		try Sys.setCwd( repo ) catch(e:String) return Failure( new Error(e) );


		// Do initial parse

		var parser, sections;
		var input = byte.ByteData.ofString( sys.io.File.getContent(inFile) );
		try {
			LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle;
			parser = new LatexParser( input, inFile );
			sections = parser.parse();
		}
		catch(e:hxparse.NoMatch<Dynamic>) {
			return Failure( new Error('Failed to parse $inFile @ ' + e.pos.format(input) + ": Unexpected " +e.token) );
		}
		catch(e:hxparse.Unexpected<Dynamic>) {
			return Failure( new Error('Failed to parse $inFile @ ' + e.pos.format(input) + ": Unexpected " +e.token) );
		}
		catch ( e:Dynamic ) return Failure( new Error('Failed to parse $inFile: $e') );

		// Small helper functions for conversion (mostly to do with links/anchors)

		function escapeFileName( s:String ) {
			return s.replace( "?", "" ).replace( "/", "-" ).replace( " ", "-" );
		}
		function escapeAnchor( s:String ) {
			return s.toLowerCase().replace( " ", "-" );
		}
		function url( sec:Section ) {
			return linkBase + sec.label.toLowerCase() + ".html";
		}
		function link( sec:Section ) {
			return '<a href="${url(sec)}">${sec.title}</a>';
		}
		function process( s:String ):String {
			function labelUrl( label:Label ) {
				return switch label.kind {
					case Section(sec): url( sec );
					case Definition: 'dictionary.html#${escapeAnchor( label.name )}';
					case Item(i): "" + i;
				}
			}
			function labelLink( label:Label ) {
				return switch label.kind {
					case Section(sec): link( sec );
					case Definition: '<a href="${escapeAnchor( "dictionary.html"+label.name )}">${label.name}</a>';
					case Item(i): "" + i;
				}
			}
			function map( r, f ) {
				var i = r.matched(1);
				if ( !parser.labelMap.exists(i) ) {
					trace( 'Warning: No such label $i' );
					return i;
				}
				return f( parser.labelMap[i] );
			}
			var s1 = ~/~~~([^~]+)~~~/g.map( s, map.bind(_, labelLink) );
			return ~/~~([^~]+)~~/g.map( s1, map.bind(_, labelUrl) );
		}

		// Delete existing export

		try SiteApi.unlink( tmpOutDir ) catch ( e:Dynamic ) return Failure( new Error('Failed to delete existing tmp directory $tmpOutDir: $e') );
		try FileSystem.createDirectory( tmpOutDir ) catch ( e:Dynamic ) return Failure( new Error('Failed to create tmp directory $tmpOutDir: $e') );

		// Process each section

		var allSections = [];
		var unreviewed = [];
		var modified = [];
		var noContent = [];
		var nav = [];
		function add( sec:Section ):ManualNavItem {
			if ( sec.label==null ) {
				ufError( 'Missing label while parsing Latex: ${sec.title}' );
				return null;
			}
			sec.content = process( sec.content.trim() );
			if( sec.content.length==0 ) {
				if (sec.state != NoContent) {
					noContent.push('${sec.id} - ${sec.title}');
				}
				if (sec.sub.length == 0) return null;
				sec.content = sec.sub.map( function(sec) return sec.id + ": " +link(sec) ).join( "\n\n" );
			}
			else switch(sec.state) {
				case New: unreviewed.push('${sec.id} - ${sec.title}');
				case Modified: modified.push('${sec.id} - ${sec.title}');
				case Edited | NoContent:
			}
			allSections.push(sec);
			if ( sec.sub.length>0 ) {
				var subNav = [];
				for (sec in sec.sub) {
					var navItem = add(sec);
					if ( navItem!=null ) subNav.push( navItem );
				}
				return ParentItem( link(sec), subNav );
			}
			else return Item( link(sec) );
		}
		for ( sec in sections ) {
			var navItem = add(sec);
			if ( navItem!=null ) nav.push( navItem );
		}
		for ( i in 0...allSections.length ) {

			var sec = allSections[i];
			var content = try Markdown.markdownToHtml( sec.content ) catch ( e:Dynamic ) return Failure( new Error('Failed to convert Markdown from manual [${sec.id}:${sec.title}]: $e') );
			
			var prevSection = (i!=0) ? allSections[i-1] : null;
			var nextSection = (i!=allSections.length-1) ? allSections[i+1] : null;

			var pageData:ManualPage = {
				id: sec.id,
				title: sec.title,
				content: content,
				prev: (prevSection!=null) ? url(prevSection) : null,
				prevTitle: (prevSection!=null) ? prevSection.title : null,
				next: (nextSection!=null) ? url(nextSection) : null,
				nextTitle: (nextSection!=null) ? nextSection.title : null
			};
			var pageJson = Json.stringify( pageData );
			var manualPage = '$tmpOutDir/${url(sec)}'.withoutExtension().withExtension("json");

			try 
				File.saveContent( manualPage, pageJson )
			catch ( e:Dynamic ) 
				return Failure( new Error('Failed to save manual page $manualPage: $e') );
		}

		// Create the dictionary

		var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
		a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
		var dictionaryFile = '$tmpOutDir/dictionary.html';
		try
			File.saveContent( dictionaryFile, a.map(function(v) return '<h5 id="${escapeAnchor(v.k)}">${v.k}</a></h5>\n${process(v.v)}').join("\n\n") )
		catch ( e:Dynamic )
			return Failure( new Error('Failed to save manual dictionary $dictionaryFile: $e') );

		// Create the nav file

		var navFile = '$tmpOutDir/navigation.html';
		var navOutput = new StringBuf();
		function printNav( nav:Array<ManualNavItem>, sb:StringBuf ) {
			sb.add( "<ul>" );
			for ( item in nav ) {
				switch item {
					case Item(link): 
						sb.add( '<li>$link</li>' );
					case ParentItem(link,subNav):
						sb.add( '<li>$link' );
						printNav( subNav, sb );
						sb.add( '</li>' );
				}
			}
			sb.add( "</ul>" );
		}
		printNav( nav, navOutput );
		try
			File.saveContent( navFile, navOutput.toString() )
		catch ( e:Dynamic ) 
			return Failure( new Error('Failed to save navigation menu from manual $navFile: $e') );

		// Create the TODO file

		var todoFile = '$tmpOutDir/todo.html';
		var todo = "This file is generated, do not edit!\n\n"
			+ "# Todo:\n\n" + parser.todos.join("\n - ") + "\n\n"
			+ "## Missing Content:\n\n" + noContent.join("\n - ") + "\n\n"
			+ "## Unreviewed:\n\n" + unreviewed.join("\n - ") + "\n\n"
			+ "## Modified:\n\n" + modified.join("\n - ");
		try {
			var html = Markdown.markdownToHtml( todo );
			File.saveContent( todoFile, html );
		}
		catch ( e:Dynamic ) 
			return Failure( new Error('Failed to save navigation menu from manual $navFile: $e') );

		// Move the tmp directory into place as our new manual dir

		try SiteApi.unlink( outDir ) catch ( e:Dynamic ) return Failure( new Error('Failed to remove existing directory $outDir: $e') );
		try FileSystem.rename( tmpOutDir, outDir ) catch ( e:Dynamic ) return Failure( new Error('Failed to move temporary dir $tmpOutDir to permanent location $outDir: $e') );
		
		try Sys.setCwd( oldCwd ) catch ( e:Dynamic ) return Failure( new Error('Failed to set CWD to $oldCwd') );

		return Success( Noise );
	}

	static function removeTrailingSlash ( path : String ) : String {
		return switch(path.charCodeAt(path.length - 1)) {
			case '/'.code | '\\'.code: path.substr(0, -1);
			case _: path;
		}
	}
}