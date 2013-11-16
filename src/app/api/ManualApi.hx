package app.api;

#if server
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end

import latexparser.LatexParser;
import app.model.ManualNavItem;
using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class ManualApi extends ufront.api.UFApi {
	@inject("contentDirectory") public var contentDir:String;

	/**
		Convert Latex into HTML files.
		
		@param `inFile` the absolute path to the Latex file
		@param `outDir` the absolute path to the directory we should save our HTML to
		@param `linkBase` the absolute http path to use as the base for links.  Default "" (relative links)
		@return Success(Noise), or Failure(errorMsg)
	**/
	public function convertLatex( inFile:String, outDir:String, ?linkBase:String="" ):Outcome<Noise,String> {
		

		try {
			var oldCwd = Sys.getCwd();
			var repo = inFile.directory();
			try Sys.setCwd( repo ) catch(e:String) return Failure(e);

			// Do initial parse

			var input = byte.ByteData.ofString( sys.io.File.getContent(inFile) );
			var parser = new LatexParser( input, inFile );
			var sections = parser.parse();
			
			// Extra conversion (mostly to do with links/anchors)
			function escapeFileName( s:String ) {
				return s.replace( "?", "" ).replace( "/", "-" ).replace( " ", "-" );
			}
			function escapeAnchor( s:String ) {
				return s.toLowerCase().replace( " ", "-" );
			}
			function url( sec:Section ) {
				return linkBase + sec.label + ".html";
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
			unlink( outDir );
			sys.FileSystem.createDirectory( outDir );

			// Process each section
			var allSections = [];
			var nav = [];
			function add( sec:Section ) {
				if ( sec.label==null ) {
					throw 'Missing label: ${sec.title}';
				}
				sec.content = process( sec.content.trim() );
				if( sec.content.length==0 ) {
					if (sec.sub.length==0 ) return null;
					sec.content = sec.sub.map( function(sec) return sec.id + ": " +link(sec) ).join( "\n\n" );
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
				var content = '<h1>${sec.id} ${sec.title}</h1>';
				content += Markdown.markdownToHtml( sec.content );
				content += "\n\n<div class='prev-next-links'>";

				if (i != 0) content += '\n\n<div class="prev-link">' + link(allSections[i-1]) + '</div>';
				if (i != allSections.length-1) content += '\n\n<div class="next-link">' + link(allSections[i+1]) + '</div>';

				content += "\n\n</div>";

				sys.io.File.saveContent('$outDir/${url(sec)}', content);
			}

			// Create the dictionary
			var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
			a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
			sys.io.File.saveContent('$outDir/dictionary.html', a.map(function(v) return '<h5 id="${escapeAnchor(v.k)}">${v.k}</a></h5>\n${process(v.v)}').join("\n\n"));

			// Create the nav file
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
			sys.io.File.saveContent('$outDir/navigation.html', navOutput.toString() );
			
			Sys.setCwd( oldCwd );

			return Success( Noise );
		}
		catch ( e:Dynamic ) return Failure( 'Failed to convert latex: $e' );

	}

	public function getNavigation( repo:String ):Outcome<String,String> {
		return 
			try Success( File.getContent('${repo}/navigation.html') )
			catch ( e:Dynamic ) Failure('$e')
		;
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