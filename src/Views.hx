import generators.Blog.Post;
import generators.Videos;
import tink.template.Html;

class Views {

	@:template public static function BlogList (title:String, description:String, posts:Array<{ background:String, name:String, title:String, description:String, authors:Array<generators.Blog.Author>, disqusID:String, date:String }>, avatar:String) : Html;
	@:template public static function BlogPost (background:String, title:String, description:String, authors:Array<generators.Blog.Author>, name:String, date:String, disqusID:String, content:Html, tags:Array<{ name:String }>) : Html;
	@:template public static function VideoPage (video:Video, categories:Array<VideoCategory>, relatedVideos:Array<Video>) : Html;
	@:template public static function VideoCategoryList (category:VideoCategory, categories:Array<VideoCategory>) : Html;
	@:template public static function VideoLanding (section:VideoSection, categories:Array<VideoCategory>, sections:Array<VideoSection>) : Html;
	@:template public static function BlogRss (posts:Array<{ title:String, name:String, date:String, authors:Array<generators.Blog.Author>, description:String }>) : Html;
	@:template public static function DownloadFile (prev:String, next:String, title:String, directDownloadLink:String, releaseNotes:Html, changes:Html, api:String) : Html;
	@:template public static function DownloadList (title:String, current:String, versions:Array<DownloadsData.Version>) : Html;
	@:template public static function DownloadVersion (version:DownloadsData.Version, prev:String, next:String, title:String, downloads:DownloadsData.DownloadList, api:String, current:String, releaseNotes:Html, changes:Html, prevTag:String) : Html;
	@:template public static function Footer (firstColumn:Array<{ url:String, title:String }>, columns:Array<{ title:String, url:String, rows:Array<SiteMap.Row> }>) : Html;
	@:template public static function MainLayout (title:String, description:String, navBar:Html, viewContent:Html, siteMap:Html, currentYear:String, editLink:String, additionalScripts:Html, additionalStyles:Html) : Html;
	@:template public static function PageWithoutSidebar (content:Html, editLink:String, downloads:DownloadsData.Data) : Html;
	@:template public static function PageWithSidebar (prevNextLinks:{ prevUrl:String, prevTitle:String, nextUrl:String, nextTitle:String }, sideNav:Html, content:Html, editLink:String, comments:{ repo:String, branch:String, title:String }) : Html;
	@:template public static function HomePage (currentVersion:DownloadsData.Version, blogs:Array<Post>, videos:Array<Video>) : Html;
	@:template public static function Redirection (redirectionLink:String) : Html;
	@:template public static function WhoIsWho (members:Array<generators.Blog.Author>, formers:Array<generators.Blog.Author>) : Html;

}
