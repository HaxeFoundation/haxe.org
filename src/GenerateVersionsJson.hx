import haxe.Json;
import sys.io.File;
import sys.io.Process;

using StringTools;

typedef GithubUser = {
	login : String,
	id : Int,
	avatar_url : String,
	gravatar_id : String,
	url : String,
	html_url : String,
	followers_url : String,
	following_url : String,
	gists_url : String,
	starred_url : String,
	subscriptions_url : String,
	organizations_url : String,
	repos_url : String,
	events_url : String,
	received_events_url : String,
	type : String,
	site_admin : String
};

typedef GithubAsset = {
	url : String,
	id : Int,
	name : String,
	label : String,
	uploader : GithubUser,
	content_type : String,
	state : String,
	size : Int,
	download_count : Int,
	created_at : String,
	updated_at : String,
	browser_download_url : String
};

typedef GithubRelease = {
	url : String,
	assets_url : String,
	upload_url : String,
	html_url : String,
	id : Int,
	tag_name : String,
	target_commitish : String,
	name : String,
	draft : Bool,
	author : GithubUser,
	prerelease : Bool,
	created_at : String,
	published_at : String,
	assets : Array<GithubAsset>,
	tarball_url : String,
	zipball_url : String,
	body : String
};

class GenerateVersionsJson {

	public static function main () {
		// Get data from github api
		//TODO: for now uses curl, haxe.Http in https doesn't work in --interp, and in neko it doesn't work "ssl@ssl_recv"
		Sys.println("Downloading data from github api ...");
		var data = new Process("curl", ["https://api.github.com/repos/haxefoundation/haxe/releases"]);
		var releases:Array<GithubRelease> = Json.parse(data.stdout.readAll().toString());
		data.close();

		Sys.println("Exporting data ...");
		// Sort data by semver (currently by upload date)
		releases.sort(function (a:GithubRelease, b:GithubRelease):Int {
			return Reflect.compare(a.name, b.name); //TODO: works-ish (rc are after releases0) now but that's not made for this
		});

		var buf = new StringBuf();
		var current = releases[releases.length - 1].name;
		buf.add('{\n\t"current": "${current}",\n\t"versions": [\n');

		for (release in releases) {
			if (release.name == "") {
				continue;
			}

			var api = "";
			var downloads = [];

			for (asset in release.assets) {
				if (asset.name.startsWith("api-")) {
					api = '${asset.browser_download_url}';
				}
				else {
					downloads.push('"${asset.browser_download_url}"');
				}
			}

			var r:Dynamic = {};
			r.version = release.name;
			if (api != "") {
				r.api = api;
			}
			r.tag = release.tag_name;
			r.date = release.created_at.substr(0, 10);
			r.changes = release.body;
			r.downloads = downloads;
			var o = Json.stringify(r);
			buf.add('\t\t$o');

			if (release != releases[releases.length - 1]) {
				buf.add(",");
			}

			buf.add("\n");
		}

		buf.add("\t]\n}\n");

		File.saveContent("versions.json", buf.toString());
		Sys.println("Done.");
	}

}
