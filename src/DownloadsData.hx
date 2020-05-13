import haxe.Json;
import haxe.io.Path;
import sys.io.*;

using StringTools;
using Lambda;

typedef Download = {
	title : String,
	filename : String,
	url : String
}

typedef DownloadList = {
	osx : DownloadType,
	windows : DownloadType,
	linux : DownloadType,
	all : Array<Download>
}

typedef DownloadType = {
	installers : Array<Download>,
	archives : Array<Download>
}

typedef Version = {
	var version : String;
	var tag : String;
	var date : String;
	@:optional var api : Download;
	@:optional var next : Version;
	@:optional var prev : Version;
	@:optional var downloads : DownloadList;
}

typedef Data = {
	current : String,
	versions : Array<Version>
}

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

class DownloadsData {

	static var githubReleases(get, null):Array<GithubRelease>;
	static function get_githubReleases():Array<GithubRelease> return githubReleases != null ? githubReleases : githubReleases = {
		// Get data from github api
		//TODO: for now uses curl, haxe.Http in https doesn't work in --interp, and in neko it doesn't work "ssl@ssl_recv"
		var authArgs = switch (Sys.getEnv("GITHUB_AUTH")) {
			case null:
				[];
			case githubAuth: //format is username:token
				["-u", githubAuth];
		}
		#if nodejs
		var data = js.node.ChildProcess.execSync("curl " + authArgs.concat(["https://api.github.com/repos/haxefoundation/haxe/releases?per_page=50"]).join(" "));
		var releases:Array<GithubRelease> = Json.parse(data);
		#else
		var data = new Process("curl", authArgs.concat(["https://api.github.com/repos/haxefoundation/haxe/releases?per_page=50"]));
		var releases:Array<GithubRelease> = Json.parse(data.stdout.readAll().toString());
		data.close();
		#end
		// Github API will return an object instead when there is an error (rate limit, etc.)
		Std.is(releases, Array) ? releases : [];
	}

	static function getDownloadInfo (version:Version) {
		var downloads = {
			"osx": { installers: [], archives: [] },
			"windows": { installers: [], archives: [] },
			"linux": { installers: [], archives: [] },
			"all": []
		};

		function getInfo (title:String, url:String) : Download {
			return { title: title, url:url, filename: Path.withoutDirectory(url) };
		}

		var downloadUrls = [];
		var githubRelease = githubReleases.find(function(r) return r.tag_name == version.tag);

		if (githubRelease != null) {
			downloadUrls = githubRelease.assets.map(function(a) return a.browser_download_url);
		} else {
			var prEnv = Sys.getEnv("TRAVIS_PULL_REQUEST");
			if (prEnv != null && prEnv != "false") {
				trace('Warning: failed to retrieve download links for version ${version.tag}; skipping assets for this build.');
			} else {
				throw 'missing github release for version ${version.tag}';
			}
		}

		//TODO: make something a little less horrible here
		for (url in downloadUrls) {
			var filename = Path.withoutDirectory(url);
			var current;
			if (filename.endsWith("-linux32.tar.gz") || filename.endsWith("-linux.tar.gz")) {
				downloads.linux.archives.unshift(current = getInfo("Linux 32-bit Binaries", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-linux64.tar.gz")) {
				downloads.linux.archives.push(current = getInfo("Linux 64-bit Binaries", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-raspi.tar.gz")) {
				downloads.linux.archives.push(current = getInfo("Raspberry Pi", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-osx-installer.pkg") || filename.endsWith("-osx-installer.dmg")) {
				downloads.osx.installers.unshift(current = getInfo("OS X Installer", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-osx.tar.gz")) {
				downloads.osx.archives.push(current = getInfo("OS X Binaries", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-win.exe")) {
				downloads.windows.installers.unshift(current = getInfo("Windows 32-bit Installer", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-win.zip")) {
				downloads.windows.archives.push(current = getInfo("Windows 32-bit Binaries", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-win64.exe")) {
				downloads.windows.installers.unshift(current = getInfo("Windows 64-bit Installer", url));
				downloads.all.unshift(current);
			} else if (filename.endsWith("-win64.zip")) {
				downloads.windows.archives.push(current = getInfo("Windows 64-bit Binaries", url));
				downloads.all.unshift(current);
			} else if (filename == 'api-${version.version}.zip') {
				version.api = getInfo("API Documentation", url);
			} else {
				throw('Unknown download type for "$filename"');
			}
		}
		version.downloads = downloads;
	}

	public static function getData():Data {
		var data:Data = Json.parse(File.getContent(Path.join([Config.downloadsPath, "versions.json"])));
		var versions = data.versions;
		versions.reverse();

		// Annotate data
		var next = null;
		for (version in versions) {
			version.next = next;
			if (next != null) {
				next.prev = version;
			}
			next = version;

			getDownloadInfo(version);
		}

		return data;
	}

}
