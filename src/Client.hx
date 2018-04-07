import js.Browser;
import js.jquery.JQuery;

class Client {

	static function main () {
		new JQuery(Browser.document).ready(function (_) {
			menuExpandCollapse();
			expandCurrentPageOnMenu();
			pullOutStyling();
			emptyLinks();
		});
	}

	static function menuExpandCollapse() {
		var t = new JQuery(".tree-nav li i.fa");
		t.click( function (event) {
			new JQuery(event.target).parent().toggleClass(Config.activeClass);
		});
	}

	static function expandCurrentPageOnMenu() {
		var current = js.Browser.location.pathname;
		new JQuery('.tree-nav a[href="$current"]').addClass(Config.activeClass).parents("li").addClass(Config.activeClass);
	}

	static function pullOutStyling() {
		for (h5 in [for (e in new JQuery("blockquote h5")) new JQuery(e)]) {
			var type = h5.text().substr(0, h5.text().indexOf(":"));
			h5.parent().addClass(type.toLowerCase());
		}
	}

	static function setupBootstrap() {
		var popoverLinks = new JQuery(".popover-icon");
		untyped popoverLinks.popover();
	}

	static function emptyLinks() {
		new JQuery('a[href="#"]').click(function(_):Bool return false).attr("title", "This page has not been created yet");
	}

}
