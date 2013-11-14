package app.model;

import ufront.db.*;
import ufront.db.Object;
import sys.db.Types;

class Post extends Object 
{
	public var slug:SString<255>;
	public var author:BelongsTo<Author>;
	public var category:BelongsTo<Category>;
	public var tags:ManyToMany<Post,Tag>;
	public var content:SData<PostType>;
	public var comments:HasMany<Comment>;
}

enum PostType
{
	Status( status:String );
	Post( title:String, post:String );
	Quote( quote:String, attribution:String, ?link:String, ?comment:String );
	Picture( src:String, title:String, alt:String, description:String );
	Link( href:String, text:String, description:String );
}