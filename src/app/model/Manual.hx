package app.model;

typedef ManualSectionJson = {
	var label:String;
	var id:String;
	var sub:Array<ManualSectionJson>;
	var state:Int;
	var title:String;
	var index:Int;
	var source:{ file:String, lineMin:Int, lineMax:Int };
	@:optional var disambiguation:Null<String>;
	@:optional var parent:Null<ManualSectionJson>;
}
