package tasks;

import ufront.tasks.TaskSet;
import haxe.web.Dispatch;
import ufront.auth.model.*;
import sys.FileSystem;
import tasks.*;

class Tasks extends TaskSet
{
	@help("Set up admin user and optionally initial seed data") 
	function doInitialSetup( adminUser:String, adminPass:String, ?loadSeedData=true ) {
		
	}

	static function main() {
		sys.db.Manager.cnx = sys.db.Mysql.connect( app.Config.db );
		TaskSet.run( new Tasks(), Sys.args() );
	}
}