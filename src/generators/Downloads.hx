package generators;

import haxe.Json;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef Version = {
	var version : String;
	var tag : String;
	var date : String;
	var changes : String;
	var downloads : Array<String>;
	@:optional var api : String;
	@:optional var next : Version;
	@:optional var prev : Version;
};

typedef Data = {
	current : String,
	versions : Array<Version>
};

class Downloads {

	static function getDownloadInfo (d:Array<String>) {
		var downloads = {
			"osx": [],
			"windows": [],
			"linux": [],
			"api": null
		};

		function getInfo (title:String, filename:String) {
			return { title: title, filename:filename }
		}

		for (filename in d) {
			var filename = filename.substr(1, filename.length - 2);
			if (filename.endsWith("-linux32.tar.gz") || filename.endsWith("-linux.tar.gz") ) downloads.linux.unshift(getInfo("Linux 32-bit Binaries", filename));
			else if (filename.endsWith("-linux64.tar.gz")) downloads.linux.push(getInfo("Linux 64-bit Binaries", filename));
			else if (filename.endsWith("-raspi.tar.gz")) downloads.linux.push(getInfo("Raspberry Pi", filename));
			else if (filename.endsWith("-osx-installer.pkg") || filename.endsWith("-osx-installer.dmg")) downloads.osx.unshift(getInfo("OS X Installer", filename));
			else if (filename.endsWith("-osx.tar.gz")) downloads.osx.push(getInfo("OS X Binaries", filename));
			else if (filename.endsWith("-win.exe")) downloads.windows.unshift(getInfo("Windows Installer", filename));
			else if (filename.endsWith("-win.zip")) downloads.windows.push(getInfo("Windows Binaries", filename));
			else trace('Unknown download type for "$filename"');
		}

		return downloads;
	}

	public static function generate () {
		Sys.println("Generating downloads ...");

		// Data
		var data:Data = Json.parse(File.getContent("versions.json"));
		var versions = data.versions;
		versions.reverse();

		// Annotate data //TODO: move to DownloadList.hx
		var next = null;
		for (version in versions) {
			version.next = next;
			if (next != null) {
				next.prev = version;
			}
			next = version;
		}

		// The list
		var title = "Haxe Download List";
		var content = views.DownloadList.execute({
			current: data.current,
			versions: data.versions,
			title: title,
			tagBaseUrl: Config.tagBaseUrl,

			//TODO need a better template engine or something, having the result of foreach in the global scope is not good
			version: null,
			tag: null,
			date: null,
			api: null
		});

		Utils.save(Path.join([Config.outputFolder, "download", "list", "index.html"]), content, null, null, title);

		// The versions
		function getReleaseNotes (version:String) : String {
			var path = Path.join(["releaseNotes", version + ".md"]);
			if (FileSystem.exists(path)) {
				return Markdown.markdownToHtml(File.getContent(path));
			}
			return null;
		}

		for (version in versions) {
			var title = 'Haxe ${version.version}';
			var downloads = getDownloadInfo(version.downloads);

			var content = views.DownloadVersion.execute({
				title: title,
				version: version.version,
				tagBaseUrl: Config.tagBaseUrl,
				prev: version.prev != null ? version.prev.version : null,
				next: version.next != null ? version.next.version : null,
				tag: version.tag,
				prevTag: version.prev != null ? version.prev.tag : null,
				compareBaseUrl: Config.compareBaseUrl,
				releaseNotes: getReleaseNotes(version.version),
				changes: Markdown.markdownToHtml(version.changes.replace("\r\n", "\n")), //getReleaseFile("CHANGES.md", version.version),
				downloads_windows: downloads.windows,
				downloads_linux: downloads.linux,
				downloads_osx: downloads.osx,
				api: version.api,

				//TODO need a better template engine or something, having the result of foreach in the global scope is not good
				filename: null,
			});

			Utils.save(Path.join([Config.outputFolder, "download", "version", version.version, "index.html"]), content, null, null, title);
		}

		// The current version
		File.copy(Path.join([Config.outputFolder, "download", "version", data.current, "index.html"]), Path.join([Config.outputFolder, "download", "index.html"]));
	}

}
