package app.model;

typedef ManualPage = {
	/** The id (eg "3.2.1") **/
	id:String,

	/** The title of this page **/
	title:String,

	/** The HTML content of this page (rendered from the Markdown) **/
	content:String,

	/** The title of the previous page, null if this is the first page **/
	prevTitle:Null<String>,

	/** The URL to the previous page, null if this is the first page **/
	prev:Null<String>,

	/** The title of the next page, null if this is the last page **/
	nextTitle:Null<String>,

	/** The URL to the next page, null if this is the last page **/
	next:Null<String>

}

enum ManualNavItem {
	Item( link:String );
	ParentItem( link:String, children:Array<ManualNavItem> );
}