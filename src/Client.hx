import js.Browser;
import js.JQuery.JQueryHelper.*;
using haxe.io.Path;

class Client
{
	static function main() {
		J( cast Browser.document ).ready( function (_) {
			menuExpandCollapse();
			expandCurrentPageOnMenu();
			syntaxHighlight();
			pullOutStyling();
			tableStyling();
			emptyLinks();
			externalLinks();
		});
	}

	static function syntaxHighlight() {
		var kwds = ["abstract", "break", "case", "cast", "class", "continue", "default", "do", "dynamic", "else", "enum", "extends", "extern", "for", "function", "if", "implements", "import", "in", "inline", "interface", "macro", "new", "override", "package", "private", "public", "return", "static", "switch", "throw", "try", "typedef", "untyped", "using", "var", "while" ];
		var kwds = new EReg("\\b(" + kwds.join("|") + ")\\b", "g");

		var vals = ["null", "true", "false", "this"];
		var vals = new EReg("\\b(" + vals.join("|") + ")\\b", "g");

		for( s in J("pre") ) {
			var html = s.html();
			
			// detect and remove identation
			var tabs = null;
			for( line in html.split("\n") )
				if( StringTools.trim(line) != "" ) {
					var r = ~/^\t*/;
					r.match(line);
					var t = r.matched(0);
					if( tabs == null || t.length < tabs.length ) tabs = t;
				}
			html = new EReg("^" + tabs, "gm").replace(html, "");
			html = StringTools.trim(html);

			html = ~/('[^']*')/g.replace(html, "<span __xlass='str'>$1</span>");
			html = kwds.replace(html, "<span class='kwd'>$1</span>");
			html = vals.replace(html, "<span class='val'>$1</span>");
			
			html = html.split('__xlass').join("class");
			
			html = ~/("[^"]*")/g.replace(html, "<span class='str'>$1</span>");
			html = ~/(\/\/[^\n]*)/g.replace(html, "<span class='cmt'>$1</span>");
			html = ~/(\/\*\*?[^*]*\*?\*\/)/g.replace(html, "<span class='cmt'>$1</span>");
			html = html.split("\t").join("    ");
			s.html(html);
		}
	}

	static function menuExpandCollapse() {
		J(".tree-nav li i.fa").click( function () {
			JTHIS.parent().toggleClass('active');
		});
	}

	static function expandCurrentPageOnMenu() {
		var current = js.Browser.document.URL.withoutDirectory();
		J('.tree-nav a[href="$current"]').addClass( 'active' ).parents( 'li' ).addClass( 'active' );
	}

	static function pullOutStyling() {
		for ( h5 in J('blockquote h5') ) {
			var type = h5.text().substr( 0, h5.text().indexOf(":") );
			h5.parent().addClass( type.toLowerCase() );
		}
	}

	static function tableStyling() {
		J( '.site-content' ).addClass( 'table' );
	}

	static function externalLinks() {
		J( ".site-content a[href^='http://']" ).attr( 'target', '_blank' );
		J( ".site-content a[href^='https://']" ).attr( 'target', '_blank' );
	}

	static function setupBootstrap() {
		var popoverLinks = J( '.popover-icon' );
		untyped popoverLinks.popover();
	}

	static function emptyLinks() {
		J( 'a[href="#"]' ).click( function() return false ).attr("title","This page has not been created yet");
	}
}
