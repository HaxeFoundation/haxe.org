package generators;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.*;
import tink.template.Html;

using Lambda;

class Downloads {
	public static var data:DownloadsData.Data;

	public static function generate () {
		Sys.println("Generating downloads ...");

		// Data
		data = DownloadsData.getData();
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
				version,
				version.prev != null ? version.prev.version : null,
				version.next != null ? version.next.version : null,
				title,
				version.downloads,				
				version.api != null ? version.api.url : null,
				data.current,
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
			for (asset in version.downloads.all) {
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
