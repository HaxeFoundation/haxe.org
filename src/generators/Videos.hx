package generators;

import haxe.DynamicAccess;
import haxe.Json;
import haxe.ds.StringMap;
import haxe.io.Path;
import haxe.xml.Parser.XmlParserException;
import sys.FileSystem;
import sys.io.File;
import tink.template.Html;

using StringTools;

typedef Video = {
	var title : String;
	var description : Html;
	var where : String;
	var date : String;
	var published : Bool;
	var youtubeId : String; 
	var featured : Bool; 
	
	// appended below
	@:optional var category : VideoCategory;
	@:optional var name : String;
	@:optional var path : String;
}

typedef VideoCategory = {
	var title : String;
	var description : Html;
	var path : String;
	var name : String;
	var videos : Array<Video>;
	var featuredVideos : Array<Video>;
	var sortIndex : Int;
}

/**
	get playlist data
		https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.playlistItems.list?part=snippet&maxResults=50&playlistId=PLLW5YfXlahjMXhFDPjVDd9vl-clQpN7vX&_h=1&
  
	paste to 
		https://try.haxe.org/#2dA2f
**/
class Videos {
	public static function generate () {
		Sys.println("Generating videos ...");

		var categories:Array<VideoCategory> = [];

		// Step 1: read jsons in videos-directory, parse the data
		var videosPath = Config.videosPath;
		for(file in FileSystem.readDirectory(videosPath)) {
			if (Path.extension(file) == "json") {
				var data:{ title:String, description:String, videos:Array<Video>} = Json.parse(File.getContent(Path.join([videosPath, file])));
				var videos:Array<Video> = data.videos;
				
				var categoryName = getName(Path.withoutExtension(file));
				var sortIndex = Std.parseInt(categoryName.split("-")[0]);
				categoryName = categoryName.substr('$sortIndex'.length + 1);
				
				var category:VideoCategory = {
					sortIndex: sortIndex,
					name: categoryName, 
					title: data.title, 
					description: new Html(data.description), 
					path: Path.join([Config.videoOutput, categoryName]) + "/", 
					videos: videos,
					featuredVideos: [],
				}
				categories.push(category);
				
				// assign extra/missing data to video
				for (video in videos) {
					if (!Reflect.hasField(video, "featured")) video.featured = false;
					if (video.featured) category.featuredVideos.push(video);
					
					video.category = category;
					video.name = getName(video.title);
					video.path = Path.join([Config.videoOutput, categoryName, video.name + ".html"]);
				}
			}
		}
		
		// sort videos from new to old date
		for (category in categories) {
			// yep, that is string compare and I don't care
			category.videos.sort(function(a, b) return a.date < b.date ? 1 : -1); 
			category.featuredVideos.sort(function(a, b) return a.date < b.date ? 1 : -1);
		}
		categories.sort(function(a, b) return a.sortIndex < b.sortIndex ? 1 : -1);
		
		
		
		// step 2:  generate pages
		
		// main category
		Utils.save(Path.join([Config.outputFolder, Config.videoOutput, Config.index]), Views.VideoLanding(
			categories
		), null, null, "Haxe Videos", "Learn Haxe by watching videos from the Haxe community.");
		
		// generate category pages
		for (category in categories) {
			trace('Generating video category: ${category.name} (${category.videos.length} videos)');
			Utils.save(Path.join([Config.outputFolder, category.path, Config.index]), Views.VideoCategoryList(
				category,
				categories
			), null, null, category.title, category.description);
			
			
			// generate video pages
			for (video in category.videos) {
				Utils.save(Path.join([Config.outputFolder, video.path]), Views.VideoPage(
					video,
					categories,
					video.category.videos.filter(function(v) return v != video) // exclude current video
				), null, null, video.title, video.description);
			}
		}
	}
	
	static function getName(value:String):String {
		var name = stripAccents(value.toLowerCase()).replace(" ", "-").replace("&", "-").replace(".", "-").replace("/", "-").replace(",", "").replace('"', "").replace("'", "").replace(":", "").replace("?", "").replace("(", "").replace(")", "").replace("#", "");
		while (name.indexOf("--") != -1) name = name.replace("--", "-");
		if (name.startsWith("-")) name = name.substr(1);
		if (name.endsWith("-")) name = name.substr(0, name.length-1);
		return name;
	}
	
	static function stripAccents(value:String) {
		var inChars   = 'àáâãäçèéêëìíîïñòóôõöùúûüýÿ'.split('');
		var outChars  = 'aaaaaceeeeiiiinooooouuuuyy'.split('');
		for (i in 0 ... inChars.length) {
			value = value.replace(inChars[i], outChars[i]);
		}
		return value;
	}
}
