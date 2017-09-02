import haxe.Json;
import sys.io.File;

using StringTools;

typedef SitePage = {
	var url : String;
	var title : String;
	@:optional var sub : Array<SitePage>;

	@:optional var parent : SitePage;
	@:optional var previous : SitePage;
	@:optional var next : SitePage;
	@:optional var editLink : String;
}

typedef PrevNextLinks = {
	prevUrl : String,
	prevTitle : String,
	nextUrl : String,
	nextTitle : String
}

typedef Row = {
	url : String,
	title : String
}

class SiteMap {

	static var sitemap : Array<SitePage>;
	public static function init () {
		sitemap = Json.parse(File.getContent("sitemap.json"));
		annotateGroup(sitemap);
	}

	public static function annotateGroup (map:Array<SitePage>, parent:SitePage = null) {
		var previous = null;
		for (page in map) {
			page.parent = parent;

			page.previous = previous;
			if (previous != null) {
				previous.next = page;
			}
			previous = page;

			if (page.sub == null) {
				page.sub = [];
			}
			annotateGroup(page.sub, page);
		}
	}

	public static function pageForUrl (url:String, category:Bool, fuzzy:Bool, map:Array<SitePage> = null) : SitePage {
		if (map == null) {
			map = SiteMap.sitemap;
		}

		url = Utils.urlNormalize(url);

		var matches = fuzzyPageForUrl(url, category, map);

		if (matches.length == 0) {
			return null;
		}

		var best = matches[0];

		if (fuzzy) {
			return best;
		} else if (best.url == url) {
			return best;
		}

		return null;
	}

	static function fuzzyPageForUrl (url:String, category:Bool, map:Array<SitePage>) : Array<SitePage> {
		var fuzzyMatches = [];

		for (page in map) {
			// Search in sub first, first sub often has the same url as category
			// unless category is asked

			if (category && url.startsWith(page.url)) {
				fuzzyMatches.push(page);
			}

			fuzzyMatches = fuzzyMatches.concat(fuzzyPageForUrl(url, category, page.sub));

			if (!category && url.startsWith(page.url)) {
				fuzzyMatches.push(page);
			}
		}

		fuzzyMatches.sort(function (p1, p2):Int {
			return -1 * Reflect.compare(p1.url.length, p2.url.length);
		});

		return fuzzyMatches;
	}

	static function getFlat (map:Array<SitePage>) : Array<SitePage> {
		var flat = [];

		for (page in map) {
			if (page.url != Config.sitemapDividerUrl) {
				flat.push(page);
			}
			flat = flat.concat(getFlat(page.sub));
		}

		return flat;
	}

	public static function prevNextLinks (map:Array<SitePage>, page:SitePage) : PrevNextLinks{
		var flat = getFlat(map);
		var prev = null;
		var next = null;

		for (i in 0...flat.length) {
			if (flat[i] == page) {
				if (i > 0) {
					prev = flat[i - 1];
				}
				if (i < flat.length - 1) {
					next = flat[i + 1];
				}
			}
		}

		return {
			prevUrl: prev != null ? prev.url : null,
			prevTitle: prev != null ? prev.title : null,
			nextUrl: next != null ? next.url : null,
			nextTitle: next != null ? next.title : null,
		};
	}

	static function isOrParent (page:SitePage, of:SitePage) : Bool {
		var p = of;

		while (p != null) {
			if (p == page) {
				return true;
			}

			p = p.parent;
		}

		return false;
	}

	public static function sideBar (map:Array<SitePage>, current:SitePage) : String {
		var sb = new StringBuf();
		printSidebarRecursive(map, current, sb);
		return sb.toString();
	}

	/**
		Print a standard `<ul>` for the sitemap, with active classes in the correct places. Add icons to links.
	**/
	static function printSidebarRecursive (map:Array<SitePage>, current:SitePage, sb:StringBuf) {
		sb.add("<ul>");

		for (page in map) {
			if (page.url == Config.sitemapDividerUrl) {
				continue;
			}

			// Create list item, add classes
			sb.add('<li class="');
			if (page.sub.length > 0) {
				sb.add(" parent");
			}
			if (page == current) {
				sb.add(' ${Config.activeClass}');
			}
			sb.add('">');

			// Add icon
			sb.add('<i class="fa"></i>');

			// Add link
			sb.add('<a href="${page.url}"');
			if (page == current) {
				sb.add(' class="${Config.activeClass}"');
			}
			sb.add(">");
			sb.add(page.title);
			sb.add("</a>");

			// Add submenu
			if (page.sub.length > 0) {
				printSidebarRecursive(page.sub, current, sb);
			}

			// Close list item
			sb.add("</li>");
		}
		sb.add("</ul>");
	}

	/**
		Print the sitemap to be used as a footer.
	**/
	static var _footer : String;
	public static function footer () : String {
		if (_footer != null) {
			return _footer;
		}

		var firstColumn = [];
		var columns = [];

		function makeRow (page:SitePage) : Row {
			return { url: page.url, title: page.title };
		}

		for (page in sitemap) {
			if (page.url == Config.sitemapDividerUrl) {
				continue;
			}

			if (page.sub.length == 0) {
				firstColumn.push(makeRow(page));
			} else {
				var header = makeRow(page);
				var rows = [];

				for (p in page.sub) {
					if (p.url != Config.sitemapDividerUrl) {
						rows.push(makeRow(p));
					}
				}

				columns.push({ title: header.title, url: header.url, rows: rows });
			}
		}

		_footer = Views.Footer(firstColumn, columns);

		return _footer;
	}

	public static function navbar (current:SitePage) : String {
		var sb = new StringBuf();
		printNavBarRecursive(sitemap, current, sb, false);
		return sb.toString();
	}

	/**
		Print a sitemap to be used as a navbar, with drop-downs providing one level of navigation.
	**/
	static function printNavBarRecursive(map:Array<SitePage>, current:SitePage, sb:StringBuf, isSubMenu:Bool) {
		if (isSubMenu) {
			sb.add('<ul class="dropdown-menu">');
		}

		for (page in map) {
			// Create list item, add classes
			sb.add('<li class="');

			if (isOrParent(page, current)) {
				sb.add(' ${Config.activeClass}');
			}

			if (page.sub.length > 0 && !isSubMenu) {
				sb.add(" dropdown");
			}

			if (page.url == Config.sitemapDividerUrl) {
				sb.add(" divider");
			}

			sb.add('">');

			if (page.sub.length > 0 && !isSubMenu) {
				// Add a dropdown menu, only if this has a submenu and we're still on the top level.
				sb.add('<a href="${page.url}" data-toggle="dropdown" class="dropdown-toggle' );

				if (isOrParent(page, current)) {
					sb.add(' ${Config.activeClass}');
				}

				sb.add('">');
				sb.add(page.title);
				sb.add(' <b class="caret"></b>');
				sb.add("</a>");

				printNavBarRecursive(page.sub, current, sb, true);
			} else if (page.url != Config.sitemapDividerUrl) {
				// Add a regular link - no submenu.
				sb.add('<a href="${page.url}"');
				if (page == current) {
					sb.add(' class="${Config.activeClass}"');
				}
				sb.add(">");
				sb.add(page.title);
				sb.add("</a>");
			}

			// Close list item
			sb.add("</li>");
		}

		if (isSubMenu) {
			sb.add("</ul>");
		}
	}

}
