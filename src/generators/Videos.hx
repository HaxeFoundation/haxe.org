package generators;

import haxe.Json;
import haxe.io.Path;
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

	@:optional var next : Null<Video>;
	@:optional var prev : Null<Video>;
}

typedef VideoCategory = {
	var title : String;
	var description : Html;
	var path : String;
	var name : String;
	var videos : Array<Video>;
	var userFeaturedVideos : Array<Video>;
	var featuredVideos : Array<Video>;
	var sortIndex : Int;
	var section : VideoSection;
}

typedef VideoSection = {
	var title : String;
	var description : Html;
	@:optional var path : String;
	@:optional var name : String;
	@:optional var categories : Array<VideoCategory>;
}

/**
	get playlist data
		https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.playlistItems.list?part=snippet&maxResults=50&playlistId=PLLW5YfXlahjMXhFDPjVDd9vl-clQpN7vX&_h=1&

	paste to
		https://try.haxe.org/#2dA2f
**/
class Videos {
	public static var sections:Array<VideoSection> = [];
	
	public static function generate () {
		Sys.println("Generating videos ...");


		// Step 1: read jsons in videos-directory, parse the data
		function read(videosPath:String) {
			var section:VideoSection = Json.parse(File.getContent(Path.join([videosPath, "index.json"])));

			section.categories = [];
			section.name = Path.withoutDirectory(videosPath);
			section.path = Path.join([videosPath]) + "/";
			sections.push(section);

			for (file in FileSystem.readDirectory(videosPath)) {
				var path = Path.join([videosPath, file]);
				if (FileSystem.isDirectory(path)) {
					read(path);
				} else if (Path.extension(file) == "json" && file != "index.json") {
					var data:{ title:String, description:String, videos:Array<Video>} = Json.parse(File.getContent(path));
					var videos:Array<Video> = data.videos;

					var categoryName = getName(Path.withoutExtension(file));
					var sortIndex = Std.parseInt(categoryName.split("-")[0]);
					categoryName = categoryName.substr('$sortIndex'.length + 1);

					var category:VideoCategory = {
						sortIndex: sortIndex,
						name: categoryName,
						title: data.title,
						description: new Html(data.description),
						path: Path.join([Config.videoOutput, section.name, categoryName]) + "/",
						videos: videos,
						section: section,
						userFeaturedVideos: [],
						featuredVideos: [],
					}
					section.categories.push(category);

					// assign extra/missing data to video
					for (video in videos) {
						if (!Reflect.hasField(video, "featured")) video.featured = false;
						if (video.featured && category.featuredVideos.length <= 5) {
							category.userFeaturedVideos.push(video);
							category.featuredVideos.push(video);
						}

						video.category = category;
						video.name = getName(video.title);
						video.path = Path.join([Config.videoOutput, section.name, categoryName, video.name + ".html"]);
					}
				}
			}
		}
		read(Config.videosPath);

		// sort videos from new to old date
		for (section in sections) {
			for (category in section.categories) {
				// yep, that is string compare and I don't care
				category.videos.sort(function(a, b) return a.date < b.date ? 1 : -1);

				var i = 0;
				while (category.featuredVideos.length < 5 && category.videos.length >= 5) {
					var v = category.videos[i++];
					if (category.featuredVideos.indexOf(v) < 0) category.featuredVideos.push(v);
				}
				category.userFeaturedVideos.sort(function(a, b) return a.date < b.date ? 1 : -1);
				category.featuredVideos.sort(function(a, b) return a.date < b.date ? 1 : -1);
			}
			// highest sort index on front
			section.categories.sort(function(a, b) return a.sortIndex < b.sortIndex ? 1 : -1);
		}

		// assign next/prev videos
		for (section in sections) {
			for (category in section.categories) {
				for (i in 0 ... category.videos.length) {
					var video = category.videos[i];
					video.prev = category.videos[i - 1];
					video.next = category.videos[i + 1];
				}
			}
		}

		// step 2:  generate pages

		var totalVideos = 0;
		// main category
		for (section in sections) {
			Utils.save(Path.join([Config.outputFolder, section.path, Config.index]), Views.VideoLanding(
				section,
				section.categories,
				sections
			), null, null, section.title, section.description);

			// generate category pages
			for (category in section.categories) {
				Sys.println('\tGenerating video category: ${category.name} (${category.videos.length} videos)');
				Utils.save(Path.join([Config.outputFolder, category.path, Config.index]), Views.VideoCategoryList(
					category,
					section.categories
				), null, null, category.title, category.description);

				// generate video pages
				for (video in category.videos) {
					totalVideos ++;
					Utils.save(Path.join([Config.outputFolder, video.path]), Views.VideoPage(
						video,
						section.categories,
						video.category.videos.filter(function(v) return v != video) // exclude current video
					), null, null, video.title, video.description);
				}
			}
		}

		Sys.println("\tTotal videos: " + totalVideos);
	}

	static function getName(value:String):String {
		var name = stripAccents(value.toLowerCase()).replace(" ", "-").replace("&", "-").replace(".", "-").replace("/", "-").replace(",", "").replace('"', "").replace("'", "").replace(":", "").replace("?", "").replace("(", "").replace(")", "").replace("#", "");
		while (name.indexOf("--") != -1) name = name.replace("--", "-");
		if (name.startsWith("-")) name = name.substr(1);
		if (name.endsWith("-")) name = name.substr(0, name.length-1);
		return name;
	}

	static function stripAccents(value:String) {
		var inChars   = ["à", "á", "â", "ã", "ä", "ç", "è", "é", "ê", "ë", "ì", "í", "î", "ï", "ñ", "ò", "ó", "ô", "õ", "ö", "ù", "ú", "û", "ü", "ý", "ÿ"];
		var outChars  = ["a", "a", "a", "a", "a", "c", "e", "e", "e", "e", "i", "i", "i", "i", "n", "o", "o", "o", "o", "o", "u", "u", "u", "u", "y", "y"];
		for (i in 0 ... inChars.length) {
			value = value.replace(inChars[i], outChars[i]);
		}
		return value;
	}
}
