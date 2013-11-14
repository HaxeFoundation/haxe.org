package app;

class Config 
{
	public static var app = CompileTime.parseJsonFile( "conf/app.json" );

	#if server 
		public static var db = CompileTime.parseJsonFile( "conf/mysql.json" );
	#end
}