package app.model;

import ufront.db.*;
import sys.db.Types;
import ufront.db.Object;

class Comment extends Object 
{
	public var author:BelongsTo<Author>;
	public var post:BelongsTo<Post>;
	public var replyTo:Null<BelongsTo<Comment>>;
	public var comment:SText;
}