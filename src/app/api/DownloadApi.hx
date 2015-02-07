package app.api;

#if server
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end

import app.model.Download;
import haxe.Json;
import ufront.sys.SysUtil;
using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class DownloadApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Retrieve a list (and basic metadata) of all downloads in the repo.  Basically returns the `versions.json` file

		@param repo - absolute path to the folder containing all our versions.
		@return Pair(current, [versions])
		@throws String if versions.json could not be loaded or parsed.
	**/
	public function getDownloadList( repo:String ):CurrentVersionAndList {
		var versionFile = repo.addTrailingSlash()+'versions.json';
		var versionJson = File.getContent( versionFile );
		return haxe.Json.parse( versionJson );
	}

	/**
		Retrieve information about a specific download

		@param repo - absolute path to the folder containing all our versions.
		@param version - the version string to collect information about
		@return version info for the current version
		@throws String if version file could not be read or parsed.
	**/
	public function getDownloadVersion( repo:String, version:String ):VersionInfo {
		var version = version.replace( '.', ',' );
		var versionFile = repo.addTrailingSlash()+'$version.json';
		var versionJson = File.getContent( versionFile );
		var versionsInfo:VersionInfo = haxe.Json.parse( versionJson );
		return versionsInfo;
	}

	/**
		Convert downloads into JSON used to render information about each Haxe version's downloads.
		
		Will read the "website-content/versions/versions.json" to get a list of versions.  
		Will then create JSON info for the downloads, including download links, RELEASE.md, CHANGES.md and prev/next version links.
		RELEASE.md is optional, will be parsed as Markdown.  Same for CHANGES.md

		The naming conventions used for files:

		- All stored in `/website-content/versions/$version/downloads/`
		- Files ending in `-linux.tar.gz` or `-linux32.tar.gz` are Linux 32bit binaries
		- Files ending in `-linux64.tar.gz` are Linux 64bit binaries
		- Files ending in `-osx.tar.gz` are Mac OS X binaries
		- Files ending in `-osx-installer.pkg` are Mac OS X self installers
		- Files ending in `-win.zip` are Windows binaries
		- Files ending in `-win.exe` are Windows self installers
		
		@param `inDir` the absolute path to the directory containing the different Haxe versions
		@param `linkBase` the absolute http path to use as the base for links.  Default "" (relative links)
		@throw An array of error messages if there were failures.  All remaining files will be attempted before error is thrown.
	**/
	public function prepareDownloadJson( inDir:String, outDir:String ):Void {
		
		var errorMessages = [];
		var versionInfo = readVersionInfo( inDir.addTrailingSlash()+'versions.json', errorMessages );
		var currentVersion = versionInfo.a;
		var versions = versionInfo.b;

		// For each version, create a page

		var i = 0;
		for ( version in versions ) {
			try {
				var commaVersion = version.version.replace( '.', ',' );
				var versionInDir = inDir.addTrailingSlash() + commaVersion;
				
				var downloadDir = versionInDir + '/downloads/';
				var downloads = getDownloadInfo( downloadDir, errorMessages );

				var changes = readAndConvertMdFile( versionInDir+'/CHANGES.md', errorMessages );
				var releaseNotes = readAndConvertMdFile( versionInDir+'/RELEASE.md', errorMessages );

				var prevVersion = (i>0) ? versions[i-1].version : null;
				var prevTag = (i>0) ? versions[i-1].tag : null;
				var nextVersion = (i<versions.length-1) ? versions[i+1].version : null;

				var downloadInfo:VersionInfo = {
					downloads: downloads,
					changes: changes,
					releaseNotes: releaseNotes,
					tag: version.tag,
					version: version.version,
					api: version.api,
					prev: prevVersion,
					prevTag: prevTag,
					next: nextVersion
				};
				var json = Json.stringify( downloadInfo );
				SysUtil.mkdir( outDir );
				File.saveContent( outDir.addTrailingSlash()+commaVersion+'.json', json );
			} catch ( e:Dynamic ) errorMessages.push( 'Failed to process download ${version.version}: $e $i ${versions.length}' );

			i++;
		}

		if ( errorMessages.length>0 ) throw errorMessages;
	}

	/**
		Read a Markdown file and convert it to HTML.

		Returns null if file does not exist, or could not be read/converted.
	**/
	function readAndConvertMdFile( filename:String, errorMessages:Array<String> ):Null<String> {
		if ( !FileSystem.exists(filename) ) return null;

		try 
			return Markdown.markdownToHtml( File.getContent(filename) ) 
			catch (e:Dynamic) {
				errorMessages.push( 'Failed to read or convert Markdown file $filename' );
				return null;
			}
	}

	/**
		Read a `versions.json` file and return information about the versions.

		Add error to array if there is an error.

		Return a pair, the first part containing the current version string, the second part, an array of info about each version.
	**/
	function readVersionInfo( versionFile:String, errorMessages:Array<String> ):Pair<String, DownloadList> {
		
		var versions:Array<{ version:String, api:Bool, tag:String, date:String }> = [];
		var currentVersion:String = null;

		try {
			var versionJson = File.getContent( versionFile );
			var versionsInfo = haxe.Json.parse( versionJson );
			versions = versionsInfo.versions;
			currentVersion = versionsInfo.current;
		} catch ( e:Dynamic ) errorMessages.push( '$e' );

		return new Pair( currentVersion, versions );
	}

	/**
		Get information about which versions are available for download

		Returns an anonymous object, each key is the platform name ('osx', 'windows', 'linux'), and holds an array of available downloads for that platform)

		@param downloadDir that contains all the download files
		@param errorMessages an array to add to if we encounter messages
		@return { osx: [ {title,filename,size} ], windows: ..., linux: ... }
	**/
	function getDownloadInfo( downloadDir:String, errorMessages:Array<String> ):DownloadFileInfo {

		var downloads = {
			"osx": [],
			"windows": [],
			"linux": []
		};

		function getInfo( title:String, filename:String ) {
			var size =
				try FileSystem.stat( downloadDir.addTrailingSlash()+filename ).size 
				catch ( e:Dynamic ) {
					errorMessages.push( 'Failed to read download size of $filename' );
					0;
				}

			return { title: title, filename:filename, size: size }
		}
		try {
			for ( filename in FileSystem.readDirectory(downloadDir) ) {
				var fullFilename = downloadDir.addTrailingSlash()+filename;

				if ( filename.endsWith("-linux32.tar.gz") || filename.endsWith("-linux.tar.gz") ) downloads.linux.unshift( getInfo("Linux 32-bit Binaries", filename) );
				else if ( filename.endsWith("-linux64.tar.gz") ) downloads.linux.push( getInfo("Linux 64-bit Binaries", filename) );
				else if ( filename.endsWith("-raspi.tar.gz") ) downloads.linux.push( getInfo("Raspberry Pi", filename) );
				else if ( filename.endsWith("-osx-installer.pkg") || filename.endsWith("-osx-installer.dmg") ) downloads.osx.unshift( getInfo("OS X Installer", filename) );
				else if ( filename.endsWith("-osx.tar.gz") ) downloads.osx.push( getInfo("OS X Binaries", filename) );
				else if ( filename.endsWith("-win.exe") ) downloads.windows.unshift( getInfo("Windows Installer", filename) );
				else if ( filename.endsWith("-win.zip") ) downloads.windows.push( getInfo("Windows Binaries", filename) );
				else errorMessages.push( 'Download file $fullFilename does not match one of our usual rules, we do not know which platform it belongs to...' );
			}
		}
		catch ( e:Dynamic ) errorMessages.push( 'Failed to read download directory $downloadDir: $e' );

		return downloads;
	}
}
