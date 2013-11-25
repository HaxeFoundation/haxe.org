package app.model;

using tink.CoreApi;

typedef DownloadList = Array<{ version:String, api:Bool, tag:String }>;
typedef CurrentVersionAndList = Pair<String, DownloadList>;
typedef DownloadFileInfo = Dynamic<Array<{ title:String, filename:String, size:Int }>>;

typedef VersionInfo = {
	downloads:DownloadFileInfo,
	changes:String,
	releaseNotes:String,
	tag:String,
	version:String,
	api:Bool,
	prev:Null<String>,
	next:Null<String>
}
