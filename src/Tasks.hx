import ufront.tasks.TaskSet;
import haxe.web.Dispatch;
import ufront.auth.model.*;
import sys.FileSystem;
import tasks.*;

class Tasks extends TaskSet
{
	@help("Pull a new version of the manual, parse it and save the output.") 
	function doPullManual( ?deleteFirst=false ) {
		
	}
	
	@help("Pull a new version of the site, update the content.") 
	function doPullSite() {
		
	}

	static function main() {
		sys.db.Manager.cnx = sys.db.Mysql.connect( app.Config.db );
		TaskSet.run( new Tasks(), Sys.args() );
	}
}