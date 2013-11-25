package app.controller;

import app.Config;
import ufront.web.Controller;
import ufront.web.Dispatch;
import ufront.web.result.*;

class SearchController extends Controller {
	
	public function doDefault():ActionResult {

		var q = context.request.params['s'];
		var title = (q==null) ? "Search" : 'Search for $q';

		return ViewResult.create({
			title: title,
			topNav: '/search'
		});
	}
}