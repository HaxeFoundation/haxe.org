package generators;

import haxe.Json;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.*;
import tink.template.Html;

using StringTools;
using Lambda;

typedef Download = {
	title : String,
	filename : String,
	url : String
}

typedef DownloadList = {
	osx : Array<Download>,
	windows : Array<Download>,
	linux : Array<Download>
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

class Downloads {


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
		var data = new Process("curl", authArgs.concat(["https://api.github.com/repos/haxefoundation/haxe/releases"]));
		var releases:Array<GithubRelease> = Json.parse(data.stdout.readAll().toString());
		data.close();
		releases;
	}

	static function getDownloadInfo (version:Version) {
		var downloads = {
			"osx": [],
			"windows": [],
			"linux": []
		};

		function getInfo (title:String, url:String) : Download {
			return { title: title, url:url, filename: Path.withoutDirectory(url) };
		}
		var githubRelease = githubReleases.find(function(r) return r.tag_name == version.tag);
		if (githubRelease == null)
			throw 'missing github release for version ${version.tag}';
		var downloadUrls = githubRelease.assets.map(function(a) return a.browser_download_url);

		for (url in downloadUrls) {
			var filename = Path.withoutDirectory(url);
			if (filename.endsWith("-linux32.tar.gz") || filename.endsWith("-linux.tar.gz")) {
				downloads.linux.unshift(getInfo("Linux 32-bit Binaries", url));
			} else if (filename.endsWith("-linux64.tar.gz")) {
				downloads.linux.push(getInfo("Linux 64-bit Binaries", url));
			} else if (filename.endsWith("-raspi.tar.gz")) {
				downloads.linux.push(getInfo("Raspberry Pi", url));
			} else if (filename.endsWith("-osx-installer.pkg") || filename.endsWith("-osx-installer.dmg")) {
				downloads.osx.unshift(getInfo("OS X Installer", url));
			} else if (filename.endsWith("-osx.tar.gz")) {
				downloads.osx.push(getInfo("OS X Binaries", url));
			} else if (filename.endsWith("-win.exe")) {
				downloads.windows.unshift(getInfo("Windows Installer", url));
			} else if (filename.endsWith("-win.zip")) {
				downloads.windows.push(getInfo("Windows Binaries", url));
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

	public static function generate () {
		Sys.println("Generating downloads ...");

		// Data
		var data = getData();
		var downloadFilesOut = Path.join(["website-content", "downloads"]);

		// The list
		var title = "Haxe Download List";
		var content = Views.DownloadList(title, data.current, data.versions);

		Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "list", Config.index]), content, null, null, title);

		// The versions
		function getNotes (version:String, type:String) : String {
			var path = Path.join([Config.downloadsPath, version, '${type}.md']);
			if (FileSystem.exists(path)) {
				return Markdown.markdownToHtml(File.getContent(path));
			}
			return null;
		}

		for (version in data.versions) {
			var title = 'Haxe ${version.version}';
			var releaseNotes = getNotes(version.version, "RELEASE");
			var changes = getNotes(version.version, "CHANGES");

			var content = Views.DownloadVersion(
				version.version,
				version.prev != null ? version.prev.version : null,
				version.next != null ? version.next.version : null,
				title,
				version.downloads.windows,
				version.downloads.osx,
				version.tag,
				version.api != null ? version.api.url : null,
				new Html(releaseNotes),
				new Html(changes),
				version.prev != null ? version.prev.tag : null
			);

			Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "version", version.version, Config.index]), content, null, null, title);

			// Copy assets
			var link = Path.join([downloadFilesOut, version.version, "downloads"]);
			var path = Path.join([Config.outputFolder, link]);
			if (!FileSystem.exists(path)) {
				FileSystem.createDirectory(path);
			}
			for (asset in version.downloads.linux.concat(version.downloads.windows).concat(version.downloads.osx)) {
				var filename = Path.withoutDirectory(asset.url);
				Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "file", version.version, filename, Config.index]), Views.DownloadFile(
					version.prev != null ? version.prev.version : null,
					version.next != null ? version.next.version : null,
					title,
					asset.url,
					new Html(releaseNotes),
					new Html(changes),
					version.api != null ? version.api.url : null
				), null, null, title);
			}
		}

		// The current version
		File.copy(Path.join([Config.outputFolder, Config.downloadOutput, "version", data.current, Config.index]), Path.join([Config.outputFolder, Config.downloadOutput, Config.index]));

		// Copy the versions.json file
		Utils.copy(Path.join([Config.downloadsPath, "versions.json"]), Path.join([Config.outputFolder, downloadFilesOut, "versions.json"]));

		// Stable urls
		var releaseNotes = getNotes(data.current, "RELEASE");
		var changes = getNotes(data.current, "CHANGES");

		for (url in ["win.exe", "win.zip", "osx-installer.pkg", "osx.tar.gz", "linux32.tar.gz", "linux64.tar.gz"]) {
			var filename = 'haxe-latest-${url}';
			var link = Path.join([downloadFilesOut, "latest", "downloads"]);
			var title = 'latest: ${data.current}';
			var version = data.versions.find(function(v) return v.version == data.current);

			// Download page
			Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "file", "latest", filename, Config.index]), Views.DownloadFile(
					null,
					null,
					title,
					'/$link/$filename',
					new Html(releaseNotes),
					new Html(changes),
					version.api != null ? version.api.url : null
			), null, null, title);
		}
	}

}
