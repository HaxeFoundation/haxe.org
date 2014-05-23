package app.model;

typedef ManualSectionJson = {
	var label:String;
	var id:String;
	var sub:Array<ManualSectionJson>;
	var state:Int;
	var title:String;
	var index:Int;
	/** We extract this from the markdown content, it is not provided in the sections.txt JSON. **/
	var editLink:Null<String>;
}
