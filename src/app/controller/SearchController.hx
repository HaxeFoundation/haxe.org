package app.controller;

import app.Config;
import ufront.MVC;
using StringTools;

class SearchController extends Controller {

	@:route("/")
	public function doDefault():ActionResult {

		var q = context.request.params['s'];
		var title = (q==null) ? "Search" : 'Search for ${q.htmlEscape()}';

		return new ViewResult({
			title: title,
			topNav: '/search',
			description: 'Search results for `${q}` on haxe.org'
		});
	}
}
