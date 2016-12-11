import haxe.Json;
import haxe.io.Path;
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

class SiteMap {

	static var sitemap : Array<SitePage>;
	public static function init () {
		sitemap = Json.parse(File.getContent("sitemap.json"));
		annotateGroup(sitemap);
	}

	public static function annotateGroup (map:Array<SitePage>, ?parent:SitePage) {
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

	public static function urlForFile (file:String) : String {
		var path = Path.normalize(file).split("/");

		if (path[0] == Config.outputFolder) {
			path.shift();
		}

		var last = path.pop();
		var ext = Path.extension(last);

		if (ext == "md") {
			last = Path.withoutExtension(file) + ".html";
		}

		if (last != "index.html") {
			path.push(last);
		}
		else {
			path.push("");
		}

		return path.join("/");
	}

	public static function pageForUrl (url:String, ?sitemap:Array<SitePage>) : SitePage {
		if (Path.extension(url) == "md") {
			url = Path.withoutExtension(url) + ".html";
		}

		if (url.endsWith("/index.html")) {
			url = Path.directory(url) + "/";
		}

		if (sitemap == null) {
			sitemap = SiteMap.sitemap;
		}

		return pageInSiteMap(sitemap, url);
	}

	public static function urlForPage (page:SitePage) : String {
		if (page.url.startsWith("http")) {
			return page.url;
		}

		if (page.url == "/") {
			return "/";
		}

		return "/" + page.url;
	}

	static function pageInSiteMap (map:Array<SitePage>, url:String) : SitePage {
		for (page in map) {
			if (url == page.url) {
				return page;
			}

			for (spage in page.sub) {
				var p = pageInSiteMap(page.sub, url);
				if (p != null) {
					return p;
				}
			}
		}

		return null;
	}

	static function inMap (m:Array<SitePage>, page:SitePage) : Bool {
		for (p in m) {
			if (p == page) {
				return true;
			}

			if (inMap(p.sub, page)) {
				return true;
			}
		}

		return false;
	}

	static function getFlat (map:Array<SitePage>) : Array<SitePage> {
		var flat = [];

		for (page in map) {
			flat.push(page);
			flat = flat.concat(getFlat(page.sub));
		}

		return flat;
	}

	public static function prevNextLinks (map:Array<SitePage>, page:SitePage) {
		var flat = getFlat(map);
		var prev = null;
		var next = null;

		for (i in 0...flat.length) {
			if (flat[i] == page) {
				var j = i - 1;
				while (j >= 0) {
					if (flat[j].url == Config.sitemapDividerUrl) {
						j--;
					}
					else {
						prev = flat[j];
						break;
					}
				}

				var j = i + 1;
				while (j < flat.length) {
					if (flat[j].url == Config.sitemapDividerUrl) {
						j++;
					}
					else {
						next = flat[j];
						break;
					}
				}
			}
		}

		return {
			prevUrl: prev != null ? "/" + prev.url : null,
			prevTitle: prev != null ? prev.title : null,
			nextUrl: next != null ? "/" + next.url : null,
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
			if (isOrParent(page, current)) {
				sb.add(" active");
			}
			sb.add('">');

			// Add icon
			sb.add('<i class="fa"></i>');

			// Add link
			sb.add('<a href="${urlForPage(page)}"');
			if (page == current) {
				sb.add(' class="active"');
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
	static var _footer : String;
	public static function footer () : String {
		if (_footer != null) {
			return _footer;
		}

		var sb = new StringBuf();
		var columns = [];
		sb.add("<ul>");

		inline function addHeader (page:SitePage, colBuf:StringBuf) {
			colBuf.add('<h5><a href="${urlForPage(page)}">${page.title}</a></h5>' );
		}

		function openColumn(?page:SitePage) : StringBuf {
			var colBuf = new StringBuf();
			columns.push(colBuf);

			if (page != null && page.url == Config.sitemapDividerUrl) {
				return colBuf;
			}

			colBuf.add('<li class="column">');

			if (page != null) {
				addHeader(page, colBuf);
			}

			return colBuf;
		}

		var firstColumn = openColumn();

		for (page in sitemap) {
			if (page.url == Config.sitemapDividerUrl) {
				continue;
			}

			if (page.sub.length == 0) {
				addHeader(page, firstColumn);
			}
			else {
				var col = openColumn(page);
				col.add("<ul>");
				for (p in page.sub) {
					if (p.url != Config.sitemapDividerUrl) {
						col.add('<li><a href="${urlForPage(p)}">${p.title}</a></li>' );
					}
				}
				col.add("</ul>");
			}
		}

		for (c in columns) {
			c.add("</li>");
			sb.add(c.toString());
		}

		sb.add("</ul>");

		_footer = sb.toString();
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
				sb.add(" active");
			}

			if (page.sub.length > 0 && !isSubMenu) {
				sb.add(' dropdown');
			}

			if (page.url == Config.sitemapDividerUrl) {
				sb.add(" divider");
			}

			sb.add('">');

			if (page.sub.length > 0 && !isSubMenu) {
				// Add a dropdown menu, only if this has a submenu and we're still on the top level.
				sb.add('<a href="${urlForPage(page)}" data-toggle="dropdown" class="dropdown-toggle' );

				if (page == current) {
					sb.add(" active");
				}

				sb.add('">');
				sb.add(page.title);
				sb.add(' <b class="caret"></b>');
				sb.add("</a>");

				printNavBarRecursive(page.sub, current, sb, true);
			}
			else if (page.url != Config.sitemapDividerUrl) {
				// Add a regular link - no submenu.
				sb.add('<a href="${urlForPage(page)}"');
				if (page == current) {
					sb.add(' class="active"');
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
