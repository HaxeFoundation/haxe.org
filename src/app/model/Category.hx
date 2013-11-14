package app.model;

import ufront.db.*;
import sys.db.Types;
import ufront.db.Object;

class Category extends Object 
{
	public var slug:SString<20>;
	public var title:SString<50>;
	public var description:SText;
	public var posts:HasMany<Post>;
}