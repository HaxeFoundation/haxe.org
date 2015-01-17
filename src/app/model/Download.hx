package app.model;

using tink.CoreApi;

typedef Download = { version:String, api:Bool, tag:String, ?date:String };
typedef DownloadList = Array<Download>;
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
