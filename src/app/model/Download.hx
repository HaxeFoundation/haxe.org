package app.model;

using tink.CoreApi;

typedef DownloadList = Array<{ version:String, api:Bool, tag:String, date:String }>;
typedef CurrentVersionAndList = { current:String, versions:DownloadList };
typedef DownloadFileInfo = Dynamic<Array<{ title:String, filename:String, size:Int }>>;

typedef VersionInfo = {
	downloads:DownloadFileInfo,
	changes:String,
	releaseNotes:String,
	tag:String,
	version:String,
	api:Bool,
	prev:Null<String>,
	prevTag:Null<String>,
	next:Null<String>
}
