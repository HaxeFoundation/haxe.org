package app.model;

typedef Article = {
	public var title:String;
	public var author:String;
	public var description:String;
	public var date:String;
	public var background:String;
	public var articleFile:String;
	public var published:Bool;

	/** Our `ArticleApi` will insert the slug when it reads the article, so no need to include it in the JSON. **/
	public var slug:String;
}
