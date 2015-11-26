package app;

class Config
{
	public static var app = CompileTime.parseJsonFile( "conf/app.json" );

	#if server
		#if deploy
			public static var db = CompileTime.parseJsonFile( "conf/mysql-haxeorg.json" );
		#else
			public static var db = CompileTime.parseJsonFile( "conf/mysql.json" );
		#end
	#end
}
