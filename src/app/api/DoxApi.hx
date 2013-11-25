package app.api;

#if server
	import haxe.Json;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.Process;
#end

using StringTools;
using Lambda;
using tink.CoreApi;
using haxe.io.Path;

class DoxApi extends ufront.api.UFApi {

	@inject("contentDirectory") public var contentDir:String;

	/**
		Run `convertDoxToHtml` for every version that has documentation files
	**/
	public function convertDoxForAllVersions( versionsDir:String ):Outcome<Noise,String> {
		return Success( Noise );
	}

	/**
		Convert Haxedoc xml files into API documentation using DOX classes.
		
		@param `inDir` the absolute path to the directory containing Xml files
		@param `outDir` the absolute path to the directory we should save our HTML to
		@param `linkBase` the absolute http path to use as the base for links.  Default "" (relative links)
		@return Success(Noise), or Failure(errorMsg)
	**/
	public function convertDoxToHtml( inDir:String, outDir:String, ?linkBase:String="" ):Outcome<Noise,String> {
		return Success(Noise);
	}

	/**
		Fetch the manual navigation (a `<ul>` we generated during import)
	**/
	public function getNavigation( repo:String ):Outcome<String,String> {
		return 
			try Success( File.getContent('${repo}/navigation.html') )
			catch ( e:Dynamic ) Failure('$e')
		;
	}
}