package app.model;

import haxe.ds.Option;
import haxe.EnumFlags;
using haxe.io.Path;
using StringTools;

typedef SiteMap = Array<SitePage>;

typedef SitePage = {
	var url:String;
	var title:String;
	@:optional var editLink:Null<String>;
	@:optional var sub:Null<SiteMap>;
	@:optional var disambiguation:Null<String>;
};

class SiteMapHelper {
	/**
		For a given sitemap and URL, try find a matching page.

		@param sitemap The SiteMap to search.
		@param url The URI to search for.
		@return SitePage
		@throw String if not found
	**/
	public static function getPageForUrl( sitemap:SiteMap, url:String ):SitePage {
		url = url.removeTrailingSlashes();
		for ( page in sitemap ) {
			if ( page.url.removeTrailingSlashes()==url ) {
				return page;
			}
			else if ( page.sub!=null ) {
				var page = getPageForUrl(page.sub, url);
				if ( page!=null ) return page;
			}
		}
		return null;
	}

	/**
		Get prev/next links for a given URL on the sitemap.

		@param sitemap The sitemap to search.
		@param baseUrl The base URL of all links in the SiteMap.
		@param currentUri The current uri to match against. (base URL included).
		@return `{ prevUrl:String, prevTitle:String, nextUrl:String, nextTitle:String }`
	**/
	public static function getPrevNextLinks( sitemap:SiteMap, baseUrl:String, currentUri:String ) {
		var prevNextLinks = {
			prevUrl:null,
			prevTitle:null,
			nextUrl:null,
			nextTitle:null
		};
		if ( sitemap!=null ) {
			var previousPage:SitePage = null;
			var currentPage:SitePage = null;
			var nextPage:SitePage = null;

			var collapsedSitemap = collapseSitemap(sitemap);

			for ( page in collapsedSitemap ) {
				if ( baseUrl+page.url==currentUri ) {
					// This is the active page.
					// We'll leave `previousPage` whatever it was on the previous iteration.
					currentPage = page;
				}
				else if ( currentPage==null ) {
					// No current page found yet, keep setting `previousPage` until we find it.
					previousPage = page;
				}
				else if ( currentPage!=null ) {
					// The previous page was current, so set this one to "next page" and exit the loop.
					nextPage = page;
					break;
				}
			}
			if ( currentPage==null ) previousPage=null;

			if ( previousPage!=null ) {
				prevNextLinks.prevUrl = baseUrl+previousPage.url;
				prevNextLinks.prevTitle = previousPage.title;
			}
			if ( nextPage!=null ) {
				prevNextLinks.nextUrl = baseUrl+nextPage.url;
				prevNextLinks.nextTitle = nextPage.title;
			}
		}
		return prevNextLinks;
	}

	static function collapseSitemap( sitemap:SiteMap, ?array:Array<SitePage> ):Array<SitePage> {
		if ( array==null ) array = [];

		for ( page in sitemap ) {
			array.push( page );
			if ( page.sub!=null ) collapseSitemap( page.sub, array );
		}

		return array;
	}

	/**
		See if the URI belongs to this page.

		@param page The current page in the SiteMap.
		@param baseUrl The base URL of all links in the SiteMap.
		@param currentUri The current uri to match against. (base URL included).
		@return True if the current URI belongs to this page.
	**/
	public static function isCurrentPageActive( page:SitePage, baseUrl:String, currentUri:String ):Bool {
		return baseUrl+page.url==currentUri;
	}

	/**
		See if the current URI belongs to this page or any sub page.

		@param page The current page in the SiteMap.
		@param baseUrl The base URL of all links in the SiteMap.
		@param currentUri The current uri to match against. (base URL included).
		@return True if the current URI belongs to this page, or one of it's children.
	**/
	public static function isCurrentPageParentOfActive( page:SitePage, baseUrl:String, currentUri:String ):Bool {
		if ( isCurrentPageActive(page,baseUrl,currentUri) ) {
			return true;
		}
		if ( page.sub!=null ) {
			for ( p in page.sub ) {
				if ( isCurrentPageParentOfActive(p,baseUrl,currentUri) ) return true;
			}
			if ( currentUri.startsWith( baseUrl+page.url) ) {
				return true;
			}
		}
		return false;
	}

	/**
		Print a sitemap as <UL> element.

		@param sitemap The Sitemap that we are printing.
		@param baseUrl A prefix to insert before each url.  Also used when matching the current URL. Use "" for no prefix.
		@param currentUri (Optional) The URL of the current page.  If specified, the correct item and all of it's parents will have the "active" class.
		@return A String containing `<ul><li><a href="${page.url}">$icon ${page.title} $submenu</a></li></ul>`
	**/
	public static function printSitemap( sitemap:SiteMap, type:SiteMapType, baseUrl:String, ?currentUri:String ) {
		var sb = new StringBuf();
		baseUrl = baseUrl.addTrailingSlash();
		switch type {
			case SideBar: printSidebarRecursive( sitemap, baseUrl, currentUri, sb );
			case Footer: printFooter( sitemap, baseUrl, currentUri, sb );
			case NavBar: printNavBarRecursive( sitemap, baseUrl, currentUri, sb, false );
		}
		return sb.toString();
	}

