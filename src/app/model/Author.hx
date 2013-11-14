package app.model;

import ufront.db.*;
import sys.db.Types;
import ufront.auth.model.User;
import haxe.crypto.Md5;
import ufront.db.Object;
using StringTools;

class Author extends Object 
{
	public var user:Null<BelongsTo<User>>;
	public var firstName:SString<50>;
	public var lastName:SString<50>;
	public var email:SString<100>;

	public var posts:HasMany<Post>;
	public var comments:HasMany<Comment>;

	@:skip public var gravatarURL(get,null):String;

	function get_gravatarURL() {
		var size = 200;
		var hash = Md5.encode( email.trim().toLowerCase() );
		return 'http://www.gravatar.com/avatar/$hash?s=$size';
	}
}