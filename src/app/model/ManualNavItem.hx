package app.model;

enum ManualNavItem {
	Item( link:String );
	ParentItem( link:String, children:Array<ManualNavItem> );
}