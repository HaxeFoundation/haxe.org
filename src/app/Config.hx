package app;

class Config
{
	public static var app = CompileTime.parseJsonFile( "conf/app.json" );

	#if server
		public static var db = {
			"host": Sys.getEnv("HAXEORG_DB_HOST"),
			"port": Sys.getEnv("HAXEORG_DB_PORT"),
			"database": "haxe",
			"user": Sys.getEnv("HAXEORG_DB_USER"),
			"pass": Sys.getEnv("HAXEORG_DB_PASS"),
			"socket": null
		}
	#end
}
