package app.model;

import ufront.db.*;
import sys.db.Types;

class Tag extends Object 
{
	public var slug:SString<20>;
	public var tag:SString<50>;
	public var description:SText;
	public var posts:ManyToMany<Tag,Post>;
}