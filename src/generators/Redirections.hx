package generators;

import haxe.io.Path;

class Redirections {

	public static function generate () {
		Sys.println("Generating redirections ...");

		var list =  [
			"/community/index.html" => "/community/community-support.html",
			"/documentation/index.html" => "/documentation/introduction/",
			"/foundation/support.html" => "/foundation/support-plans.html",
			"/manual/index.html" => "/manual/introduction.html"
		];

		for (page in list.keys()) {
			var content = views.Redirection.execute({
				redirectionLink: list.get(page)
			});

			Utils.save(Path.join([Config.outputFolder, page]), content, null, null);
		}
	}

}
