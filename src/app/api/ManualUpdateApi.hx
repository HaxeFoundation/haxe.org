package app.api;

#if server
	import dtx.DOMCollection;
	import haxe.Json;
	import sys.FileSystem;
	import sys.io.File;
#end

import app.model.SiteMap;
import app.model.Manual;
import ufront.web.HttpError;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;
using Strings;
using Detox;

class ManualUpdateApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	var mdDir:String;
	var htmlDir:String;

	/**
		Convert Markdown to HTML

		@param `mdDir` the absolute path to the Markdown directory
		@param `htmlDir` the absolute path to the HTML output directory
		@throw error message (String)
	**/
	public function convertMarkdownToHtml( mdDir:String, htmlDir:String ) {

		this.mdDir = mdDir;
		this.htmlDir = htmlDir;

		if ( !FileSystem.exists(mdDir) ) 
			throw 'Markdown directory $mdDir did not exist during manual import';
		if ( !FileSystem.exists(htmlDir) ) 
			try FileSystem.createDirectory( htmlDir ) catch ( e:Dynamic ) throw 'Failed to create directory $htmlDir during manual import';

		var sectionsJson = File.getContent( '$mdDir/sections.txt' );
		var sections:Array<ManualSectionJson> = Json.parse( sectionsJson );
		sections = processSections( sections );

		try {
			var sitemap = generateSiteMap( sections );
			File.saveContent( '$htmlDir/sitemap.json', Json.stringify(sitemap) ); 
		}
		catch ( e:Dynamic ) throw 'Failed to create save $htmlDir/sitemap.json';

		// Process the dictionary manually because it's not in "sections.txt"
		var dictionarySection = {
			label: "dictionary",
			id: "0",
			sub: [],
			state: 0,
			title: "Dictionary",
			index: 0
		}
		processSection( dictionarySection );
	}

	/**
		Read the sections JSON and generate a Sitemap JSON we can use.
	**/
	function generateSiteMap( sections:Array<ManualSectionJson> ):SiteMap {
		var siteMap:SiteMap = [];
		for ( section in sections ) {
			var page:SitePage = {
				title: section.title,
				url: section.label+".html"
			}
			if ( section.sub!=null && section.sub.length>0 ) {
				page.sub = generateSiteMap( section.sub );
			}
			siteMap.push( page );
		}
		return siteMap;
	}

	/**
		Go through an array of sections and process them into HTML
		Sometimes a section exists in the JSON but not in the markdown.  
		Return an array of sections, but only including those that exist, so that in our menu we only display those that exist.
	**/
	function processSections( sections:Array<ManualSectionJson> ) {
		var validSections = [];
		for ( section in sections ) {
			var existed = processSection( section );
			if ( existed )
				validSections.push( section );
			
			if ( section.sub!=null ) 
				section.sub = processSections( section.sub );
		}
		return validSections;
	}

	/**
		Read the markdown file, parse as XML, and do some filtering.
		The markdown lacks some markup we need, for example, classes on the "previous" and "next" links so we can style them appropriately.
		We also need to redirect links (if relative, change extension from `.md` to `.html`), and we need to process images.
	**/
	function processSection( section:ManualSectionJson ) {
		var filename = '$mdDir/${section.label}.md';
		var outFilename = '$htmlDir/${section.label}.html';

		if ( FileSystem.exists(filename) ) {
			var markdown = File.getContent( filename );
			if ( section.id=="9.3.1" ) ufTrace( markdown );
			var html = Markdown.markdownToHtml( markdown );
			if ( section.id=="9.3.1" ) ufTrace( html );

			var xml = 'div'.create().setInnerHTML( html );
			if ( section.id=="9.3.1" ) ufTrace( "HERE WE ARE "+xml.toString() );

			var titleNode:DOMNode = null;
			var endOfContentNode:DOMNode = null;
			var prevLink:DOMNode = null;
			var nextLink:DOMNode = null;

			for ( node in xml.children() ) {
				if ( endOfContentNode==null ) {
					switch node.tagName() {
						case "hr":
							// A "---" in the markdown signifies the end of the page content, and the beginning of the navigation links.
							endOfContentNode = node;
						case "h2": 
							var h1 = "h1".create().setInnerHTML( '<small>${section.id}</small> ${section.title}' );
							titleNode = h1;
							node.replaceWith( h1 );
						case "blockquote":
							var firstElm = node.firstElement();
							if ( firstElm.tagName()=="h5" ) {
								if ( firstElm.text().startsWith("Define") ) node.addClass("define");
								else if ( firstElm.text().startsWith("Trivia") ) node.addClass("trivia");
							}
						default: 
							if ( section.id=="9.3.1" ) ufTrace('Before process: '+node.toString());
							processNodes( node );
							if ( section.id=="9.3.1" ) ufTrace('After process toString: '+node.toString());
							if ( section.id=="9.3.1" ) ufTrace('After process     html: '+node.html());
					}
				}
				else {
					if ( node.tagName()=="p" ) {
						var pText = node.text();
						if ( pText.startsWith("Previous section:") ) {
							prevLink = node.firstElement();
						}
						else if ( pText.startsWith("Next section:") ) {
							nextLink = node.firstElement();
						}
					}
					node.removeFromDOM();
				}
			}
			addPrevNextEditLinks( prevLink, nextLink, titleNode, endOfContentNode );

			try File.saveContent( outFilename, xml.html() ) catch ( e:Dynamic ) throw 'Failed to write to file $outFilename';

			return true;
		}
		else {
			ufError('Section ${section.id} ${section.state} was not found [$filename]');
			return false;
		}
	}

	/**
		Look through manual content for nodes that need markup transformation.

		So far:

		- Links, will need the `href="something.md"` transformed into `href="something.html"`
		- Images, will need to be loaded correctly
	**/
	function processNodes( top:DOMNode ) {
		var thisAndDescendants = top.descendants( true ).add( top );
		for ( node in thisAndDescendants ) if ( node.isElement() ) {
			switch node.tagName() {
				case "a": 
					node.setAttr( "href", node.attr("href").replace(".md",".html") );
				case "table":
					node.addClass( "table table-bordered" );
				case "img": 
					ufTrace( '  Processing image asset ' + node.html() );
				default:
			}
		}
	}

	function addPrevNextEditLinks( prevLink:DOMNode, nextLink:DOMNode, titleNode:DOMNode, endOfContentNode:DOMNode ) {
		var header = "div".create().addClass( "prev-next-links clearfix top" );
		var footer = "div".create().addClass( "prev-next-links clearfix bottom" );

		if ( prevLink!=null ) {
			prevLink.addClass( "prev-link" ).setAttr( "href", prevLink.attr("href").replace(".md",".html") );
			header.append( prevLink );
			footer.append( prevLink.clone() );
		}
		
		var contributeLink = '<a href="${app.Config.app.manual.editLink}">Contribute to this page</a>'.parse();
		footer.append( contributeLink );

		if ( nextLink!=null ) {
			nextLink.addClass( "next-link" ).setAttr( "href", nextLink.attr("href").replace(".md",".html") );
			header.append( nextLink );
			footer.append( nextLink.clone() );
		}

		titleNode.afterThisInsert( header );
		endOfContentNode.afterThisInsert( footer );
		endOfContentNode.removeFromDOM();
	}

	// /**
	// 	Convert Latex into HTML files.
		
	// 	@param `inFile` the absolute path to the Latex file
	// 	@param `outDir` the absolute path to the directory we should save our HTML to
	// 	@param `linkBase` the absolute http path to use as the base for links.  Default "" (relative links)
	// 	@throw error message String 
	// **/
	// public function convertLatexToHtml( inFile:String, outDir:String, ?linkBase:String="" ) {

	// 	ufTrace( 'Convert Latex manual $inFile into HTML at $outDir' );
	// 	var tmpOutDir = removeTrailingSlash( outDir ) +'-tmp/';

	// 	var oldCwd = Web.getCwd();
	// 	var repo = inFile.directory();
	// 	try Sys.setCwd( repo ) catch(e:String) throw 'Failed to change cwd to $repo';


	// 	// Do initial parse

	// 	var parser, sections;
	// 	var input = byte.ByteData.ofString( sys.io.File.getContent(inFile) );
	// 	try {
	// 		LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle;
	// 		parser = new LatexParser( input, inFile );
	// 		sections = parser.parse();
	// 	}
	// 	catch(e:hxparse.NoMatch<Dynamic>) {
	// 		throw 'Failed to parse $inFile @ ' + e.pos.format(input) + ": Unexpected " +e.token;
	// 	}
	// 	catch(e:hxparse.Unexpected<Dynamic>) {
	// 		throw 'Failed to parse $inFile @ ' + e.pos.format(input) + ": Unexpected " +e.token;
	// 	}
	// 	catch ( e:Dynamic ) throw 'Failed to parse $inFile: $e';

	// 	// Small helper functions for conversion (mostly to do with links/anchors)

	// 	function escapeFileName( s:String ) {
	// 		return s.replace( "?", "" ).replace( "/", "-" ).replace( " ", "-" );
	// 	}
	// 	function escapeAnchor( s:String ) {
	// 		return s.toLowerCase().replace( " ", "-" );
	// 	}
	// 	function url( sec:Section ) {
	// 		return linkBase + sec.label.toLowerCase() + ".html";
	// 	}
	// 	function link( sec:Section ) {
	// 		return '<a href="${url(sec)}">${sec.title}</a>';
	// 	}
	// 	function process( s:String ):String {
	// 		function labelUrl( label:Label ) {
	// 			return switch label.kind {
	// 				case Section(sec): url( sec );
	// 				case Definition: 'dictionary.html#${escapeAnchor( label.name )}';
	// 				case Item(i): "" + i;
	// 			}
	// 		}
	// 		function labelLink( label:Label ) {
	// 			return switch label.kind {
	// 				case Section(sec): link( sec );
	// 				case Definition: '<a href="${escapeAnchor( "dictionary.html"+label.name )}">${label.name}</a>';
	// 				case Item(i): "" + i;
	// 			}
	// 		}
	// 		function map( r, f ) {
	// 			var i = r.matched(1);
	// 			if ( !parser.labelMap.exists(i) ) {
	// 				trace( 'Warning: No such label $i' );
	// 				return i;
	// 			}
	// 			return f( parser.labelMap[i] );
	// 		}
	// 		var s1 = ~/~~~([^~]+)~~~/g.map( s, map.bind(_, labelLink) );
	// 		return ~/~~([^~]+)~~/g.map( s1, map.bind(_, labelUrl) );
	// 	}

	// 	// Delete existing export

	// 	try 
	// 		SiteApi.unlink( tmpOutDir ) 
	// 	catch ( e:Dynamic ) 
	// 		throw 'Failed to delete existing tmp directory $tmpOutDir: $e';
		
	// 	try 
	// 		FileSystem.createDirectory( tmpOutDir ) 
	// 	catch ( e:Dynamic ) 
	// 		throw 'Failed to create tmp directory $tmpOutDir: $e';

	// 	// Process each section

	// 	var allSections = [];
	// 	var unreviewed = [];
	// 	var modified = [];
	// 	var noContent = [];
	// 	var nav = [];
	// 	function add( sec:Section ):ManualNavItem {
	// 		if ( sec.label==null ) {
	// 			ufError( 'Missing label while parsing Latex: ${sec.title}' );
	// 			return null;
	// 		}
	// 		sec.content = process( sec.content.trim() );
	// 		if( sec.content.length==0 ) {
	// 			if (sec.state != NoContent) {
	// 				noContent.push('${sec.id} - ${sec.title}');
	// 			}
	// 			if (sec.sub.length == 0) return null;
	// 			sec.content = sec.sub.map( function(sec) return sec.id + ": " +link(sec) ).join( "\n\n" );
	// 		}
	// 		else switch(sec.state) {
	// 			case New: unreviewed.push('${sec.id} - ${sec.title}');
	// 			case Modified: modified.push('${sec.id} - ${sec.title}');
	// 			case Edited | NoContent:
	// 		}
	// 		allSections.push(sec);
	// 		if ( sec.sub.length>0 ) {
	// 			var subNav = [];
	// 			for (sec in sec.sub) {
	// 				var navItem = add(sec);
	// 				if ( navItem!=null ) subNav.push( navItem );
	// 			}
	// 			return ParentItem( link(sec), subNav );
	// 		}
	// 		else return Item( link(sec) );
	// 	}
	// 	for ( sec in sections ) {
	// 		var navItem = add(sec);
	// 		if ( navItem!=null ) nav.push( navItem );
	// 	}
	// 	for ( i in 0...allSections.length ) {

	// 		var sec = allSections[i];
	// 		var content = try Markdown.markdownToHtml( sec.content ) catch ( e:Dynamic ) throw 'Failed to convert Markdown from manual [${sec.id}:${sec.title}]: $e';
			
	// 		var prevSection = (i!=0) ? allSections[i-1] : null;
	// 		var nextSection = (i!=allSections.length-1) ? allSections[i+1] : null;

	// 		var pageData:ManualPage = {
	// 			id: sec.id,
	// 			title: sec.title,
	// 			content: content,
	// 			prev: (prevSection!=null) ? url(prevSection) : null,
	// 			prevTitle: (prevSection!=null) ? prevSection.title : null,
	// 			next: (nextSection!=null) ? url(nextSection) : null,
	// 			nextTitle: (nextSection!=null) ? nextSection.title : null
	// 		};
	// 		var pageJson = Json.stringify( pageData );
	// 		var manualPage = '$tmpOutDir/${url(sec)}'.withoutExtension().withExtension("json");

	// 		try 
	// 			File.saveContent( manualPage, pageJson )
	// 		catch ( e:Dynamic ) 
	// 			throw 'Failed to save manual page $manualPage: $e';
	// 	}

	// 	// Create the dictionary

	// 	var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
	// 	a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
	// 	var dictionaryFile = '$tmpOutDir/dictionary.html';
	// 	try
	// 		File.saveContent( dictionaryFile, a.map(function(v) return '<h5 id="${escapeAnchor(v.k)}">${v.k}</a></h5>\n${process(v.v)}').join("\n\n") )
	// 	catch ( e:Dynamic )
	// 		throw 'Failed to save manual dictionary $dictionaryFile: $e';

	// 	// Create the nav file

	// 	var navFile = '$tmpOutDir/navigation.html';
	// 	var navOutput = new StringBuf();
	// 	function printNav( nav:Array<ManualNavItem>, sb:StringBuf ) {
	// 		sb.add( "<ul>" );
	// 		for ( item in nav ) {
	// 			switch item {
	// 				case Item(link): 
	// 					sb.add( '<li>$link</li>' );
	// 				case ParentItem(link,subNav):
	// 					sb.add( '<li>$link' );
	// 					printNav( subNav, sb );
	// 					sb.add( '</li>' );
	// 			}
	// 		}
	// 		sb.add( "</ul>" );
	// 	}
	// 	printNav( nav, navOutput );
	// 	try
	// 		File.saveContent( navFile, navOutput.toString() )
	// 	catch ( e:Dynamic ) 
	// 		throw 'Failed to save navigation menu from manual $navFile: $e';

	// 	// Create the TODO file

	// 	var todoFile = '$tmpOutDir/todo.html';
	// 	var todo = "This file is generated, do not edit!\n\n"
	// 		+ "# Todo:\n\n" + parser.todos.join("\n - ") + "\n\n"
	// 		+ "## Missing Content:\n\n" + noContent.join("\n - ") + "\n\n"
	// 		+ "## Unreviewed:\n\n" + unreviewed.join("\n - ") + "\n\n"
	// 		+ "## Modified:\n\n" + modified.join("\n - ");
	// 	try {
	// 		var html = Markdown.markdownToHtml( todo );
	// 		File.saveContent( todoFile, html );
	// 	}
	// 	catch ( e:Dynamic ) 
	// 		throw 'Failed to save navigation menu from manual $navFile: $e';

	// 	// Move the tmp directory into place as our new manual dir

	// 	try SiteApi.unlink( outDir ) catch ( e:Dynamic ) throw 'Failed to remove existing directory $outDir: $e';
	// 	try FileSystem.rename( tmpOutDir, outDir ) catch ( e:Dynamic ) throw 'Failed to move temporary dir $tmpOutDir to permanent location $outDir: $e';
		
	// 	try Sys.setCwd( oldCwd ) catch ( e:Dynamic ) throw 'Failed to set CWD to $oldCwd';

	// 	return;
	// }

	static function removeTrailingSlash ( path : String ) : String {
		return switch(path.charCodeAt(path.length - 1)) {
			case '/'.code | '\\'.code: path.substr(0, -1);
			case _: path;
		}
	}
}