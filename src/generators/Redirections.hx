package generators;

import haxe.io.Path;

class Redirections {

	public static function generate () {
		Sys.println("Generating redirections ...");

		var list =  [
			"/community/index.html" => "/community/community-support.html",
			"/documentation/index.html" => "/documentation/introduction/",
			"/manual/index.html" => "/manual/introduction.html",
			"/manual/macros/index.html" => "/manual/macro.html",
			"/manual/lf-trace-log.html" => "/manual/debugging-trace-log.html",
			"/manual/type-system-extensions.html" => "/manual/types-structure-extensions.html",
			"/manual/target-javascript-debugging.html" => "/manual/debugging-javascript.html",
			"/manual/serialization/format/index.html" => "/manual/std-serialization-format.html",
			"/doc/index.html" => "/manual/introduction.html",
			"/foundation/support.html" => "/foundation/support-plans.html",
			"/foundation/shop.html" => "/foundation/shop/",
			"/api/index.html" => "https://api.haxe.org/",
		];

		// fix some old links to toplevel api classes. 
		for (oldName in "reflect,array,date,sys,type,map,int,math,dynamic,enum,float,class,xml".split(",")) {
			var newName = oldName.charAt(0).toUpperCase() + oldName.substr(1);
			list.set('/api/$oldName/index.html', 'https://api.haxe.org/$newName.html');
		}

		for (page in list.keys()) {
			var content = Views.Redirection(list.get(page));

			Utils.save(Path.join([Config.outputFolder, page]), content, null, null);
		}
	}

}