	/**
		Print a standard `<ul>` for the sitemap, with active classes in the correct places.  Add icons to links.
	**/
	static function printSidebarRecursive( sitemap:SiteMap, baseUrl:String, currentUri:Null<String>, sb:StringBuf ) {
		sb.add( '<ul>' );
		for ( page in sitemap ) {
			// Create list item, add classes
			sb.add( '<li class="' );
			if ( page.sub!=null && page.sub.length>0 ) sb.add(' parent');
			if ( isCurrentPageParentOfActive(page,baseUrl,currentUri) ) sb.add(' active');
			sb.add( '">' );

			// Add icon
			sb.add( '<i class="fa"></i>' );

			// Add link
			sb.add( '<a href="$baseUrl${page.url}"' );
			if ( isCurrentPageActive(page,baseUrl,currentUri) ) sb.add( ' class="active"' );
			sb.add( '>' );
			sb.add( page.title );
			sb.add( '</a>' );

			// Add submenu
			if ( page.sub!=null && page.sub.length>0 ) printSidebarRecursive( page.sub, baseUrl, currentUri, sb );

			// Close list item
			sb.add( '</li>' );
		}
		sb.add( '</ul>' );
	}

	/**
		Print a sitemap to be used as a footer.

		The structure will be:

		```
		<ul>
			<li class="sitemap-column">
				<ul>
					<li>Page</li>
					<li>Page</li>
				</ul>
			</li>
			<li class="sitemap-column">
				<h5>Sub Menu 1</h5>
				<ul>
					<li>Sub Page 1A</li>
					<li>Sub Page 1B</li>
				</ul>
			</li>
		</ul>
		```
	**/
	static function printFooter( sitemap:SiteMap, baseUrl:String, currentUri:Null<String>, sb:StringBuf ) {
		var columns = [];
		sb.add( '<ul>' );

		
		function addHeader( page:SitePage, colBuf:StringBuf ) {
			colBuf.add( '<h5><a href="$baseUrl${page.url}">${page.title}</a></h5>' );
		}
		function openColumn( ?page:SitePage ):StringBuf {
			var colBuf = new StringBuf();
			columns.push( colBuf );
			colBuf.add( '<li class="column">');
			if ( page!=null ) addHeader( page, colBuf );
			return colBuf;
		}
		function addLink( p:SitePage, colBuf:StringBuf ) {
			colBuf.add( '<li><a href="$baseUrl${p.url}">${p.title}</a></li>' );
		}
		function closeColumn( colBuf:StringBuf ) {
			colBuf.add( '</li>' );
		}

		var firstColumn = openColumn();

		for ( page in sitemap ) {
			if ( page.sub==null || page.sub.length==0 ) {
				addHeader( page, firstColumn );
			}
			else {
				var col = openColumn( page );
				col.add( '<ul>');
				for ( p in page.sub ) {
					addLink( p, col );
				}
				col.add( '</ul>');
			}
		}

		for ( c in columns ) {
			closeColumn( c );
			sb.add( c.toString() );
		}

		sb.add( '</ul>' );
	}

	/**
		Print a sitemap to be used as a navbar, with drop-downs providing one level of navigation.
	**/
	static function printNavBarRecursive( sitemap:SiteMap, baseUrl:String, currentUri:Null<String>, sb:StringBuf, isSubMenu:Bool ) {
		var cls = isSubMenu ? "dropdown-menu" : "nav";
		sb.add( '<ul class="$cls">' );

		for ( page in sitemap ) {
			// Create list item, add classes
			sb.add( '<li class="' );
			if ( isCurrentPageParentOfActive(page,baseUrl,currentUri) ) sb.add(' active');
			if ( page.sub!=null && page.sub.length>0 && isSubMenu==false ) sb.add(' dropdown');
			sb.add( '">' );


			if ( page.sub!=null && page.sub.length>0 && isSubMenu==false ) {
				// Add a dropdown menu, only if this has a submenu and we're still on the top level.
				sb.add( '<a href="$baseUrl${page.url}" data-toggle="dropdown" class="dropdown-toggle' );
				if ( isCurrentPageActive(page,baseUrl,currentUri) ) 
					sb.add( ' active' );
				sb.add( '">' );
				sb.add( page.title );
				sb.add( ' <b class="caret"></b>' );
				sb.add( '</a>' );

				printNavBarRecursive( page.sub, baseUrl, currentUri, sb, true );
			}
			else {
				// Add a regular link - no submenu.
				sb.add( '<a href="$baseUrl${page.url}"' );
				if ( isCurrentPageActive(page,baseUrl,currentUri) )
					sb.add( ' class="active"' );
				sb.add( '>' );
				sb.add( page.title );
				sb.add( '</a>' );
			}

			// Close list item
			sb.add( '</li>' );
		}
		sb.add( '</ul>' );
	}
}

enum SiteMapType {
	NavBar;
	SideBar;
	Footer;
}
