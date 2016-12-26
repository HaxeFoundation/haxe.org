package generators;

import haxe.Json;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef Download = {
	title : String,
	filename : String
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
	@:optional var api : Bool;
	@:optional var next : Version;
	@:optional var prev : Version;
	@:optional var downloads : DownloadList;
}

typedef Data = {
	current : String,
	versions : Array<Version>
}

typedef FileInfo = {
	title : String,
	filename : String
}

class Downloads {

	static function getDownloadInfo (version:Version) {
		var downloads = {
			"osx": [],
			"windows": [],
			"linux": []
		};

		function getInfo (title:String, filename:String) : FileInfo {
			return { title: title, filename:filename }
		}

		for (filename in FileSystem.readDirectory(Path.join([Config.downloadsPath, version.version]))) {
			if (filename.endsWith("-linux32.tar.gz") || filename.endsWith("-linux.tar.gz")) {
				downloads.linux.unshift(getInfo("Linux 32-bit Binaries", filename));
			} else if (filename.endsWith("-linux64.tar.gz")) {
				downloads.linux.push(getInfo("Linux 64-bit Binaries", filename));
			} else if (filename.endsWith("-raspi.tar.gz")) {
				downloads.linux.push(getInfo("Raspberry Pi", filename));
			} else if (filename.endsWith("-osx-installer.pkg") || filename.endsWith("-osx-installer.dmg")) {
				downloads.osx.unshift(getInfo("OS X Installer", filename));
			} else if (filename.endsWith("-osx.tar.gz")) {
				downloads.osx.push(getInfo("OS X Binaries", filename));
			} else if (filename.endsWith("-win.exe")) {
				downloads.windows.unshift(getInfo("Windows Installer", filename));
			} else if (filename.endsWith("-win.zip")) {
				downloads.windows.push(getInfo("Windows Binaries", filename));
			} else if (filename == 'api-${version.version}.zip') {
				version.api = true;
			} else if (filename.endsWith(".md")) {
				// ignore
			} else {
				Sys.println('Unknown download type for "$filename"');
			}
		}

		version.downloads = downloads;
	}

	public static function generate () {
		Sys.println("Generating downloads ...");

		// Data
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

		var downloadFilesOut = Path.join(["website-content", "downloads"]);

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
			api: false
		});

		Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "list", Config.index]), content, null, null, title);

		// The versions
		function getNotes (version:String, type:String) : String {
			var path = Path.join([Config.downloadsPath, version, '${type}.md']);
			if (FileSystem.exists(path)) {
				return Markdown.markdownToHtml(File.getContent(path));
			}
			return null;
		}

		for (version in versions) {
			var title = 'Haxe ${version.version}';
			var releaseNotes = getNotes(version.version, "RELEASE");
			var changes = getNotes(version.version, "CHANGES");

			var content = views.DownloadVersion.execute({
				title: title,
				version: version.version,
				tagBaseUrl: Config.tagBaseUrl,
				prev: version.prev != null ? version.prev.version : null,
				next: version.next != null ? version.next.version : null,
				tag: version.tag,
				prevTag: version.prev != null ? version.prev.tag : null,
				compareBaseUrl: Config.compareBaseUrl,
				releaseNotes: releaseNotes,
				changes: changes,
				downloads_windows: version.downloads.windows,
				downloads_linux: version.downloads.linux,
				downloads_osx: version.downloads.osx,
				api: version.api,

				//TODO need a better template engine or something, having the result of foreach in the global scope is not good
				filename: null,
			});

			Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "version", version.version, Config.index]), content, null, null, title);

			// Copy assets
			var link = Path.join([downloadFilesOut, version.version, "downloads"]);
			var path = Path.join([Config.outputFolder, link]);
			if (!FileSystem.exists(path)) {
				FileSystem.createDirectory(path);
			}
			for (asset in version.downloads.linux.concat(version.downloads.windows).concat(version.downloads.osx)) {
				File.copy(Path.join([Config.downloadsPath, version.version, asset.filename]), Path.join([path, asset.filename]));

				Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "file", version.version, asset.filename, Config.index]), views.DownloadFile.execute({
					version: version.version,
					prev: version.prev != null ? version.prev.version : null,
					next: version.next != null ? version.next.version : null,
					title: title,
					directDownloadLink: '/$link/${asset.filename}',
					releaseNotes: releaseNotes,
					changes: changes,
					api: version.api
				}), null, null, title);
			}

			// Copy api
			if (version.api) {
				var apiIn = Path.join([Config.downloadsPath, version.version, 'api-${version.version}.zip']);
				var apiOut = Path.join([Config.outputFolder, Config.downloadOutput, "api", version.version, "api.zip"]);
				var outDir = Path.directory(apiOut);

				if (!FileSystem.exists(outDir)) {
					FileSystem.createDirectory(outDir);
				}

				File.copy(apiIn, apiOut);
			}
		}

		// The current version
		File.copy(Path.join([Config.outputFolder, Config.downloadOutput, "version", data.current, Config.index]), Path.join([Config.outputFolder, Config.downloadOutput, Config.index]));

		// Stable urls
		var releaseNotes = getNotes(data.current, "RELEASE");
		var changes = getNotes(data.current, "CHANGES");

		for (url in ["win.exe", "win.zip", "osx-installer.pkg", "osx.tar.gz", "linux32.tar.gz", "linux64.tar.gz"]) {
			var filename = 'haxe-latest-${url}';
			var link = Path.join([downloadFilesOut, "latest", "downloads"]);
			var title = 'latest: ${data.current}';

			// Download page
			Utils.save(Path.join([Config.outputFolder, Config.downloadOutput, "file", "latest", filename, Config.index]), views.DownloadFile.execute({
					version: title,
					prev: null,
					next: null,
					title: title,
					directDownloadLink: '/$link/$filename',
					releaseNotes: releaseNotes,
					changes: changes,
					api: null
				}), null, null, title);

			// File
			var inPath = Path.join([Config.downloadsPath, data.current, 'haxe-${data.current}-${url}']);
			var outPath = Path.join([Config.outputFolder, link, filename]);
			Utils.copy(inPath, outPath);
		}
	}

}
